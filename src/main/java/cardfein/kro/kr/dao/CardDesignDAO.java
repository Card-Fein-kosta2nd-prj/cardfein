package cardfein.kro.kr.dao;

import java.sql.SQLException;

import cardfein.kro.kr.dto.CardCoverDto;

public interface CardDesignDAO {
	
	/**
	 * 기본 이미지 로드 메서드
	 */
	String getDefaultCardDesign();
	
	/**
	 * 완성된 카드 커버 이미지 저장 메서드
	 */
	void saveFinalCardImage(int userNo, String title, String finalCoverUrl) throws SQLException;
}
