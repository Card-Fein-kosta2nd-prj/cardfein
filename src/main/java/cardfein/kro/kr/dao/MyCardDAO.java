package cardfein.kro.kr.dao;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.dto.UserCardDto;

/**
 * 회원 보유카드 관리 DAO
 */
public interface MyCardDAO {
	/**
	 * 입력한 keyword가 카드이름에 포함된 카드목록 검색
	 */
	List<CardDto> selectByKeyword(String keyword) throws SQLException;
	
	/**
	 * 선택된 카드 보유카드table 에 추가
	 */
	int insertMyCard(int cardNo) throws SQLException;
	
	/**
	 * DB 에 없는 카드 1:1 문의글에 추가
	 */
	int insertRequest(String content) throws SQLException;
	
	/**
	 * 보유카드 매칭율 검색
	 */
	UserCardDto selectMatchTrend() throws SQLException;
	
	/**
	 * 보유카드 상세정보 검색
	 */
	List<CardDto> selectMyCardDetails() throws SQLException;
}
