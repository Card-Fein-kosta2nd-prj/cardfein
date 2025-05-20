package cardfein.kro.kr.dao;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardDto;

public interface FitCardDAO {

	List<CardDto> getCardsByCategory(String category);
	
	CardDto getCardsDetail(int cardNo);
	
	boolean incrementCardView(int cardNo) throws SQLException;
}
