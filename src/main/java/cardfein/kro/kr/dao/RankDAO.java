package cardfein.kro.kr.dao;

import cardfein.kro.kr.dto.CardDto;
import java.util.List;

/**
 * 카드 랭킹 조회용 DAO 인터페이스
 */
public interface RankDAO {

    /**
     * 카테고리별 조회수 높은 카드 리스트 반환 (TOP 10)
     * @param category - 혜택 카테고리
     * @return List<CardDto>
     */
    List<CardDto> findCardsByCategory(String category);
}
