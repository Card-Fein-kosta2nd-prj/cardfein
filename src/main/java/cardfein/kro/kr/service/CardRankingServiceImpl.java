package cardfein.kro.kr.service;

import java.util.List;

import cardfein.kro.kr.dao.CardRankingDAO;
import cardfein.kro.kr.dao.CardRankingDAOImpl;
import cardfein.kro.kr.dto.CardCoverDto;

public class CardRankingServiceImpl implements CardRankingService {

	CardRankingDAO dao = new CardRankingDAOImpl();
	

	@Override
	public List<CardCoverDto> getAllCovers() {
		
		return dao.findAllCovers();
	}
	
	@Override
	public List<CardCoverDto> getTopCovers() {
		
		return dao.findTopCovers();
	}

}
