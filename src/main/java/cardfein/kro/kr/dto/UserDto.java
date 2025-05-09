package cardfein.kro.kr.dto;

public class UserDto {

    private int userNo;               // 회원번호
    private String userId;           // 회원ID
    private String password;         // 비밀번호
    private String email;            // 이메일
    private String role;             // 권한 ('member', 'admin')
    private int status;              // 상태 (1: 활성, 0: 비활성 등)
    private String category;         // 관심분야
    private String adminId;          // 관리자ID

    // 기본 생성자
    public UserDto() {
    }

    // 전체 생성자
    public UserDto(int userNo, String userId, String password, String email,
                   String role, int status, String category, String adminId) {
        this.userNo = userNo;
        this.userId = userId;
        this.password = password;
        this.email = email;
        this.role = role;
        this.status = status;
        this.category = category;
        this.adminId = adminId;
    }

    // Getter & Setter
    public int getUserNo() {
        return userNo;
    }

    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }
}

