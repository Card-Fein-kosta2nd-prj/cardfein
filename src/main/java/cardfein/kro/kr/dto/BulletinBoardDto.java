package cardfein.kro.kr.dto;

import java.time.LocalDateTime;

public class BulletinBoardDto {
    private int boardId;
    private String title;
    private String content;
    private String author;
    private LocalDateTime regDate;
    private int views;

    // 기본 생성자 - 자동으로 등록 날짜 설정
    public BulletinBoardDto() {
        this.views = 0;
        this.regDate = LocalDateTime.now();
    }

    // 전체 필드 포함 생성자
    public BulletinBoardDto(int boardId, String title, String content, String author, LocalDateTime regDate) {
        this.boardId = boardId;
        this.title = title;
        this.content = content;
        this.author = author;
        this.regDate = regDate;
        this.views = 0; // 조회수 초기값 설정
    }

    // 조회수 증가 기능 추가
    public void incrementViews() {
        this.views++;
    }

    // Getter & Setter
    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public LocalDateTime getRegDate() {
        return regDate;
    }

    public void setRegDate(LocalDateTime regDate) {
        this.regDate = regDate;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }
}

//20글자 수정 전