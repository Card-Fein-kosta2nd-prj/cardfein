package cardfein.kro.kr.controller;

import java.io.PrintWriter;
import java.sql.SQLException;

import cardfein.kro.kr.service.CardDesignService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CardCoverController {
	private CardDesignService service;
	
	public CardCoverController() {
		
	}
	
	/**
	 * 기본 카드 이미지 반환
	 */
	public String getBaseImage() throws Exception {
		return service.getBaseImageUrl();
	}
	
	/**
	 * 완성된 커버 이미지 저장
	 */
	public void saveFinalCard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int userId = Integer.parseInt(request.getParameter("userNo"));
		String title = request.getParameter("title");
		String finalImageUrl = request.getParameter("finalImageUrl");
		
		service.saveFinalCard(userId, title, finalImageUrl);
		
		PrintWriter out = response.getWriter();
		
	}
}
