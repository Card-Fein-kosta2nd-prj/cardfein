package cardfein.kro.kr.service;

import java.util.List;

import cardfein.kro.kr.dao.CardRankingDAO;
import cardfein.kro.kr.dao.CardRankingDAOImpl;
import cardfein.kro.kr.dto.CardCoverDto;

public class CardRankingServiceImpl implements CardRankingService {

	private static final CardRankingServiceImpl instance = new CardRankingServiceImpl();
	
	private final CardRankingDAO cardRankingDAO;
	
	public CardRankingServiceImpl() {
		this.cardRankingDAO = CardRankingDAOImpl.getInstance();
	}
	
	public static CardRankingServiceImpl getInstance() {
		return instance;
	}

	@Override
	public List<CardCoverDto> getAllCovers() {
		
		return cardRankingDAO.findAllCovers();
	}
	
	@Override
	public List<CardCoverDto> getTopCovers() {
		
		return null;
	}

}
