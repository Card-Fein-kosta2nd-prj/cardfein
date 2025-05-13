<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 공통 스타일 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/ocrResult.css">
<!-- 공통 스크립트 -->
<script src="${pageContext.request.contextPath}/static/js/common.js"
	defer></script>
</head>


<body>
	<!-- header -->
	<jsp:include page="../../views/common/header.jsp" />
	<!-- 메인 콘텐츠 -->
	<main class="container">
		<h2>명세서 분석 결과</h2>

		<section>
			<canvas id="spendingChart" class="small-chart"></canvas>

		</section>

		<section>
			<canvas id="barChart" class="small-chart"></canvas>
		</section>
		<section id="guestNote"
			class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 hidden">
			<p class="font-medium">※ 비회원은 카드 추천 결과가 저장되지 않으며, 누적 분석은 제공되지
				않습니다.</p>
		</section>
		<p id="memberCheck">
			더 정확한 추천을 원하시나요? <a href="member-dashboard.html">회원 로그인 후 누적 분석
				보기</a>
		</p>
	</main>
	<!-- footer -->
	<jsp:include page="../../views/common/footer.jsp" />
	<script>
 
  const spendingData = async () => {
	  let response = await fetch("${path}/ajax", {
	    method: "POST",
	    credentials: "include",
	    body: new URLSearchParams({
	      key: "ocr",
	      methodName: "parsing"
	    })
	  });

	  let result = await response.json(); // [{ category: "카페/커피", amount: 50000 }, ...]
	  // 필요만큼 색상을 자동 생성
	  const generateColors = (num) => {
	    const baseColors = [
	      '#60A5FA', '#34D399', '#FBBF24', '#F87171', '#A78BFA', '#4BC0C0',
	      '#FF9F40', '#FF6384', '#36A2EB', '#9966FF'
	    ];
	    return Array.from({ length: num }, (_, i) => baseColors[i % baseColors.length]);
	  };

	  const categories =  Object.keys(result); //또는   Map<String, Integer> spendingMap = (Map<String, Integer>) result; downcasting
	  const amounts = Object.values(result);

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
	    	  maintainAspectRatio: true,
	      plugins: {
	        title: {
	          display: true,
	          text: '카테고리별 소비'
	        }
	      }
	    }
	  });
	  await cardMatch();
	  if(1===1) //회원이 로그인 한 상태라면!!
	  document.getElementById('memberCheck')
	  .innerHTML=`<button id="memberAnalysis"  onclick="location.href = 'memberCardRecommend.jsp'"> 누적소비 기반 맞춤카드 확인하기 </button>`;
	  
	};
	
  
   const cardMatch= async()=>{
	   let response = await fetch("${path}/ajax", {
		    method: "POST",
		    credentials: "include",
		    body: new URLSearchParams({
		      key: "ocr",
		      methodName: "cardRecommend"
		    })
		  });

		  let result = await response.json(); 
		  
		  const cardNames =  Object.keys(result); //또는   Map<String, Integer> spendingMap = (Map<String, Integer>) result; downcasting
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
		          maintainAspectRatio: false,
		        plugins: { title: { display: true, text: '추천 카드 매칭률' } },
		        scales: { y: { beginAtZero: true, max: 100 } }
		      }
		    });
		  
		  
		  
   }
   
   
   
   
   spendingData();
   
	


   

  </script>
</body>
</html>