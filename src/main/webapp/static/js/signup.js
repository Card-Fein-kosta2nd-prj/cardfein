// ✅ signup.js - signup.jsp에서 사용하는 클라이언트 유효성 검사 연계 스크립트

document.addEventListener("DOMContentLoaded", function () {
  const signupForm = document.querySelector("form");

  if (signupForm) {
    signupForm.addEventListener("submit", function (event) {
      const userId = document.querySelector("input[name='username']").value.trim();
      const password = document.querySelector("input[name='password']").value.trim();
      const email = document.querySelector("input[name='email']").value.trim();

      // 아이디 유효성 검사
      if (userId === "") {
        alert("아이디를 입력해주세요.");
        event.preventDefault();
        return;
      }

      // 비밀번호 유효성 검사
      if (password.length < 8) {
        alert("비밀번호는 8자 이상이어야 합니다.");
        event.preventDefault();
        return;
      }

      // 이메일 형식 유효성 검사
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email)) {
        alert("이메일 형식을 맞춰주세요.");
        event.preventDefault();
        return;
      }

      // 서버에서 중복 여부는 SignupController.java가 최종 검증
    });
  }
});
