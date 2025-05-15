<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
			<h1>커뮤니티</h1>
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
				<div class="action-buttons">
					<button class="action-button edit-button">수정</button>
					<button class="action-button delete-button">삭제</button>
				</div>
				<div class="comments-section">
				<hr>
					<h3 class="comments-title">댓글</h3>
					<c:forEach var="reply" items="${review.replyList}">
						<div class="comment-item">
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
</html>