<%@page import="cardfein.kro.kr.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String path = request.getContextPath();
  LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
  int userNo = (loginUser != null) ? loginUser.getUserNo() : -1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>회원 맞춤카드 추천</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 공통 스타일 -->
<link rel="stylesheet"
	href="${path}/static/css/common.css">
	<link rel="stylesheet"
	href="${path}/static/css/recommend/cardRecommend.css">
	<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js"
	defer></script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../views/common/header.jsp" />

	<main class="recommend">
    <h2 id="recentCategory"></h2>
		<h2 class="mt-8">🔥 추천 카드 목록</h2>
		<div id="personalizedCards" class="space-y-6 mt-4"></div>


	</main>
	<!-- footer -->
	<jsp:include page="../../views/common/footer.jsp" />

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
   // result = null; //회원인데 명세서 업로드 안한 회원테스트용
    if(!result || result.length === 0){
    	document.querySelector(".recommend").innerHTML = `
    		<div style="text-align: center; padding: 40px 0;">
    	    명세서 업로드 이력이 없습니다. 명세서 업로드 후 누적 기반 맞춤 카드 추천이 가능합니다.<br>
    	    <button style="display: inline-block; padding: 10px 20px; background-color: #10b981; color: white; border-radius: 8px; font-size: 1rem; cursor: pointer; margin-top: 20px;" onclick="location.href='byBill.jsp'">
    	      명세서 업로드 하러가기
    	    </button>
    	  </div>
    		`;
         return; //return 이 있어야 아닌경우 아래 구문들이 실행될 수 있다.
    }
    
    let recentCategories = [];
    result[0].cardBenefitList.forEach((benefit)=>{
        recentCategories.push(benefit.category); 
    });
    let category1 = recentCategories[0];
    let category2 = recentCategories[1];
    
    let message = category2
    ? `지난 3개월 간 "\${category1}"와 "\${category2}"에 많이 사용하셨군요!<br>해당 분야에 혜택이 많은 카드를 모아봤어요. 😊`
    : `지난 3개월 간 "\${category1}"에 많이 사용하셨군요!<br>해당 분야에 혜택이 많은 카드를 모아봤어요. 😊`;

  document.getElementById('recentCategory').innerHTML = message;
    
    
    const container = document.getElementById('personalizedCards');
    result.forEach((card, idx) => {
      const box = document.createElement('div');
      box.className = 'card-match-box';
      
    	console.log(card.cardNo);
      box.innerHTML = `
        <img src="${path}/static/images/cards/\${card.cardImageUrl}" alt="카드 이미지" style="width:10%" />
        <div class="card-info">
          <h3>\${card.cardName}</h3>
          <div class="match-rate">매칭률: \${card.matchingRate}%</div>
          <div class="match-bar-container">
            <div class="match-bar" style="width: \${card.matchingRate}%; background-color: "#3b82f6";"></div>
          </div>
          <div class="reason"><!-- cardBenefitList가 비어있지 않으면 첫 번째 항목을 출력하고, 두 번째 항목이 있으면 출력 -->
          \${card.cardBenefitList && card.cardBenefitList.length > 0 ? 
                  `할인혜택: \${card.cardBenefitList[0].category} - \${card.cardBenefitList[0].discountRate}%` 
                  : '할인 혜택 정보 없음'}
                
               \${card.cardBenefitList && card.cardBenefitList.length > 1 ? 
                  `, \${card.cardBenefitList[1].category} - \${card.cardBenefitList[1].discountRate}%` 
                  : ''}
            </div>
            <div class="button-group">
            <a class="btn-sm" href="#" onclick="addToCart(\${card.cardNo})">비교 바구니 담기</a>
            <a class="btn-detail" href="#"onclick="showDetail(\${card.cardNo})">자세히 보기</a>
          </div>
        </div>
      `;
      container.appendChild(box);
    });
  
  };
  recommendCards();
  document.addEventListener("DOMContentLoaded", () => {
  const addToCart = async(cardNo)=>{
	  let saved = JSON.parse(localStorage.getItem("cartCards") || "[{}, {}, {}]");

	  // 이미 들어있는지 확인
	  const alreadyAdded = saved.some(item => item.cardNo === cardNo);
	  if (alreadyAdded) {
	    alert("이미 장바구니에 담긴 카드입니다!");
	    return;
	  }

	  // 빈 슬롯 찾기
	  const emptyIndex = saved.findIndex(item => !item.cardNo);
	  if (emptyIndex === -1) {
	    alert("장바구니에는 최대 3개의 카드만 담을 수 있습니다!");
	    return;
	  }

	  // 새 카드 추가
	  saved[emptyIndex] = { cardNo };

	  // 저장
	  localStorage.setItem("cartCards", JSON.stringify(saved));
	  alert("카드가 비교 바구니에 담겼습니다!");
	  
	  updateCartCnt();
  }
  window.addToCart = addToCart;
  });
  
  const showDetail =(cardNo)=>{
	  window.location.href = "${path}/views/cardMenu/fitCardDetail.jsp?cardNo="+cardNo;
  }
  
   

    
  </script>


</body>
</html>