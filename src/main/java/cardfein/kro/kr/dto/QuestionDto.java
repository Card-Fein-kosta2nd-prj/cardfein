package cardfein.kro.kr.dto;

public class QuestionDto {
	
	private int questionNo;
	private String content;
	
	public QuestionDto() {
		
	}
	
	public QuestionDto(int questionNo, String content) {
		super();
		this.questionNo = questionNo;
		this.content = content;
	}

	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
