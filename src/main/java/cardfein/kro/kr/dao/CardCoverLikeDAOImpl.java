package cardfein.kro.kr.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import cardfein.kro.kr.util.DbUtil;

public class CardCoverLikeDAOImpl implements CardCoverLikeDAO {
	
	private static final CardCoverLikeDAOImpl instance = new CardCoverLikeDAOImpl();
	
	private CardCoverLikeDAOImpl() {}
	
	public static CardCoverLikeDAOImpl getInstance() {
		return instance;
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
			DbUtil.dbClose(rs, ps, con);
		}
		
		return false;
	}

	/**
	 * user_no = 2 일단 로그인 정보가 없어서 넣어놓고 구현
	 */
	@Override
	public void addLike(int coverNo, int userNo) {
		String sql = "insert into cover_like(cover_no, user_no) values (?, 2)";
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
			DbUtil.dbClose(ps, con);
		}
	}

	@Override
	public int getLikeCount(int coverNo) {
		String sql = "SELECT COUNT(*) FROM cover_like WHERE cover_no = ?";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, coverNo);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.dbClose(rs, ps, con);
		}
		return 0;
	}

}
