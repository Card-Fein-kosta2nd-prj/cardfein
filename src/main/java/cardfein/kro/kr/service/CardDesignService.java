package cardfein.kro.kr.service;

public interface CardDesignService {

	/**
	 * 커버 기본 이미지 가져오기 메서드
	 */
	String getBaseImageUrl();
	
	/**
	 * 커스터마이징 이미지 저장 메서드
	 */
	void saveFinalCard(int userNo, String title, String finalCoverUrl);
}
