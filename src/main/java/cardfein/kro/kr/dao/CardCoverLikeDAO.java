package cardfein.kro.kr.dao;

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
	void addLike(int coverNo, int userNo);
	
	/**
	 * select count(*) from cover_like where cover_no = ?
	 * 해당 커버의 좋아요 수
	 */
	int getLikeCount(int coverNo);
}
