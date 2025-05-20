<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cardfein.kro.kr.dto.LoginDto" %>
<%
  String path = request.getContextPath();
  LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
%>

<style>
header {
  position: relative;
  z-index: 1000;
}

.dropdown {
  position: relative;
  z-index: 1000;
}

.dropdown-content {
  position: absolute;
  top: 100%;
  left: 0;
  background-color: #fff;
  min-width: 160px;
  padding: 10px 0;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  display: none;
  z-index: 9999;
}

.dropdown:hover .dropdown-content {
  display: block;
}
</style>

<header class="logo-header">
  <div class="header-container">
    <a href="<%= path %>/main.jsp">
      <img src="<%= path %>/static/images/icons/logo.png" alt="로고" class="main-logo">
    </a>
  </div>
</header>

	<div class="card-nav" id="sticky-nav">
	  <div class="header-container">
	
	    <!-- 작은 로고 + 검색창 -->
	    <div class="left-area">
	      <div class="card-nav-logo">
	        <a href="<%= path %>/main.jsp">
	          <img src="<%= path %>/static/images/icons/logo.png" alt="로고" class="nav-logo-img">
	        </a>
	      </div>
	      <!-- 검색창 -->
	      <div class="search-box">
	        <input type="text" class="search-input" id="cardSearchInput" placeholder="카드를 검색해보세요" />
	      </div>
	    </div>
	    <!-- left-area 끝 -->
	    
		<!-- 카드 검색 모달 (cart.jsp에서 복사 + 접두어 추가) -->
		<div id="searchCardModal" class="header-modal">
		  <div class="header-modal-content">
		    <button class="header-modal-close" onclick="document.getElementById('searchCardModal').style.display='none'">&times;</button>
		    
		    <div class="header-modal-header">
		      <h2 class="header-modal-title">카드를 검색하세요</h2>
		    </div>
		
		    <!-- 카드사 필터 버튼 -->
		    <div class="header-provider-buttons">
		      <button class="header-provider-btn" data-provider="국민">국민</button>
		      <button class="header-provider-btn" data-provider="기업">기업</button>
		      <button class="header-provider-btn" data-provider="농협">농협</button>
		      <button class="header-provider-btn" data-provider="롯데">롯데</button>
		      <button class="header-provider-btn" data-provider="삼성">삼성</button>
		      <button class="header-provider-btn" data-provider="신한">신한</button>
		      <button class="header-provider-btn" data-provider="우리">우리</button>
		      <button class="header-provider-btn" data-provider="하나">하나</button>
		      <button class="header-provider-btn" data-provider="현대">현대</button>
		    </div>
		
		    <!-- 키워드 검색창 -->
		    <div class="header-search-container">
		      <input type="text" class="header-search-input" id="searchCardKeyword" placeholder="카드명을 입력하세요">
		    </div>
		
		    <!-- 카드 리스트 -->
		    <div class="header-modal-card-list">
		      <div class="header-modal-card-grid" id="searchCardGrid"></div>
		    </div>
		  </div>
		</div>

	    <!-- 모달 끝! -->
	
	<!-- 중앙 메뉴 -->
    <nav class="card-nav-menu">
      <ul>
        <!-- 랭킹 -->
        <!-- 
        <li class="dropdown">
          <a href="#" class="dropbtn">혜택별 랭킹</a>
          <div class="dropdown-content">
            <a href="#">실시간</a>
            <a href="#">카드사별</a>
            <a href="<%= path %>/views/ranking/benefit_rank.jsp">혜택별</a>
          </div>
        </li>
         -->

        <!-- 카드 -->
        <li class="dropdown">
          <a href="<%= path %>/views/cardMenu/fitCard.jsp" class="dropbtn">카드</a>
          <div class="dropdown-content">
            <a href="<%= path %>/views/cardMenu/fitCard.jsp">맞춤카드 검색</a>
            <a href="<%= path %>/views/recommend/byBill.jsp">명세서 추천</a>
            <% if (loginUser != null) { %>
              <a href="<%= path %>/views/recommend/memberCardRecommend.jsp">누적기반 맞춤추천</a>
            <% } %>
          </div>
        </li>
        
        <li>
        	<a href="<%= path %>/views/ranking/benefit_rank.jsp">혜택별</a>
        </li>

        <!-- 커뮤니티 -->
        <li>
  			<a href="<%= path %>/views/community/community.jsp">커뮤니티</a>
		</li>
        
        <!-- 
        <li class="dropdown">
          <a href="<%= path %>/views/community/community.jsp">커뮤니티</a>
          <div class="dropdown-content">
            <a href="<%= path %>/views/community/community.jsp">카드리뷰</a>
            <a href="#">콘텐츠</a>
            <a href="#">공지사항</a>
            -->
		
            <!-- 관리자만 대시보드 표시 -->
            <!--
            <% if (loginUser != null && "admin".equals(loginUser.getRole())) { %>
              <a href="<%= path %>/views/adminpage.jsp">대시보드</a>
            <% } %>
          </div>
        </li>
         -->

        <!-- 커버 -->
        <li class="dropdown">
          <a href="#" class="dropbtn">커버</a>
          <div class="dropdown-content">
             <a href="<%= path %>/views/cardCover/cardmain.jsp">커버 만들기</a>
             <a href="<%= path %>/views/cardCover/cardranking.jsp">커버 순위</a>
          </div>
        </li>
      </ul>
    </nav>
    
    <!-- 우측 유저 영역 -->
	<div class="user-actions" style="margin-left: auto; display: flex; align-items: center; gap: 12px;">
	  <a href="<%= path %>/views/cart/cart.jsp" class="cart">
	    <img src="<%= path %>/static/images/icons/cart.png" alt="장바구니">
	    <span class="cart-count">0</span>
	  </a>
	
	  <% if (loginUser == null) { %>
	    <a href="<%= path %>/views/card_login.jsp" class="login-btn">로그인</a>
	  <% } else { %>
	    <!-- 프로필 드롭다운 -->
		<div class="profile-dropdown">
		  <div class="profile-hover-area">
		    <img src="<%= path %>/static/images/icons/profile.png" alt="프로필" class="profile-img" />
		    <div class="profile-bubble">
		      <a href="<%= path %>/views/mycard/mycard.jsp">내 지갑</a>
		      <a href="<%= path %>/logout">로그아웃</a>
		    </div>
		  </div>
		</div>






	  <% } %>
	</div>


  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
	  const path = "<%= path %>";
	  const cardSearchInput = document.getElementById("cardSearchInput");
	  const searchCardModal = document.getElementById("searchCardModal");
	  const searchCardKeyword = document.getElementById("searchCardKeyword");
	  const searchCardGrid = document.getElementById("searchCardGrid");
	  let selectedProvider = "";

	  // [1] 검색창 클릭 시 모달 열기
	  cardSearchInput.addEventListener("focus", () => {
	    searchCardModal.style.display = "block";
	    searchCardKeyword.value = "";
	    loadCardList("");
	  });

	  // [2] 외부 클릭 시 닫기
	  window.addEventListener("click", function (event) {
	    if (event.target === searchCardModal) {
	      searchCardModal.style.display = "none";
	    }
	  });

	  // [3] 검색어 입력
	  searchCardKeyword.addEventListener("input", (e) => {
	    loadCardList(e.target.value.trim());
	  });

	  // [4] 카드사 필터
	  document.querySelectorAll(".header-provider-btn").forEach(btn => {
	    btn.addEventListener("click", () => {
	      const isActive = btn.classList.contains("active");
	      document.querySelectorAll(".header-provider-btn").forEach(b => b.classList.remove("active"));
	      if (isActive) {
	        selectedProvider = "";
	      } else {
	        btn.classList.add("active");
	        selectedProvider = btn.dataset.provider;
	      }
	      loadCardList(searchCardKeyword.value.trim());
	    });
	  });

	  // [5] Ajax 카드 검색
	  async function loadCardList(keyword = "") {
	    let methodName = "selectAll";
	    if (keyword && selectedProvider) methodName = "selectByProviderAndKeyword";
	    else if (keyword) methodName = "selectByKeyword";
	    else if (selectedProvider) methodName = "selectByProvider";

	    const params = new URLSearchParams({ key: "cart", methodName });
	    if (keyword) params.append("keyword", keyword);
	    if (selectedProvider) params.append("provider", selectedProvider);

	    try {
	      const res = await fetch(`${path}/ajax?${'${params.toString()}'}`);
	      if (!res.ok) throw new Error("서버 오류");
	      const cards = await res.json();
	      renderCardList(cards);
	    } catch (err) {
	      alert("카드 불러오기 실패: " + err.message);
	    }
	  }

	  // [6] 카드 리스트 렌더링
	  function renderCardList(cards) {
	    searchCardGrid.innerHTML = "";
	    cards.forEach(card => {
	      const item = document.createElement("div");
	      item.className = "header-modal-card-item";
	      item.innerHTML = `
	        <img src="${path}/static/images/cards/\${card.cardImageUrl}" alt="${'${card.cardName}'}">
	        <div class="header-modal-card-name">\${card.cardName}</div>
	        <div class="header-modal-card-company">\${card.provider}</div>
	      `;
	      item.addEventListener("click", () => {
	        window.location.href = `${path}/views/cardMenu/fitCardDetail.jsp?cardNo=\${card.cardNo}`;
	      });
	      searchCardGrid.appendChild(item);
	    });
	  }
	});
</script>