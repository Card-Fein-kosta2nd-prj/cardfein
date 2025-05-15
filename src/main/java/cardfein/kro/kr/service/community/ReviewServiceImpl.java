package cardfein.kro.kr.service.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.community.ReviewDAO;
import cardfein.kro.kr.dao.community.ReviewDAOImpl;
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
	public ReviewDto selectDetailByReviewNo(int reviewNo) throws SQLException {
		
		return dao.selectDetailByReviewNo(reviewNo);
	}
}//class
