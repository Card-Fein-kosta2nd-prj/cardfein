package cardfein.kro.kr.controller.community;

import java.sql.SQLException;

import cardfein.kro.kr.controller.Controller;
import cardfein.kro.kr.controller.ModelAndView;
import cardfein.kro.kr.dto.ReviewDto;
import cardfein.kro.kr.service.community.ReviewService;
import cardfein.kro.kr.service.community.ReviewServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ReviewDetailController implements Controller {
	ReviewService service = new ReviewServiceImpl();
	
	public ReviewDetailController() {
		
	}//생성자
	
	public ModelAndView selectDetailByReviewNo(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		System.out.println("selectDetailByReviewNo(상세) 진입");

		// 1. 리뷰번호 받기
		String reviewNo = request.getParameter("reviewNo");

		// 2. 상세 조회
		ReviewDto review = service.selectDetailByReviewNo(Integer.parseInt(reviewNo));

		request.setAttribute("review", review);
		
		return new ModelAndView("/views/community/com_detail.jsp"); //forward 방식
	}
}
