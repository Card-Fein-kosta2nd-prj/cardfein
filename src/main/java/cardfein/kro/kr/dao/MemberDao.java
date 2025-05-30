package cardfein.kro.kr.dao;

import cardfein.kro.kr.dto.LoginDto;

public interface MemberDao {

    // 회원 등록
    boolean register(String userId, String password, String email);

    // ID 중복 확인
    boolean isUserIdExists(String userId);

    // 비밀번호 중복 확인
    boolean isPasswordExists(String password);

    // 이메일 중복 확인
    boolean isEmailExists(String email);

    // 로그인
    LoginDto login(String userId, String password);

    // 이메일로 userId 찾기
    String findUserIdByEmail(String email);

    // 아이디 + 이메일로 비밀번호 찾기
    String findPasswordByUserIdAndEmail(String userId, String email);
}