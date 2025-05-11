package cardfein.kro.kr.controller;

import cardfein.kro.kr.dto.BulletinBoardDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/board")
public class BulletinBoardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // 게시글 데이터를 저장할 임시 리스트
    private final List<BulletinBoardDto> posts = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < posts.size(); i++) {
            BulletinBoardDto post = posts.get(i);
            json.append("{")
                .append("\"boardId\": ").append(post.getBoardId()).append(", ")
                .append("\"title\": \"").append(post.getTitle()).append("\", ")
                .append("\"content\": \"").append(post.getContent()).append("\", ")
                .append("\"author\": \"").append(post.getAuthor()).append("\", ")
                .append("\"regDate\": \"").append(post.getRegDate()).append("\", ")
                .append("\"views\": ").append(post.getViews())
                .append("}");
            if (i < posts.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String boardIdParam = request.getParameter("boardId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String author = request.getParameter("author");

        if (title == null || content == null || author == null || title.isEmpty() || content.isEmpty() || author.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("필수 필드가 누락되었습니다.");
            return;
        }

        if (boardIdParam == null || boardIdParam.isEmpty() || boardIdParam.equals("0")) {
            // 새 게시글 작성
            BulletinBoardDto newPost = new BulletinBoardDto(posts.size() + 1, title, content, author, LocalDateTime.now());
            posts.add(newPost);
        } else {
            // 기존 게시글 수정
            int boardId = Integer.parseInt(boardIdParam);
            for (BulletinBoardDto post : posts) {
                if (post.getBoardId() == boardId) {
                    post.setTitle(title);
                    post.setContent(content);
                    post.setAuthor(author);
                    break;
                }
            }
        }

        response.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String boardIdParam = request.getParameter("boardId");
        if (boardIdParam == null || boardIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("게시글 ID가 누락되었습니다.");
            return;
        }

        int boardId = Integer.parseInt(boardIdParam);
        boolean removed = posts.removeIf(post -> post.getBoardId() == boardId);

        if (removed) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("삭제할 게시글을 찾을 수 없습니다.");
        }
    }
}