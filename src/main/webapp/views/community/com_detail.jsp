<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card:fein - 카드리뷰 상세보기</title>

<!-- 공통 스타일 -->
<link rel="stylesheet" href="${path}/static/css/common.css">
<!-- 페이지 전용 스타일 -->
<link rel="stylesheet" href="${path}/static/css/community/com_detail.css" defer>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js" defer></script>

</head>
<body>

	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />



	<div class="container">
		<div class="com-detail-header">
			<a href="${path}/views/community/community.jsp"><h1>커뮤니티</h1></a>
		</div>

		<div class="content-wrapper">
			<div id="sidebar-container">
				<div class="sidebar">
					<ul class="menu" id="sidebar_menu">
						<li class="menu-item" data-type="cardReview">
							<h2>카드리뷰</h2>
						</li>
					</ul>
				</div>
			</div>
			<div class="main-content">

				<h2 class="post-title">${review.reviewTitle}</h2>
				<div class="post-meta">
					<span class="post-views">
						<img src="${path}/static/images/icons/eye.png">
						${review.views}
					</span>
					<span class="post-date">${fn:substring(review.inputDate, 0, 10)}</span>
				</div>
				<div class="card-info">
					<div class="card-content">
						<div class="card-left">
							<div class="card-header">
								<span class="card-label">카드명</span> <span class="card-name">${review.cardName}</span>
							</div>
							<div class="rating-wrapper">
								<span class="rating-label">별점</span>
								<!-- 별점 변수 -->
								<c:set var="rating" value="${review.rating}" />
								<c:set var="emptyStars" value="${5 - rating}" />
								<span class="rating-stars">
								    <!-- 꽉 찬 별 -->
								    <c:forEach begin="1" end="${rating}" var="i">
								        <i class="fas fa-star"></i>
								    </c:forEach>
								    <!-- 빈 별 -->
								    <c:forEach begin="1" end="${emptyStars}" var="i">
								        <i class="far fa-star"></i>
								    </c:forEach>
								</span>
							</div>
						</div>
						<div class="post-image-container">
							<img src="${path}/static/images/cards/${review.cardImg}"
								alt="${review.cardName}" class="card-image">
						</div>
					</div>
				</div>
				<div class="post-content">${review.reviewContent}</div>
				
				<c:set var="loginUser" value="${sessionScope.loginUser}"/>
				<c:if test="${loginUser.userId == review.userId}">
					<div class="action-buttons">
						<button class="action-button edit-button">수정</button>
						<button class="action-button delete-button">삭제</button>
					</div>
				</c:if>
				<div class="comments-section">
				<hr>
					<h3 class="comments-title">댓글</h3>
					<c:if test="${not empty sessionScope.loginUser}">
						<div class="comment-insert-form">
							<form id="insertForm">
								<textarea id="insertContent" name="insertContent" class="insert-textarea" placeholder="댓글을 입력하세요"></textarea>
								<button type="submit" class="action-button insert-button">등록</button>
							</form>
						</div>
					
					</c:if>
					<c:forEach var="reply" items="${review.replyList}">
						<div class="comment-item" data-reply-num="${reply.replyNum}">
							<!-- 삭제 버튼: 로그인한 사용자 본인 댓글일 경우에만 표시 -->
							<c:if test="${reply.userId == sessionScope.loginUser.userId}">
							    <button class="reply-delete-button" data-reply-num="${reply.replyNum}">
							    	<i class="fas fa-times"></i>
							    </button>
							</c:if>
							
							<div class="comment-avatar">
								<i class="fas fa-user"></i>
							</div>
							
							<div class="comment-content">
								<!-- ✅ avatar 바깥으로 위치 -->
								<div class="comment-author">${reply.userId}</div>
								<div class="comment-text">${reply.replyContent}</div>
								<div class="comment-date">${reply.inputDate.split(' ')[0]}</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<a href="javascript:window.history.back()" class="back-button"> 
				<i class="fas fa-arrow-left"></i> 목록으로
				</a>
			</div>
		</div>
	</div>

	<!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />
</body>

