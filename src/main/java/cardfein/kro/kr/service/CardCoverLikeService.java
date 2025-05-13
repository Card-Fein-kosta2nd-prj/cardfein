package cardfein.kro.kr.service;

public interface CardCoverLikeService {

	void likeCover(int coverNo, int userNo);
	
	int getLikeCount(int coverNo);
	
	boolean hasUserLiked(int coverNo, int userNo);
}
