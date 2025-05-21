package cardfein.kro.kr.service;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.CardDto;

public interface MainService {
	List<CardDto> selectCardList() throws SQLException;
	
	List<CardDto> selectMyCardList() throws SQLException;
	
	List<CardDto> selectPopularList() throws SQLException;

}
