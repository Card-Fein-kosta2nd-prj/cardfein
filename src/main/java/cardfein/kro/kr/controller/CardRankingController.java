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
		System.out.println("여기 옴?");
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
	public Object getAllCardCover(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<CardCoverDto> list = service.getAllCovers();
		System.out.println(list);
		String contextPath = request.getContextPath();
		
		for (CardCoverDto dto : list) {
			String originalUrl = dto.getFinalCardUrl();
			if (originalUrl != null && !originalUrl.startsWith(contextPath)) {
				dto.setFinalCardUrl(contextPath + originalUrl);
				System.out.println("이미지 :"+ contextPath+originalUrl);
			}
		}
		
		return list;
	}
	
	/**
	 *  좋아요 수 기준 top 5 카드 커버를 조회하여 Json 형태로 응답
	 */
	
	public Object getTopCardCovers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<CardCoverDto> list = service.getTopCovers();
		String contextPath = request.getContextPath();
		
		for (CardCoverDto dto : list) {
			String originalUrl = dto.getFinalCardUrl();
			if (originalUrl != null && !originalUrl.startsWith(contextPath)) {
				dto.setFinalCardUrl(contextPath + originalUrl);
				System.out.println("이미지 :"+ contextPath+originalUrl);
			}
		}
		
		return list;	
	}
	
	
}
