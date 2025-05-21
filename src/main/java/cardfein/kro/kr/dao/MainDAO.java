package cardfein.kro.kr.dao;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardDto;

public interface MainDAO {
	/**
	 * 조회수 top6 카드 검색
	 */
	List<CardDto> selectCardList() throws SQLException;
	
	/**
	 * 보유카드 top6 검색
	 */
	List<CardDto> selectMyCardList() throws SQLException;
	/**
	 * 혜택별 인기카드 top4
	 */
	List<CardDto> selectPopularList() throws SQLException;
}
