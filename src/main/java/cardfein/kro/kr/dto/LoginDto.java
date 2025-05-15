package cardfein.kro.kr.dto;

public class LoginDto {
    private int userNo;
    private String userId;
    private String password;
    private String email;
    private String role;
    private String category;

    public LoginDto() {}

    public LoginDto(int userNo, String userId, String password, String email, String role, String category) {
        this.userNo = userNo;
        this.userId = userId;
        this.password = password;
        this.email = email;
        this.role = role;
        this.category = category;
    }

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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
