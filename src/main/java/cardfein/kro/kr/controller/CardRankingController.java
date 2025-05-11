package cardfein.kro.kr.controller;

import java.util.List;

import com.google.gson.Gson;

import cardfein.kro.kr.dto.CardCoverDto;
import cardfein.kro.kr.service.CardRankingService;
import cardfein.kro.kr.service.CardRankingServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CardRankingController {
	
	private static final CardRankingController instance = new CardRankingController();

	private final CardRankingService service;
	
	public CardRankingController() {
		this.service = CardRankingServiceImpl.getInstance();
	}
	
	public static CardRankingController getInstance() {
		return instance;
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
	
	public void getAllCardCover(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<CardCoverDto> list = service.getAllCovers();
		
		Gson gson = new Gson();
		String json = gson.toJson(list);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.getWriter().write(json);
	}
}
