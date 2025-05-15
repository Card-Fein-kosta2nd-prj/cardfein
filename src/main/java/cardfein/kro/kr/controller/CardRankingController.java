package cardfein.kro.kr.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import cardfein.kro.kr.dto.CardCoverDto;
import cardfein.kro.kr.service.CardRankingService;
import cardfein.kro.kr.service.CardRankingServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 카드 랭킹 관련 요청을 처리하는 controller 클래스
 */

public class CardRankingController implements RestController{
	
	CardRankingService service = new CardRankingServiceImpl();
	
	public CardRankingController() {
		
	}
	
	/**
	 * [
  {
    "id": 1,
    "finalCoverUrl": "https://example.com/card1.jpg"
  },
  {
    "id": 2,
    "finalCoverUrl": "https://example.com/card2.jpg"
  }
]

	 */
	
	/**
     * 전체 카드 커버 목록을 조회하여 JSON 형태로 응답
     */
	public void getAllCardCover(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<CardCoverDto> list = service.getAllCovers();
		
		String contextPath = request.getContextPath();
		
		for (CardCoverDto dto : list) {
			String originalUrl = dto.getFinalCardUrl();
			if (originalUrl != null && !originalUrl.startsWith(contextPath)) {
				dto.setFinalCardUrl(contextPath + originalUrl);
				System.out.println("이미지 :"+ contextPath+originalUrl);
			}
		}
		
		Gson gson = new Gson();
		String json = gson.toJson(list);
		
		Map<String, Object> result = new HashMap<>();
		/* result.put("rank", rank); */
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.getWriter().write(json);
	}
	
	/**
	 *  좋아요 수 기준 top 5 카드 커버를 조회하여 Json 형태로 응답
	 */
	
	public void getTopCardCovers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<CardCoverDto> list = service.getTopCovers();
		
		Gson gson = new Gson();
		String json = gson.toJson(list);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.getWriter().write(json);
		
	}
	
	
}
