package cardfein.kro.kr.controller;

import cardfein.kro.kr.service.SignupService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/signup")
public class SignupController extends HttpServlet {
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
            case "success":
                response.sendRedirect(request.getContextPath() + "/views/card_login.jsp?signup=success");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=unknown");
        }
    }
}
