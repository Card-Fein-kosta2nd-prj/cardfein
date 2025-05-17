package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cardfein.kro.kr.dao.MyCardDAO;
import cardfein.kro.kr.dao.MyCardDAOImpl;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.dto.UserCardDto;

public class MyCardServiceImpl implements MyCardService {
	MyCardDAO dao = new MyCardDAOImpl();
	@Override
	public List<CardDto> selectByKeyword(String keyword,int userNo) throws SQLException {
		List<CardDto> list = dao.selectByKeyword(keyword,userNo);
		return list;
	}

	@Override
	public int insertMyCard(int cardNo,int userNo) throws SQLException {
		int result = dao.insertMyCard(cardNo,userNo);
		return result;
	}

	@Override
	public int insertRequest(String content) throws SQLException {
		int result = dao.insertRequest(content);
		return result;
	}

	@Override
	public UserCardDto selectMatchTrend(int userNo) throws SQLException {
		UserCardDto userCard = dao.selectMatchTrend(userNo);
		return userCard;
	}

	@Override
	public Map<Integer, CardDto> selectMyCardDetails(int userNo) throws SQLException {
		Map<Integer, CardDto> map = dao.selectMyCardDetails(userNo);
		return map;
	}
	
	@Override
	public int deleteMyCard(int cardNo,int userNo) throws SQLException {
		int result = dao.deleteMyCard(cardNo,userNo);
		return result;
	}

}
