package cardfein.kro.kr.service;

import java.sql.SQLException;

import cardfein.kro.kr.dao.CardDesignDAO;
import cardfein.kro.kr.dao.CardDesignDAOImpl;

public class CardDesignServiceImpl implements CardDesignService {
	CardDesignDAO cardDesignDAO = new CardDesignDAOImpl();
	
	@Override
	public String getBaseImageUrl() {
		String coverDesign = cardDesignDAO.getDefaultCardDesign();
		return coverDesign;
	}
	
	@Override
	public void saveFinalCard(int userNo, String title, String finalCoverUrl) {
		
		try {
			cardDesignDAO.saveFinalCardImage(userNo, title, finalCoverUrl);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
