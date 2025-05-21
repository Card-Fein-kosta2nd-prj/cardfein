package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.MainDAO;
import cardfein.kro.kr.dao.MainDAOImpl;
import cardfein.kro.kr.dto.CardDto;

public class MainServiceImpl implements MainService{
	MainDAO dao = new MainDAOImpl();
	@Override
	public List<CardDto> selectCardList() throws SQLException{
		List<CardDto> list = dao.selectCardList();
		return list;
	}
	@Override
	public List<CardDto> selectMyCardList() throws SQLException{
		List<CardDto> list = dao.selectMyCardList();
		return list;
	}
	@Override
	public List<CardDto> selectPopularList() throws SQLException{
		List<CardDto> list = dao.selectPopularList();
		return list;
	}
	

}
