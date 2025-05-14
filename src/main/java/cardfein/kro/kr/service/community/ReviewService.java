package cardfein.kro.kr.service.community;

import java.sql.SQLException;
import java.util.List;

import cardfein.kro.kr.dto.ReviewDto;

public interface ReviewService {

	/**
	 * 리뷰 전체 조회
	 * @return 리뷰 리스트
	 * @throws SQLException
	 */
	List<ReviewDto> selectAll() throws SQLException;
}
