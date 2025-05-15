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

import cardfein.kro.kr.service.CardDesignService;
import cardfein.kro.kr.service.CardDesignServiceImpl;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

public class CardDesignController implements RestController{
	private static final CardDesignController instance = new CardDesignController();

    private final CardDesignService service;

    private CardDesignController() {
        this.service = CardDesignServiceImpl.getInstance(); // 싱글톤 서비스 주입
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
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    // 1. 폼 필드(title) 추출
	    String title = request.getParameter("title");

	    // 2. 파일 파트(finalImage) 추출
	    Part imagePart = request.getPart("finalImage");

	    // 3. 파일 이름 및 저장 경로 설정
	    String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
	    String fileName = title+"_img.png";

	    ServletContext sc = request.getServletContext();
	    String uploadPath = sc.getRealPath("/static/upload/cover");
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) uploadDir.mkdirs();

	    // 4. 파일 저장
	    File file = new File(uploadDir, fileName);
	    try (InputStream input = imagePart.getInputStream();
	         FileOutputStream output = new FileOutputStream(file)) {
	        byte[] buffer = new byte[1024];
	        int bytesRead;
	        while ((bytesRead = input.read(buffer)) != -1) {
	            output.write(buffer, 0, bytesRead);
	        }
	    }

	    // 5. DB에 저장할 상대경로 생성
	    String imageUrl = "/static/upload/cover/" + fileName;

	    // 6. DB 저장 호출
	    service.saveFinalCard(title, imageUrl);

	    // 7. 응답 JSON
	    Map<String, String> result = new HashMap<>();
	    result.put("success", "카드 커버 저장 성공");
	    result.put("error", "실패");

	    Gson gson = new Gson();
	    String jsonResponse = gson.toJson(result);
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