package cardfein.kro.kr.controller;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import cardfein.kro.kr.service.CardCoverLikeService;
import cardfein.kro.kr.service.CardCoverLikeServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 카드 커버 좋아요 관련 요청을 처리하는 controller
 */
public class CardCoverLikeController {
	
	private static final CardCoverLikeController instance = new CardCoverLikeController();
	
	private final CardCoverLikeService likeService;
	
	private CardCoverLikeController() {
		this.likeService = CardCoverLikeServiceImpl.getInstance();
	}
	
	public static CardCoverLikeController getInstance() {
		return instance;
	}
	
	
	/**
	 * 사용자가 특정 카드 커버에 좋아요를 눌렀는지 확인하고,
	 * 누르지 않았다면 좋아요 추가 후 현재 좋아요 수를 Json 형태로 응답
	 */
	public void liked(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int coverNo = Integer.parseInt(request.getParameter("coverNo"));
        int userNo = Integer.parseInt(request.getParameter("userNo"));

        /**
    	 * 이미 좋아요를 눌렀는지 확인
    	 */
        boolean liked = likeService.hasUserLiked(coverNo, userNo);
        
        /**
    	 * 좋아요를 아직 누르지 않았다면 추가
    	 */
        if (!liked) {
        	likeService.likeCover(coverNo, userNo);
        }
        
        /**
    	 * 갱신된 좋아요 수 조회
    	 */
        int likeCount = likeService.getLikeCount(coverNo);

        Map<String, Object> result = new HashMap<>();
        result.put("liked", liked);
        result.put("likeCount", likeCount);

        String json = new Gson().toJson(result);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(json);
    }

}
