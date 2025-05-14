package cardfein.kro.kr.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.dto.UserCardDto;
import cardfein.kro.kr.util.DbUtil;
import cardfein.kro.kr.util.OcrEncryptor;

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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserCardDto> selectMatchTrend() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CardDto> selectMyCardDetails() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
