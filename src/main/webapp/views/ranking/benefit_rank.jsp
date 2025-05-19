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
    .category-tab-container {
      display: flex;
      flex-wrap: wrap;
      gap: 12px;
      justify-content: center;
      margin-top: 30px;
    }
    .category-tab {
      background-color: #f3f4f6;
      color: #374151;
      border: none;
      padding: 10px 20px;
      font-size: 15px;
      border-radius: 20px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    .category-tab.active {
      background-color: #2563eb;
      color: white;
    }
    .card-view-list {
      margin-top: 40px;
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: flex-start;
      padding: 0 20px;
    }
    .card-item {
      position: relative;
      width: calc(20% - 20px);
      height: 280px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      text-align: center;
      padding: 16px;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: center;
      box-sizing: border-box;
    }
    .card-item img {
      width: 100%;
      height: 180px;
      object-fit: contain;
      border-radius: 6px;
      background-color: #f9fafb;
    }
    .card-rank {
      position: absolute;
      color: white;
      padding: 4px 8px;
      font-size: 13px;
      font-weight: bold;
      border-radius: 6px;
      z-index: 1;
      top: 10px;
      left: 10px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .rank-1 {
      background-color: gold;
      background-image: url('${path}/static/images/gold-crown.png');
      background-size: cover;
    }
    .rank-2 {
      background-color: silver;
      background-image: url('${path}/static/images/silver-crown.png');
      background-size: cover;
    }
    .rank-3 {
      background-color: #cd7f32;
      background-image: url('${path}/static/images/bronze-crown.png');
      background-size: cover;
    }
    .top-rank, .bottom-rank {
      background-color: #2563eb;
    }
    .card-name {
      font-weight: bold;
      margin-top: 12px;
      margin-bottom: 12px;
      text-align: center;
      font-size: 14px;
      white-space: normal;
      word-wrap: break-word;
      line-height: 1.2em;
    }
    .card-brand {
      font-size: 14px;
      color: #6b7280;
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
