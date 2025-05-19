package cardfein.kro.kr.dao.cart;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.util.DbUtil;

public class CartDAOImpl implements CartDAO {
	private Properties proFile = new Properties();
	
	public CartDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//생성자

	@Override
	public List<CardDto> selectAll() throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<CardDto> list = new ArrayList<>();
		
		String sql= proFile.getProperty("query.selectAllCards");
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				//card_no, card_name, provider, card_image_url
				CardDto cards = 
				new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
				
			   list.add(cards);
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

	@Override
	public List<CardDto> selectByProvider(String provider) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<CardDto> list = new ArrayList<>();
		
		String sql= proFile.getProperty("query.selectByProvider");
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);

			ps.setString(1, provider);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				//card_no, card_name, provider, card_image_url
				CardDto cards = 
				new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
				
			   list.add(cards);
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

	@Override
	public List<CardDto> selectByKeyword(String keyword) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<CardDto> list = new ArrayList<>();
		
		String sql= proFile.getProperty("query.selectByKeyword");
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);

			ps.setString(1, "%" + keyword + "%");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				//card_no, card_name, provider, card_image_url
				CardDto cards = 
				new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
				
			   list.add(cards);
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

	@Override
	public CardDto selectByCardNo(int cardNo) throws SQLException {
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    CardDto card = null;
	    List<CardBenefitDto> benefitList = new ArrayList<>();

	    String sql = proFile.getProperty("query.selectByCardNo");

	    try {
	        con = DbUtil.getConnection();
	        ps = con.prepareStatement(sql);
	        ps.setInt(1, cardNo);
	        rs = ps.executeQuery();

	        System.out.println("쿼리 실행 완료. 결과 있음? " + rs.isBeforeFirst()); // true면 결과 있음
	        
	        while (rs.next()) {
	            if (card == null) {
	                // 카드 기본 정보는 한 번만 세팅
	                card = new CardDto(
	                    rs.getInt("card_no"),
	                    rs.getString("card_name"),
	                    rs.getString("provider"),
	                    rs.getString("fee"),
	                    rs.getString("card_image_url")
	                );

	            }

	            String category = rs.getString("category");
	            String description = rs.getString("description");

	            // 혜택 정보가 null이 아닐 때만 추가
	            if (category != null && description != null) {
	                benefitList.add(new CardBenefitDto(category, description));
	            }
	        }

	        if (card != null) {
	            card.setCardBenefitList(benefitList); // 카드에 혜택 리스트 세팅
	        }
	    } finally {
	        DbUtil.dbClose(con, ps, rs);
	    }

	    return card;
	}

	public List<CardDto> selectByProviderAndKeyword(String provider, String keyword) throws SQLException {
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    List<CardDto> list = new ArrayList<>();

	    String sql = proFile.getProperty("query.selectByProviderAndKeyword");

	    try {
	        con = DbUtil.getConnection();
	        ps = con.prepareStatement(sql);
	        ps.setString(1, provider);
	        ps.setString(2, "%" + keyword + "%");
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            CardDto dto = new CardDto(
	                rs.getInt("card_no"),
	                rs.getString("card_name"),
	                rs.getString("provider"),
	                rs.getString("card_image_url")
	            );
	            list.add(dto);
	        }
	    } finally {
	        DbUtil.dbClose(con, ps, rs);
	    }

	    return list;
	}


}
