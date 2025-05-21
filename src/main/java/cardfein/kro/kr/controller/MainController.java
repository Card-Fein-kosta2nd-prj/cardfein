package cardfein.kro.kr.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.service.MainService;
import cardfein.kro.kr.service.MainServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MainController implements RestController {
	MainService service = new MainServiceImpl();
	public MainController() {
	}
	
	/**
	 * 조회수 top6 카드 검색
	 * @throws SQLException 
	 */
	public Object selectViewList(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException {
		List<CardDto> list = service.selectCardList();
		return list;
	}
	/**
	 * 보유카드수 top6 카드 검색
	 */
	public Object selectMyCardList(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException {
		List<CardDto> list = service.selectMyCardList();
		return list;
	}
	/**
	 * 혜택별 인기카드 top4 검색
	 */
	public Object selectPopularList(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, SQLException {
		List<CardDto> list = service.selectPopularList();
		return list;
	}
}
