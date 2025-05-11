package cardfein.kro.kr.dao;

import java.util.List;

import cardfein.kro.kr.dto.CardCoverDto;

public interface CardRankingDAO {

	List<CardCoverDto> findAllCovers();
}
