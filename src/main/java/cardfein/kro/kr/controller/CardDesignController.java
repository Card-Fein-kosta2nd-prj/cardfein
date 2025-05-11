package cardfein.kro.kr.controller;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import cardfein.kro.kr.service.CardDesignService;
import cardfein.kro.kr.service.CardDesignServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CardDesignController {
	private static final CardDesignController instance = new CardDesignController();

    private final CardDesignService service;

    private CardDesignController() {
        this.service = CardDesignServiceImpl.getInstance(); // ✅ 싱글톤 서비스 주입
    }

    public static CardDesignController getInstance() {
        return instance;
    }
	
	/**
	 * 기본 카드 이미지 반환
	 */
	public void getBaseImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String baseImageUrl = service.getBaseImageUrl();
		
		Map<String, String> result = new HashMap<String, String>();
		result.put("baseImageUrl", baseImageUrl);
		
		Gson gson = new Gson();
		String jsonResponse = gson.toJson(result);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonResponse);
	}
	
	/**
	 * 완성된 커버 이미지 저장
	 */
	public void saveFinalCard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int userId = Integer.parseInt(request.getParameter("userNo"));
		String title = request.getParameter("title");
		String finalImageUrl = request.getParameter("finalImageUrl");
		
		service.saveFinalCard(userId, title, finalImageUrl);
		
		Map<String, String> result = new HashMap<String, String>();
		result.put("status", "success");
		result.put("message", "커버 이미지가 저장되었습니다.");
		
		Gson gson = new Gson();
		String jsonResponse = gson.toJson(result);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonResponse);
	}
}
