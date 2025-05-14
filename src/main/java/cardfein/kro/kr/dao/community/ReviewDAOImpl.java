package cardfein.kro.kr.dao.community;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import cardfein.kro.kr.dto.ReviewDto;
import cardfein.kro.kr.util.DbUtil;

public class ReviewDAOImpl implements ReviewDAO {
	private Properties proFile = new Properties();
	
	public ReviewDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//생성자
	
	
	@Override
	public List<ReviewDto> selectAll() throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<ReviewDto> list = new ArrayList<ReviewDto>();
		
		String sql= proFile.getProperty("query.selectAllReview");
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				//review_no, review_title, review_content, rating, input_date, card_img_url, user_id
				ReviewDto reviews = 
				new ReviewDto(rs.getInt(1), rs.getString(2), rs.getString(3),
						rs.getInt(4), rs.getString(5), rs.getString(6),
						rs.getString(7));
				
			   list.add(reviews);
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

}
