package cardfein.kro.kr.controller.community;

import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import cardfein.kro.kr.controller.Controller;
import cardfein.kro.kr.controller.ModelAndView;
import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.dto.ReviewDto;
import cardfein.kro.kr.service.community.ReviewService;
import cardfein.kro.kr.service.community.ReviewServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ReviewDetailController implements Controller {
	ReviewService service = new ReviewServiceImpl();
	
	public ReviewDetailController() {
		
	}//생성자
	
	public ModelAndView selectDetailByReviewNo(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		System.out.println("selectDetailByReviewNo(상세) 진입");

		String reviewNoStr = request.getParameter("reviewNo");
		int reviewNo = Integer.parseInt(reviewNoStr);
		
		//1. 수정 후 돌아온 경우가 아니면 세션 체크
		boolean flag = request.getParameter("flag") == null; //조회일 경우 (수정X)
		System.out.println("첫번째 flag: " + flag);
		
		if(flag) {
			//세션에서 조회한 게시글 번호 목록 확인
			HttpSession session = request.getSession();
			@SuppressWarnings("unchecked")
			Set<Integer> viewedReviewNo = (Set<Integer>) session.getAttribute("viewedReviewNo");
			
			if(viewedReviewNo == null) {
				viewedReviewNo = new HashSet<>();
				session.setAttribute("viewedReviewNo", viewedReviewNo);
			}
			
			//이미 본 게시글이라면 조회수 증가하지 않음
			if(viewedReviewNo.contains(reviewNo)) {
				flag = false;
			} else {
				viewedReviewNo.add(reviewNo); //처음 본 글이므로 기록 추가
			}
			
			System.out.println("두번째 flag: " + flag);
		}

		// 2. 상세 조회
		ReviewDto review = service.selectDetailByReviewNo(reviewNo, flag);

		// 3. 전달
		request.setAttribute("review", review);
		
		return new ModelAndView("/views/community/com_detail.jsp"); //forward 방식
	}
	
	public ModelAndView selectUserCards(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		//1.세션에서 userNo 가져오기
		HttpSession session = request.getSession();
		LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
		int loginUserNo = loginUser.getUserNo();
		
		//2. 해당 사용자의 보유카드 목록 조회
		List<ReviewDto> list = service.selectUserCards(loginUserNo);
		
		//3. JSP에 전달
		request.setAttribute("userCardList", list);
		
		//4. 글쓰기 페이지로 이동
		return new ModelAndView("/views/community/write_content.jsp"); //forward 방식
	}

}
