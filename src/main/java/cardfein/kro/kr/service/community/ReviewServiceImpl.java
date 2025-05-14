package cardfein.kro.kr.service.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.community.ReviewDAO;
import cardfein.kro.kr.dao.community.ReviewDAOImpl;
import cardfein.kro.kr.dto.ReviewDto;

public class ReviewServiceImpl implements ReviewService {
	ReviewDAO dao = new ReviewDAOImpl();
	
	@Override
	public List<ReviewDto> selectAll() throws SQLException {
		List<ReviewDto> reviewList = dao.selectAll();
		
		return reviewList;
	}

}//class
