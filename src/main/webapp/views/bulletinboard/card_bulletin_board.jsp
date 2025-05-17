<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Card:Fein 관리자 게시판</title>
  <style>
    body {
      margin: 0;
      font-family: "Noto Sans KR", sans-serif;
      background-color: #f3f4f6;
      height: 100vh;
      display: flex;
    }

    .sidebar {
      width: 200px;
      background: white;
      padding: 20px;
      box-shadow: 2px 0 6px rgba(0, 0, 0, 0.1);
    }

    .sidebar a {
      display: block;
      padding: 10px;
      color: #374151;
      text-decoration: none;
    }

    .sidebar a:hover {
      background: #e5e7eb;
    }

    .menu-item {
      position: relative;
    }

    .submenu {
      display: none;
      flex-direction: column;
      padding-left: 10px;
    }

    .menu-item:hover .submenu {
      display: flex;
    }

    .main-content {
      flex: 1;
      display: flex;
      flex-direction: column;
    }

    header {
      background: #3b82f6;
      color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px 40px;
    }

    .container {
      padding: 40px;
    }

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
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 999;
    }

    .modal {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: white;
      padding: 24px;
      border-radius: 12px;
      width: 400px;
      z-index: 1000;
      box-shadow: 0 8px 20px rgba(0,0,0,0.2);
    }

    .modal input, .modal textarea {
      width: 100%;
      margin-bottom: 12px;
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
      background: #3b82f6;
      color: white;
    }

    .modal .cancel-btn {
      background: #e5e7eb;
      margin-left: 10px;
    }

    .full-view-btn {
      background: none;
      border: none;
      cursor: pointer;
      font-size: 16px;
    }

    #view-modal h3 {
      margin: 0;
      font-size: 18px;
    }

    #view-modal p {
      font-size: 15px;
      white-space: pre-wrap;
    }
  </style>
</head>
<body>

  <script>
    window.contextPath = "<%= request.getContextPath() %>";
  </script>

  <div class="sidebar">
    <a href="#">대시보드</a>
    <a href="#">카드정보</a>
    <div class="menu-item">
      <a href="#" class="submenu-toggle">게시판</a>
      <div class="submenu">
        <a href="#">공지사항</a>
        <a href="#">컨텐츠</a>
      </div>
    </div>
  </div>

  <div class="main-content">
    <header>
      <div><strong>📄 Card:Fein</strong> 관리자 게시판</div>
      <nav>
        <a href="#" style="color:white;">홈</a>
        <a href="#" style="color:white;">로그인</a>
      </nav>
    </header>

    <div class="container">
      <h2>공지사항</h2>
      <button class="btn-write" id="btn-write">글쓰기</button>
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

  <!-- 글쓰기 모달 -->
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

  <!-- 전체 내용 보기 모달 -->
  <div class="modal-overlay" id="view-modal-overlay"></div>
  <div class="modal" id="view-modal">
    <h3>전체 내용</h3>
    <p id="view-full-content"></p>
    <div style="text-align: right; margin-top: 20px;">
      <button class="cancel-btn" onclick="closeViewModal()">닫기</button>
    </div>
  </div>

  <script src="<%= request.getContextPath() %>/static/js/bulletin_board.js"></script>
</body>
</html>
