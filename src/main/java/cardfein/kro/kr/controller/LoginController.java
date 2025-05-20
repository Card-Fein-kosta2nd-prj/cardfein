package cardfein.kro.kr.controller;

import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.service.LoginService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final LoginService service = new LoginService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String userId = request.getParameter("username");
        String password = request.getParameter("password");

        LoginDto user = service.login(userId, password);

        if (user != null) {
            // ✅ 디버깅 로그 출력
            System.out.println("▶ 로그인된 ID: " + user.getUserId());
            System.out.println("▶ 로그인된 ROLE: " + user.getRole());

            // 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", user);

            // ✅ 관리자 계정: userId도 "admin"이고 role도 "admin"일 때
            if ("admin".equals(user.getUserId()) && "admin".equals(user.getRole())) {
                System.out.println("▶ 관리자 계정 → adminpage.jsp 이동");
                response.sendRedirect(request.getContextPath() + "/views/adminpage.jsp");
            } else {
                // ✅ 일반 사용자 → main.jsp (주의: 루트 위치)
                System.out.println("▶ 일반 사용자 계정 → main.jsp 이동");
                session.setAttribute("justLoggedIn", true);
                response.sendRedirect(request.getContextPath() + "/main.jsp");
            }
        } else {
            // 로그인 실패
            System.out.println("▶ 로그인 실패: 아이디 또는 비밀번호 오류");
            response.sendRedirect(request.getContextPath() + "/views/card_login.jsp?error=fail");
        }
    }
}
