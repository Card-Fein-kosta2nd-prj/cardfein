package cardfein.kro.kr.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;

public interface StatementDAO {
	/**
	 * 카테고리에 해당하는 카드 목록 검색
	 */
	List<CardDto> selectByCategory(String[] category) throws SQLException;
	/**
	 * 카드 번호에 해당하는 카테고리별 할인율 검색
	 */
	List<CardBenefitDto> selectByCardNo(List<Integer> cardNoList) throws SQLException;
	
	/**
	 * 명세서 분석 결과 추가
	 */
	int insertStatementResult(List<Object> statementResult) throws SQLException;
	
	/**
	 * 회원 소비 기반 맞춤 카드 리스트 검색
	 */
	public List<CardDto> selectRecommendCardList(int userNo) throws SQLException; //회원번호는 application영역에 저장되게끔 !!!!
}