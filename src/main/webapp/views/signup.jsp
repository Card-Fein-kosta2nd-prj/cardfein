<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Card:Fein 회원가입</title>
  <style>
    body {
      font-family: "Arial", sans-serif;
      background-color: #3b82f6;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .logo {
      font-size: 40px;
      font-weight: bold;
      color: white;
      margin-bottom: 30px;
    }

    .signup-container {
      width: 420px;
      background-color: white;
      padding: 50px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .signup-container h1 {
      font-size: 2em;
      font-weight: bold;
      color: black;
      margin-bottom: 32px;
    }

    .input-button-section {
      display: flex;
      gap: 10px;
      margin-bottom: 18px;
    }

    .input-button-section input {
      flex: 1;
      padding: 12px;
      border: 2px solid #2563eb;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
    }

    .input-button-section button {
      height: 44px;
      padding: 0 10px;
      font-size: 12px;
      background-color: #10b981;
      color: white;
      border: none;
      border-radius: 6px;
      white-space: nowrap;
      cursor: pointer;
      box-sizing: border-box;
    }

    input[type="email"],
    input[type="password"]#password-confirm {
      width: 100%;
      padding: 12px;
      margin-bottom: 18px;
      border: 2px solid #2563eb;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
    }

    button[type="submit"] {
      width: 100%;
      padding: 14px;
      background-color: #2563eb;
      border: none;
      border-radius: 6px;
      color: white;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      margin-top: 10px;
    }

    .error-message {
      color: red;
      font-size: 13px;
      margin-bottom: 12px;
    }

    .check-result,
    .pw-check-result {
      font-size: 13px;
      text-align: left;
      margin-top: -8px;
      margin-bottom: 10px;
    }

    .check-result {
      color: red;
    }

    .check-result.valid {
      color: green;
    }

    .pw-check-result.invalid {
      color: red;
    }

    .pw-check-result.valid {
      color: green;
    }
  </style>

  <script>
    const contextPath = "<%= request.getContextPath() %>";

    let isUsernameChecked = false;
    let isUsernameValid = false;
    let isEmailChecked = false;
    let isEmailValid = false;

    window.addEventListener("DOMContentLoaded", function () {
      const signupForm = document.querySelector("form");

      // ID 중복 확인
      const checkBtn = document.getElementById("check-duplicate-btn");
      const usernameInput = document.getElementById("username");
      const idResult = document.getElementById("check-result");

      checkBtn.addEventListener("click", function () {
        const username = usernameInput.value.trim();
        if (username === "") {
          alert("아이디를 입력해주세요.");
          return;
        }

        fetch(contextPath + "/check-duplicate?username=" + encodeURIComponent(username))
          .then(res => res.json())
          .then(data => {
            isUsernameChecked = true;
            if (data.exists) {
              idResult.textContent = "이미 사용 중인 아이디입니다.";
              idResult.classList.remove("valid");
              isUsernameValid = false;
            } else {
              idResult.textContent = "사용 가능한 아이디입니다.";
              idResult.classList.add("valid");
              isUsernameValid = true;
            }
          });
      });

      usernameInput.addEventListener("input", function () {
        if (usernameInput.value.trim() === "") {
          idResult.textContent = "";
          isUsernameChecked = false;
          isUsernameValid = false;
        }
      });

      // 비밀번호 확인
      const pwInput = document.getElementById("password");
      const pwCheckBtn = document.getElementById("check-password-btn");
      const pwErrorEl = document.getElementById("pw-check-error");
      const pwValidEl = document.getElementById("pw-check-valid");

      pwCheckBtn.addEventListener("click", function () {
        const pw = pwInput.value;
        pwErrorEl.textContent = "";
        pwValidEl.textContent = "";

        const minLength = /.{8,}/;
        const hasLetter = /[a-zA-Z]/;
        const hasNumber = /[0-9]/;
        const hasSpecial = /[!@#$%^&]/;

        if (!minLength.test(pw)) {
          pwInput.value = "";
          pwErrorEl.textContent = "비밀번호는 최소 8자 이상이어야 합니다.";
          return;
        }
        if (!hasLetter.test(pw)) {
          pwInput.value = "";
          pwErrorEl.textContent = "영문자를 포함해야 합니다.";
          return;
        }
        if (!hasNumber.test(pw)) {
          pwInput.value = "";
          pwErrorEl.textContent = "숫자를 포함해야 합니다.";
          return;
        }
        if (!hasSpecial.test(pw)) {
          pwInput.value = "";
          pwErrorEl.textContent = "다음 특수문자 중 하나 이상 포함: !@#$%^&";
          return;
        }

        pwValidEl.textContent = "안전한 비밀번호입니다.";
      });

      pwInput.addEventListener("input", function () {
        pwErrorEl.textContent = "";
        pwValidEl.textContent = "";
      });

      // 비밀번호 일치 확인
      const pwConfirmInput = document.getElementById("password-confirm");
      const pwConfirmMsg = document.getElementById("pw-confirm-message");

      pwConfirmInput.addEventListener("input", function () {
        const pw = pwInput.value.trim();
        const confirmPw = pwConfirmInput.value.trim();

        if (confirmPw === "") {
          pwConfirmMsg.textContent = "";
        } else if (pw === confirmPw) {
          pwConfirmMsg.textContent = "비밀번호가 일치합니다.";
          pwConfirmMsg.style.color = "green";
        } else {
          pwConfirmMsg.textContent = "비밀번호가 일치하지 않습니다.";
          pwConfirmMsg.style.color = "red";
        }
      });

      // 이메일 중복 확인
      const emailInput = document.getElementById("email");
      const emailResult = document.getElementById("email-check-result");

      emailInput.addEventListener("blur", function () {
        const email = emailInput.value.trim();
        if (email === "") return;

        fetch(contextPath + "/check-email?email=" + encodeURIComponent(email))
          .then(res => res.json())
          .then(data => {
            isEmailChecked = true;
            if (data.exists) {
              emailResult.textContent = "이미 사용 중인 이메일입니다.";
              emailResult.style.color = "red";
              isEmailValid = false;
            } else {
              emailResult.textContent = "사용 가능한 이메일입니다.";
              emailResult.style.color = "green";
              isEmailValid = true;
            }
          });
      });

      emailInput.addEventListener("input", function () {
        emailResult.textContent = "";
        isEmailChecked = false;
        isEmailValid = false;
      });

      // 폼 제출 전 유효성 확인
      signupForm.addEventListener("submit", function (event) {
        if (!isUsernameChecked || !isUsernameValid) {
          alert("아이디 중복 확인을 해주세요.");
          event.preventDefault();
          return;
        }

        if (!isEmailChecked || !isEmailValid) {
          alert("이메일 중복 확인을 해주세요.");
          event.preventDefault();
          return;
        }
      });
    });
  </script>
</head>
<body>
  <div class="logo">Card:Fein</div>
  <div class="signup-container">
    <h1>Sign Up</h1>

    <%-- 서버 측 오류 메시지 --%>
    <%
      String error = request.getParameter("error");
      String message = "";
      if ("id".equals(error)) message = "이미 존재하는 ID입니다.";
      else if ("pw".equals(error)) message = "이미 사용 중인 비밀번호입니다.";
      else if ("email".equals(error)) message = "이미 존재하는 이메일입니다.";
      else if ("unknown".equals(error)) message = "회원가입에 실패했습니다.";
    %>
    <% if (!message.isEmpty()) { %>
      <p class="error-message"><%= message %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/signup" method="post">
      <div class="input-button-section">
        <input type="text" name="username" id="username" placeholder="ID" required />
        <button type="button" id="check-duplicate-btn">중복 확인</button>
      </div>
      <div id="check-result" class="check-result"></div>

      <div class="input-button-section">
        <input type="password" name="password" id="password" placeholder="Password" required />
        <button type="button" id="check-password-btn">확인</button>
      </div>
      <div id="pw-check-error" class="pw-check-result invalid"></div>
      <div id="pw-check-valid" class="pw-check-result valid"></div>

      <input type="password" id="password-confirm" placeholder="비밀번호 확인" required />
      <div id="pw-confirm-message" class="pw-check-result invalid"></div>

      <input type="email" name="email" id="email" placeholder="Email" required />
      <div id="email-check-result" class="check-result"></div>

      <button type="submit">회원가입</button>
    </form>
  </div>
</body>
</html>