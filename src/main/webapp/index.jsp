<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Card:fein - 내 손안의 카드비서</title>
    
    <!-- 공통 스타일 -->
    <link rel="stylesheet" href="${path}/static/css/index.css">

    <!-- 공통 스크립트 -->
    <script src="${path}/static/js/index.js" defer></script>
    <!-- 페이지 전용 스크립트 -->
</head>
<body>
    <header>
        <div class="header-content">
	        <!-- 로고 부분 -->
	        <div class="card-nav-logo">
	            <img src="${path}/static/images/icons/logo.png" alt="로고" class="nav-logo-img">
	        </div>
        </div>
        <div class="login-content">
            <button class="login-btn">로그인</button>
        </div>
    </header>
    <div class="container">
        <div class="carousel-container">
            <div class="circle-bg"></div>
            <div class="white-circle">
                <div class="carousel-wrapper" id="carouselWrapper">
                    <div class="carousel">
                        <div class="carousel-item active">
                            <img src="${path}/static/images/index/index_img1.png" alt="ZERO 카드" class="card-img">
                            <p class="card-desc">내 라이프스타일에 맞춘 카드 생활</p>
                            <button class="action-btn">분석하러 가기</button>
                        </div>
                        <div class="carousel-item">
                            <img src="${path}/static/images/index/index_img2.png" alt="카드 2" class="card-img">
                            <p class="card-desc">다양한 혜택을 한눈에</p>
                            <button class="action-btn">카드 랭킹 확인</button>
                        </div>
                        <div class="carousel-item">
                            <img src="${path}/static/images/index/index_img3.png" alt="카드 3" class="card-img">
                            <p class="card-desc">맞춤형 카드 추천</p>
                            <button class="action-btn">맞춤 카드 찾기</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="nav-buttons">
                <button class="nav-btn prev">&lt;</button>
                <button class="nav-btn next">&gt;</button>
            </div>

            <div class="indicator-container">
                <div class="indicator active" data-index="0"></div>
                <div class="indicator" data-index="1"></div>
                <div class="indicator" data-index="2"></div>
            </div>
        </div>

        <a href="${path}/main.jsp" class="skip-btn">
            <span>SKIP</span>
            <span class="skip-arrow">→</span>
        </a>
    </div>
</body>
</html>