package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.StatementDAO;
import cardfein.kro.kr.dao.StatementDAOImpl;
import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;

public class StatementServiceImpl implements StatementService {
	StatementDAO dao =  new StatementDAOImpl();
	@Override
	public List<CardDto> selectByCategory(String[] category) throws SQLException {
		List<CardDto> cardList = dao.selectByCategory(category);
		return cardList;
	}
	@Override
	public List<CardBenefitDto> selectByCardNo(List<Integer> cardNoList) throws SQLException {
		List<CardBenefitDto> cardList = dao.selectByCardNo(cardNoList);
		return cardList;
	}
	
	@Override
	public int insertStatementResult(List<Object> statementResult) throws SQLException{
		int result = dao.insertStatementResult(statementResult);
		if(result==0) new SQLException("명세서 결과 추가 불가합니다."); 
		return result;
	}

}
