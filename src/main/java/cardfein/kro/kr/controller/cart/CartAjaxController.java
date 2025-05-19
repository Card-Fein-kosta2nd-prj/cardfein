package cardfein.kro.kr.controller.cart;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cardfein.kro.kr.controller.RestController;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.service.cart.CartService;
import cardfein.kro.kr.service.cart.CartServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CartAjaxController implements RestController{
	
	private CartService service = new CartServiceImpl();

	//카드 전체 or 키워드 조회
	public Object selectAll(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		
		String keyword = request.getParameter("keyword");
		
		List<CardDto> result;
		
		if(keyword == null || keyword.trim().isEmpty()) {
			result = service.selectAll();
		} else {
			result = service.selectByKeyword(keyword);
		}//end if
		
		return result;
	}
	
	//카드사별 조회
	public Object selectByProvider(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    String provider = request.getParameter("provider");

	    List<CardDto> result = service.selectByProvider(provider);

	    return result;
	}
	
	//선택된 카드 정보 상세 조회
	public Object selectByCardNo(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    
		String cardNoStr = request.getParameter("cardNo");
		
	    if (cardNoStr == null) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        return Map.of("error", "카드 번호가 전달되지 않았습니다.");
	    }

	    int cardNo = Integer.parseInt(cardNoStr);
	    CardDto card = service.selectByCardNo(cardNo); // 카드 상세 + 혜택 포함

	    return card;
	}
	
	// 키워드만으로 검색 (카드사 X)
	public Object selectByKeyword(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    String keyword = request.getParameter("keyword");

	    if (keyword == null || keyword.trim().isEmpty()) {
	        return List.of(); // 빈 리스트 반환
	    }

	    return service.selectByKeyword(keyword);
	}
	
	// 카드사 + 키워드 검색
	public Object selectByProviderAndKeyword(HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    System.out.println("카트 여기오니?");
		
		String provider = request.getParameter("provider");
	    String keyword = request.getParameter("keyword");

	    if(provider == null || keyword == null || provider.trim().isEmpty() || keyword.trim().isEmpty()) {
	        return List.of(); // 빈 리스트 반환
	    }

	    return service.selectByProviderAndKeyword(provider, keyword);
	}

}
