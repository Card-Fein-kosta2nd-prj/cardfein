package cardfein.kro.kr.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.util.DbUtil;

public class FitCardDAOImpl implements FitCardDAO{

	@Override
	public List<CardDto> getCardsByCategory(String category) {
		String sql = """
				SELECT
				    c.card_no,
				    c.card_name,
				    c.provider,
				    c.fee,
				    c.card_image_url,
				    cb.category AS benefitCategory,
				    cb.description AS benefitDescription
				FROM
				    cards c
				JOIN
				    card_benefit cb ON c.card_no = cb.card_no
				WHERE
				    cb.category LIKE ?
				""";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CardDto> list = new ArrayList<CardDto>();
		Map<Integer, CardDto> cardMap = new HashMap<Integer, CardDto>();
		
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, "%"+category+"%");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int cardNo = rs.getInt("card_no");
				
				if (!cardMap.containsKey(cardNo)) {
					CardDto cardDto = new CardDto();
					cardDto.setCardNo(cardNo);
					
					cardDto.setCardName(rs.getString("card_name"));
					cardDto.setProvider(rs.getString("provider"));
					cardDto.setFee(rs.getString("fee"));
					cardDto.setCardImageUrl(rs.getString("card_image_url"));
					cardMap.put(cardNo, cardDto);
					list.add(cardDto);
				}
				
				CardBenefitDto benefitDto = new CardBenefitDto();
				benefitDto.setCategory(rs.getString("benefitCategory"));
				benefitDto.setDescription(rs.getString("benefitDescription"));
				benefitDto.setCardNo(cardNo);
				
				cardMap.get(cardNo).setCardBenefit(benefitDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}
}
