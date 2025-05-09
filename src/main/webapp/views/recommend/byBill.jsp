<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Card:fein - 명세서 맞춤추천</title>
    
    <!-- 공통 스타일 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <!-- 페이지 전용 스타일 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/byBill.css">

    <!-- 공통 스크립트 -->
    <script src="${pageContext.request.contextPath}/static/js/common.js" defer></script>
    <!-- 페이지 전용 스크립트 -->
</head>
<body>

    <!-- header -->
    <jsp:include page="../../views/common/header.jsp" />





    <!-- 메인 콘텐츠 -->
    <main>
        <div class="container">
            <section class="card-recommendation">
                <div class="text-content">
                    <h2>명세서로<br>카드 추천 받기</h2>
                    <p>내 소비습관에 딱맞춘 카드를 알아보고 추천받아요!</p>

                    <div class="card-tags">
                        <button class="tag">신한카드</button>
                        <button class="tag">삼성카드</button>
                        <button class="tag">국민카드</button>
                        <button class="tag">하나카드</button>
                        <button class="tag">현대카드</button>
                        <button class="tag">등등...</button>
                    </div>

                    <button class="find-btn">명세서 이미지 찾기</button>
                </div>

                <div class="image-content">
                    <img src="${pageContext.request.contextPath}/static/images/cards.png" alt="카드 이미지">
                </div>
            </section>
        </div>
    </main>





    <!-- footer -->
    <jsp:include page="../../views/common/footer.jsp" />

</body>
</html>