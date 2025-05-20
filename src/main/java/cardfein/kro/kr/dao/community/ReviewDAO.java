package cardfein.kro.kr.dao.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.ReplyDto;
import cardfein.kro.kr.dto.ReviewDto;

public interface ReviewDAO {
	
	/**
	 * 리뷰 목록 전체 검색
	 * @return 리뷰 리스트
	 * @throws SQLException
	 */
	List<ReviewDto> selectAll(int startRow, int pageSize) throws SQLException;

	/**
	 * 페이지네이션 - 전체 리뷰 수
	 * @return 전체 리뷰 수
	 * @throws SQLException
	 */
	int getTotalReviewCount() throws SQLException;
	
	/**
	 * 해당 댓글 수
	 * @return 해당 글 댓글 수
	 * @throws SQLException
	 */
	int getReplyCount(int reviewNo) throws SQLException;
	
	/**
	 * 키워드로 리뷰 검색
	 * @param keyword
	 * @param startRow
	 * @param pageSize
	 * @return 키워드로 검색된 리뷰 리스트
	 * @throws SQLException
	 */
	List<ReviewDto> selectAllByKeyword(String keyword, int startRow, int pageSize) throws SQLException;
	
	/**
	 * 키워드로 검색된 리뷰 수
	 * @param keyword
	 * @return 키워드로 검색된 리뷰 수
	 * @throws SQLException
	 */
	int getReviewCountByKeyword(String keyword) throws SQLException;
	
	/**
	 * 리뷰번호로 검색된 리뷰상세
	 * @param reviewNo
	 * @return
	 * @throws SQLException
	 */
	ReviewDto selectDetailByReviewNo(int reviewNo) throws SQLException;
	
	/**
	 * 리뷰 내용 수정
	 * @param reviewNo
	 * @return 리뷰 수정 결과 (0/1)
	 * @throws SQLException
	 */
	int updateReview(ReviewDto review) throws SQLException;
	
	/**
	 * 리뷰 게시물 조회 시 조회수 증가
	 * @param reviewNo
	 * @return 조회수 증가 결과 (0/1)
	 * @throws SQLException
	 */
	int updateReviewViews(int reviewNo) throws SQLException;
	
	/**
	 * 리뷰 삭제
	 * @param reviewNo
	 * @return 리뷰 삭제 결과 (0/1)
	 * @throws SQLException
	 */
	int deleteReview(int reviewNo) throws SQLException;
	
	/**
	 * 회원 보유 카드 조회
	 * @param user_no
	 * @return 회원 보유 카드 리스트
	 * @throws SQLException
	 */
	List<ReviewDto> selectUserCards(int user_no) throws SQLException;
	
	/**
	 * 리뷰 등록
	 * @param review
	 * @return 리뷰 등록 결과 (0/1)
	 * @throws SQLException
	 */
	int insertReview(ReviewDto review) throws SQLException;
	
	/**
	 * 댓글 등록
	 * @param review
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
