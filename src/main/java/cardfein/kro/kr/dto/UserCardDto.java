package cardfein.kro.kr.dto;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class UserCardDto {
	private String cardName;
	private String cosumeDate;
	private Double matchScore;
	private Map<String,Map<String,Double>> matchTrend; //cardName = Map<date,matchScore>
	private Set<String> DateSet;
	

	public UserCardDto() {
		this.matchTrend = new HashMap<>();
		this.DateSet = new LinkedHashSet<>();
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public Map<String, Map<String,Double>> getMatchTrend() {
		return matchTrend;
	}

	public void setMatchTrend(Map<String, Map<String,Double>> matchTrend) {
		this.matchTrend = matchTrend;
	}

	public Set<String> getDateSet() {
		return DateSet;
	}

	public void setDateSet(Set<String> dateSet) {
		DateSet = dateSet;
	}

}