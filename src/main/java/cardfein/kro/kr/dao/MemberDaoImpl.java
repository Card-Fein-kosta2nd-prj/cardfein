package cardfein.kro.kr.dao;

import java.sql.*;

import cardfein.kro.kr.dto.LoginDto;
import cardfein.kro.kr.util.DbUtil;

public class MemberDaoImpl implements MemberDao {

    // 회원 등록
    @Override
    public boolean register(String userId, String password, String email) {
        String sql = "INSERT INTO users (user_id, password, email, role, status) VALUES (?, ?, ?, 'member', 1)";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ID 중복 확인
    @Override
    public boolean isUserIdExists(String userId) {
        String sql = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 비밀번호 중복 확인
    @Override
    public boolean isPasswordExists(String password) {
        String sql = "SELECT COUNT(*) FROM users WHERE password = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 이메일 중복 확인
    @Override
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 로그인 (role 포함하여 분기 가능하도록 수정)
    @Override
    public LoginDto login(String userId, String password) {
        String sql = "SELECT user_no, user_id, password, email, role, category " +
                     "FROM users WHERE user_id = ? AND password = ? AND status = 1";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new LoginDto(
                        rs.getInt("user_no"),
                        rs.getString("user_id"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("role"),
                        rs.getString("category")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 이메일로 아이디 찾기
    @Override
    public String findUserIdByEmail(String email) {
        String sql = "SELECT user_id FROM users WHERE email = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("user_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 아이디 + 이메일로 비밀번호 찾기
    @Override
    public String findPasswordByUserIdAndEmail(String userId, String email) {
        String sql = "SELECT password FROM users WHERE user_id = ? AND email = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("password");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}