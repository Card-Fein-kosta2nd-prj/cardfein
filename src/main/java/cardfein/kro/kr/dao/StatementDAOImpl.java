package cardfein.kro.kr.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import cardfein.kro.kr.dto.CardBenefitDto;
import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.util.DbUtil;
import cardfein.kro.kr.util.OcrEncryptor;

public class StatementDAOImpl implements StatementDAO {
	private Properties proFile = new Properties();

	public StatementDAOImpl() {
		try {
			InputStream is = getClass().getClassLoader().getResourceAsStream("dbQuery.properties");
			proFile.load(is);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 소비 top2 카테고리에 해당하는 카드정보 5개 검색
	 */
	@Override
	public List<CardDto> selectByCategory(String[] category) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CardDto> list = new ArrayList<CardDto>();

		String sql = proFile.getProperty("query.selectByCategory");// select card_no,card_name,
																	// provider,card_image_url,category, discount_rate
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, category[0]);
			ps.setString(2, category[1]);
			System.out.println(category[0]+category[1]);

			rs = ps.executeQuery();
			// CardDto(int cardNo, String cardName, String provider, String fee, String
			// cardImageUrl, int view,List<CardBenefitDto> cardBenefitList)
			// CardBenefitDto(int benefit_no, String category, String description, int
			// card_no, double discount_rate)
			while (rs.next()) {
				CardDto card = new CardDto(rs.getInt(1), rs.getString(2), rs.getString(3), null, "cardImageUrl", 0,
						new CardBenefitDto(0, rs.getString(5), null, 0, rs.getDouble(6)));
				list.add(card);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

	/**
	 * 카드 번호에 해당하는 카테고리별 할인율 검색
	 */
	@Override
	public List<CardBenefitDto> selectByCardNo(List<Integer> cardNoList) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CardBenefitDto> list = new ArrayList<CardBenefitDto>();
		System.out.println(cardNoList.toString());

		String sql = proFile.getProperty("query.selectByCardNumber");// select category,card_no, discount_rate
		System.out.println(sql);
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, cardNoList.get(0));
			ps.setInt(2, cardNoList.get(1));
			ps.setInt(3, cardNoList.get(2));
			ps.setInt(4, cardNoList.get(3));
			ps.setInt(5, cardNoList.get(4));

			rs = ps.executeQuery();
			// CardBenefitDto(int benefit_no, String category, String description, int
			// card_no, double discount_rate)
			while (rs.next()) {
				CardBenefitDto cardBenefit = new CardBenefitDto(0, rs.getString(1), "", rs.getInt(2), rs.getDouble(3));
				list.add(cardBenefit);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return list;
	}

	/**
	 * 명세서 분석 결과 추가
	 */
	@Override
	public int insertStatementResult(List<Object> statementResult) throws SQLException {
		String ocrText = (String) statementResult.get(0); // db 저장할 ocr text
		String encryptedOcrText = OcrEncryptor.encrypt(ocrText);
		
		List<Map<String, String>> statement = (List<Map<String, String>>) statementResult.get(1); // db 저장할 명세서 데이터
		Map<String, Integer> categorySums = (Map<String, Integer>) statementResult.get(2); // db 저장할 category별 합계
		Map<Integer, Double> matchingRateDb = (Map<Integer, Double>) statementResult.get(3); // db 저장할 Map<카드번호,매칭률>
		int userNo = (Integer)statementResult.get(4);// userNo
		String[] dateArr= statement.get(0).get("date").split("-");
		

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int result = 0;
		String sql = proFile.getProperty("query.insertOcr");// insert into receipt(user_no,ocr_result) values(?,?);
		try {
			con = DbUtil.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setInt(1, userNo); // 추후 해당하는 회원번호로 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			ps.setString(2, encryptedOcrText);
//			ps.setString(2, "테스트 암호화 문자열");

			result = ps.executeUpdate();
			if (result == 0) {
				con.rollback();
				throw new SQLException("OCR데이터 저장이 불가합니다.");
			} else {
				rs = ps.getGeneratedKeys();
				int statementId = 0;
				if (rs.next()) {
					statementId = rs.getInt(1);
				}
				insertStatementItems(con, statementId, statement,userNo);
				insertMonthlyConsum(con, categorySums, dateArr,userNo);
				insertMonthlyCard(con, matchingRateDb, dateArr,userNo);
				con.commit();
			}
		} catch (Exception e) {
			con.rollback();
			throw new SQLException("명세서 데이터 추가가 불가합니다. 고객센터에 문의 바랍니다.");
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return result;
	}

	/**
	 * 명세서 항목들 추가
	 */
	public void insertStatementItems(Connection con, int statementId, List<Map<String, String>> statement,int userNo)
			throws SQLException {
		String encryptedDate ="";
		String encryptedMerchant ="";
		String encryptedAmount ="";
		String encryptedCategory="";
		
		PreparedStatement ps = null;
		int[] result = null;
		String sql = proFile.getProperty("query.insertStatementItem");// insert into
																		// receipt_item(receipt_id,user_no,consume_at,merchant,amount,category)
																		// values(?,?,?,?,?,?);
		try {
			ps = con.prepareStatement(sql);
			for (Map<String, String> item : statement) {
				encryptedDate = OcrEncryptor.encrypt(item.get("date"));
				encryptedMerchant = OcrEncryptor.encrypt(item.get("merchant"));
				encryptedAmount = OcrEncryptor.encrypt(item.get("amount"));
			    encryptedCategory = OcrEncryptor.encrypt(item.get("category"));
				
			    
				ps.setInt(1, statementId);
				ps.setInt(2, userNo); // 추후 해당하는 회원번호로 수정되어야 함!!!!!!!!!!!!!!!!!
				ps.setString(3, encryptedDate); 
				ps.setString(4, encryptedMerchant);
				ps.setString(5, encryptedAmount);
				ps.setString(6, encryptedCategory);
				
				ps.addBatch(); 
				ps.clearParameters(); 
			}
			result = ps.executeBatch();// 일괄처리
			for (int i : result) {
				if (i != 1) {
					con.rollback();
					throw new SQLException("명세서 항목 추가 불가합니다.");
				}
			}
		} finally {
			DbUtil.dbClose(null, ps);
		}
	}
	
	/**
	 * 월별 소비내역 테이블에 추가
	 */
	public void insertMonthlyConsum(Connection con, Map<String, Integer> categorySums,String[] dateArr,int userNo)
			throws SQLException {
		PreparedStatement ps = null;
		int[] result = null;
		String sql = proFile.getProperty("query.insertMonthlySummary");// insert into monthly_summary(user_no,expense_year,expense_month,category,total_amount,updated_at) values(?,?,?,?,?,now());
		String year =dateArr[0];
		String month =dateArr[1];
		try {
			ps = con.prepareStatement(sql);
			for (String category : categorySums.keySet()) {
				
				ps.setInt(1, userNo); // 추후 해당하는 회원번호로 수정되어야 함!!!!!!!!!!!!!!!!!
				ps.setInt(2, Integer.parseInt(year));
				ps.setInt(3, Integer.parseInt(month));
				ps.setString(4, category);
				ps.setInt(5, categorySums.get(category));
				
				ps.addBatch(); 
				ps.clearParameters(); 
			}
			result = ps.executeBatch();// 일괄처리
			for (int i : result) {
				if (i != 1) {
					con.rollback();
					throw new SQLException("월별 소비내역 추가 불가합니다.");
				}
			}
		} finally {
			DbUtil.dbClose(null, ps);
		}
	}
	/**
	 * 월별 추천카드 테이블에 추가
	 */
	public void insertMonthlyCard(Connection con, Map<Integer, Double> matchingRateDb,String[] dateArr,int userNo)throws SQLException {
		PreparedStatement ps = null;
		int[] result = null;
		String sql = proFile.getProperty("query.insertMonthlyRec");// insert into monthly_recommendations(expense_year,expense_month,match_score,recommended_at,card_no,user_no) values(?,?,?,now(),?,?);
		String year =dateArr[0];
		String month =dateArr[1];
		try {
			ps = con.prepareStatement(sql);
			for (Integer cardNo : matchingRateDb.keySet()) {
				ps.setInt(1, Integer.parseInt(year));
				ps.setInt(2, Integer.parseInt(month));
				ps.setDouble(3, matchingRateDb.get(cardNo));
				ps.setInt(4, cardNo);
				ps.setInt(5, userNo); // 추후 해당하는 회원번호로 수정되어야 함!!!!!!!!!!!!!!!!!
				
				ps.addBatch(); 
				ps.clearParameters(); 
			}
			result = ps.executeBatch();// 일괄처리
			for (int i : result) {
				if (i != 1) {
					con.rollback();
					throw new SQLException("월별 추천카드 추가 불가합니다.");
				}
			}
		} finally {
			DbUtil.dbClose(null, ps);
		}
	}
	
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	/**
	 * 회원 맞춤 카드정보 검색
	 */
	@Override
	public List<CardDto> selectRecommendCardList(int userNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Map<Integer, CardDto> cardMap = new HashMap<>();
		
		List<String> category=  selectRecentCategory(userNo);
		Map<Integer,Double> matchingRates=selectMatchRate(userNo);
		Integer[] cardNos = matchingRates.keySet().toArray(new Integer[0]);

		String sql = proFile.getProperty("query.selectRecommendCardDetails");// select card_no,card_name,card_image_url,category,discount_rate
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, cardNos[0]);
			ps.setInt(2, cardNos[1]);
			ps.setInt(3, cardNos[2]);
			ps.setString(4, category.get(0));
			ps.setString(5, category.get(1));
			rs = ps.executeQuery();
			while (rs.next()) {
				int cardNoMatch = rs.getInt(1);
				CardDto card=cardMap.get(cardNoMatch);
				
				if(card==null) {
					card = new CardDto(cardNoMatch, rs.getString(2), "", "", rs.getString(3),0);
					card.setCardBenefit(new CardBenefitDto(0, rs.getString(4), "", 0, rs.getDouble(5)));
					card.setMatchingRate(matchingRates.get(cardNoMatch));
			        cardMap.put(cardNoMatch, card);
				}
				CardBenefitDto benefit = new CardBenefitDto(0, rs.getString(4), "", 0, rs.getDouble(5));
				card.getCardBenefitList().add(benefit);
				
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return new ArrayList<>(cardMap.values());
	}
	
	/**
	 * 회원 소비기반 매칭률,카드번호 검색(top3)
	 */
	public Map<Integer,Double> selectMatchRate(int userNo) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Map<Integer,Double> avgMatchingRate = new HashMap<>();

		String sql = proFile.getProperty("query.selectMatchedCardList");// select avg(match_score),card_no 
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, userNo); // 추후 해당하는 회원번호로 수정되어야 함!!!!!!!!!!!!!!!!!
			ps.setInt(2, userNo); // 추후 해당하는 회원번호로 수정되어야 함!!!!!!!!!!!!!!!!!

			rs = ps.executeQuery();
			while (rs.next()) {
				avgMatchingRate.put(rs.getInt(1),rs.getDouble(2)) ;
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return avgMatchingRate;
	}
	
	
	/**
	 * 최근 소비가 많았던 카테고리 top2 검색
	 */
	public List<String> selectRecentCategory(int userNo) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<String> categories = new ArrayList<>();

		String sql = proFile.getProperty("query.selectRecentCategory");// SELECT ms.category, SUM(ms.total_amount)
		try {
			con = DbUtil.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, userNo); // 추후 해당하는 회원번호로 수정되어야 함!!!!!!!!!!!!!!!!!
			ps.setInt(2, userNo); // 추후 해당하는 회원번호로 수정되어야 함!!!!!!!!!!!!!!!!!

			rs = ps.executeQuery();
			while (rs.next()) {
				String category = rs.getString(1);
				categories.add(category);
			}
		} finally {
			DbUtil.dbClose(con, ps, rs);
		}
		return categories;
	}
}