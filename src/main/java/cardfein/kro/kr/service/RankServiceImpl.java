package cardfein.kro.kr.service;

import cardfein.kro.kr.dao.RankDAO;
import cardfein.kro.kr.dao.RankDAOImpl;
import cardfein.kro.kr.dto.CardDto;

import java.util.List;

/**
 * RankService 인터페이스 구현체 - 혜택별 카드 랭킹 로직 처리
 */
public class RankServiceImpl implements RankService {

    private final RankDAO rankDAO = new RankDAOImpl();

    /**
     * 특정 카테고리(교통, 쇼핑 등)에 해당하는 카드 랭킹 리스트 조회
     * @param category 혜택 카테고리명
     * @return 해당 카테고리에 속하는 카드 리스트 (최대 10개)
     */
    @Override
    public List<CardDto> getCardsByBenefit(String category) {
        return rankDAO.findCardsByCategory(category);
    }
}
