package cardfein.kro.kr.controller.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.controller.RestController;
import cardfein.kro.kr.dto.ReviewDto;
import cardfein.kro.kr.service.community.ReviewService;
import cardfein.kro.kr.service.community.ReviewServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ReviewController implements RestController{
	ReviewService service = new ReviewServiceImpl();
	
	public ReviewController() {
		
	}//생성자
	
	public Object selectAll(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		System.out.println("여기오니?");
		List<ReviewDto> reviewList = service.selectAll();
		
		System.out.println(reviewList);
		return reviewList;
	}
	
}//class
