/*document.addEventListener("DOMContentLoaded", () => {
  const boardBody = document.getElementById("board-body");
  const btnWrite = document.getElementById("btn-write");
  const modalOverlay = document.getElementById("modal-overlay");
  const postModal = document.getElementById("post-modal");
  const postTitle = document.getElementById("post-title");
  const postAuthor = document.getElementById("post-author");
  const postContent = document.getElementById("post-content");
  const savePostButton = document.getElementById("save-post");
  const cancelPostButton = document.getElementById("cancel-post");

  let posts = [];
  let editIndex = null;

  // 게시글 렌더링
  function renderPosts() {
    boardBody.innerHTML = "";
    posts.forEach((post, index) => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${index + 1}</td>
        <td>${post.title}</td>
        <td>${post.author}</td>
        <td>${post.content}</td>
        <td>${post.regDate}</td>
        <td>${post.views}</td>
        <td>
          <button onclick="editPost(${index})">수정</button>
          <button onclick="deletePost(${index})">삭제</button>
        </td>
      `;
      boardBody.appendChild(row);
    });
  }

  // 글쓰기 모달 열기
  btnWrite.addEventListener("click", () => {
    postModal.style.display = "block";
    modalOverlay.style.display = "block";
    postTitle.value = "";
    postAuthor.value = "";
    postContent.value = "";
    editIndex = null;
  });

  // 글쓰기 모달 닫기
  cancelPostButton.addEventListener("click", () => {
    postModal.style.display = "none";
    modalOverlay.style.display = "none";
  });

  // 게시글 저장
  savePostButton.addEventListener("click", () => {
    const title = postTitle.value.trim();
    const author = postAuthor.value.trim();
    const content = postContent.value.trim();

    if (!title || !author || !content) {
      alert("모든 필드를 입력해주세요.");
      return;
    }

    const newPost = {
      title,
      author,
      content,
      regDate: new Date().toLocaleString(),
      views: 0,
    };

    if (editIndex === null) {
      // 새 글 작성
      posts.push(newPost);
    } else {
      // 기존 글 수정
      posts[editIndex] = { ...posts[editIndex], ...newPost };
    }

    renderPosts();
    postModal.style.display = "none";
    modalOverlay.style.display = "none";
  });

  // 게시글 수정
  window.editPost = (index) => {
    const post = posts[index];
    postTitle.value = post.title;
    postAuthor.value = post.author;
    postContent.value = post.content;
    editIndex = index;

    postModal.style.display = "block";
    modalOverlay.style.display = "block";
  };

  // 게시글 삭제
  window.deletePost = (index) => {
    if (confirm("정말 삭제하시겠습니까?")) {
      posts.splice(index, 1);
      renderPosts();
    }
  };

  renderPosts();
});*/