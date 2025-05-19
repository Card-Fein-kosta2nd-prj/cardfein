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
	
	@Override
    public CardDto getCardsDetail(int cardNo) {
        String cardSql = """
            SELECT
                card_no,
                card_name,
                provider,
                fee,
                card_image_url
            FROM
                cards
            WHERE
                card_no = ?
            """;

        String benefitSql = """
            SELECT
                description
            FROM
                card_benefit
            WHERE
                card_no = ?
            """;

        Connection con = null;
        PreparedStatement cardPs = null;
        ResultSet cardRs = null;
        
        PreparedStatement benefitPs = null;
        ResultSet benefitRs = null;
        CardDto cardDetail = new CardDto();
        List<CardBenefitDto> benefits = new ArrayList<>();

        try {
            con = DbUtil.getConnection();

            // cards 테이블에서 카드 정보 가져오기
            cardPs = con.prepareStatement(cardSql);
            cardPs.setInt(1, cardNo);
            cardRs = cardPs.executeQuery();

            if (cardRs.next()) {
                cardDetail.setCardNo(cardRs.getInt("card_no"));
                cardDetail.setCardName(cardRs.getString("card_name"));
                cardDetail.setProvider(cardRs.getString("provider"));
                cardDetail.setFee(cardRs.getString("fee"));
                cardDetail.setCardImageUrl(cardRs.getString("card_image_url"));
            }

            // card_benefit 테이블에서 해당 card_no의 모든 혜택 정보 가져오기
            benefitPs = con.prepareStatement(benefitSql);
            benefitPs.setInt(1, cardNo);
            benefitRs = benefitPs.executeQuery();

            while (benefitRs.next()) {
                CardBenefitDto benefit = new CardBenefitDto();
                benefit.setDescription(benefitRs.getString("description"));
                benefits.add(benefit);
            }
            cardDetail.setCardBenefitList(benefits);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.dbClose(null, cardPs, cardRs);
            DbUtil.dbClose(con, benefitPs, benefitRs);
        }
        return cardDetail; // List가 아닌 단일 CardDto 객체 반환
    }
	
	@Override
	public boolean incrementCardView(int cardNo) throws SQLException {
		String sql = "update cards set view = view + 1 where card_no = ?";
		boolean success = false;
		
		try(Connection con = DbUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, cardNo);
			int rows = ps.executeUpdate();
			
			if (rows > 0) {
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			
		}
		return success;
	}
}
