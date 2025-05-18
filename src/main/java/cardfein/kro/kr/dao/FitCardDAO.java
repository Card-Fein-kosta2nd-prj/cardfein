package cardfein.kro.kr.dao;

import java.util.List;

import cardfein.kro.kr.dto.CardDto;

public interface FitCardDAO {

	List<CardDto> getCardsByCategory(String category);
}
