package cardfein.kro.kr.dto;

import java.util.HashMap;
import java.util.Map;

public class UserCardDto {
	private int cardNo;
	private String cosumeDate;
	private Double matchScore;
	private Map<String,Double> matchTrend;
	
	public UserCardDto() {
	}

	public UserCardDto(int cardNo, Map<String, Double> matchTrend) {
		super();
		this.cardNo = cardNo;
		this.matchTrend = new HashMap<String, Double>();
	}

	public int getCardNo() {
		return cardNo;
	}

	public void setCardNo(int cardNo) {
		this.cardNo = cardNo;
	}

	public Map<String, Double> getMatchTrend() {
		return matchTrend;
	}

	public void setMatchTrend(Map<String, Double> matchTrend) {
		this.matchTrend = matchTrend;
	}
	
	

}
