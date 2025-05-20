// bulletin_board.js

document.addEventListener("DOMContentLoaded", () => {
  const boardBody = document.getElementById("board-body");
  const btnWrite = document.getElementById("btn-write");
  const modalOverlay = document.getElementById("modal-overlay");
  const postModal = document.getElementById("post-modal");
  const postTitle = document.getElementById("post-title");
  const postAuthor = document.getElementById("post-author");
  const postContent = document.getElementById("post-content");
  const savePostButton = document.getElementById("save-post");
  const cancelPostButton = document.getElementById("cancel-post");

  let editId = null;
  const contextPath = window.contextPath || "";
  const userRole = window.currentUserRole || "guest";

  function fetchPosts() {
    fetch(`${contextPath}/board`)
      .then((res) => res.json())
      .then((data) => renderPosts(data))
      .catch((err) => console.error("불러오기 실패:", err));
  }

  function renderPosts(posts) {
    boardBody.innerHTML = "";
    posts.forEach((post) => {
      const truncatedContent = post.content.length > 20
        ? post.content.substring(0, 20) + "..."
        : post.content;

      const fullContentBtn = post.content.length > 20
        ? `<button class="full-view-btn" onclick="showFullContent(${post.boardId})">🔍</button>`
        : "";

      const isAdmin = userRole === "admin";
      const manageBtns = isAdmin ? `
        <button class="edit-btn" data-id="${post.boardId}">수정</button>
        <button class="delete-btn" data-id="${post.boardId}">삭제</button>
      ` : "";

      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${post.boardId}</td>
        <td onclick="increaseViews(${post.boardId})">${post.title}</td>
        <td>${post.author}</td>
        <td>${truncatedContent} ${fullContentBtn}</td>
        <td>${post.regDate}</td>
        <td>${post.views}</td>
        <td>${manageBtns}</td>
      `;
      boardBody.appendChild(row);
    });

    if (userRole === "admin") {
      document.querySelectorAll(".edit-btn").forEach((btn) => {
        btn.addEventListener("click", () => loadPost(btn.dataset.id));
      });
      document.querySelectorAll(".delete-btn").forEach((btn) => {
        btn.addEventListener("click", () => deletePost(btn.dataset.id));
      });
    }
  }

  if (btnWrite) {
    btnWrite.addEventListener("click", () => {
      editId = null;
      postTitle.value = "";
      postAuthor.value = "";
      postContent.value = "";
      postModal.style.display = "block";
      modalOverlay.style.display = "block";
    });
  }

  cancelPostButton.addEventListener("click", closeModal);

  function closeModal() {
    postModal.style.display = "none";
    modalOverlay.style.display = "none";
  }

  savePostButton.addEventListener("click", () => {
    const title = postTitle.value.trim();
    const author = postAuthor.value.trim();
    const content = postContent.value.trim();

    if (!title || !author || !content) {
      alert("모든 필드를 입력해주세요.");
      return;
    }

    const data = new URLSearchParams();
    data.append("boardId", editId || "0");
    data.append("title", title);
    data.append("author", author);
    data.append("content", content);

    fetch(`${contextPath}/board`, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: data.toString(),
    })
      .then((res) => {
        if (res.ok) {
          fetchPosts();
          closeModal();
        } else {
          return res.text().then((msg) => alert("저장 실패: " + msg));
        }
      })
      .catch((err) => alert("저장 오류: " + err));
  });

  function loadPost(boardId) {
    fetch(`${contextPath}/board?boardId=${boardId}`)
      .then((res) => res.json())
      .then((post) => {
        editId = post.boardId;
        postTitle.value = post.title;
        postAuthor.value = post.author;
        postContent.value = post.content;
        postModal.style.display = "block";
        modalOverlay.style.display = "block";
      })
      .catch((err) => alert("불러오기 실패: " + err));
  }

  function deletePost(boardId) {
    if (!confirm("정말 삭제하시겠습니까?")) return;

    fetch(`${contextPath}/board?boardId=${boardId}`, { method: "DELETE" })
      .then((res) => {
        if (res.ok) {
          fetchPosts();
        } else {
          return res.text().then((msg) => alert("삭제 실패: " + msg));
        }
      })
      .catch((err) => alert("삭제 오류: " + err));
  }

  window.increaseViews = function (boardId) {
    fetch(`${contextPath}/board?boardId=${boardId}&action=view`)
      .then(() => fetchPosts())
      .catch((err) => console.error("조회수 증가 실패:", err));
  };

  window.showFullContent = function (boardId) {
    fetch(`${contextPath}/board?boardId=${boardId}`)
      .then(res => res.json())
      .then(post => {
        const modal = document.getElementById("view-modal");
        const overlay = document.getElementById("view-modal-overlay");
        const content = document.getElementById("view-full-content");
        content.textContent = post.content;
        modal.style.display = "block";
        overlay.style.display = "block";
      })
      .catch(err => alert("내용 불러오기 실패: " + err));
  };

  window.closeViewModal = function () {
    document.getElementById("view-modal").style.display = "none";
    document.getElementById("view-modal-overlay").style.display = "none";
  };

  fetchPosts();
});