package cardfein.kro.kr.controller;

import cardfein.kro.kr.dto.BulletinBoardDto;
import cardfein.kro.kr.dto.LoginDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/board")
public class BulletinBoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final List<BulletinBoardDto> posts = new ArrayList<>();
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        LoginDto loginUser = (session != null) ? (LoginDto) session.getAttribute("loginUser") : null;
        String userRole = (loginUser != null) ? loginUser.getRole() : "guest";

        String boardIdParam = request.getParameter("boardId");
        String action = request.getParameter("action");

        if (boardIdParam != null && action != null && action.equals("view")) {
            int boardId = Integer.parseInt(boardIdParam);
            for (BulletinBoardDto post : posts) {
                if (post.getBoardId() == boardId) {
                    post.incrementViews();
                    break;
                }
            }
        }

        if (boardIdParam != null && action == null) {
            int boardId = Integer.parseInt(boardIdParam);
            for (BulletinBoardDto post : posts) {
                if (post.getBoardId() == boardId) {
                    String json = String.format(
                            "{\"boardId\":%d,\"title\":\"%s\",\"author\":\"%s\",\"content\":\"%s\",\"regDate\":\"%s\",\"views\":%d,\"role\":\"%s\"}",
                            post.getBoardId(),
                            escapeJson(post.getTitle()),
                            escapeJson(post.getAuthor()),
                            escapeJson(post.getContent()),
                            post.getRegDate().format(formatter),
                            post.getViews(),
                            userRole
                    );
                    response.getWriter().write(json);
                    return;
                }
            }
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < posts.size(); i++) {
            BulletinBoardDto post = posts.get(i);
            json.append("{")
                .append("\"boardId\": ").append(post.getBoardId()).append(", ")
                .append("\"title\": \"").append(escapeJson(post.getTitle())).append("\", ")
                .append("\"author\": \"").append(escapeJson(post.getAuthor())).append("\", ")
                .append("\"content\": \"").append(escapeJson(post.getContent())).append("\", ")
                .append("\"regDate\": \"").append(post.getRegDate().format(formatter)).append("\", ")
                .append("\"views\": ").append(post.getViews()).append(", ")
                .append("\"role\": \"").append(userRole).append("\"")
                .append("}");
            if (i < posts.size() - 1) json.append(",");
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        HttpSession session = request.getSession(false);
        LoginDto loginUser = (session != null) ? (LoginDto) session.getAttribute("loginUser") : null;

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("글 작성 권한이 없습니다.");
            return;
        }

        String boardIdParam = request.getParameter("boardId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String author = request.getParameter("author");

        if (title == null || content == null || author == null ||
                title.trim().isEmpty() || content.trim().isEmpty() || author.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("필수 필드가 누락되었습니다.");
            return;
        }

        if (boardIdParam == null || boardIdParam.isEmpty() || boardIdParam.equals("0")) {
            BulletinBoardDto newPost = new BulletinBoardDto(
                    posts.size() + 1, title, content, author, LocalDateTime.now()
            );
            posts.add(newPost);
        } else {
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
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        LoginDto loginUser = (session != null) ? (LoginDto) session.getAttribute("loginUser") : null;

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("글 삭제 권한이 없습니다.");
            return;
        }

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

    private String escapeJson(String input) {
        return input.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }
}