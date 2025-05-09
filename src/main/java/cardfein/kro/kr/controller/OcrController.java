package cardfein.kro.kr.controller;

import java.io.IOException;
import java.io.InputStream;

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

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * 비회원 명세서 ocr 분석 Controller
 */
public class OcrController implements RestController {
	public OcrController() {
	}
	/**
	 * ocr 분석
	 * @throws ServletException 
	 * @throws IOException 
	 */
   public Object recognize(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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
       String requestJson = "{"
               + "\"version\": \"V2\","
               + "\"requestId\": \"test_request\","
               + "\"timestamp\": " + System.currentTimeMillis() + ","
               + "\"images\": [ { \"name\": \"image\", \"format\": \"jpg\" } ]"
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
       StringBuilder ocrResult = new StringBuilder();

       for (JsonNode imageNode : imagesNode) {
           JsonNode fieldsNode = imageNode.path("fields");
           for (JsonNode fieldNode : fieldsNode) {
               ocrResult.append(fieldNode.path("inferText").asText()).append("\n");
           }
       }
	   return ocrResult.toString();
   }
	
	
	
	
	
	
        
    

}
