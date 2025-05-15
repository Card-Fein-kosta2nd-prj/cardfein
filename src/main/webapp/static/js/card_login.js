document.addEventListener("DOMContentLoaded", function () {
  const loginForm = document.querySelector("form");
  if (loginForm) {
    loginForm.addEventListener("submit", function (event) {
      const username = document.querySelector("input[name='username']").value.trim();
      const password = document.querySelector("input[name='password']").value.trim();
      if (username === "" || password === "") {
        alert("아이디와 비밀번호를 입력해주세요.");
        event.preventDefault();
      }
    });
  }
});