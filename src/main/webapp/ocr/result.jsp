<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<main class="container">
    <h2>분석 결과 (일회성 추천)</h2>

    <section>
      <canvas id="spendingChart" class="small-chart"></canvas>
     
    </section>

    <section>
      <canvas id="barChart" class="small-chart"></canvas>
    </section>
    <section id="guestNote" class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 hidden">
      <p class="font-medium">※ 비회원은 카드 추천 결과가 저장되지 않으며, 누적 분석은 제공되지 않습니다.</p>
    </section>
    <p>더 정확한 추천을 원하시나요? <a href="member-dashboard.html">회원 로그인 후 누적 분석 보기</a></p>
  </main>

  <script>
    // 예시 데이터
    const spendingData = [
      { category: "카페", amount: 8000 },
      { category: "마트", amount: 19000 },
      { category: "편의점", amount: 5000 }
    ];

    const cardMatches = [
      { card: "신한 딥드림", rate: 87 },
      { card: "현대 ZERO", rate: 74 }
    ];

    new Chart(document.getElementById('spendingChart'), {
      type: 'pie',
      data: {
        labels: spendingData.map(s => s.category),
        datasets: [{
          data: spendingData.map(s => s.amount),
          backgroundColor: ['#60A5FA', '#34D399', '#FBBF24']
        }]
      },
      options: { plugins: { title: { display: true, text: '카테고리별 소비' } } }
    });

    new Chart(document.getElementById('barChart'), {
      type: 'bar',
      data: {
        labels: cardMatches.map(c => c.card),
        datasets: [{
          label: '매칭률',
          data: cardMatches.map(c => c.rate),
          backgroundColor: '#3b82f6'
        }]
      },
      options: {
        plugins: { title: { display: true, text: '추천 카드 매칭률' } },
        scales: { y: { beginAtZero: true, max: 100 } }
      }
    });
  </script>
</body>
</html>