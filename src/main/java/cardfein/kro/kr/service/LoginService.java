package cardfein.kro.kr.service;

import cardfein.kro.kr.dao.MemberDao;
import cardfein.kro.kr.dao.MemberDaoImpl;
import cardfein.kro.kr.dto.LoginDto;

public class LoginService {
    private final MemberDao dao = new MemberDaoImpl();

    public LoginDto login(String userId, String password) {
        return dao.login(userId, password);
    }
}
