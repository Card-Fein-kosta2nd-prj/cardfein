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

public class MainDAOImpl implements MainDAO{
	
	private Properties proFile = new Properties();

	public MainDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 조회수 top6 카드 검색
	 */
	@Override
	public List<CardDto> selectCardList() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CardDto> list = new ArrayList<CardDto>();

		String sql = proFile.getProperty("query.selectCardList");//select card_name,provider,card_image_url,

		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();
			// cardfein.kro.kr.dto.CardDto.CardDto(
//			int cardNo,
//			String cardName,
//			String provider,
//			String fee,
//			String cardImageUrl,
//			int view
//			)
			while (rs.next()) {
				CardDto card = new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), "", rs.getString(4), 0);
				list.add(card);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}
	/**
	 * 보유카드 top6 검색
	 */
	@Override
	public List<CardDto> selectMyCardList() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CardDto> list = new ArrayList<CardDto>();

		String sql = proFile.getProperty("query.selectMyCardList");//select card_name,provider,card_image_url,

		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				CardDto card = new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), "", rs.getString(4), 0);
				list.add(card);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}
	/**
	 * 혜택별 인기카드 top4
	 */
	@Override
	public List<CardDto> selectPopularList() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CardDto> list = new ArrayList<CardDto>();

		String sql = proFile.getProperty("query.selectPopularList");//select rn,card_name, card_image_url,category

		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				CardDto card = new CardDto(rs.getInt(1), rs.getString(2), "", "", rs.getString(3), 0,new CardBenefitDto(0, rs.getString(4), "", 0,0.0));
				list.add(card);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}
}
