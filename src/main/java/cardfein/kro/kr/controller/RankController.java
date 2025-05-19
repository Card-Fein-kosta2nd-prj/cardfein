package cardfein.kro.kr.controller;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.service.RankService;
import cardfein.kro.kr.service.RankServiceImpl;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/ajax/rank")
public class RankController extends HttpServlet {

    private final RankService rankService = new RankServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<CardDto> cardList = (category == null || category.trim().isEmpty())
                ? List.of()
                : rankService.getCardsByBenefit(category);

        String json = new Gson().toJson(cardList);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
