package cardfein.kro.kr.service;

import cardfein.kro.kr.dao.CardCoverLikeDAO;
import cardfein.kro.kr.dao.CardCoverLikeDAOImpl;

public class CardCoverLikeServiceImpl implements CardCoverLikeService {
	
	private static final CardCoverLikeServiceImpl instance = new CardCoverLikeServiceImpl();

    private final CardCoverLikeDAO likeDAO;

    private CardCoverLikeServiceImpl() {
        this.likeDAO = CardCoverLikeDAOImpl.getInstance();
    }

    public static CardCoverLikeServiceImpl getInstance() {
        return instance;
    }
	
	@Override
	public void likeCover(int coverNo, int userNo) {
		if (!likeDAO.hasUserLiked(coverNo, userNo)) {
			likeDAO.addLike(coverNo, userNo);
			
		}
		
	}

	@Override
	public int getLikeCount(int coverNo) {
		
		return likeDAO.getLikeCount(coverNo);
	}
	
	@Override
	public boolean hasUserLiked(int coverNo, int userNo) {
		// TODO Auto-generated method stub
		return false;
	}

}
