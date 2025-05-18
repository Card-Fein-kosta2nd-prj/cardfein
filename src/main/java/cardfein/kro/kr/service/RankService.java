package cardfein.kro.kr.service;

import cardfein.kro.kr.dto.CardDto;
import java.util.List;

/**
 * 혜택별 카드 랭킹 서비스 인터페이스
 */
public interface RankService {

    /**
     * 카테고리별 카드 리스트를 조회수 기준으로 반환
     * @param category - 혜택 카테고리 (ex. 교통, 쇼핑 등)
     * @return List<CardDto>
     */
    List<CardDto> getCardsByBenefit(String category);
}
