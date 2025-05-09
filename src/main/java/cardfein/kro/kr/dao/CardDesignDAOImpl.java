package cardfein.kro.kr.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import cardfein.kro.kr.dto.CardCoverDto;
import cardfein.kro.kr.util.DbUtil;

public class CardDesignDAOImpl implements CardDesignDAO {
	
	@Override
	public String getDefaultCardDesign() {
		
		String sql = "select base_card_url from card_cover where is_default = 1";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString("base_card_url");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		return null;
	}

	@Override
	public void saveFinalCardImage(int userNo, String title, String finalCoverUrl) {
		
		String sql = "insert into card_cover(user_no, title, final_cover_url) values (?, ?, ?)";
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, userNo);
			ps.setString(2, title);
			ps.setString(3, finalCoverUrl);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
