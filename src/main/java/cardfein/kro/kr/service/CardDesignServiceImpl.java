package cardfein.kro.kr.service;

import java.sql.SQLException;
import cardfein.kro.kr.dao.CardDesignDAO;
import cardfein.kro.kr.dao.CardDesignDAOImpl;

public class CardDesignServiceImpl implements CardDesignService {
	
	private static final CardDesignServiceImpl instance = new CardDesignServiceImpl();

    private final CardDesignDAO cardDesignDAO;

    private CardDesignServiceImpl() {
        this.cardDesignDAO = CardDesignDAOImpl.getInstance();
    }

    public static CardDesignServiceImpl getInstance() {
        return instance;
    }
	
	@Override
	public String getBaseImageUrl() {
		String coverDesign = cardDesignDAO.getDefaultCardDesign();
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
	public void saveFinalCard(String title, String finalCoverUrl) {
	    try {
	        // user_no는 DAO 내부에서 2로 고정되어 있으므로 생략
	        cardDesignDAO.saveFinalCardImage(2, title, finalCoverUrl);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

}
