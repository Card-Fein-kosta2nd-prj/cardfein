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
		
	public List<CardDto> getCardsByCategory(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String category = request.getParameter("category");
		
		List<CardDto> list = service.getCardsByCategory(category);
		
		return list;
		
	}
	
	public CardDto getCardsDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int cardNo = Integer.parseInt(request.getParameter("cardNo"));
		
		CardDto cardDto = service.getCardsDetail(cardNo);
		
		return cardDto;
		
	}
	
}
