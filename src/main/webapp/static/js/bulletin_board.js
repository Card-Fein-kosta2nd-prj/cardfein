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

  function fetchPosts() {
    fetch("/board")
      .then((res) => res.json())
      .then((data) => renderPosts(data))
      .catch((err) => console.error("불러오기 실패:", err));
  }

  function renderPosts(posts) {
    boardBody.innerHTML = "";
    posts.forEach((post) => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${post.boardId}</td>
        <td onclick="increaseViews(${post.boardId})">${post.title}</td>
        <td>${post.author}</td>
        <td>${post.content}</td>
        <td>${post.regDate}</td>
        <td>${post.views}</td>
        <td>
          <button class="edit-btn" data-id="${post.boardId}">수정</button>
          <button class="delete-btn" data-id="${post.boardId}">삭제</button>
        </td>
      `;
      boardBody.appendChild(row);
    });

    document.querySelectorAll(".edit-btn").forEach((btn) => {
      btn.addEventListener("click", () => loadPost(btn.dataset.id));
    });
    document.querySelectorAll(".delete-btn").forEach((btn) => {
      btn.addEventListener("click", () => deletePost(btn.dataset.id));
    });
  }

  btnWrite.addEventListener("click", () => {
    editId = null;
    postTitle.value = "";
    postAuthor.value = "";
    postContent.value = "";
    postModal.style.display = "block";
    modalOverlay.style.display = "block";
  });

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

    fetch("/board", {
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
    fetch(`/board?boardId=${boardId}`)
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

    fetch(`/board?boardId=${boardId}`, { method: "DELETE" })
      .then((res) => {
        if (res.ok) {
          fetchPosts();
        } else {
          return res.text().then((msg) => alert("삭제 실패: " + msg));
        }
      })
      .catch((err) => alert("삭제 오류: " + err));
  }

  window.increaseViews = function(boardId) {
    fetch(`/board?boardId=${boardId}&action=view`)
      .then(() => fetchPosts())
      .catch((err) => console.error("조회수 증가 실패:", err));
  };

  fetchPosts();
});
