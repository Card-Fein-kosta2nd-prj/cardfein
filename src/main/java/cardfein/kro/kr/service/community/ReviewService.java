package cardfein.kro.kr.service.community;

import java.sql.SQLException;
import java.util.List;

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
	ReviewDto selectDetailByReviewNo(int reviewNo) throws SQLException;
	
}
