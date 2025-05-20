package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.dto.UserCardDto;

/**
 * 회원 보유카드 관리 Service
 */
public interface MyCardService {
	/**
	 * MyCardDAOIml의 입력한 keyword가 카드이름에 포함된 카드목록 검색하는 메소드 호출
	 */
	List<CardDto> selectByKeyword(String keyword,int userNo) throws SQLException;
	
	/**
	 * MyCardDAOIml의 보유카드table 에 삽입하는 메소드 호출
	 */
	int insertMyCard(int cardNo,int userNo) throws SQLException;
	
	/**
	 * MyCardDAOIml의 DB 에 없는 카드 1:1 문의글에 삽입하는 메소드 호출
	 */
	int insertRequest(String content) throws SQLException;
	
	/**
	 * MyCardDAOIml의 보유카드 매칭율 검색하는 메소드 호출
	 */
	UserCardDto selectMatchTrend(int userNo) throws SQLException;
	
	/**
	 * MyCardDAOIml의 보유카드 상세정보 검색하는 메소드 호출
	 */
	Map<Integer, CardDto> selectMyCardDetails(int userNo) throws SQLException;
	
	/**
	 * MyCardDAOIml의 보유카드 삭제 메소드 호출
	 */
	int deleteMyCard(int cardNo,int userNo) throws SQLException;
}