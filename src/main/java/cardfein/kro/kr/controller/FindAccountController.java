package cardfein.kro.kr.controller;

import cardfein.kro.kr.dao.MemberDao;
import cardfein.kro.kr.dao.MemberDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/find_id")
public class FindAccountController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        MemberDao dao = new MemberDaoImpl();
        String userId = dao.findUserIdByEmail(email);

        request.setAttribute("userId", userId);

        // views 폴더 안에 있다면 이 경로로!
        request.getRequestDispatcher("/views/find_id_result.jsp").forward(request, response);
    }
}
