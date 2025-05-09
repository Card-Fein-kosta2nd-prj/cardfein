package cardfein.kro.kr.dto;

public class CardCoverDto {

	private int cover_no;
//	private String imageUrl;
	private String title;
	private String baseCardUrl;
	private String finalCardUrl;
//	private DateTime created_at;
	
	public CardCoverDto() {
		
	}
	
	public CardCoverDto(int cover_no, String title, String baseCardUrl, String finalCardUrl) {
	super();
	this.cover_no = cover_no;
	this.title = title;
	this.baseCardUrl = baseCardUrl;
	this.finalCardUrl = finalCardUrl;
	}

	public int getCover_no() {
		return cover_no;
	}
	public void setCover_no(int cover_no) {
		this.cover_no = cover_no;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBaseCardUrl() {
		return baseCardUrl;
	}
	public void setBaseCardUrl(String baseCardUrl) {
		this.baseCardUrl = baseCardUrl;
	}
	public String getFinalCardUrl() {
		return finalCardUrl;
	}
	public void setFinalCardUrl(String finalCardUrl) {
		this.finalCardUrl = finalCardUrl;
	}
	
	
}
