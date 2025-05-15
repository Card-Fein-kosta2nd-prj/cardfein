package cardfein.kro.kr.dto;

public class ReplyDto {
	private int replyNum;
	private String replyContent;
	private String inputDate;
	private String userId;
	private int parentReviewNo;
	
	public ReplyDto() {
		
	}
	
	public ReplyDto(int replyNum, String replyContent, String inputDate, int parentReviewNo, String userId) {
		super();
		this.replyNum = replyNum;
		this.replyContent = replyContent;
		this.inputDate = inputDate;
		this.parentReviewNo = parentReviewNo;
		this.userId = userId;
	}

	public int getReplyNum() {
		return replyNum;
	}

	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getInputDate() {
		return inputDate;
	}

	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getParentReviewNo() {
		return parentReviewNo;
	}

	public void setParentReviewNo(int parentReviewNo) {
		this.parentReviewNo = parentReviewNo;
	}
	
}
