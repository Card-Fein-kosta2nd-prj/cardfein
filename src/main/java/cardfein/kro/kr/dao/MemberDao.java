package cardfein.kro.kr.dao;

import cardfein.kro.kr.dto.LoginDto;

public interface MemberDao {
	
	boolean register(String userId, String password, String email);
    boolean isUserIdExists(String userId);
    boolean isPasswordExists(String password);
    LoginDto login(String userId, String password);
}
