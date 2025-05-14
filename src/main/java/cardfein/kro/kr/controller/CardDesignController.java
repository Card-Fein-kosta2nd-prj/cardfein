package cardfein.kro.kr.controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import com.google.gson.Gson;

import cardfein.kro.kr.service.CardDesignService;
import cardfein.kro.kr.service.CardDesignServiceImpl;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CardDesignController {
	private static final CardDesignController instance = new CardDesignController();

    private final CardDesignService service;

    private CardDesignController() {
        this.service = CardDesignServiceImpl.getInstance(); // ✅ 싱글톤 서비스 주입
    }

    public static CardDesignController getInstance() {
        return instance;
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
	public void saveFinalCard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		BufferedReader reader = request.getReader();
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		String jsonData = sb.toString();
		
		Gson gson = new Gson();
		Map<String, String> formData = gson.fromJson(jsonData, Map.class);
		
		String title = formData.get("title");
		String finalImageUrl = formData.get("finalImageUrl");
		
		ServletContext sc = request.getServletContext();
		
		String fileName = "cover_"+System.currentTimeMillis();
		String imageUrl = saveBase64ImageToFile(finalImageUrl, fileName, sc);
		
		service.saveFinalCard(title, imageUrl);
		
		Map<String, String> result = new HashMap<String, String>();
		result.put("success", "카드 커버 저장 성공");
		result.put("message", "실패요");
		
		String jsonResponse = gson.toJson(result);
		
		response.setContentType("appliction/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonResponse);
	}
	
	private String saveBase64ImageToFile(String base64Image, String fileName, ServletContext sc) throws Exception {
	    // base64 헤더 제거
	    String base64Data = base64Image.split(",")[1];
	    byte[] imageBytes = Base64.getDecoder().decode(base64Data);

	    String contextPath = (String) sc.getAttribute("path");
	    
	    // 저장 경로 지정 (예: webapp/uploads/cover/)
	    String uploadPath = sc.getRealPath("/uploads/cover/");
	    System.out.println("Image upload: "+uploadPath);
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) uploadDir.mkdirs();

	    // 파일명 지정 및 저장
	    String filePath = uploadPath + fileName + ".png";
	    try (FileOutputStream fos = new FileOutputStream(filePath)) {
	        fos.write(imageBytes);
	    }

	    // 웹에서 접근할 수 있는 상대 경로로 반환 (DB에 저장될 값)
	    return contextPath+"/uploads/cover/"+fileName+".png";
	}

}
