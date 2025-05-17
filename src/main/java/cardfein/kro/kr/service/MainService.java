package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.MainDAO;
import cardfein.kro.kr.dto.CardDto;

public class MainService {
	MainDAO dao = new MainDAO();
	
	public List<CardDto> selectCardList() throws SQLException{
		List<CardDto> list = dao.selectCardList();
		return list;
	}
	public List<CardDto> selectMyCardList() throws SQLException{
		List<CardDto> list = dao.selectMyCardList();
		return list;
	}
	public List<CardDto> selectPopularList() throws SQLException{
		List<CardDto> list = dao.selectPopularList();
		return list;
	}
	

}
