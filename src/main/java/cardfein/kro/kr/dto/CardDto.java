package cardfein.kro.kr.dto;

import java.util.List;

public class CardDto {

    private int cardNo;                  // 카드번호
    private String cardName;            // 카드명
    private String provider;            // 카드사
    private String fee;                 // 연회비
    private String cardImageUrl;        // 카드 이미지 URL
    private int view;                   // 조회수

   private CardBenefitDto cardBenefit;
    
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
    }
    public CardDto(int cardNo, String cardName, String provider, String fee, String cardImageUrl, int view,CardBenefitDto cardBenefit) {
        this.cardNo = cardNo;
        this.cardName = cardName;
        this.provider = provider;
        this.fee = fee;
        this.cardImageUrl = cardImageUrl;
        this.view = view;
        this.cardBenefit = cardBenefit;
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

	
    
}

