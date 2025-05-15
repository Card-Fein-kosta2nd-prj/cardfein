package cardfein.kro.kr.controller;

import java.awt.Graphics2D;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import com.google.gson.Gson;

import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.service.CardDesignService;
import cardfein.kro.kr.service.CardDesignServiceImpl;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

public class CardDesignController implements RestController{
	
	CardDesignService service = new CardDesignServiceImpl();
	
	public CardDesignController() {
		
	}
	
	/**
	 * 기본 카드 이미지 반환
	 */
	public void getBaseImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String baseImageUrl = service.getBaseImageUrl();
		
		Map<String, String> result = new HashMap<String, String>();
		result.put("baseImageUrl", baseImageUrl);
		
		Gson gson = new Gson();
		String jsonResponse = gson.toJson(result);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonResponse);
	}
	
	/**
	 * 완성된 커버 이미지 저장
	 */
	
	public Map<String, Object> saveFinalCard(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    Map<String, Object> result = new HashMap<>();

	    try {
	    	HttpSession session = request.getSession();
	    	LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
	    	
	    	int userNo = loginUser.getUserNo();
	        String title = request.getParameter("title");
	        Part imagePart = request.getPart("finalImage");

	        String fileName = title + "_img.png";

	        ServletContext sc = request.getServletContext();
	        String uploadPath = sc.getRealPath("/static/upload/cover");
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) uploadDir.mkdirs();

	        File file = new File(uploadDir, fileName);
	        try (InputStream input = imagePart.getInputStream();
	             FileOutputStream output = new FileOutputStream(file)) {
	            byte[] buffer = new byte[1024];
	            int bytesRead;
	            while ((bytesRead = input.read(buffer)) != -1) {
	                output.write(buffer, 0, bytesRead);
	            }
	        }

	        String imageUrl = "/static/upload/cover/" + fileName;
	        
	        service.saveFinalCard(userNo, title, imageUrl);

	        result.put("success", true);
	        result.put("message", "카드 커버 저장 성공");

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	        result.put("message", "카드 저장 중 오류 발생");
	    }

	    return result;
	    
	}

}