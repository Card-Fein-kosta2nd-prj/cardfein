package cardfein.kro.kr.dao;

import java.util.List;

import cardfein.kro.kr.dto.CardCoverDto;

public interface CardRankingDAO {

	// 전체 카드 커버 리스트 조회
	List<CardCoverDto> findAllCovers();
	
	// 좋아요 수 기준 상위 5개 카드 커버 조회
	List<CardCoverDto> findTopCovers();
	
}
