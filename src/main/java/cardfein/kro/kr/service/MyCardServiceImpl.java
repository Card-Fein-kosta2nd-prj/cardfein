package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.MyCardDAO;
import cardfein.kro.kr.dao.MyCardDAOImpl;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.dto.UserCardDto;

public class MyCardServiceImpl implements MyCardService {
	MyCardDAO dao = new MyCardDAOImpl();
	@Override
	public List<CardDto> selectByKeyword(String keyword) throws SQLException {
		List<CardDto> list = dao.selectByKeyword(keyword);
		return list;
	}

	@Override
	public int insertMyCard(int cardNo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertRequest(String content) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserCardDto> selectMatchTrend() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CardDto> selectMyCardDetails() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
