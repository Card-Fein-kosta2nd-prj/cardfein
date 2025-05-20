package cardfein.kro.kr.controller;

import java.util.List;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.service.FitCardService;
import cardfein.kro.kr.service.FitCardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FitCardController implements RestController{

	FitCardService service = new FitCardServiceImpl();
		
	public FitCardController() {
			
	}
	
	/**
	 * 맟춤카드 검색 - 카테고리에 해당하는 카드 정보 다 가져오기
	 */
	public List<CardDto> getCardsByCategory(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String category = request.getParameter("category");
		
		List<CardDto> list = service.getCardsByCategory(category);
		
		return list;
		
	}
	
	/**
	 * 카드 상세 정보 가져오기
	 */
	public CardDto getCardsDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int cardNo = Integer.parseInt(request.getParameter("cardNo"));
		
		CardDto cardDto = service.getCardsDetail(cardNo);
		
		return cardDto;	
	}
	
	/**
	 * 카드 상세 정보 클릭하면 view + 1
	 */
	public boolean incrementCardView(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int cardNo = Integer.parseInt(request.getParameter("cardNo"));
		
		boolean result = service.incrementCardView(cardNo);
		
		return result;
	}
	
}
