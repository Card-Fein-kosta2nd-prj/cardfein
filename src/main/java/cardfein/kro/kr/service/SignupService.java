package cardfein.kro.kr.service;

import cardfein.kro.kr.dao.MemberDao;
import cardfein.kro.kr.dao.MemberDaoImpl;

public class SignupService {
    private final MemberDao dao = new MemberDaoImpl();

    public String register(String userId, String password, String email) {
        if (dao.isUserIdExists(userId)) return "id";
        if (dao.isPasswordExists(password)) return "pw";
        return dao.register(userId, password, email) ? "success" : "unknown";
    }
}
