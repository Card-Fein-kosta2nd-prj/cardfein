package cardfein.kro.kr.controller.community;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import cardfein.kro.kr.controller.RestController;
import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.dto.ReplyDto;
import cardfein.kro.kr.dto.ReviewDto;
import cardfein.kro.kr.service.community.ReviewService;
import cardfein.kro.kr.service.community.ReviewServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ReviewDetailAjaxController implements RestController {
	ReviewService service = new ReviewServiceImpl();
	
	public ReviewDetailAjaxController() {
		
	}//생성자
	
	public Object updateReview(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		//1. 파라미터 받기
		String reviewNoStr = request.getParameter("reviewNo");
		int reviewNo = Integer.parseInt(reviewNoStr);
		String reviewTitle = request.getParameter("reviewTitle");
		String content = request.getParameter("reviewContent");
		
		//2. DTO 구성
		ReviewDto review = new ReviewDto();
		review.setReviewNo(reviewNo);
		review.setReviewTitle(reviewTitle);
		review.setReviewContent(content);
		
		//3. 서비스 호출
		service.updateReview(review);
		
		//4. 응답 데이터 구성
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("message", "리뷰가 성공적으로 수정되었습니다.");
		result.put("reviewNo", reviewNo);
		
		return result;
	}
	
	public Object deleteReview(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    String reviewNoStr = request.getParameter("reviewNo");
	    System.out.println("컨트롤러 : " + reviewNoStr);
	    boolean flag = false;
	    if (reviewNoStr == null || reviewNoStr.trim().isEmpty()) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        Map<String, Object> error = new HashMap<>();
	        error.put("status", "fail");
	        error.put("message", "리뷰 번호가 전달되지 않았습니다.");
	        
	        return error;
	    }

	    int reviewNo = Integer.parseInt(reviewNoStr);

	    try {
	        service.deleteReview(reviewNo);
	        
	        System.out.println(reviewNo);

	        Map<String, Object> result = new HashMap<>();
	        result.put("status", "success");
	        result.put("message", "리뷰가 성공적으로 삭제되었습니다.");
	        
	        return result;
	        
	    } catch (SQLException e) {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        Map<String, Object> error = new HashMap<>();
	        error.put("status", "fail");
	        error.put("message", "리뷰 삭제 중 오류가 발생했습니다.");
	        
	        return error;
	    }
	}
	
	
	public Object insertReview(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    String title = request.getParameter("reviewTitle");
	    String content = request.getParameter("reviewContent");
	    int rating = Integer.parseInt(request.getParameter("rating"));
	    int cardNo = Integer.parseInt(request.getParameter("cardNo"));
	    int userNo = Integer.parseInt(request.getParameter("userNo"));
	    
	    ReviewDto review = new ReviewDto();
	    review.setReviewTitle(title);
	    review.setReviewContent(content);
	    review.setRating(rating);
	    review.setCardNo(cardNo);
	    review.setUserNo(userNo);
	    
		
		Map<String, Object> result = new HashMap<>();
		int insertResult = service.insertReview(review); // 1이면 성공, 0이면 실패

	    if (insertResult > 0) {
	        result.put("status", "success");
	        result.put("message", "리뷰가 등록되었습니다.");
	    } else {
	        result.put("status", "fail");
	        result.put("message", "리뷰 등록에 실패했습니다.");
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	    }

	    return result;
	}
	
	public Object insertReply(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    Map<String, Object> result = new HashMap<>();

	    try {
	        String reviewNoStr = request.getParameter("reviewNo");
	        String content = request.getParameter("replyContent");

	        HttpSession session = request.getSession();
	        LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");

	        int reviewNo = Integer.parseInt(reviewNoStr);
	        ReplyDto reply = new ReplyDto();
	        reply.setReplyContent(content);
	        reply.setParentReviewNo(reviewNo);
	        reply.setUserNo(loginUser.getUserNo());

	        service.insertReply(reply);

	        result.put("status", "success");
	        result.put("message", "댓글 등록 완료");
	    } catch (Exception e) {
	        e.printStackTrace(); // 로그로 남기는 것도 중요!
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        result.put("status", "fail");
	        result.put("message", "댓글 등록 중 오류 발생");
	    }

	    return result;
	}
	
	public Object deleteReply(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    try {
	        int replyNum = Integer.parseInt(request.getParameter("replyNum"));
	        System.out.println("삭제번호 : " + replyNum);
	        service.deleteReply(replyNum);

	        return Map.of("status", "success", "message", "댓글 삭제 성공");
	    } catch (Exception e) {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        return Map.of("status", "fail", "message", "댓글 삭제 실패");
	    }
	}
	
}//class
