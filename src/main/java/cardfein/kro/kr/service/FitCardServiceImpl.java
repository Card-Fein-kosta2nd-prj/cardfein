package cardfein.kro.kr.service;

import java.util.List;

import cardfein.kro.kr.dao.FitCardDAO;
import cardfein.kro.kr.dao.FitCardDAOImpl;
import cardfein.kro.kr.dto.CardDto;

public class FitCardServiceImpl implements FitCardService{
	
	FitCardDAO dao = new FitCardDAOImpl();

	@Override
	public List<CardDto> getCardsByCategory(String category) throws Exception {
		
		return dao.getCardsByCategory(category);
	}
	
	@Override
	public CardDto getCardsDetail(int cardNo) {
		
		return dao.getCardsDetail(cardNo);
	}
}
