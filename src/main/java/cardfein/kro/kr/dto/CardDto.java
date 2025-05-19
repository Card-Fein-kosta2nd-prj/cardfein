package cardfein.kro.kr.dto;

import java.util.ArrayList;
import java.util.List;

public class CardDto {

    private int cardNo;                  // 카드번호
    private String cardName;            // 카드명
    private String provider;            // 카드사
    private String fee;                 // 연회비
    private String cardImageUrl;        // 카드 이미지 URL
    private int view;                   // 조회수
    private Double matchingRate; // 카드 추천시 사용할 매칭율
    private List<String> discount;
    
    private String category;
    private String description;

   private CardBenefitDto cardBenefit;
   private List<CardBenefitDto> cardBenefitList;
    // 기본 생성자
    public CardDto() {
    }

    // 전체 필드 생성자
    public CardDto(int cardNo, String cardName, String provider, String fee, String cardImageUrl, int view) {
        this.cardNo = cardNo;
        this.cardName = cardName;
        this.provider = provider;
        this.fee = fee;
        this.cardImageUrl = cardImageUrl;
        this.view = view;
        this.cardBenefitList = new ArrayList<>();
    }
    

	public CardDto(int cardNo, String cardName, String provider, String fee, String cardImageUrl, int view,CardBenefitDto cardBenefit) {
        this(cardNo, cardName, provider, fee, cardImageUrl, view);
        this.cardBenefit = cardBenefit;
    }
	
	// 맞춤카드 검색 시 사용
	public CardDto(int cardNo, String cardName, String provider, String fee, String cardImageUrl, CardBenefitDto cardBenefit) {
		this(cardNo, cardName, cardImageUrl);
		this.provider = provider;
		this.fee = fee;
		this.cardBenefit = cardBenefit;
	}
    

	//보유카드 검색시 사용할 생성자
	public CardDto(int cardNo, String cardName, String cardImageUrl) {
		this.cardNo = cardNo;
		this.cardName = cardName;
		this.cardImageUrl = cardImageUrl;
		this.discount = new ArrayList<>();
	}
	
	//카드 전체,카드사,키워드 목록 검색시
	public CardDto(int cardNo, String cardName, String provider, String cardImageUrl) {
		this.cardNo = cardNo;
		this.cardName = cardName;
		this.provider = provider;
		this.cardImageUrl = cardImageUrl;
	}
	
	//c.card_no, c.card_name, c.provider, c.fee, c.card_image_url, b.category, b.description
	//카드 단일 정보 검색 시
	public CardDto(int cardNo, String cardName, String provider, String fee, String cardImageUrl) {
		this.cardNo = cardNo;
		this.cardName = cardName;
		this.provider = provider;
		this.fee = fee;
		this.cardImageUrl = cardImageUrl;
	}

	// Getter & Setter
    public int getCardNo() {
        return cardNo;
    }

    public void setCardNo(int cardNo) {
        this.cardNo = cardNo;
    }

    public String getCardName() {
        return cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public String getFee() {
        return fee;
    }

    public void setFee(String fee) {
        this.fee = fee;
    }

    public String getCardImageUrl() {
        return cardImageUrl;
    }

    public void setCardImageUrl(String cardImageUrl) {
        this.cardImageUrl = cardImageUrl;
    }

    public List<String> getDiscount() {
		return discount;
	}

	public void setDiscount(List<String> discount) {
		this.discount = discount;
	}

	public int getView() {
        return view;
    }

    public void setView(int view) {
        this.view = view;
    }

	public CardBenefitDto getCardBenefit() {
		return cardBenefit;
	}

	public void setCardBenefit(CardBenefitDto cardBenefit) {
		this.cardBenefit = cardBenefit;
	}
	public Double getMatchingRate() {
		return matchingRate;
	}

	public void setMatchingRate(Double matchingRate) {
		this.matchingRate = matchingRate;
	}

	public List<CardBenefitDto> getCardBenefitList() {
		return cardBenefitList;
	}

	public void setCardBenefitList(List<CardBenefitDto> cardBenefitList) {
		this.cardBenefitList = cardBenefitList;
	}
	
    
}

