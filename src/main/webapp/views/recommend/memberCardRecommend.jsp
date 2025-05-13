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
    <h2 id="recentCategory"></h2>
		<h2 class="mt-8">🔥 추천 카드 목록</h2>
		<div id="personalizedCards" class="space-y-6 mt-4"></div>


	</main>

	<script>
 	const recommendCards = async () => {
	  let response = await fetch("${path}/ajax", {
	    method: "POST",
	    credentials: "include",
	    body: new URLSearchParams({
	      key: "ocr",
	      methodName: "memberCardRecommend"
	    })
	  });

	  let result = await response.json();
	  console.log(result);
    //result = null; //회원인데 명세서 업로드 안한 회원테스트용
    if(!result || result.length === 0){
      document.querySelector('.container').innerHTML =`명세서 업로드 이력이 없습니다. 명세서 업로드 후 누적 기반 맞춤 카드 추천이 가능합니다.<br>
      <button onclick="location.href='byBill.jsp'"/>명세서 업로드 하러가기`;
         return; //return 이 있어야 아닌경우 아래 구문들이 실행될 수 있다.
    }
    
    let recentCategories = [];
    result[0].cardBenefitList.forEach((benefit)=>{
        recentCategories.push(benefit.category); 
    });
    
    document.getElementById('recentCategory').innerHTML=`지난 3개월 간 "\${recentCategories[0]}"와 "\${recentCategories[1]}"에 많이 사용하셨군요!<br>
해당 분야에 혜택이 많은 카드를 모아봤어요. 😊 `;
    
    console.log(result);
    const container = document.getElementById('personalizedCards');
    result.forEach((card, idx) => {
      const box = document.createElement('div');
      box.className = 'card-match-box';
      box.innerHTML = `
        <img src="삼성_2V4.png" alt="카드 이미지" style="width:10%" />
        <div class="card-info">
          <h3>\${card.cardName}</h3>
          <div class="match-rate">매칭률: \${card.matchingRate}%</div>
          <div class="match-bar-container">
            <div class="match-bar" style="width: \${card.matchingRate}%; background-color: "#3b82f6";"></div>
          </div>
          <div class="reason">할인혜택:\${card.cardBenefitList[0].category}-\${card.cardBenefitList[0].discountRate}%, \${card.cardBenefitList[1].category}-\${card.cardBenefitList[1].discountRate}%
            </div>
          <a class="btn-sm" href="#">비교 바구니 담기</a>
        </div>
      `;
      container.appendChild(box);
    });
  
  };
  recommendCards();
  
  
  
  
   

    
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