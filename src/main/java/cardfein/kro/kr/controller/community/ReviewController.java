package cardfein.kro.kr.controller.community;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cardfein.kro.kr.controller.RestController;
import cardfein.kro.kr.dto.PageCnt;
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
		System.out.println("selectAll(+검색 +페이징) 진입");

		// 1. pageNo 받기 (기본값 1)
		String pageParam = request.getParameter("pageNo");
		int pageNo = 1;
		if (pageParam != null && !pageParam.isEmpty()) {
			pageNo = Integer.parseInt(pageParam);
		}

		// 2. 검색어 받기
		String keyword = request.getParameter("keyword");
		boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();

		// 3. 전체 게시글 수 조회 (조건 있음/없음)
		int totalCount = hasKeyword
				? service.getTotalReviewCountByKeyword(keyword)
				: service.getTotalReviewCount();

		// 4. 페이지 계산
		PageCnt page = new PageCnt(totalCount, pageNo);

		// 5. 해당 페이지 게시글 목록 조회
		List<ReviewDto> reviewList = hasKeyword
				? service.selectAllByKeyword(keyword, page.getStartRow(), page.getPageSize())
				: service.selectAll(page.getStartRow(), page.getPageSize());

		// 6. 각 게시글에 댓글 수(replyCount) 주입
		for (ReviewDto dto : reviewList) {
			int replyCount = service.getReplyCount(dto.getReviewNo());
			dto.setReplyCount(replyCount);
		}

		// 7. 응답 데이터 구성
		Map<String, Object> result = new HashMap<>();
		result.put("list", reviewList);
		result.put("page", page);
		if (hasKeyword) {
			result.put("keyword", keyword);
		}

		return result;
	}
	
}//class
