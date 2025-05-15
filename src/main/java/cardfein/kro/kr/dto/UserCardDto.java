package cardfein.kro.kr.dto;

import java.util.HashMap;
import java.util.Map;

public class UserCardDto {
	private String cardName;
	private String cosumeDate;
	private Double matchScore;
	private Map<String,Double[]> matchTrend; //cardName = matchScore[]
	
	public UserCardDto() {
	}

	public UserCardDto(String cardName, Map<String, Double> matchTrend) {
		super();
		this.cardName = cardName;
		this.matchTrend = new HashMap<String, Double[]>();
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public Map<String, Double[]> getMatchTrend() {
		return matchTrend;
	}

	public void setMatchTrend(Map<String, Double[]> matchTrend) {
		this.matchTrend = matchTrend;
	}
	
	

}
