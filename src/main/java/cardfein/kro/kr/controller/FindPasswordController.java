package cardfein.kro.kr.controller;

import cardfein.kro.kr.dao.MemberDao;
import cardfein.kro.kr.dao.MemberDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/find_pw")
public class FindPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 사용자 입력값 받기
        String userId = request.getParameter("userId");
        String email = request.getParameter("email");

        // DAO를 통해 비밀번호 조회
        MemberDao dao = new MemberDaoImpl();
        String password = dao.findPasswordByUserIdAndEmail(userId, email);

        // 결과 JSP에 전달
        request.setAttribute("password", password);
        request.getRequestDispatcher("/views/find_pw_result.jsp").forward(request, response);
    }
}
