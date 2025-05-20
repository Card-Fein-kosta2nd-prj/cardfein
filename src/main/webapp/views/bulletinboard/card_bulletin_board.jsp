<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cardfein.kro.kr.dto.LoginDto" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%
  Object loginUserObj = session.getAttribute("loginUser");
  String role = "guest";
  if (loginUserObj instanceof LoginDto) {
    role = ((LoginDto) loginUserObj).getRole();
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Card:Fein 관리자 게시판</title>
  <link rel="stylesheet" href="${path}/static/css/common.css" />
  <link rel="stylesheet" href="${path}/static/css/main.css" />
  <script>
    window.contextPath = "${path}";
    window.currentUserRole = "<%= role %>";
  </script>
  <style>
    body {
      margin: 0;
      font-family: "Noto Sans KR", sans-serif;
      background-color: #f3f4f6;
    }
    .header-wrapper { width: 100%; margin: 0; padding: 0; }
    .sidebar {
      width: 119px;
      background: white;
      padding: 20px;
      border-right: 1.5px solid #d1d5db;
      box-shadow: 2px 0 6px rgba(0, 0, 0, 0.08);
      position: fixed;
      top: 175px;
      height: 300px;
      left: 0;
      z-index: 998;
      display: flex;
      flex-direction: column;
      overflow-y: auto;
    }
    .sidebar a {
      display: block;
      padding: 10px;
      color: #374151;
      text-decoration: none;
      font-size: 14px;
    }
    .sidebar a:hover { background: #e5e7eb; }
    .menu-item { position: relative; }
    .submenu {
      display: none;
      flex-direction: column;
      padding-left: 10px;
    }
    .menu-item:hover .submenu { display: flex; }
    .main-content {
      margin-left: 160px;
      flex: 1;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }
    .container { padding: 40px; flex-grow: 1; }
    .btn-write {
      background: #3b82f6;
      color: white;
      border: none;
      padding: 10px 16px;
      border-radius: 6px;
      cursor: pointer;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      margin-top: 20px;
      border-radius: 12px;
      overflow: hidden;
    }
    th, td {
      padding: 12px;
      border-bottom: 1px solid #e5e7eb;
      text-align: center;
    }
    th {
      background-color: #f9fafb;
      color: #374151;
    }
    .modal-overlay {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 999;
    }
    .modal {
      display: none;
      position: fixed;
      top: 50%; left: 50%;
      transform: translate(-50%, -50%);
      background: white;
      padding: 24px;
      border-radius: 12px;
      width: 400px;
      z-index: 1000;
      box-shadow: 0 8px 20px rgba(0,0,0,0.2);
    }
    .modal input, .modal textarea {
      width: 100%; margin-bottom: 12px;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }
    .modal button {
      padding: 10px 20px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
    .modal .save-btn {
      background: #3b82f6; color: white;
    }
    .modal .cancel-btn {
      background: #e5e7eb; margin-left: 10px;
    }
    .full-view-btn {
      background: none;
      border: none;
      cursor: pointer;
      font-size: 16px;
    }
    #view-modal h3 { margin: 0; font-size: 18px; }
    #view-modal p {
      font-size: 15px;
      white-space: pre-wrap;
    }
    .footer-full { width: 100%; margin: 0; padding: 0; }
  </style>
</head>
<body>
  <div class="header-wrapper">
    <jsp:include page="/views/common/header.jsp" />
  </div>

  <div class="sidebar">
    <a href="${path}/views/adminpage.jsp">대시보드</a>
    <div class="menu-item">
      <a href="#">게시판</a>
      <div class="submenu">
        <a href="#">공지사항</a>
        <a href="#">콘텐츠</a>
      </div>
    </div>
  </div>

  <div class="main-content">
    <div class="container">
      <h2>공지사항</h2>
      <% if ("admin".equals(role)) { %>
        <button class="btn-write" id="btn-write">글쓰기</button>
      <% } %>

      <table>
        <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="board-body"></tbody>
      </table>
    </div>
  </div>

  <div class="footer-full">
    <jsp:include page="/views/common/footer.jsp" />
  </div>

  <div class="modal-overlay" id="modal-overlay"></div>
  <div class="modal" id="post-modal">
    <input type="text" id="post-title" placeholder="제목" />
    <input type="text" id="post-author" placeholder="작성자" />
    <textarea id="post-content" rows="5" placeholder="내용"></textarea>
    <div style="text-align: right;">
      <button class="save-btn" id="save-post">저장</button>
      <button class="cancel-btn" id="cancel-post">취소</button>
    </div>
  </div>

  <div class="modal-overlay" id="view-modal-overlay"></div>
  <div class="modal" id="view-modal">
    <h3>전체 내용</h3>
    <p id="view-full-content"></p>
    <div style="text-align: right; margin-top: 20px;">
      <button class="cancel-btn" onclick="closeViewModal()">닫기</button>
    </div>
  </div>

  <script src="${path}/static/js/bulletin_board.js"></script>
</body>
</html>