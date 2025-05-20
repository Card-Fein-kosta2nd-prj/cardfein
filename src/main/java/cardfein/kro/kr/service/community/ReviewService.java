package cardfein.kro.kr.service.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.ReplyDto;
import cardfein.kro.kr.dto.ReviewDto;

public interface ReviewService {

	/**
	 * 리뷰 전체 조회
	 * @param startRow
	 * @param pageSize
	 * @return 전체 리뷰 리스트
	 * @throws SQLException
	 */
	List<ReviewDto> selectAll(int startRow, int pageSize) throws SQLException;
	
	/**
	 * 전체 리뷰 수
	 * @return 전체 리뷰 수
	 * @throws SQLException
	 */
	int getTotalReviewCount() throws SQLException;
	
	/**
	 * 해당 글 댓글 수
	 * @return 해당 글 댓글 수
	 * @throws SQLException
	 */
	int getReplyCount(int reviewNo) throws SQLException;
	
	/**
	 * 검색어로 조회한 리뷰 리스트
	 * @param keyword
	 * @return 검색어로 조회한 리뷰 리스트
	 * @throws SQLException
	 */
	int getTotalReviewCountByKeyword(String keyword) throws SQLException;

	/**
	 * 검색어로 조회한 리뷰 수
	 * @param keyword
	 * @param startRow
	 * @param pageSize
	 * @return 검색어로 조회한 리뷰 수
	 * @throws SQLException
	 */
	List<ReviewDto> selectAllByKeyword(String keyword, int startRow, int pageSize) throws SQLException;
	
	/**
	 * 리뷰 번호로 조회한 리뷰 상세
	 * @param reviewNo
	 * @return 리뷰 번호로 조회한 리뷰 상세
	 * @throws SQLException
	 */
	public ReviewDto selectDetailByReviewNo(int reviewNo, boolean flag) throws SQLException;
	
	/**
	 * 리뷰 내용 수정
	 * @param review
	 * @return
	 * @throws SQLException
	 */
	int updateReview(ReviewDto review) throws SQLException;
	
	/**
	 * 리뷰 삭제
	 * @param reviewNo
	 * @return 리뷰 삭제 결과 (0/1)
	 * @throws SQLException
	 */
	int deleteReview(int reviewNo) throws SQLException;
	
	/**
	 * 회원 보유 카드 조회
	 * @param userNo
	 * @return 회원 보유 카드 리스트
	 * @throws SQLException
	 */
	List<ReviewDto> selectUserCards(int userNo) throws SQLException;
	
	/**
	 * 리뷰 등록
	 * @param review
	 * @return 리뷰 등록 결과(0/1)
	 * @throws SQLException
	 */
	int insertReview(ReviewDto review) throws SQLException;
	
	/**
	 * 댓글 등록
	 * @param reply
	 * @return 댓글 등록 결과 (0/1)
	 * @throws SQLException
	 */
	int insertReply(ReplyDto reply) throws SQLException;
	
	/**
	 * 댓글 삭제
	 * @param replyNum
	 * @return 댓글 삭제 결과 (0/1)
	 * @throws SQLException
	 */
	int deleteReply(int replyNum) throws SQLException;
	
}
