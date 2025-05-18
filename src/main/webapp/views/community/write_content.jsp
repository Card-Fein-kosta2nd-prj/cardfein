<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card:fein - 리뷰작성</title>
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/common.css">
	<!-- 페이지 전용 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/community/write_content.css" defer>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
	
	<!-- 공통 스크립트 -->
	<script src="${path}/static/js/common.js" defer></script>
</head>
<body>
	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />


	<div class="write-container">
	<div class="write-header">
		<a href="${path}/views/community/community.jsp"><h1>커뮤니티</h1></a>
	</div>

	<div class="content-wrapper">
		<div class="main-content">
			<h2 class="section-title">카드리뷰 글쓰기</h2>
		
			<!-- 제목 입력 -->
			<input type="text" id="write-title" class="write-title" placeholder="제목을 입력하세요">

			<!-- 카드 선택 & 별점 선택 -->
			<div class="card-rating-section">
				<!-- 카드 선택 -->
				<div class="form-group">
					<label for="card-select">보유 카드</label>
					<select id="card-select" class="card-select">
						<option value="">카드를 선택하세요</option>
						<!-- 옵션은 동적으로 바뀔 수 있음 -->
						<c:forEach var="card" items="${userCardList}">
							<option value="${card.cardNo}">${card.cardName}</option>
						</c:forEach>
					</select>
				</div>

				<!-- 별점 선택 -->
				<div class="form-group rating-group">
					<label>별점</label>
					<div class="star-rating">
						<i class="far fa-star" data-value="1"></i>
						<i class="far fa-star" data-value="2"></i>
						<i class="far fa-star" data-value="3"></i>
						<i class="far fa-star" data-value="4"></i>
						<i class="far fa-star" data-value="5"></i>
					</div>
				</div>
			</div>

			<!-- 리뷰 내용 입력 -->
			<textarea id="write-content" class="write-content" placeholder="리뷰 내용을 입력해주세요."></textarea>

			<!-- 버튼 -->
			<div class="action-buttons">
				<button class="action-button save-button">등록</button>
				<button class="action-button cancel-button">취소</button>
			</div>
		</div>
	</div>
</div>


	<!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />
	
	
	
<script>
document.addEventListener("DOMContentLoaded", () => {
  const saveBtn = document.querySelector(".save-button");
  const cancelBtn = document.querySelector(".cancel-button");
  const stars = document.querySelectorAll(".star-rating i");
  const path = "${path}";
  const userNo = "${sessionScope.loginUser.userNo}";

  let selectedRating = 0;

  //별점 클릭 처리
  stars.forEach(star => {
    star.addEventListener("click", () => {
      selectedRating = parseInt(star.dataset.value);
      stars.forEach((s, i) => {
        s.className = i < selectedRating ? "fas fa-star" : "far fa-star";
      });
    });
  });

  //등록 버튼 클릭 시
  saveBtn.addEventListener("click", async () => {
    const title = document.getElementById("write-title").value.trim();
    const content = document.getElementById("write-content").value.trim();
    const cardNo = document.getElementById("card-select").value;

    if (!title || !content || !selectedRating || !cardNo) {
      alert("모든 항목을 입력해주세요.");
      return;
    }

    try {
      const response = await fetch(`${path}/ajax`, {
        method: "POST",
        body: new URLSearchParams({
          key: "reviewDetail",
          methodName: "insertReview",
          reviewTitle: title,
          reviewContent: content,
          rating: selectedRating,
          cardNo,
          userNo
        })
      });

      if (!response.ok) throw new Error("서버 응답 실패");

      const result = await response.json();

      if (result.status === "success") {
        alert("리뷰가 등록되었습니다.");
        location.href = `${path}/views/community/community.jsp`;
      } else {
        alert("등록 실패: " + (result.message || "알 수 없는 오류"));
      }
    } catch (err) {
      console.error("리뷰 등록 중 오류:", err);
      alert("등록 도중 오류가 발생했습니다.");
    }
  });

  //취소 버튼 클릭 시
  cancelBtn.addEventListener("click", () => {
    if (confirm("작성을 취소하시겠습니까?")) {
      history.back();
    }
  });
});
</script>

</body>
</html>