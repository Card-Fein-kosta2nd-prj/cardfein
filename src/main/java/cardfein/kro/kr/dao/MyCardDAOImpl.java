package cardfein.kro.kr.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.dto.UserCardDto;
import cardfein.kro.kr.util.DbUtil;

public class MyCardDAOImpl implements MyCardDAO {
	private Properties proFile = new Properties();

	public MyCardDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<CardDto> selectByKeyword(String keyword) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CardDto> list = new ArrayList<>();

		String sql = proFile.getProperty("query.selectByKeword");// select card_no,card_name,provider ,card_image_url
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, '%' + keyword + '%');
			ps.setInt(2, 1); // 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

			rs = ps.executeQuery();
			// CardDto(int cardNo,String cardName, String provider, String fee, String
			// cardImageUrl, int view)
			while (rs.next()) {
				CardDto card = new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), "", rs.getString(4), 0);
				list.add(card);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

	@Override
	public int insertMyCard(int cardNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int result = 0;
		String sql = proFile.getProperty("query.insertMyCard");// insert into user_card(card_no,user_no) values(?,?);
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, cardNo);
			ps.setInt(2, 1);// 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

			result = ps.executeUpdate();
			if (result == 0) {
				throw new SQLException("카드 저장이 불가합니다.");
			}

		} catch (Exception e) {
			throw new SQLException("카드 저장이 불가합니다. 고객센터에 문의 바랍니다.");
		} finally {
			DbUtil.dbClose(con, ps, null);
		}
		return result;
	}

	@Override
	public int insertRequest(String content) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int result = 0;
		String sql = proFile.getProperty("query.insertRequest");// insert into ask(title,content) values(?,?);
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, "카드 추가 요청");
			ps.setString(2, content);

			result = ps.executeUpdate();
			if (result == 0) {
				throw new SQLException("문의 등록이 불가합니다.");
			}

		} catch (Exception e) {
			throw new SQLException("문의 등록이 불가합니다. 고객센터에 연락 바랍니다.");
		} finally {
			DbUtil.dbClose(con, ps, null);
		}
		return result;
	}

	@Override
	public UserCardDto selectMatchTrend() throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		UserCardDto userCard = new UserCardDto();
		Set<String> dateSet = userCard.getDateSet();
		Map<String, Map<String, Double>> matchTrend = userCard.getMatchTrend();

		String sql = proFile.getProperty("query.selectMatchTrend");// select card_name,concat(yr,'-',case when m<10 then
																	// concat(0,m) else m end) as date,round(match_r,1)
																	// m_rate
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, 1); // 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			ps.setInt(2, 1); // 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			ps.setInt(3, 1); // 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

			rs = ps.executeQuery();
			//
			while (rs.next()) {
				String cardName = rs.getString(1);
				String date = rs.getString(2);
				Double rate = rs.getDouble(3);

				dateSet.add(date);
				if (matchTrend.get(cardName) == null) {
					Map<String, Double> map = new HashMap<>();
					map.put(date, rate);
					matchTrend.put(cardName, map);
				} else
					matchTrend.get(cardName).put(date, rate);
			}

			for (String date : dateSet) {
				for (String name : matchTrend.keySet()) {
					if (matchTrend.get(name).get(date) == null) {
						matchTrend.get(name).put(date, 0.0);
					}
				}
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return userCard;
	}

	@Override
	public Map<Integer, CardDto> selectMyCardDetails() throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Map<Integer, CardDto> map = new HashMap<>();

		String sql = proFile.getProperty("query.selectMyCards");// select
																// card_no,card_name,card_image_url,concat(category,'
																// ',round(discount_rate,1))
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, 1); // 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

			rs = ps.executeQuery();
			while (rs.next()) {
				int cardNo = rs.getInt(1);
				String cardName = rs.getString(2);
				String url = rs.getString(3);
				String category = rs.getString(4);

				if (map.get(cardNo) == null) {
					CardDto card = new CardDto(cardNo, cardName, url);//추후 바꿔야함
					card.getDiscount().add(category);
					map.put(cardNo, card);
				} else {
					map.get(cardNo).getDiscount().add(category);
				}
			}

		} finally {
			DbUtil.dbClose(con, ps, rs);
		}

		return map;
	}
	@Override
	public int deleteMyCard(int cardNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int result = 0;
		String sql = proFile.getProperty("query.deleteMyCard");// delete from user_card where user_no=? and card_no=?;
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, 1); // 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			ps.setInt(2, cardNo);

			result = ps.executeUpdate();
			if (result == 0) {
				throw new SQLException("카드 삭제가 불가합니다.");
			}

		} catch (Exception e) {
			throw new SQLException("카드 삭제가 불가합니다.");
		} finally {
			DbUtil.dbClose(con, ps, null);
		}
		return result;
	}

}
