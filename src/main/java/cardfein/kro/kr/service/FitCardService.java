package cardfein.kro.kr.service;

import java.util.List;

import cardfein.kro.kr.dto.CardDto;

public interface FitCardService {

	List<CardDto> getCardsByCategory(String category) throws Exception;
}
