<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>게시판 관리</title>
    <style>
      body {
        font-family: "Noto Sans KR", sans-serif;
        background-color: #f3f4f6;
        margin: 0;
        padding: 0;
      }
      header {
        background-color: #3b82f6;
        color: white;
        padding: 20px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
      }
      header .logo {
        font-size: 20px;
        font-weight: bold;
      }
      header nav a {
        color: white;
        text-decoration: none;
        margin-left: 20px;
        font-size: 14px;
      }
      .container {
        max-width: 960px;
        margin: 32px auto;
        padding: 0 20px;
      }
      h1 {
        font-size: 24px;
        color: #1f2937;
        text-align: center;
        margin-bottom: 32px;
      }
      .table-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 16px;
      }
      .btn-write {
        padding: 10px 20px;
        background-color: #3b82f6;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        background-color: #ffffff;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      }
      th,
      td {
        padding: 16px;
        text-align: left;
        border-bottom: 1px solid #e5e7eb;
      }
      th {
        background-color: #f9fafb;
        color: #374151;
        font-size: 14px;
      }
      td {
        font-size: 14px;
        color: #4b5563;
      }
      td.content-cell {
        max-width: 200px; /* 내용 열의 최대 너비 */
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        cursor: pointer;
      }
      .view-more {
        font-size: 12px; /* 돋보기 크기 */
        padding: 2px 6px;
        background: none;
        border: none;
        color: #3b82f6;
        cursor: pointer;
      }
      .view-more:hover {
        color: #2563eb;
      }
      .modal {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        z-index: 1000;
        width: 400px;
      }
      .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
      }
      .modal input,
      .modal textarea {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
      }
      .modal button {
        padding: 8px 12px;
        background: #3b82f6;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-right: 5px;
      }
    </style>
  </head>
  <body>
    <header>
      <div class="logo">📝 게시판 관리</div>
      <nav>
        <a href="#">홈</a>
        <a href="#">카드검색</a>
        <a href="#">로그인</a>
      </nav>
    </header>

    <div class="container">
      <h1>공지사항</h1>
      <div class="table-header">
        <div></div>
        <button class="btn-write" id="btn-write">글쓰기</button>
      </div>
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
        <tbody id="board-body">
          <c:forEach var="post" items="${posts}">
            <tr>
              <td>${post.boardId}</td>
              <td>${post.title}</td>
              <td>${post.author}</td>
              <td class="content-cell" data-content="${post.content}">
                <c:choose>
                  <c:when test="${fn:length(post.content) > 20}">
                    ${fn:substring(post.content, 0, 20)}...
                    <button class="view-more" onclick="viewFullContent('${post.content}')">🔍</button>
                  </c:when>
                  <c:otherwise>
                    ${post.content}
                  </c:otherwise>
                </c:choose>
              </td>
              <td>${post.regDate}</td>
              <td>${post.views}</td>
              <td>
                <button onclick="editPost(${post.boardId})">수정</button>
                <button onclick="deletePost(${post.boardId})">삭제</button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <!-- Modal for writing/editing posts -->
    <div class="modal-overlay" id="modal-overlay"></div>
    <div class="modal" id="post-modal">
      <h3 id="modal-title">게시글 작성</h3>
      <input type="text" id="post-title" placeholder="제목" />
      <input type="text" id="post-author" placeholder="작성자" />
      <textarea id="post-content" placeholder="내용"></textarea>
      <button id="save-post">저장</button>
      <button id="cancel-post">취소</button>
    </div>

    <!-- Modal for viewing content -->
    <div class="modal" id="view-modal">
      <h3>게시글 내용</h3>
      <p id="view-content"></p>
      <button id="close-view-modal">닫기</button>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/bulletin_board.js"></script>
  </body>
</html>