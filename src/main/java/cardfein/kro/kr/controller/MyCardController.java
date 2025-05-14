package cardfein.kro.kr.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.service.MyCardService;
import cardfein.kro.kr.service.MyCardServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 회원보유카드 관리 Controller
 */
public class MyCardController implements RestController {
	MyCardService service = new MyCardServiceImpl();
	
	public MyCardController() {
	}
	
	/**
	 * 입력한 키워드가 포함된 카드 리스트 검색
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException 
	 */
	public Object selectCard(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException{
		String keyword = request.getParameter("word");
		List<CardDto> list = service.selectByKeyword(keyword);
		return list;
	}
	
	/**
	 * 보유카드 등록
	 */
	public Object registerCard(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException{
		int cardNo = Integer.parseInt(request.getParameter("cardNo"));
		int result = service.insertMyCard(cardNo);
		return result;
	}

}
