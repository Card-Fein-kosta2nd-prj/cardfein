<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Card:fein - 혜택별 카드 랭킹</title>

  <!-- 공통 스타일 -->
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
      width: calc(20% - 20px); /* 5개씩 배치 (100% / 5 - gap) */
      height: 260px;
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

    .card-name {
      font-weight: bold;
      margin-top: 12px;
    }

    .card-brand {
      font-size: 14px;
      color: #6b7280;
    }
  </style>
</head>

<body>
  <!-- 공통 header include -->
  <jsp:include page="/views/common/header.jsp" />

  <!-- 메인 콘텐츠 -->
  <main class="container">
    <h2 style="text-align: center;">혜택별 카드 랭킹</h2>

    <div class="category-tab-container" id="categoryTabs">
      <button class="category-tab" data-category="교통">교통</button>
      <button class="category-tab" data-category="쇼핑">쇼핑</button>
      <button class="category-tab" data-category="외식">외식</button>
      <button class="category-tab" data-category="병원/약국">병원/약국</button>
      <button class="category-tab" data-category="문화/여가">문화/여가</button>
    </div>

    <div class="card-view-list" id="cardList">
      <p style="margin-top: 30px;">카드 데이터를 불러오는 중...</p>
    </div>
  </main>

  <!-- 공통 footer include -->
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

        cardList.innerHTML = result.map(card => {
          const safeImage = card.cardImageUrl && card.cardImageUrl.trim() !== "" 
              ? card.cardImageUrl 
              : 'default-card.png';

          return `
            <div class="card-item">
              <img 
                src="${path}/static/images/cards/\${safeImage}" //오류가 나서 ${safeImage}에서 $앞에 \ 붙였습니다.
                alt="${card.cardName}" 
                onerror="this.src='${path}/static/images/default-card.png';">
              <div class="card-name">${card.cardName}</div>
              <div class="card-brand">${card.provider}</div>
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

    // 페이지 로드 시 첫 번째 탭 자동 클릭
    tabs[0].click();
  </script>
</body>
</html>
