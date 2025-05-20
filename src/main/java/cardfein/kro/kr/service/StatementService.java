package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;

public interface StatementService {
	/**
	 * StatementDAOImpl의 카테고리 top2에 해당하는 카드 목록 검색하는 메소드 호출
	 */
	List<CardDto> selectByCategory(String[] category) throws SQLException;
	
	/**
	 * StatementDAOImpl의 카드번호에 해당하는 카드혜택 검색하는 메소드 호출
	 */
	List<CardBenefitDto> selectByCardNo(List<Integer> cardNoList) throws SQLException;
	
	/**
	 * StatementDAOImpl의 명세서 분석 데이터 삽입하는 메소드 호출
	 */
	int insertStatementResult(List<Object> statementResult) throws SQLException;
	
	/**
	 * StatementDAOImpl의 회원 맞춤 카드정보 검색하는 메소드 호출
	 */
	List<CardDto> selectRecommendCardList(int userNo)throws SQLException;
}