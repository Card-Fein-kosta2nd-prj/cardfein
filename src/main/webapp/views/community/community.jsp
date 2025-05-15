<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>커뮤니티</title>
	
	<!-- 공통 스타일 -->
    <link rel="stylesheet" href="${path}/static/css/common.css">
	<!-- 페이지 전용 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/community/community.css">
	
	<!-- 공통 스크립트 -->
    <script src="${path}/static/js/common.js" defer></script>
	<!-- 페이지 전용 스크립트 -->
	<script src="${path}/static/js/community/community.js" defer></script>
	<!-- 사이드바 스크립트 -->
	<script src="${path}/static/js/community/com_sidebar.js" defer></script>

</head>
<body>

	<!-- header -->
    <jsp:include page="/views/common/header.jsp" />
	
	
	
	<div class="container">
		<div class="header">
			<h1>커뮤니티</h1>
			<div class="search-container">
				<input type="text" class="search-input" />
				<button class="search-button">검색</button>
			</div>
		</div>

		<div class="content-wrapper">
			<div id="sidebar-container"></div>
			<div class="main-content">
				<div id="list-view">
					<!-- 게시글이 여기에 동적으로 추가됩니다 -->
				</div>

				<div id="detail-view">
					<!-- 상세 내용이 여기에 동적으로 추가됩니다 -->
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>