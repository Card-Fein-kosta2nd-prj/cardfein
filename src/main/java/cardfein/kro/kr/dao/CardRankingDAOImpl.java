package cardfein.kro.kr.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import cardfein.kro.kr.dto.CardCoverDto;
import cardfein.kro.kr.util.DbUtil;

public class CardRankingDAOImpl implements CardRankingDAO {
	
private Properties proFile = new Properties();
	
	public CardRankingDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	    List<CardCoverDto> list = new ArrayList<>();
	    String sql = """
	        SELECT 
	            cc.cover_no,
	            cc.final_cover_url,
	            cc.title,
	            cc.user_no,
	            COUNT(cl.like_no) AS like_count
	        FROM 
	            card_cover cc
	        LEFT JOIN 
	            cover_like cl ON cc.cover_no = cl.cover_no
	        GROUP BY 
	            cc.cover_no
	        ORDER BY 
	            like_count DESC
	        LIMIT 5
	    """;

	    try (
	        Connection conn = DbUtil.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();
	    ) {
	        while (rs.next()) {
	            CardCoverDto dto = new CardCoverDto();
	            dto.setCover_no(rs.getInt("cover_no"));
	            dto.setFinalCardUrl(rs.getString("final_cover_url"));
	            dto.setTitle(rs.getString("title"));
	            dto.setUserId(rs.getInt("user_no"));
	            // 필요 시 like_count도 dto에 추가 가능
	            list.add(dto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}


}
