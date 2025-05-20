package cardfein.kro.kr.dto;

public class CardBenefitDto {
	private int benefitNo;
	private String category;
	private String description;
	private int cardNo;
	private double discountRate;
	
	
	// 기본 생성자
	public CardBenefitDto() {
	}
	// 전체 필드 생성자
	public CardBenefitDto(int benefitNo, String category, String description, int cardNo, double discountRate) {
		this.benefitNo = benefitNo;
		this.category = category;
		this.description = description;
		this.cardNo = cardNo;
		this.discountRate = discountRate;
	}
	
	//장바구니 카드 정보 조회시
    public CardBenefitDto(String category, String description) {
        this.category = category;
        this.description = description;
    }
	
	public int getBenefitNo() {
		return benefitNo;
	}
	public void setBenefitNo(int benefitNo) {
		this.benefitNo = benefitNo;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCardNo() {
		return cardNo;
	}
	public void setCardNo(int cardNo) {
		this.cardNo = cardNo;
	}
	public double getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(double discountRate) {
		this.discountRate = discountRate;
	}

	
	
	
	
}