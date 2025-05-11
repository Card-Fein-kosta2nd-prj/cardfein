package cardfein.kro.kr.controller;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import cardfein.kro.kr.service.CardCoverLikeService;
import cardfein.kro.kr.service.CardCoverLikeServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CardCoverLikeController {
	
	private static final CardCoverLikeController instance = new CardCoverLikeController();
	
	private final CardCoverLikeService likeService;
	
	private CardCoverLikeController() {
		this.likeService = CardCoverLikeServiceImpl.getInstance();
	}
	
	public static CardCoverLikeController getInstance() {
		return instance;
	}
	
	public void liked(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int coverNo = Integer.parseInt(request.getParameter("coverNo"));
        int userNo = Integer.parseInt(request.getParameter("userNo"));

        boolean liked = likeService.likeCover(coverNo, userNo);
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
