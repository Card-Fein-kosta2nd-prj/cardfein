// signup.js - signup.jsp에서 사용하는 클라이언트 유효성 검사 및 중복 확인 반영 스크립트

document.addEventListener("DOMContentLoaded", function () {
  const signupForm = document.querySelector("form");
  const usernameInput = document.querySelector("input[name='username']");
  const checkBtn = document.getElementById("check-duplicate-btn");
  const checkResult = document.getElementById("check-result");

  let isUsernameChecked = false; // 중복 확인 여부 저장
  let isUsernameValid = false;   // 중복 확인 결과 저장

  if (checkBtn) {
    checkBtn.addEventListener("click", function () {
      const username = usernameInput.value.trim();

      if (username === "") {
        alert("아이디를 입력해주세요.");
        return;
      }

      fetch(`/check-duplicate?username=${encodeURIComponent(username)}`)
        .then(res => res.json())
        .then(data => {
          isUsernameChecked = true;

          if (data.exists) {
            isUsernameValid = false;
            checkResult.textContent = "이미 사용 중인 아이디입니다.";
            checkResult.style.color = "red";
          } else {
            isUsernameValid = true;
            checkResult.textContent = "사용 가능한 아이디입니다.";
            checkResult.style.color = "green";
          }
        })
        .catch(error => {
          isUsernameChecked = false;
          isUsernameValid = false;
          console.error("중복 확인 에러:", error);
          checkResult.textContent = "중복 확인 중 오류가 발생했습니다.";
          checkResult.style.color = "red";
        });
    });
  }

  if (signupForm) {
    signupForm.addEventListener("submit", function (event) {
      const userId = usernameInput.value.trim();
      const password = document.querySelector("input[name='password']").value.trim();
      const email = document.querySelector("input[name='email']").value.trim();

      // 아이디 유효성 검사
      if (userId === "") {
        alert("아이디를 입력해주세요.");
        event.preventDefault();
        return;
      }

      // 중복 확인 미수행 또는 사용 불가일 경우
      if (!isUsernameChecked) {
        alert("아이디 중복 확인을 해주세요.");
        event.preventDefault();
        return;
      }

      if (!isUsernameValid) {
        alert("사용할 수 없는 아이디입니다.");
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

      // 통과 → 서버로 전송
    });
  }
});
