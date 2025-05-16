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
public class CardCoverLikeController implements RestController{
	
	CardCoverLikeService service = new CardCoverLikeServiceImpl();
	
	
	/**
	 * 사용자가 특정 카드 커버에 좋아요를 눌렀는지 확인하고,
	 * 누르지 않았다면 좋아요 추가 후 현재 좋아요 수를 Json 형태로 응답
	 */
	public Object liked(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int coverNo = Integer.parseInt(request.getParameter("cover_no"));
        int userNo = Integer.parseInt(request.getParameter("user_no"));

        /**
    	 * 이미 좋아요를 눌렀는지 확인
    	 */
        boolean liked = service.hasUserLiked(coverNo, userNo);
        
        /**
    	 * 좋아요를 아직 누르지 않았다면 추가
    	 */
        if (!liked) {
        	service.addLike(coverNo, userNo);
        	return true;
        } else {
        	service.removeLike(coverNo, userNo);
        	return false;
        }
        
        // 처리 이후 상태를 다시 조회
//        boolean newLiked = service.hasUserLiked(coverNo, userNo);
        
        /**
    	 * 갱신된 좋아요 수 조회
    	 * 리턴 값으로 좋아요 추가 성공 실패, 좋아요 취소 성공 실패?
    	 */
		/* Map<String, Object> result = new HashMap<String, Object>(); */
		result.put("liked", liked);
		
		return result;
    }

}
