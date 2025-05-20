package cardfein.kro.kr.dto;

import java.util.List;

public class ReviewDto {
	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private int rating;
	private String inputDate;
	private int cardNo;
	private String cardName;
	private String cardImg;
	private int userNo;
	private String userId;
	private int views;
	private int replyCount;
	
	
	//댓글 정보
	private List<ReplyDto> replyList;
	
	public ReviewDto() {
		
	}
	
	//리뷰 전체 조회시 사용
	public ReviewDto(int reviewNo, String reviewTitle, String reviewContent, int rating, String inputDate,
			String cardName, String cardImg, String userId, int views) {
		super();
		this.reviewNo = reviewNo;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.rating = rating;
		this.inputDate = inputDate;
		this.cardName = cardName;
		this.cardImg = cardImg;
		this.userId = userId;
		this.views = views;
	}
	
	//보유 카드 목록 조회시 사용
	public ReviewDto(int cardNo, String cardName) {
		super();
		this.cardNo = cardNo;
		this.cardName = cardName;
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

	public String getCardImg() {
		return cardImg;
	}

	public void setCardImg(String cardImg) {
		this.cardImg = cardImg;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public List<ReplyDto> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<ReplyDto> replyList) {
		this.replyList = replyList;
	}
	
}