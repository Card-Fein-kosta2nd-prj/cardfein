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
<meta charset="UTF-8">
<title>Card:fein - 맞춤카드 검색</title>
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/common.css">
	<!-- 페이지 전용 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/cardMenu/fitCard.css" defer>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
	
	<!-- 공통 스크립트 -->
	<script src="${path}/static/js/common.js" defer></script>

</head>
<body>

	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />



    <div class="fitCard-container">
      <div class="search-header">
        <h1>맞춤카드 검색</h1>

        <div class="filter-container">
          <div class="filter-tag active" data-category="통신/디지털">통신/디지털</div>
          <div class="filter-tag" data-category="주유">주유</div>
          <div class="filter-tag" data-category="병원/약국">병원/약국</div>
          <div class="filter-tag" data-category="항공/여행">항공/여행</div>
          <div class="filter-tag" data-category="커피">커피</div>
          <div class="filter-tag" data-category="편의점/마트">편의점/마트</div>
          <div class="filter-tag" data-category="문화/여가">문화/여가</div>
          <div class="filter-tag" data-category="외식">외식</div>
          <div class="filter-tag" data-category="교통">교통</div>
          <div class="filter-tag" data-category="쇼핑">쇼핑</div>
        </div>
      </div>

      <div class="card-list">
        <!-- 첫 번째 카드 아이템 -->
      
      </div>
    </div>
    
    
    
    <!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />
	
	<script type="text/javascript">
    	const userNo = <%= userNo %>;
    	const path = '<%= path %>';
    	const ajaxUrl = `${path}/ajax`;
    </script>

    <script>
    	document.addEventListener('DOMContentLoaded', () => {
    		const filterContainer = document.querySelector('.filter-container');
    		const cardListContainer = document.querySelector('.card-list');
    		const filterTags = filterContainer.querySelectorAll('.filter-tag');
    		
    		filterTags.forEach(tag => {
    			tag.addEventListener('click', async function() {
    				// 모든 filter-tag에서 'active' 클래스 제거
    				filterTags.forEach(t => t.classList.remove('active'));
    				this.classList.add('active');
    				
    				const category = this.getAttribute('data-category');
    				
    				try {
    					const response = await fetch(ajaxUrl, {
    						method: "POST",
    						body: new URLSearchParams({
    							key: "card",
    							methodName: "getCardsByCategory",
    							category: category
    						})
    					});
    					
    					if (!response.ok) {
    						throw new Error("서버 상태");
    					}
    					
    					const cards = await response.json();
    					console.log("cards: ", cards);
    					displayCards(cards);
    				} catch (error) {
    					console.error("카드 정보 요청 실패: ", error);
    					cardListContainer.innerHTML = '<p>카드 정보를 불러오는 데 실패했습니다.</p>';
    				}
    			});
    		});
    		
    		// 초기 로딩 시 'active' 상태인 필터의 카드 정보를 불러오기
    		const activeFilter = filterContainer.querySelector('.filter-tag.active');
    		if (activeFilter) {
    			activeFilter.click();
    		}
    		
    		function displayCards(cards) {
    			// 기본 카드 목록 비우기
    			cardListContainer.innerHTML = "";
    			
    			if (cards && cards.length > 0) {
    				cards.forEach(card => {
    					const cardItem = document.createElement("div");
    					cardItem.classList.add("card-item");
    					cardItem.style.cursor = "pointer";
    					cardItem.addEventListener("click", async () => {
    						// 서버에 cardNo를 보내서 view 카운트 증가 요청
    						try {
    							const viewResponse = await fetch(ajaxUrl, {
    								method: "POST",
    								body: new URLSearchParams({
    									key: "card",
    									methodName: "incrementCardView",
    									cardNo: card.cardNo
    								})
    							});
    							if (!viewResponse.ok) {
    								const errorText = await response.text();
    								throw new Error("서버 오류", errorText);
    							}
    							
    							const data = await viewResponse.json();
    							console.log("view 증가 성공 여부: ", data);
    							
    							if (data) {
    								window.location.href = "${path}/views/cardMenu/fitCardDetail.jsp?cardNo="+card.cardNo;
    							} else {
    								console.error("조회수 증가 실패");
    							}
    							
    						} catch (error) {
    							console.error(error);
    						}
    					})

    					const cardInfo = document.createElement("div");
    					cardInfo.classList.add("card-info");
    					cardItem.appendChild(cardInfo);

    					const cardImageDiv = document.createElement("div");
    					cardImageDiv.classList.add("card-image");
    					const cardImage = document.createElement("img");
    					cardImage.src = "${path}/static/images/cards/"+card.cardImageUrl;
    					cardImage.alt = card.cardName;
    					cardImageDiv.appendChild(cardImage);
    					cardInfo.appendChild(cardImageDiv);

    					const cardTitleContainer = document.createElement("div");
    					cardTitleContainer.classList.add("card-title-container");
    					const cardTitle = document.createElement("h2");
    					cardTitle.classList.add("card-title");
    					cardTitle.textContent = card.cardName;
    					const cardSubtitle = document.createElement("p");
    					cardSubtitle.classList.add("card-subtitle");
    					cardSubtitle.textContent = card.provider;
    					cardTitleContainer.appendChild(cardTitle);
    					cardTitleContainer.appendChild(cardSubtitle);
    					cardInfo.appendChild(cardTitleContainer);

    					const cardTagContainer = document.createElement("div");
    					cardTagContainer.classList.add("card-tag-container");
    					
    					const benefitCategoryTag = document.createElement("span");
    					benefitCategoryTag.classList.add("card-tag", "highlight"); // 🔥 강조 클래스 추가
    					benefitCategoryTag.textContent = card.cardBenefit ? card.cardBenefit.category : "";
    					
    					const benefitDescriptionTag = document.createElement("span");
    					benefitDescriptionTag.classList.add("card-tag");
    					benefitDescriptionTag.textContent = card.cardBenefit ? card.cardBenefit.description : "";
    					
    					cardTagContainer.appendChild(benefitCategoryTag);
    					cardTagContainer.appendChild(benefitDescriptionTag);
    					cardInfo.appendChild(cardTagContainer);

    					const feeTagContainer = document.createElement("div");
    					feeTagContainer.classList.add("card-tag-container");
    					
    					const feeTag = document.createElement("span");
    					feeTag.classList.add("card-tag");
    					feeTag.textContent = "연회비 "+ card.fee;
    					
    					feeTagContainer.appendChild(feeTag);
    					cardInfo.appendChild(feeTagContainer);

    					cardListContainer.appendChild(cardItem);
    					console.log("card: ", card);
    				});
    			} else {
    				cardListContainer.innerHTML = '<p>해당 조건에 맞는 카드가 없습니다.</p>'; 
    			}
    			
    		}
    	})  
    
    </script>
  </body>
</html>