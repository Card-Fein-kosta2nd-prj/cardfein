package cardfein.kro.kr.controller;

import java.io.IOException;

import cardfein.kro.kr.dao.CardCoverLikeDAO;
import cardfein.kro.kr.dao.CardCoverLikeDAOImpl;
import cardfein.kro.kr.dao.CardDesignDAO;
import cardfein.kro.kr.dao.CardDesignDAOImpl;
import cardfein.kro.kr.dao.CardRankingDAO;
import cardfein.kro.kr.dao.CardRankingDAOImpl;
import cardfein.kro.kr.service.CardCoverLikeService;
import cardfein.kro.kr.service.CardCoverLikeServiceImpl;
import cardfein.kro.kr.service.CardDesignService;
import cardfein.kro.kr.service.CardDesignServiceImpl;
import cardfein.kro.kr.service.CardRankingService;
import cardfein.kro.kr.service.CardRankingServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *  사용자의 모든 요청을 처리할 진입점 Controller이다(FrontController의 역할한다)
 */
@WebServlet(urlPatterns = "/ajax" , loadOnStartup = 1)

public class AjaxDispatcherServlet extends HttpServlet {
	private CardDesignController cardDesignController;
	private CardRankingController cardRankingController;
	private CardCoverLikeController cardCoverLikeController;
	
	@Override
	public void init() throws ServletException {
		cardDesignController = CardDesignController.getInstance();
		cardRankingController = CardRankingController.getInstance();
		cardCoverLikeController = CardCoverLikeController.getInstance();
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String action = request.getParameter("action");
		
		if (action == null) {
			response.getWriter().print("오류발생");
			return;
		}
		
		switch (action) {
		case "getBaseImage":
			try {
				cardDesignController.getBaseImage(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case "saveFinalCard":
			try {
				cardDesignController.saveFinalCard(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case "getAllCardCover":
			try {
				cardRankingController.getAllCardCover(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case "likedCardCover":
			try {
				cardCoverLikeController.liked(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;		
			
		default:
			response.getWriter().print("존재하지 않는 키입니다.");
				
		}
	}
}









