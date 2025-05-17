package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.CardCoverLikeDAO;
import cardfein.kro.kr.dao.CardCoverLikeDAOImpl;

public class CardCoverLikeServiceImpl implements CardCoverLikeService {
	
	CardCoverLikeDAO dao = new CardCoverLikeDAOImpl();
	
	@Override
	public void addLike(int coverNo, int userNo) throws SQLException {
		
		dao.likeCover(coverNo, userNo);
	}
	
	@Override
	public void removeLike(int coverNo, int userNo) throws SQLException {
		
		dao.unlikeCover(coverNo, userNo);	
	}
	
	@Override
	public boolean hasUserLiked(int coverNo, int userNo) {
		try {
			return dao.hasUserLiked(coverNo, userNo);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
