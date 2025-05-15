package cardfein.kro.kr.service;

import java.sql.SQLException;

public interface CardCoverLikeService {

	void addLike(int coverNo, int userNo) throws SQLException;
	void removeLike(int coverNo, int userNo) throws SQLException;
	
	int getLikeCount(int coverNo);
	
	boolean hasUserLiked(int coverNo, int userNo);
}
