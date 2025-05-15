package cardfein.kro.kr.controller;

import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.service.LoginService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        LoginService service = new LoginService();
        LoginDto loginUser = service.login(username, password);

        if (loginUser != null) {
            // ✅ 세션에 로그인 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loginUser);

            // ✅ 로그인 성공 시 메인 페이지로 이동
            response.sendRedirect(request.getContextPath() + "/main.jsp");
        } else {
            // ✅ 로그인 실패 시 다시 로그인 페이지로 (에러 메시지 포함)
            response.sendRedirect(request.getContextPath() + "/views/card_login.jsp?error=fail");
        }
    }
}
