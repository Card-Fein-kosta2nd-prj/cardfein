package cardfein.kro.kr.dao.cart;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardDto;

public interface CartDAO {
	
	/**
	 * 카드 리스트 전체 조회
	 * @return 카드 리스트
	 * @throws SQLException
	 */
	List<CardDto> selectAll() throws SQLException;
	
	/**
	 * 카드사별 카드 리스트 조회
	 * @param provider
	 * @return 카드 리스트
	 * @throws SQLException
	 */
	List<CardDto> selectByProvider(String provider) throws SQLException;
	
	/**
	 * 키워드로 카드 리스트 조회
	 * @param keyword
	 * @return 카드 리스트
	 * @throws SQLException
	 */
	List<CardDto> selectByKeyword(String keyword) throws SQLException;
	
	/**
	 * 카드번호로 단일 카드 정보 조회
	 * @param cardNo
	 * @return 카드 정보
	 * @throws SQLException
	 */
	CardDto selectByCardNo(int cardNo) throws SQLException;
}
