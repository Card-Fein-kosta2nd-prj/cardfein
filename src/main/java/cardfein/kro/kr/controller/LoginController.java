package cardfein.kro.kr.controller;

import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.service.LoginService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        LoginService service = new LoginService();
        LoginDto loginUser = service.login(username, password);

        if (loginUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loginUser);
            response.sendRedirect(request.getContextPath() + "/main.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/card_login.jsp?error=fail");
        }
    }
}
