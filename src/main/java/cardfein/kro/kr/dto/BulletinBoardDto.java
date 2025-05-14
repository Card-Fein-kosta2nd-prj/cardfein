package cardfein.kro.kr.dto;

import java.time.LocalDateTime;

public class BulletinBoardDto {
    private int boardId;        // 글 번호 (PK)
    private String title;       // 제목
    private String content;     // 내용
    private String author;      // 작성자
    private LocalDateTime regDate; // 작성일
    private int views;          // 조회수

    // 기본 생성자
    public BulletinBoardDto() {
        this.views = 0; // 조회수 기본값 0
        this.regDate = LocalDateTime.now(); // 작성일 기본값 현재 시간
    }

    // 전체 필드를 받는 생성자
    public BulletinBoardDto(int boardId, String title, String content, String author, LocalDateTime regDate) {
        this.boardId = boardId;
        this.title = title;
        this.content = content;
        this.author = author;
        this.regDate = regDate;
        this.views = 0; // 조회수 기본값 0
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