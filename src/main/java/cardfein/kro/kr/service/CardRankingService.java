package cardfein.kro.kr.service;

import java.util.List;

import cardfein.kro.kr.dto.CardCoverDto;

public interface CardRankingService {

	List<CardCoverDto> getAllCovers();
	
	List<CardCoverDto> getTopCovers();
}
