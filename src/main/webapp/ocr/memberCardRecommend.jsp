<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>회원 맞춤카드 추천</title>
<link rel="stylesheet" href="home.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<header>
		<h1>회원 전용 추천</h1>
		<nav>
			<a href="index.html">홈</a>
		</nav>
	</header>

	<main class="container">
		<h3 class="mt-8">🔥 추천 카드 목록</h3>
		<div id="personalizedCards" class="space-y-6 mt-4"></div>
		<h2>📊 누적 소비 기반 카드 매칭율 변화</h2>

		<canvas id="lineChart" height="100"></canvas>


	</main>

	<script>
  const insertData = async () => {
	  let response = await fetch("${path}/ajax", {
	    method: "POST",
	    credentials: "include",
	    body: new URLSearchParams({
	      key: "ocr",
	      methodName: "memberCardRecommend"
	    })
	  });

	  let result = await response.json();
  };
  insertData();
  
  
  
  
    const matchHistory = {
      "신한 딥드림": [65, 70, 75, 80, 87],
      "현대 ZERO": [60, 63, 67, 70, 74]
    };
    const labels = ["1월", "2월", "3월", "4월", "5월"];
    const recommendations = [
      {
        card: "신한 딥드림 카드",
        matchRate: 87,
        reason: "☕ 카페, 🛒 마트 혜택 최적화",
        color: "#3b82f6"
      },
      {
        card: "현대 ZERO 카드",
        matchRate: 74,
        reason: "🧾 넷플릭스, 편의점 자주 이용 시 적합",
        color: "#f59e0b"
      }
    ];

    const lineCtx = document.getElementById('lineChart').getContext('2d');
    new Chart(lineCtx, {
      type: 'line',
      data: {
        labels: labels,
        datasets: Object.entries(matchHistory).map(([card, data]) => ({
          label: card,
          data: data,
          borderWidth: 2,
          tension: 0.3
        }))
      },
      options: {
        plugins: {
          title: { display: true, text: '월별 카드 매칭률 변화' }
        },
        scales: {
          y: { beginAtZero: true, max: 100 }
        }
      }
    });

    const container = document.getElementById('personalizedCards');
    recommendations.forEach((rec, idx) => {
      const box = document.createElement('div');
      box.className = 'card-match-box';
      box.innerHTML = `
        <img src="삼성_2V4.png" alt="카드 이미지" style="width:10%" />
        <div class="card-info">
          <h3>\${rec.card}</h3>
          <div class="match-rate">매칭률: \${rec.matchRate}%</div>
          <div class="match-bar-container">
            <div class="match-bar" style="width: \${rec.matchRate}%; background-color: \${rec.color};"></div>
          </div>
          <div class="reason">${rec.reason}</div>
          <a class="btn-sm" href="#">비교 바구니 담기</a>
        </div>
      `;
      container.appendChild(box);
    });
  </script>

	<style>
.card-match-box {
	background: white;
	border-radius: 16px;
	padding: 30px;
	margin-bottom: 24px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
	display: flex;
	gap: 24px;
	align-items: center;
}

.card-info {
	flex: 1;
}

.match-bar-container {
	background: #e5e7eb;
	height: 12px;
	border-radius: 6px;
	overflow: hidden;
	margin: 12px 0;
}

.match-bar {
	height: 100%;
	background-color: #3b82f6;
	transition: width 0.5s ease-in-out;
}

.match-rate {
	font-weight: 600;
	color: #2563eb;
}

.reason {
	font-size: 0.95rem;
	color: #374151;
	margin-top: 8px;
}

.btn-sm {
	background: #10b981;
	color: white;
	padding: 6px 14px;
	border-radius: 8px;
	font-size: 0.9rem;
	margin-top: 10px;
	display: inline-block;
}
</style>
</body>
</html>