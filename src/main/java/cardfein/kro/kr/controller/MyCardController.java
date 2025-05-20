package cardfein.kro.kr.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.dto.UserCardDto;
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
		LoginDto loginUser = (LoginDto) request.getSession().getAttribute("loginUser");
		List<CardDto> list = service.selectByKeyword(keyword,loginUser.getUserNo());
		
		return list;
	}
	
	/**
	 * 보유카드 등록
	 */
	public Object registerCard(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException{
		int cardNo = Integer.parseInt(request.getParameter("cardNo"));
		LoginDto loginUser = (LoginDto) request.getSession().getAttribute("loginUser");
		int result = service.insertMyCard(cardNo,loginUser.getUserNo());
		return result;
	}
	
	/**
	 * 카드추가 문의 등록
	 */
	public Object submitInquiry(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException{
		String content = request.getParameter("content");
		int result = service.insertRequest(content);
		return result;
	}
	
	/**
	 * 보유카드 매칭률 트랜드 확인
	 */
	public Object matchingTrend(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException{
		LoginDto loginUser = (LoginDto) request.getSession().getAttribute("loginUser");
		UserCardDto matchingTrend = service.selectMatchTrend(loginUser.getUserNo());
		return matchingTrend;
	}
	/**
	 * 보유카드 목록 확인
	 */
	public Object selectMyCards(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException{
		LoginDto loginUser = (LoginDto) request.getSession().getAttribute("loginUser");
		Map<Integer, CardDto> cards = service.selectMyCardDetails(loginUser.getUserNo());
		return cards;
	}
	/**
	 * 보유카드 삭제
	 */
	public Object deleteMyCard(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException{
		int cardNo = Integer.parseInt(request.getParameter("cardNo"));
		LoginDto loginUser = (LoginDto) request.getSession().getAttribute("loginUser");
		int result = service.deleteMyCard(cardNo,loginUser.getUserNo());
		return result;
	}
	
	
}