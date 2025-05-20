<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Card:fein - 혜택별 카드 랭킹</title>

  <script src="${path}/static/js/common.js" defer></script>
  <link rel="stylesheet" href="${path}/static/css/common.css" />
  <link rel="stylesheet" href="${path}/static/css/main.css" />

<style>
body {
	background: linear-gradient(to bottom, #f8fbff, #eef3f8);
}

main h2 {
	font-size: 2.0rem;
	font-weight: 800;
	color: #0f172a;
	text-align: center;
	margin: 50px 0 70px; /* ✅ 위아래 넉넉하게 */
	letter-spacing: -0.3px;
	line-height: 1.5;
	position: relative;
}

main h2::after {
	content: "";
	position: absolute;
	bottom: -14px;
	left: 50%;
	transform: translateX(-50%);
	width: 60px;
	height: 4px;
	background-color: #2563eb;
	border-radius: 999px;
}

.category-tab-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 12px 16px;
	margin: 50px auto 30px;
	padding: 0 12px;
	max-width: 960px;
}

.category-tab {
	min-width: 110px;
	padding: 10px 22px;
	font-size: 15px;
	font-weight: 500;
	border: none;
	border-radius: 999px;
	background: rgba(255, 255, 255, 0.7);
	backdrop-filter: blur(8px);
	color: #1f2937;
	cursor: pointer;
	transition: all 0.25s ease;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
	position: relative;
	overflow: hidden;
}

.category-tab:hover {
	background-color: #e0edff;
	color: #2563eb;
	transform: translateY(-1px);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

.category-tab.active {
	background: linear-gradient(90deg, #3b82f6, #2563eb);
	color: white;
	font-weight: 600;
	box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
}

.card-view-list {
	margin: 80px auto;
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
	max-width: 1400px;
	padding: 0 16px;
}

.card-item {
	width: 180px; /* ✅ 더 많은 카드가 한 줄에 보이도록 */
	height: auto;
	background-color: white;
	border-radius: 14px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
	padding: 16px 12px 20px;
	position: relative;
	text-align: center;
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card-item:hover {
	transform: translateY(-4px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
}

.card-item img {
	width: 100%;
	height: 140px;
	object-fit: contain;
	border-radius: 10px;
	margin-bottom: 12px;
}

.card-rank {
	position: absolute;
	top: 10px;
	left: 10px;
	font-size: 12px;
	font-weight: 700;
	color: white;
	padding: 6px 10px;
	border-radius: 20px;
	z-index: 2;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	background-color: #2563eb; /* 기본 등수 배경 */
	backdrop-filter: blur(4px);
}

.card-name {
	font-weight: 600;
	font-size: 15px;
	color: #111827;
	margin-bottom: 6px;
}

.card-brand {
	font-size: 13px;
	color: #6b7280;
}

/* 1~3위 강조 */
.rank-1 {
	background: linear-gradient(135deg, #ffe259, #ffa751); /* 금색 느낌 */
	color: #111;
}

.rank-2 {
	background: linear-gradient(135deg, #d9d9d9, #bcbcbc); /* 은색 느낌 */
	color: #111;
}

.rank-3 {
	background: linear-gradient(135deg, #d7a56c, #b97b46); /* 동색 느낌 */
	color: #fff;
}
</style>
</head>
<body>
  <jsp:include page="/views/common/header.jsp" />

  <main class="container">
    <h2 style="text-align: center;">혜택별 카드 랭킹</h2>

    <div class="category-tab-container" id="categoryTabs">
      <button class="category-tab" data-category="교통">교통</button>
      <button class="category-tab" data-category="쇼핑">쇼핑</button>
      <button class="category-tab" data-category="외식">외식</button>
      <button class="category-tab" data-category="병원/약국">병원/약국</button>
      <button class="category-tab" data-category="문화/여가">문화/여가</button>
      <button class="category-tab" data-category="카페/커피">카페/커피</button>
      <button class="category-tab" data-category="편의점/마트">편의점/마트</button>
      <button class="category-tab" data-category="통신/디지털">통신/디지털</button>
      <button class="category-tab" data-category="항공/여행">항공/여행</button>
      <button class="category-tab" data-category="주유">주유</button>
    </div>

    <div class="card-view-list" id="cardList">
      <p style="margin-top: 30px;">카드 데이터를 불러오는 중...</p>
    </div>
  </main>

  <jsp:include page="/views/common/footer.jsp" />

  <script>
    const path = '${path}';
    const tabs = document.querySelectorAll('.category-tab');
    const cardList = document.getElementById('cardList');

    const loadCards = async (category) => {
      cardList.innerHTML = '<p>불러오는 중...</p>';
      try {
        const response = await fetch(`${path}/ajax/rank`, {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: new URLSearchParams({ category })
        });

        const result = await response.json();
        if (result.length === 0) {
          cardList.innerHTML = '<p>해당 혜택의 카드 랭킹 정보가 없습니다.</p>';
          return;
        }

        cardList.innerHTML = result.map((card, index) => {
          const safeImage = card.cardImageUrl && card.cardImageUrl.trim() !== "" 
              ? card.cardImageUrl 
              : 'default-card.png';
          const rankClass = index === 0 ? "rank-1" : 
                           index === 1 ? "rank-2" : 
                           index === 2 ? "rank-3" : 
                           index < 5 ? "top-rank" : "bottom-rank";
          const rankNumber = index + 1;

          return `
            <div class="card-item">
              <div class="card-rank \${rankClass}">\${rankNumber}위</div>
              <img 
                src="${path}/static/images/cards/\${safeImage}"
                alt="\${card.cardName}" 
                onerror="this.src='${path}/static/images/default-card.png';">
              <div class="card-name">\${card.cardName}</div>
              <div class="card-brand">\${card.provider}</div>
            </div>
          `;
        }).join('');
      } catch (err) {
        console.error('불러오기 실패:', err);
        cardList.innerHTML = '<p>카드를 불러오는데 실패했습니다.</p>';
      }
    };

    tabs.forEach(btn => {
      btn.addEventListener("click", () => {
        tabs.forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
        loadCards(btn.dataset.category);
      });
    });

    const urlParams = new URLSearchParams(window.location.search);
    const initialCategory = urlParams.get('category');

    if (initialCategory) {
      const targetTab = Array.from(tabs).find(tab => tab.dataset.category === initialCategory);
      if (targetTab) {
        targetTab.click();
      } else {
        tabs[0].click();
      }
    } else {
      tabs[0].click();
    }
  </script>
</body>
</html>
