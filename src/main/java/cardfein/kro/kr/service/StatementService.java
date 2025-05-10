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
	
}
