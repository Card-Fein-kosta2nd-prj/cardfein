package cardfein.kro.kr.dao.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.ReviewDto;

public interface ReviewDAO {
	
	/**
	 * 리뷰 목록 전체 검색
	 * @return 리뷰 리스트
	 * @throws SQLException
	 */
	List<ReviewDto> selectAll() throws SQLException;

}
