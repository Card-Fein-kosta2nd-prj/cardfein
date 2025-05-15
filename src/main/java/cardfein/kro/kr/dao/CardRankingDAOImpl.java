package cardfein.kro.kr.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cardfein.kro.kr.dto.CardCoverDto;
import cardfein.kro.kr.util.DbUtil;

public class CardRankingDAOImpl implements CardRankingDAO {
	
	private static final CardRankingDAOImpl instance = new CardRankingDAOImpl();

    private CardRankingDAOImpl() {} // 생성자 private

    public static CardRankingDAOImpl getInstance() {
        return instance;
    }

	@Override
	public List<CardCoverDto> findAllCovers() {
		List<CardCoverDto> list = new ArrayList<CardCoverDto>();
		String sql = "Select cover_no, user_no, final_cover_url, title from card_cover";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int coverNo = rs.getInt("cover_no");
				int userId = rs.getInt("user_no");
				String finalUrl = rs.getString("final_cover_url");
				String title = rs.getString("title");
				list.add(new CardCoverDto(coverNo, userId, finalUrl, title));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.dbClose(rs, ps, con);
		}
		
		return list;
	}
	
	@Override
	public List<CardCoverDto> findTopCovers() {
		List<CardCoverDto> list = new ArrayList<CardCoverDto>();
		
		return null;
	}

}
