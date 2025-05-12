package cardfein.kro.kr.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.service.StatementService;
import cardfein.kro.kr.service.StatementServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * 명세서 ocr 분석 Controller
 */

public class OcrController implements RestController {
	StatementService service = new StatementServiceImpl();

	public OcrController() {
	}


	/**
	 * ocr 명세서인식
	 * 
	 * @throws ServletException
	 * @throws IOException
	 */
	public Object recognize(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		StringBuilder ocrResult = new StringBuilder();
		String apiUrl = "https://wpowaclttw.apigw.ntruss.com/custom/v1/41289/3d95171c4ef12bef25ccd28b47c4be4e3ceaf6a913911f0959fdc24765c790ed/general";
		String secretKey = "aGNyVGRzVkxLSndmVkpNUHNybkh0YUdScGhmbEVaQWs="; // Naver Cloud에서 발급받은 Secret Key

		// 이미지 파일 추출
		Part filePart = request.getPart("image");
		InputStream fileContent = filePart.getInputStream();

		// HTTP 요청 설정
		HttpClient client = HttpClients.createDefault();
		HttpPost post = new HttpPost(apiUrl);
		post.setHeader("X-OCR-SECRET", secretKey);

		// OCR API 요청 메시지
		String requestJson = "{" + "\"version\": \"V2\"," + "\"requestId\": \"test_request\"," + "\"timestamp\": "
				+ System.currentTimeMillis() + "," + "\"images\": [ { \"name\": \"image\", \"format\": \"jpg\" } ]"
				+ "}";

		// Multipart 구성
		MultipartEntityBuilder builder = MultipartEntityBuilder.create();
		builder.addTextBody("message", requestJson, ContentType.APPLICATION_JSON);
		builder.addBinaryBody("file", fileContent, ContentType.DEFAULT_BINARY, "upload.jpg");

		HttpEntity entity = builder.build();
		post.setEntity(entity);

		// API 호출 및 응답 처리
		HttpResponse apiResponse = client.execute(post);
		String jsonResponse = EntityUtils.toString(apiResponse.getEntity(), "UTF-8");

		// JSON 응답 파싱
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(jsonResponse);
		JsonNode imagesNode = rootNode.path("images");

		for (JsonNode imageNode : imagesNode) {
			JsonNode fieldsNode = imageNode.path("fields");
			for (JsonNode fieldNode : fieldsNode) {
				ocrResult.append(fieldNode.path("inferText").asText()).append("\n");
			}
		}
		request.getSession().setAttribute("ocrText", ocrResult.toString());
		
		return ocrResult.toString();
	}

	/**
	 * ocr 인식결과 파싱
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 */
	public Object parsing(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String ocrText = (String)request.getSession().getAttribute("ocrText");
		Map<String, Integer> categorySums = new HashMap<>(); // 카테고리별 합산
		int totalAmount = 0;
		// 총 사용금액 추출
		Pattern totalPattern = Pattern.compile("총 사용금액:\\n([\\d,]+)원");
		Matcher totalMatcher = totalPattern.matcher(ocrText);
		if (totalMatcher.find()) {
			totalAmount = Integer.parseInt(totalMatcher.group(1).replace(",", ""));
		}

		// 개별 항목 파싱
		String[] lines = ocrText.split("\n");
		List<Map<String, String>> entries = new ArrayList<>(); // 세부항목 모두 저장

		for (int i = 0; i < lines.length - 3; i++) {
			if (lines[i].matches("\\d{4}-\\d{2}-\\d{2}")) {
				String date = lines[i];
				String merchant = lines[i + 1];
				int amount = Integer.parseInt(lines[i + 2].replace(",", "").replace("원", ""));
				String category = lines[i + 3];

				// 저장
				Map<String, String> entry = new HashMap<>();
				entry.put("date", date);  //날짜
				entry.put("merchant", merchant); //가맹점
				entry.put("amount", String.valueOf(amount)); //금액
				entry.put("category", category); //카테고리
				entries.add(entry);

				// 카테고리별 합산
				categorySums.put(category, categorySums.getOrDefault(category, 0) + amount);
			}
		}
		
		
		request.getSession().setAttribute("statementEntries", entries); // 회원인 경우 db 저장 데이터
		request.getSession().setAttribute("ocrText", ocrText); // 회원인 경우 db 저장 데이터
		request.getSession().setAttribute("categorySums", categorySums);
		request.getSession().setAttribute("totalAmount", totalAmount);
		
		return categorySums;
	}

