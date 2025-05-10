package cardfein.kro.kr.dao;

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

public class StatementDAOImpl implements StatementDAO {
	private Properties proFile = new Properties();
	public StatementDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 소비 top2 카테고리에 해당하는 카드정보 5개 검색 
	 */
	@Override
	public List<CardDto> selectByCategory(String[] category) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<CardDto> list = new ArrayList<CardDto>();
		
		String sql= proFile.getProperty("query.selectByCategory");//select card_no,card_name, provider,card_image_url,category, discount_rate 
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, category[0]);
			ps.setString(2, category[1]);
			
			rs = ps.executeQuery();
			//CardDto(int cardNo, String cardName, String provider, String fee, String cardImageUrl, int view,List<CardBenefitDto> cardBenefitList)
			//CardBenefitDto(int benefit_no, String category, String description, int card_no, double discount_rate)
			while(rs.next()) {
				CardDto card = 
				new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), null, "cardImageUrl", 0, new CardBenefitDto(0, rs.getString(5), null, 0, rs.getDouble(6)));
			    list.add(card);
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}
	/**
	 * 카드 번호에 해당하는 카테고리별 할인율 검색
	 */
	@Override
	public List<CardBenefitDto> selectByCardNo(List<Integer> cardNoList) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<CardBenefitDto> list = new ArrayList<CardBenefitDto>();
		
		String sql= proFile.getProperty("query.selectByCardNo");//select category,card_no, discount_rate 
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, cardNoList.get(0));
			ps.setInt(2, cardNoList.get(1));
			ps.setInt(3, cardNoList.get(2));
			ps.setInt(4, cardNoList.get(3));
			ps.setInt(5, cardNoList.get(4));
			
			rs = ps.executeQuery();
			//CardBenefitDto(int benefit_no, String category, String description, int card_no, double discount_rate)
			while(rs.next()) {
				CardBenefitDto cardBenefit = 
						new CardBenefitDto(0, rs.getString(1), "", rs.getInt(2), rs.getDouble(3));
			    list.add(cardBenefit);
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

}
