package cardfein.kro.kr.service;

import java.sql.SQLException;
import cardfein.kro.kr.dao.CardDesignDAO;
import cardfein.kro.kr.dao.CardDesignDAOImpl;

public class CardDesignServiceImpl implements CardDesignService {
	
	CardDesignDAO dao = new CardDesignDAOImpl();
	
	@Override
	public String getBaseImageUrl() {
		String coverDesign = dao.getDefaultCardDesign();
		return coverDesign;
	}
	
	/*
	 * @Override public void saveFinalCard(int userNo, String title, String
	 * finalCoverUrl) {
	 * 
	 * try { cardDesignDAO.saveFinalCardImage(userNo, title, finalCoverUrl); } catch
	 * (SQLException e) { e.printStackTrace(); } }
	 */
	@Override
	public void saveFinalCard(int userNo, String title, String finalCoverUrl) {
	    try {
	        // user_no는 DAO 내부에서 2로 고정되어 있으므로 생략
	        dao.saveFinalCardImage(userNo, title, finalCoverUrl);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

}
