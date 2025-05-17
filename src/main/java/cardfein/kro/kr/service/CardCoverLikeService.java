package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

public interface CardCoverLikeService {

	void addLike(int coverNo, int userNo) throws SQLException;
	void removeLike(int coverNo, int userNo) throws SQLException;
	
	boolean hasUserLiked(int coverNo, int userNo);
}
