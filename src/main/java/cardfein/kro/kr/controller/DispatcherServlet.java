package cardfein.kro.kr.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Map;

/**
 * 모든 요청을 중앙집중적으로 관리해 줄 진입점 (FrontController) Controller이다.
 */
@WebServlet(urlPatterns = "/front", loadOnStartup = 1)
@MultipartConfig( // 어노테이션을 통해 서블릿이 파일 업로드 기능을 할 수 있도록 웹 컨테이너에 지시
		maxFileSize = 1024 * 1024 * 5, // 5M - 한 번에 업로드 할 수 있는 파일 크기 제한
		maxRequestSize = 1024 * 1024 * 50 // 50M -전체 요청의 크기 제한. 기본값은 무제한
)
public class DispatcherServlet extends HttpServlet {

}// class
