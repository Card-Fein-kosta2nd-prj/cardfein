package cardfein.kro.kr.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 *  사용자의 모든 요청을 처리할 진입점 Controller이다(FrontController의 역할한다)
 */
@WebServlet(urlPatterns = "/ajax" , loadOnStartup = 1)
public class AjaxDispatcherServlet extends HttpServlet {

}









