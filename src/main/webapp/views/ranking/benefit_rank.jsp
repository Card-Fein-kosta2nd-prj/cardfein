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
      position: relative;
      width: calc(20% - 20px); /* 5개씩 배치 (100% / 5 - gap) */
      height: 280px; /* 높이를 약간 늘려서 카드명이 잘리지 않도록 함 */
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

    /* 순위 표시 */
    .card-rank {
      position: absolute;
      color: white;
      padding: 4px 8px;
      font-size: 13px;
      font-weight: bold;
      border-radius: 6px;
      z-index: 1;
      top: 10px; /* 이미지 좌측 상단에 위치하도록 top 속성 수정 */
      left: 10px; /* 이미지 좌측 상단에 위치하도록 left 속성 수정 */
      display: flex;
      justify-content: center;
      align-items: center;
    }

    /* 1위 - 금색 왕관 */
    .rank-1 {
      background-color: gold;
      background-image: url('${path}/static/images/gold-crown.png');
      background-size: cover;
    }

    /* 2위 - 은색 왕관 */
    .rank-2 {
      background-color: silver;
      background-image: url('${path}/static/images/silver-crown.png');
      background-size: cover;
    }

    /* 3위 - 동색 왕관 */
    .rank-3 {
      background-color: #cd7f32;
      background-image: url('${path}/static/images/bronze-crown.png');
      background-size: cover;
    }

    /* 4위 이후는 기존 스타일 유지 */
    .top-rank, .bottom-rank {
      background-color: #2563eb;
    }

    .card-name {
      font-weight: bold;
      margin-top: 12px;
      margin-bottom: 12px;  /* 카드명과 이미지 간의 여백 추가 */
      text-align: center;   /* 카드명을 중앙 정렬 */
      font-size: 14px;  /* 글자 크기를 줄여서 여백을 확보 */
      white-space: normal;  /* 긴 카드명이 잘리지 않게 자동으로 줄바꿈 */
      word-wrap: break-word; /* 긴 텍스트가 한 줄로 끝나지 않고 줄 바꿈이 가능하도록 함 */
      line-height: 1.2em; /* 줄 간격 조정 */
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

  <!-- 공통 footer include -->
  <jsp:include page="/views/common/footer.jsp" />

  <script>
    const path = '${path}';
    const tabs = document.querySelectorAll('.category-tab');
    const cardList = document.getElementById('cardList');

    // loadCards 함수는 여기 안에 위치합니다.
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

          // 1위, 2위, 3위 순위에 왕관 이미지 적용
          const rankClass = index === 0 ? "rank-1" : 
                           index === 1 ? "rank-2" : 
                           index === 2 ? "rank-3" : 
                           index < 5 ? "top-rank" : "bottom-rank";
          const rankNumber = index + 1;  // 순위 번호 (1부터 시작)

          return `
            <div class="card-item">
              <div class="card-rank \${rankClass}">\${rankNumber}위</div>  <!-- 순위 숫자와 "위" 표시 -->
              <img 
                src="${path}/static/images/cards/\${safeImage}"
                alt="\${card.cardName}" 
                onerror="this.src='${path}/static/images/default-card.png';">
              <div class="card-name">\${card.cardName}</div> <!-- 카드명을 중앙에 표시 -->
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

    // 페이지 로드 시 첫 번째 탭 자동 클릭
    tabs[0].click();
  </script>
</body>
</html>
