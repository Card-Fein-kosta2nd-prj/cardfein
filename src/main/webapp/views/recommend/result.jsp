<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cardfein.kro.kr.dto.LoginDto" %>
<%
    LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card:fein - 분석 결과</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 공통 스타일 -->
<link rel="stylesheet" href="${path}/static/css/common.css">
<link rel="stylesheet" href="${path}/static/css/recommend/ocrResult.css"> 
<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js" defer></script>

<script>
  const isLogin = <%= (loginUser != null) ? "true" : "false" %>;
</script>

</head>

<body>
<!-- header -->
<jsp:include page="../../views/common/header.jsp" />

<!-- 메인 콘텐츠 -->
<main class="container">
  <h2>📊 명세서 분석 결과</h2>

  <section>
    <canvas id="spendingChart" class="small-chart"></canvas>
  </section>

  <section>
    <canvas id="barChart" class="small-chart"></canvas>
  </section>

  <div id="memberCheck">
    <section id="guestNote" class="hidden">
      <p class="font-medium">※ 비회원은 카드 추천 결과가 저장되지 않으며, 누적 분석은 제공되지 않습니다.</p>
    </section>
    <p>
      더 정확한 추천을 원하시나요? <a href="${path}/views/card_login.jsp">회원 로그인 하러가기</a>
    </p>
  </div>
</main>

<!-- footer -->
<jsp:include page="../../views/common/footer.jsp" />

<script>
  const spendingData = async () => {
    const response = await fetch("${path}/ajax", {
      method: "POST",
      credentials: "include",
      body: new URLSearchParams({
        key: "ocr",
        methodName: "parsing"
      })
    });

    const result = await response.json(); // {카테고리: 금액, ...}

    const categories = Object.keys(result);
    const amounts = Object.values(result);

    const generateColors = (num) => {
      const baseColors = [
        '#60A5FA', '#34D399', '#FBBF24', '#F87171',
        '#A78BFA', '#4BC0C0', '#FF9F40', '#FF6384',
        '#36A2EB', '#9966FF'
      ];
      return Array.from({ length: num }, (_, i) => baseColors[i % baseColors.length]);
    };

    new Chart(document.getElementById('spendingChart'), {
      type: 'pie',
      data: {
        labels: categories,
        datasets: [{
          data: amounts,
          backgroundColor: generateColors(categories.length)
        }]
      },
      options: {
        responsive: true,
        plugins: {
          title: {
            display: true,
            text: '카테고리별 소비'
          }
        }
      }
    });

    await cardMatch();

    if (isLogin) {
      document.getElementById('memberCheck').innerHTML = `
        <button id="memberAnalysis" onclick="location.href='memberCardRecommend.jsp'">
          📌 누적소비 기반 맞춤카드 확인하기
        </button>`;
    } else {
      document.getElementById('guestNote').classList.remove("hidden");
    }
  };

  const cardMatch = async () => {
    const response = await fetch("${path}/ajax", {
      method: "POST",
      credentials: "include",
      body: new URLSearchParams({
        key: "ocr",
        methodName: "cardRecommend"
      })
    });

    const result = await response.json(); // {카드명: 매칭률, ...}
    const cardNames = Object.keys(result);
    const matchingRate = Object.values(result);

    new Chart(document.getElementById('barChart'), {
      type: 'bar',
      data: {
        labels: cardNames,
        datasets: [{
          label: '매칭률',
          data: matchingRate,
          backgroundColor: '#3b82f6'
        }]
      },
      options: {
        responsive: true,
        plugins: {
          title: {
            display: true,
            text: '추천 카드 매칭률'
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            max: 100
          }
        }
      }
    });
  };

  spendingData();
</script>
</body>
</html>
