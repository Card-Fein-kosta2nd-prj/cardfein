package cardfein.kro.kr.dao;

import java.sql.SQLException;

public interface CardCoverLikeDAO {

	/**
	 * SELECT COUNT(*) FROM cover_like WHERE cover_no = ? AND user_no = ?
	 * 사용자가 특정 커버에 이미 좋아요를 눌렀는지 확인
	 */
	boolean hasUserLiked(int coverNo, int userNo);
	
	/**
	 * insert into cover_like(cover_no, user_no) values (?, ?);
	 * 사용자가 특정 카드 커버에 좋아요를 추가
	 */
	void likeCover(int coverNo, int userNo) throws SQLException;
	
	void unlikeCover(int coverNo, int userNo) throws SQLException;
	
}
