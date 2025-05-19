package cardfein.kro.kr.service.cart;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dao.cart.CartDAO;
import cardfein.kro.kr.dao.cart.CartDAOImpl;
import cardfein.kro.kr.dto.CardDto;

public class CartServiceImpl implements CartService {
	CartDAO dao = new CartDAOImpl();

	@Override
	public List<CardDto> selectAll() throws SQLException {
		
		List<CardDto> result = dao.selectAll();
		
		if(result == null) {
			throw new SQLException("전체 카드 리스트를 불러오지 못했습니다.");
		}
		
		return result;
		
	}

	@Override
	public List<CardDto> selectByProvider(String provider) throws SQLException {

		List<CardDto> result = dao.selectByProvider(provider);
		
		if(result == null) {
			throw new SQLException("카드사별로 카드 리스트를 불러오지 못했습니다.");
		}
		
		return result;
	}

	@Override
	public List<CardDto> selectByKeyword(String keyword) throws SQLException {
		
		List<CardDto> result = dao.selectByKeyword(keyword);
		
		if(result == null) {
			throw new SQLException("키워드 검색으로 카드 리스트를 불러오지 못했습니다.");
		}
		
		return result;
	}

	@Override
	public CardDto selectByCardNo(int cardNo) throws SQLException {
		
		CardDto result = dao.selectByCardNo(cardNo);
		
		if(result == null) {
			throw new SQLException("카드 상세 정보를 불러오지 못했습니다.");
		}
		
		return result;
	}

	@Override
	public List<CardDto> selectByProviderAndKeyword(String provider, String keyword) throws SQLException {
		List<CardDto> result = dao.selectByProviderAndKeyword(provider, keyword);
		
		if(result == null) {
			throw new SQLException("카드사 선택 후 키워드 검색으로 카드 리스트를 불러오지 못했습니다.");
		}
		
		return result;
	}
	
}
