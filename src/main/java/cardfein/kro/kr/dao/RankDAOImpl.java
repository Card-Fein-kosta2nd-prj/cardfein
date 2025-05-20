package cardfein.kro.kr.dao;

import cardfein.kro.kr.dto.CardDto;
import cardfein.kro.kr.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 혜택별 카드 랭킹 DAO 구현체 - 조회수 기준 정렬
 */
public class RankDAOImpl implements RankDAO {

    @Override
    public List<CardDto> findCardsByCategory(String category) {
        List<CardDto> cardList = new ArrayList<>();

        String sql = "SELECT c.card_no, c.card_name, c.provider, c.card_image_url " +
                     "FROM cards c " +
                     "JOIN card_benefit cb ON c.card_no = cb.card_no " +
                     "WHERE cb.category = ? " +
                     "ORDER BY c.view DESC " +
                     "LIMIT 10";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CardDto card = new CardDto();
                    card.setCardNo(rs.getInt("card_no"));
                    card.setCardName(rs.getString("card_name"));
                    card.setProvider(rs.getString("provider"));
                    card.setCardImageUrl(rs.getString("card_image_url"));
                    cardList.add(card);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // 로그 기록 권장
        }

        return cardList;
    }
}
