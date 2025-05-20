package cardfein.kro.kr.dto;

import java.time.LocalDateTime;

public class CardCoverLike {

	private int likeNo;
	private int coverNo;
	private int userNo;
	private LocalDateTime likedAt;
	
	public CardCoverLike(int coverNo, int userNo) {
		this.coverNo = coverNo;
		this.userNo = userNo;
	}

	public int getLikeNo() {
		return likeNo;
	}

	public void setLikeNo(int likeNo) {
		this.likeNo = likeNo;
	}

	public int getCoverNo() {
		return coverNo;
	}

	public void setCoverNo(int coverNo) {
		this.coverNo = coverNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public LocalDateTime getLikedAt() {
		return likedAt;
	}

	public void setLikedAt(LocalDateTime likedAt) {
		this.likedAt = likedAt;
	}
	
	
}
