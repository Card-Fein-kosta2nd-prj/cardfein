package cardfein.kro.kr.service;

public interface CardCoverLikeService {

	boolean likeCover(int coverNo, int userNo);
	
	int getLikeCount(int coverNo);
}
