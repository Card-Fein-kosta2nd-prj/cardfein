package cardfein.kro.kr.controller;

import java.io.IOException;

import cardfein.kro.kr.dao.CardDesignDAO;
import cardfein.kro.kr.dao.CardDesignDAOImpl;
import cardfein.kro.kr.service.CardDesignService;
import cardfein.kro.kr.service.CardDesignServiceImpl;
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
@MultipartConfig( //어노테이션을 통해  서블릿이 파일 업로드 기능을 할 수 있도록 웹 컨테이너에 지시
        maxFileSize = 1024 * 1024 * 5, //5M - 한 번에 업로드 할 수 있는 파일 크기 제한
       maxRequestSize = 1024 * 1024 * 50 //50M -전체 요청의 크기 제한. 기본값은 무제한 
)
public class AjaxDispatcherServlet extends HttpServlet {
	private CardCoverController cardCoverController;
	
	@Override
	public void init() throws ServletException {
		CardDesignDAO dao = new CardDesignDAOImpl();
		CardDesignService service = new CardDesignServiceImpl();
		cardCoverController = new CardCoverController();
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
				cardCoverController.getBaseImage(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case "saveFinalCard":
			try {
				cardCoverController.saveFinalCard(request, response);
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









