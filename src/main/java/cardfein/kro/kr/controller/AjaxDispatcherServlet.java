package cardfein.kro.kr.controller;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *  사용자의 모든 요청을 처리할 진입점 Controller이다(FrontController의 역할한다)
 */
@WebServlet(urlPatterns = "/ajax" , loadOnStartup = 1)
@MultipartConfig
public class AjaxDispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    Map<String, RestController> map;
    Map<String, Class<?>> clzMap;

	@Override
	public void init(ServletConfig config) throws ServletException {
		ServletContext application = config.getServletContext();
		Object obj = application.getAttribute("ajaxMap");
		map = (Map<String, RestController>)obj;
		System.out.println(map);
		clzMap = (Map<String, Class<?>>)config.getServletContext().getAttribute("ajaxClzMap");
		
	}
  
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=UTF-8");
		String key = request.getParameter("key"); 
		String methodName = request.getParameter("methodName"); 
		System.out.println("key = " + key);
		System.out.println("methodName = " + methodName);

		try {
			Class<?> clz = clzMap.get(key);
			Method method = clz.getMethod(methodName, HttpServletRequest.class , HttpServletResponse.class);
			
			RestController controller = map.get(key);
			Object obj = method.invoke(controller, request , response);
			
			
			Gson gson = new Gson();
			String data = gson.toJson(obj);
			
			
			response.getWriter().print(data);
			
		}catch (Exception e) {
			e.printStackTrace();
			
		}
	}//service 메소드 끝 
}