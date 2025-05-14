<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 로고 헤더 (중앙 배치) -->
<header class="logo-header">
    <div class="header-ontainer">
    	<a href="${path}/main.jsp">
        	<img src="${path}/static/images/icons/logo.png" alt="로고" class="main-logo">
    	</a>
    </div>
</header>

<!-- 네비게이션 헤더 (스크롤 시 보이는 헤더) -->
<div class="card-nav" id="sticky-nav">
    <div class="header-container" style="display: flex; justify-content: space-between; align-items: center;">
        <!-- 로고 부분 -->
        <div class="card-nav-logo">
            <a href="${path}/main.jsp">
            	<img src="${path}/static/images/icons/logo.png" alt="로고" class="nav-logo-img">
            </a>
        </div>

        <!-- 메뉴 부분 -->
        <nav class="card-nav-menu">
            <ul>
                <li class="dropdown">
                    <a href="#" class="dropbtn">랭킹</a>
                    <div class="dropdown-content">
                        <a href="#">실시간</a>
                        <a href="#">카드사별</a>
                        <a href="#">혜택별</a>
                    </div>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropbtn">카드</a>
                    <div class="dropdown-content">
                        <a href="#">맞춤카드 검색</a>
                        <a href="#">카드추천 테스트</a>
                        <a href="#">명세서 맞춤추천</a>
                    </div>
                </li>
                <li class="dropdown">
                    <a href="${path}/views/community/community.jsp" class="dropbtn">커뮤니티</a>
                    <div class="dropdown-content">
                        <a href="${path}/views/community/community.jsp">카드리뷰</a>
                        <a href="#">콘텐츠</a>
                        <a href="#">공지사항</a>
                    </div>
                </li>
                <li><a href="#">카드커버</a></li>
            </ul>
        </nav>

		<!-- 로그인 버튼을 오른쪽 끝으로 배치 -->
		<div class="user-actions" id="user-actions" style="margin-left: auto; flex-grow: 0;">
			<a href="#" class="cart"> <img src="${path}/static/images/icons/cart.png" alt="장바구니"> 
				<span class="cart-count">0</span>
			</a>
			
			<!-- 로그인하지 않은 경우 -->
			<div id="logged-out-actions">
				<a href="#" class="login-btn">로그인</a>
			</div>

			<!-- 로그인한 경우 -->
			<div id="logged-in-actions" style="display: none;">
				<a href="#" class="profile"> <img src="${path}/static/images/icons/profile.png" alt="프로필"></a>
			</div>
		</div>
	</div>
</div>
