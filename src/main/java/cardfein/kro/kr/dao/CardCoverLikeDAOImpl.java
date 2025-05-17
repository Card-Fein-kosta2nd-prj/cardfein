package cardfein.kro.kr.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import cardfein.kro.kr.util.DbUtil;

public class CardCoverLikeDAOImpl implements CardCoverLikeDAO {
	
private Properties proFile = new Properties();
	
	public CardCoverLikeDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean hasUserLiked(int coverNo, int userNo) {
		String sql = "SELECT COUNT(*) FROM cover_like WHERE cover_no = ? AND user_no = ?";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, coverNo);
			ps.setInt(2, userNo);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		
		return false;
	}

	/**
	 * 좋아요 추가 메서드
	 */
	@Override
	public void likeCover(int coverNo, int userNo) throws SQLException {
		String sql = "insert into cover_like(cover_no, user_no) values (?, ?)";
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, coverNo);
			ps.setInt(2, userNo);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.dbClose(con, ps);
		}
	}
	
	/**
	 * 좋아요 취소 메서드
	 */
	
	@Override
		public void unlikeCover(int coverNo, int userNo) throws SQLException {
			String sql = "Delete from cover_like where cover_no = ? and user_no = ?";
			
			try (Connection con = DbUtil.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
				
				ps.setInt(1, coverNo);
				ps.setInt(2, userNo);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}		
		}

}
