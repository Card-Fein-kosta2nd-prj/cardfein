package cardfein.kro.kr.dao;

import java.sql.SQLException;
import java.util.List;

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
}