	/**
	 * ocr 결과 기반 카드추천(비회원)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 */
	public Object cardRecommend(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException {
		Map<String, Double> spendingRate = new HashMap<>();
		Map<String, Integer> categorySums = (Map<String, Integer>) request.getSession().getAttribute("categorySums");
		Integer totalAmount = (Integer) request.getSession().getAttribute("totalAmount");
		
		// top2 소비 카테고리 추출
		List<Map.Entry<String, Integer>> entries = new ArrayList<>(categorySums.entrySet());
		entries.sort(Collections.reverseOrder(Map.Entry.comparingByValue()));
		String[] category = new String[2];
		category[0] = entries.get(0).getKey();
		category[1] = entries.get(1).getKey();

		// top2 카테고리 할인율이 큰 카드 5개 필터링
		List<CardDto> cardList = service.selectByCategory(category);
		List<Integer> cardNoList = new ArrayList<>();
		for (CardDto card : cardList) {
			cardNoList.add(card.getCardNo());
		}
		List<CardBenefitDto> cardBenefitList = service.selectByCardNo(cardNoList);
		// 카드번호= key, List<CardBenefitDto> =value map 만들기!!
		Map<Integer, List<CardBenefitDto>> cardBenefitMap = new HashMap<>();
		for (CardBenefitDto benefit : cardBenefitList) {
			int cardNo = benefit.getCardNo();
			cardBenefitMap.computeIfAbsent(cardNo, k -> new ArrayList<>()) // 카드번호가 없으면 새 리스트 생성
					.add(benefit); // 해당 카드번호 리스트에 추가
		}
		
		// 카테고리별 소비 비율
		for (String key : categorySums.keySet()) {
			spendingRate.put(key, (double) categorySums.get(key) / totalAmount);
		}

		// 카드별 매칭점수 구하기
		Map<Integer, Double> cardMatch = new HashMap<>();
		double max = 0;
		for (Integer cardNo : cardBenefitMap.keySet()) {
			
			List<CardBenefitDto> list = cardBenefitMap.get(cardNo);
			double score = 0;
			for (CardBenefitDto cardBenefitDto : list) {
				for (String cat : spendingRate.keySet()) {
					if (cat.equals(cardBenefitDto.getCategory())) {
						score += cardBenefitDto.getDiscountRate() * spendingRate.get(cat);
					}
				}
			}
			if(score>max) max= score;
			cardMatch.put(cardNo, score);
		}
		
		//카드별 매칭률 구하기
		Map<String,Double> matchingRate = new HashMap<>();
		Map<Integer,Double> matchingRateDb = new HashMap<>(); //회원인 경우 db 에 저장할 Map<카드번호,매칭률>
		for (CardDto card : cardList) {
			String cardName = card.getCardName();
			for (int cardNo : cardMatch.keySet()) {
				if(card.getCardNo()==cardNo) {
					Double matchscore = cardMatch.get(cardNo);
					matchingRate.put(cardName, Math.round(matchscore / max * 0.9 * 1000) / 10.0);
					matchingRateDb.put(cardNo, Math.round(matchscore / max * 0.9 * 1000) / 10.0); //회원인 경우 db 에 저장할 Map<카드번호,매칭률>
				}
			}
		}
		request.getSession().setAttribute("matchingRateDb", matchingRateDb);
		
		
		return matchingRate;
	}
	
	/**
	 * ocr 누적 결과 기반 카드 추천(회원)
	 */
	public Object memberCardRecommend(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException {
		String ocrText = (String)request.getSession().getAttribute("ocrText"); //db 저장할 ocr text
		List<Map<String, String>> statement =  (List<Map<String, String>>)request.getSession().getAttribute("statementEntries"); //db 저장할 명세서 데이터
		Map<String, Integer> categorySums = (Map<String, Integer>) request.getSession().getAttribute("categorySums"); //db 저장할 category별 합계
		Map<Integer,Double> matchingRateDb = (Map<Integer,Double>) request.getSession().getAttribute("matchingRateDb"); //db 저장할 Map<카드번호,매칭률>
		
		//회원인 경우, ocr결과, 명세서내용 List, 카테고리 별 금액 map,  카드번호=매칭률 map service 로 전달
		List<Object> inputData = new ArrayList<>();
		
		inputData.add(ocrText);
		inputData.add(statement);
		inputData.add(categorySums);
		inputData.add(matchingRateDb);
		service.insertStatementResult(inputData);
		
		
		
		
		
		
		return null;
	}

}
