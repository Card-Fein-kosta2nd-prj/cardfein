package cardfein.kro.kr.controller;

import cardfein.kro.kr.dao.MemberDao;
import cardfein.kro.kr.dao.MemberDaoImpl;
import cardfein.kro.kr.service.SignupService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = {"/signup", "/check-duplicate", "/check-email"})
public class SignupController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final MemberDao memberDao = new MemberDaoImpl();

    // 회원가입 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String userId = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        SignupService service = new SignupService();
        String result = service.register(userId, password, email);

        switch (result) {
            case "id":
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=id");
                break;
            case "pw":
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=pw");
                break;
            case "email":
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=email");
                break;
            case "success":
                response.sendRedirect(request.getContextPath() + "/views/card_login.jsp?signup=success");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=unknown");
        }
    }

    // ID 또는 이메일 중복 확인 처리
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        PrintWriter out = response.getWriter();

        if (path.equals("/check-duplicate")) {
            String username = request.getParameter("username");
            boolean exists = memberDao.isUserIdExists(username);
            out.write("{\"exists\": " + exists + "}");
        } else if (path.equals("/check-email")) {
            String email = request.getParameter("email");
            boolean exists = memberDao.isEmailExists(email);
            out.write("{\"exists\": " + exists + "}");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }

        out.close();
    }
}