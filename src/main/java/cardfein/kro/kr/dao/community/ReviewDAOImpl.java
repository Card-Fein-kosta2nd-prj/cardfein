package cardfein.kro.kr.dao.community;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import cardfein.kro.kr.dto.ReplyDto;
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
	public List<ReviewDto> selectAll(int startRow, int pageSize) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<ReviewDto> list = new ArrayList<ReviewDto>();
		
		String sql= proFile.getProperty("query.selectAllReview");
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, startRow);
			ps.setInt(2, pageSize);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				//review_no, review_title, review_content, rating, input_date, card_name, card_img_url, user_id
				ReviewDto reviews = 
				new ReviewDto(rs.getInt(1), rs.getString(2), rs.getString(3),
						rs.getInt(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9));
				
			   list.add(reviews);
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

	@Override
	public int getTotalReviewCount() throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int total = 0;

		String sql = proFile.getProperty("query.selectReviewCount");
		System.out.println("쿼리확인:" + sql);

		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			if (rs.next()) {
				total = rs.getInt(1);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return total;
	}
	
	@Override
	public int getReplyCount(int reviewNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int replyCnt = 0;

		String sql = proFile.getProperty("query.selectReplyCount");

		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, reviewNo);
			
			rs = ps.executeQuery();

			if (rs.next()) {
				replyCnt = rs.getInt(1);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return replyCnt;
	}


	@Override
	public List<ReviewDto> selectAllByKeyword(String keyword, int startRow, int pageSize) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<ReviewDto> list = new ArrayList<>();

		String sql = proFile.getProperty("query.selectAllReviewByKeyword");

		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			String likeKeyword = "%" + keyword + "%";
			ps.setString(1, likeKeyword);
			ps.setString(2, likeKeyword);
			ps.setString(3, likeKeyword);
			ps.setInt(4, startRow);
			ps.setInt(5, pageSize);

			rs = ps.executeQuery();

			while (rs.next()) {
				ReviewDto dto = new ReviewDto(
					rs.getInt(1), rs.getString(2), rs.getString(3),
					rs.getInt(4), rs.getString(5), rs.getString(6),
					rs.getString(7), rs.getString(8), rs.getInt(9)
				);
				list.add(dto);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}


	@Override
	public int getReviewCountByKeyword(String keyword) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;

		String sql = proFile.getProperty("query.selectReviewCountByKeyword");

		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			String likeKeyword = "%" + keyword + "%";
			ps.setString(1, likeKeyword);
			ps.setString(2, likeKeyword);
			ps.setString(3, likeKeyword);
			rs = ps.executeQuery();
			if (rs.next()) count = rs.getInt(1);
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return count;
	}


	@Override
	public ReviewDto selectDetailByReviewNo(int reviewNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		ReviewDto review = null;
		
		String sql= proFile.getProperty("query.selectDetailByReviewNo");
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, reviewNo);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				//review_no, review_title, review_content, rating, input_date, card_name, card_img_url, user_id
				review = 
				new ReviewDto(rs.getInt(1), rs.getString(2), rs.getString(3),
						rs.getInt(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9));
				
				//댓글 검색
				review.setReplyList(getReply(con, reviewNo));
			}
		}finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return review;
	}

	private List<ReplyDto> getReply(Connection con , int reviewNo)throws SQLException{
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<ReplyDto> list = new ArrayList<ReplyDto>();
		String sql=proFile.getProperty("query.selectAllReply");
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, reviewNo);
			rs = ps.executeQuery();
			while(rs.next()) {
				ReplyDto reply = //reply_no, reply_content, input_date, review_no, user_id
						new ReplyDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
				list.add(reply);
			}
			
		}finally {
			DbUtil.dbClose(null, ps, rs);
		}
		return list;
	}
	
	
	
}
