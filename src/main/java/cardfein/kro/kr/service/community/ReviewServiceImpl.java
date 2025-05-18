package cardfein.kro.kr.service.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.community.ReviewDAO;
import cardfein.kro.kr.dao.community.ReviewDAOImpl;
import cardfein.kro.kr.dto.ReplyDto;
import cardfein.kro.kr.dto.ReviewDto;

public class ReviewServiceImpl implements ReviewService {
	ReviewDAO dao = new ReviewDAOImpl();
	
	@Override
	public List<ReviewDto> selectAll(int startRow, int pageSize) throws SQLException {
		
		List<ReviewDto> reviewList = dao.selectAll(startRow, pageSize);
		
		return reviewList;
	}

	@Override
	public int getTotalReviewCount() throws SQLException {
		
		return dao.getTotalReviewCount();
	}
	
	@Override
	public int getReplyCount(int reviewNo) throws SQLException {
		
		return dao.getReplyCount(reviewNo);
	}
	
	@Override
	public int getTotalReviewCountByKeyword(String keyword) throws SQLException {
		return dao.getReviewCountByKeyword(keyword);
	}

	@Override
	public List<ReviewDto> selectAllByKeyword(String keyword, int startRow, int pageSize) throws SQLException {
		return dao.selectAllByKeyword(keyword, startRow, pageSize);
	}

	@Override
	public ReviewDto selectDetailByReviewNo(int reviewNo, boolean flag) throws SQLException {
		
		if(flag) {
			if(dao.updateReviewViews(reviewNo) == 0) {
				throw new SQLException("조회수 증가 오류로 조회할 수 없습니다.");
			}
		}
		
		ReviewDto review = dao.selectDetailByReviewNo(reviewNo);
		
		if(review == null) {
			throw new SQLException("리뷰 상세보기 오류가 발생했습니다.");
		}
		
		return review;
	}

	@Override
	public int updateReview(ReviewDto review) throws SQLException {
		
		return dao.updateReview(review);
	}

	@Override
	public int deleteReview(int reviewNo) throws SQLException {
		int result = dao.deleteReview(reviewNo);
		
		if(result == 0) {
			throw new SQLException("오류로 인해 삭제되지 않았습니다.");
		}
		
		return result;
	}
	
	public List<ReviewDto> selectUserCards(int userNo) throws SQLException {
		List<ReviewDto> result = dao.selectUserCards(userNo);
		
		if(result == null) {
			throw new SQLException("회원 보유 카드 정보를 불러오지 못했습니다.");
		}
		
		return result;
	}

	@Override
	public int insertReview(ReviewDto review) throws SQLException {
		int result = dao.insertReview(review);
		
		if(result == 0) {
			throw new SQLException("리뷰를 등록하지 못했습니다.");
		}
		
		return result;
	}

	public int insertReply(ReplyDto reply) throws SQLException {
		int result = dao.insertReply(reply);
		
		if(result == 0) {
			throw new SQLException("댓글을 등록하지 못했습니다.");
		}
		
		return result;
	}

	@Override
	public int deleteReply(int replyNum) throws SQLException {
		int result = dao.deleteReply(replyNum);
		
		if(result == 0) {
			throw new SQLException("오류로 인해 삭제되지 않았습니다.");
		}
		
		return result;
	}
	
}//class