<script>
document.addEventListener("DOMContentLoaded", () => {
  const editBtn = document.querySelector(".edit-button");
  const deleteBtn = document.querySelector(".delete-button");
  const path = "${path}";
  const reviewNo = "${review.reviewNo}";

  // [1] 수정 완료 버튼
  const saveBtn = document.createElement("button");
  saveBtn.textContent = "수정";
  saveBtn.className = "action-button save-button";

  // [2] 수정 취소 버튼
  const cancelBtn = document.createElement("button");
  cancelBtn.textContent = "취소";
  cancelBtn.className = "action-button cancel-button";

  // [3] 수정 전 원본 텍스트 저장 변수
  let originalTitle = "";
  let originalContent = "";

  // [4] 수정 버튼 클릭 시
  editBtn?.addEventListener("click", () => {
    const titleElem = document.querySelector(".post-title");
    const contentElem = document.querySelector(".post-content");

    originalTitle = titleElem.textContent.trim();
    originalContent = contentElem.textContent.trim();

    // 제목과 내용을 입력 필드로 변경
    titleElem.innerHTML = `
      <input type="text" id="edit-title" class="edit-input" value="${originalTitle}">
    `;
    contentElem.innerHTML = `
      <textarea id="edit-content" class="edit-textarea">${originalContent}</textarea>
    `;

    // 기존 버튼 숨기고, 저장/취소 버튼 추가
    editBtn.style.display = "none";
    deleteBtn.style.display = "none";

    if (!document.querySelector(".save-button")) {
      editBtn.parentNode.appendChild(saveBtn);
      editBtn.parentNode.appendChild(cancelBtn);
    }
  });

  // [5] 저장 버튼 클릭 시
  saveBtn.addEventListener("click", async () => {
    const newTitle = document.getElementById("edit-title").value.trim();
    const newContent = document.getElementById("edit-content").value.trim();

    if (!newTitle || !newContent) {
      alert("제목과 내용을 모두 입력해주세요.");
      return;
    }

    try {
      const response = await fetch(`${path}/ajax`, {
        method: "POST",
        body: new URLSearchParams({
          key: "reviewDetail",
          methodName: "updateReview",
          reviewNo,
          reviewTitle: newTitle,
          reviewContent: newContent
        })
      });

      if (!response.ok) throw new Error("서버 응답 실패");

      const result = await response.json();

      if (result.status === "success") {
        alert("수정이 완료되었습니다.");
        location.href = `${path}/front?key=detail&methodName=selectDetailByReviewNo&reviewNo=\${reviewNo}&flag=false`;
      } else {
        alert("수정 실패: " + (result.message || "알 수 없는 오류"));
      }
    } catch (error) {
      console.error("수정 중 오류 발생:", error);
      alert("수정 중 오류가 발생했습니다.");
    }
  });

  // [6] 취소 버튼 클릭 시
  cancelBtn.addEventListener("click", () => {
    document.querySelector(".post-title").textContent = originalTitle;
    document.querySelector(".post-content").textContent = originalContent;

    saveBtn.remove();
    cancelBtn.remove();
    editBtn.style.display = "inline-block";
    deleteBtn.style.display = "inline-block";
  });

  // [7] 리뷰 삭제 버튼 클릭 시
  deleteBtn?.addEventListener("click", async () => {
    if (!confirm("정말 이 리뷰를 삭제하시겠습니까?")) return;

    try {
      const response = await fetch(`${path}/ajax`, {
        method: "POST",
        body: new URLSearchParams({
          key: "reviewDetail",
          methodName: "deleteReview",
          reviewNo
        })
      });

      if (!response.ok) throw new Error("서버 응답 실패");

      const result = await response.json();

      if (result.status === "success") {
        alert("리뷰가 삭제되었습니다.");
        location.href = `${path}/views/community/community.jsp`;
      } else {
        alert("삭제 실패: " + (result.message || "알 수 없는 오류"));
      }
    } catch (error) {
      console.error("삭제 중 오류 발생:", error);
      alert("삭제 중 오류가 발생했습니다.");
    }
  });

	//[8] 댓글 등록 처리
	const replyForm = document.getElementById("insertForm");
	const replyContent = document.getElementById("insertContent");
	
	replyForm?.addEventListener("submit", async (e) => {
	  e.preventDefault();
	  const content = replyContent.value.trim();
	
	  if (!content) {
	    alert("댓글을 입력해주세요.");
	    return;
	  }
	
	  try {
	    const response = await fetch(`${path}/ajax`, {
	      method: "POST",
	      body: new URLSearchParams({
	        key: "reviewDetail",
	        methodName: "insertReply",
	        reviewNo,
	        replyContent: content
	      })
	    });
	
	    if (!response.ok) throw new Error("서버 응답 실패");
	
	    const result = await response.json();
	    if (result.status === "success") {
	      alert("댓글이 등록되었습니다.");
	      location.reload();
	    } else {
	      alert("댓글 등록 실패: " + (result.message || "알 수 없는 오류"));
	    }
	  } catch (err) {
	    console.error("댓글 등록 오류:", err);
	    alert("댓글 등록 중 오류가 발생했습니다.");
	  }
	});
	
	//댓글 삭제 버튼 클릭 시
	document.querySelectorAll(".reply-delete-button").forEach(btn => {
		  btn.addEventListener("click", async (e) => {
		    const replyNum = btn.dataset.replyNum;
		    if (!confirm("댓글을 삭제하시겠습니까?")) return;

		    const response = await fetch(`${path}/ajax`, {
		      method: "POST",
		      body: new URLSearchParams({
		        key: "reviewDetail",
		        methodName: "deleteReply",
		        replyNum
		      })
		    });

		    const result = await response.json();
		    if (result.status === "success") {
		      alert("댓글이 삭제되었습니다.");
		      location.reload();
		    } else {
		      alert("삭제 실패: " + (result.message || "오류"));
		    }
		  });
		});

});
</script>




</html>