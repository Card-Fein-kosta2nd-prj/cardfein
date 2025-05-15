package cardfein.kro.kr.dto;

import java.util.List;

public class ReviewDto {
	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private int rating;
	private String inputDate;
	private int cardName;
	
	//댓글 정보
	private List<ReplyDto> replyList;
	
	public ReviewDto() {
		
	}

	public ReviewDto(int reviewNo, String reviewTitle, String reviewContent, int rating, String inputDate, int cardName,
			List<ReplyDto> replyList) {
		super();
		this.reviewNo = reviewNo;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.rating = rating;
		this.inputDate = inputDate;
		this.cardName = cardName;
		this.replyList = replyList;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getInputDate() {
		return inputDate;
	}

	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}

	public int getCardName() {
		return cardName;
	}

	public void setCardName(int cardName) {
		this.cardName = cardName;
	}

	public List<ReplyDto> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<ReplyDto> replyList) {
		this.replyList = replyList;
	}
	
}
