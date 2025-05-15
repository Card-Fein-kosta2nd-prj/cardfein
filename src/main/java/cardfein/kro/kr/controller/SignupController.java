package cardfein.kro.kr.controller;

import cardfein.kro.kr.service.SignupService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

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

        PrintWriter out = response.getWriter();

        switch (result) {
            case "id":
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=id");
                break;
            case "pw":
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=pw");
                break;
            case "success":
                out.println("<script>");
                out.println("alert('회원 가입이 완료되었습니다. 로그인을 해주세요.');");
                out.println("location.href='" + request.getContextPath() + "/views/card_login.jsp';");
                out.println("</script>");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/signup.jsp?error=unknown");
        }
    }
}
