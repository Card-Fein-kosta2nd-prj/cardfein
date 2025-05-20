<%@page import="cardfein.kro.kr.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String path = request.getContextPath();
  LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>Card:fein - 내 손안의 카드비서</title>

<!-- 공통 스타일 -->
<link rel="stylesheet" href="${path}/static/css/common.css" />

<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="${path}/static/css/main.css" />
<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js" defer></script>
<!-- 페이지 전용 스크립트 -->
<script src="${path}/static/js/main.js" defer></script>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<style>
main {
	padding: 40px 20px;
	max-width: 1200px;
	margin: 0 auto;
}

.banner-section, .swiper-container {
	position: relative;
	z-index: 1; /* ↓ header보다 낮게 유지 */
}
.btn-more {
	display: block;
	text-align: center;
	text-decoration: none;
	background-color: black;
	color: white;
	padding: 12px 0;
	border-radius: 8px;
	margin-top: 10px;
}
</style>
</head>
<body>

	<!-- ✅ 공통 header 포함 -->
	<jsp:include page="/views/common/header.jsp" />

	<!-- ✅ 메인 콘텐츠 -->
	<main class="main-container">
		<!-- 카드 추천 테스트 배너 -->
		<section class="banner-section">
		  <div class="swiper-container">
		    <div class="swiper-wrapper">
		
		      <div class="swiper-slide">
		        <div class="carousel-item-horizontal">
		          <img
		            src="${path}/static/images/main/slide_chart.png"
		            alt="카드 랭킹" class="carousel-img">
		          <div class="carousel-text-box">
		            <h3 class="carousel-heading">실시간 인기카드부터</h3>
		            <p class="carousel-subtext">카드사별, 혜택별 순위까지!</p>
		            <p class="carousel-desc">필요한 카드 정보를<br>한눈에 확인하세요.</p>
		          </div>
		        </div>
		      </div>
		
		      <div class="swiper-slide">
		        <div class="carousel-item-horizontal">
		          <img
		            src="${path}/static/images/main/slide_ocr.png"
		            alt="명세서 추천" class="carousel-img">
		          <div class="carousel-text-box">
		            <h3 class="carousel-heading">내 소비 패턴을 분석해주는</h3>
		            <p class="carousel-subtext">명세서 기반 카드 추천</p>
		            <p class="carousel-desc">한 장의 명세서로<br>꼭 맞는 카드 찾기!</p>
		          </div>
		        </div>
		      </div>
		
		      <div class="swiper-slide">
		        <div class="carousel-item-horizontal">
		          <img
		            src="${path}/static/images/main/slide_customcover.png"
		            alt="커스텀 카드" class="carousel-img">
		          <div class="carousel-text-box">
		            <h3 class="carousel-heading">나만의 감성을 담은</h3>
		            <p class="carousel-subtext">카드 커버 만들기</p>
		            <p class="carousel-desc">직접 꾸미고, 좋아요<br>순위도 확인해보세요!</p>
		          </div>
		        </div>
		      </div>
		
		    </div>
		    <!-- 네비게이션/페이지네이션은 그대로 유지 -->
		    <div class="swiper-button-next"></div>
		    <div class="swiper-button-prev"></div>
		    <div class="swiper-pagination"></div>
		  </div>
		</section>

		<!-- 사람들이 많이 살펴본 카드 -->
		<section class="card-section">
			<h2>사람들이 많이 살펴본 카드!</h2>
			<div class="card-view-list list"></div>
		</section>

		<!-- 사람들이 많이 가진 카드 -->
		<section class="card-section card-own">
		  <div class="inner-wrapper">
		    <h2>지금, 지갑에 가장 많이 지니고 있는 카드는?</h2>
			<div class="my-card-list list"></div>
		  </div>
		</section>

		<!-- 인기차트 -->
		<section class="popular-chart-section">
		  <h2>혜택별 인기 차트</h2>
		  <div class="chart-grid">
		    <div class="chart-box" id="문화/여가">
		      <h3>문화/여가 TOP10</h3>
		      <ol id="category-0"></ol>
		      <button class="btn-more" onclick="window.location.href='${path}/views/ranking/benefit_rank.jsp'">차트 더보기</button>
		    </div>
		    <div class="chart-box" id="쇼핑">
		      <h3>쇼핑 TOP10</h3>
		      <ol id="category-1"></ol>
		      <button class="btn-more" onclick="window.location.href='${path}/views/ranking/benefit_rank.jsp'">차트 더보기</button>
		    </div>
		    <div class="chart-box" id="통신">
		      <h3>통신/디지털 TOP10</h3>
		      <ol id="category-2"></ol>
		      <button class="btn-more" onclick="window.location.href='${path}/views/ranking/benefit_rank.jsp'">차트 더보기</button>
		    </div>
		    <div class="chart-box" id="외식">
		      <h3>외식 TOP10</h3>
		      <ol id="category-3"></ol>
		      <button class="btn-more" onclick="window.location.href='${path}/views/ranking/benefit_rank.jsp'">차트 더보기</button>
		    </div>
		  </div>
		</section>


	</main>
	
			<!-- 카드 투표 -->
		<section class="vote-ranking-section">
			<h2>당신의 카드에 투표하세요</h2>
			<p>베스트 커스텀 카드를 뽑아주세요!</p>
			<a href="${path}/views/cardCover/cardranking.jsp" class="vote-btn">투표하러 가기</a>
			<div class="podium-wrapper">
				
			</div>

			<!-- ✅ 투표하러 가기 버튼 -->
		</section>

	<!-- ✅ 공통 footer 포함 -->
	<jsp:include page="/views/common/footer.jsp" />

	<script>
		const swiper = new Swiper('.swiper-container', {
			loop : true,
			autoplay : {
				delay : 3000,
			},
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},
			pagination : {
				el : '.swiper-pagination',
				clickable : true,
			},
		});

		const printData=(cardList)=>{
			let content = '';
			cardList.forEach(card => {
				content += `<div class="card-item">
					<div class="card-image-box">
					<a onclick="showDetails(\${card.cardNo})"><img src="static/images/cards/\${card.cardImageUrl}" alt="카드이미지" onload="handleImageLoad(this)"></a>
					</div>
					<div class="card-name">\${card.cardName}</div>
					<div class="card-brand">\${card.provider}</div>
				</div>`;
			});
			return content;
		};
		const viewCardList = async()=>{
			let response = await fetch("${path}/ajax",{
				 method: "POST",
		         body: new URLSearchParams({
		           key: "main",
		           methodName: "selectViewList"
				})
			});
			let result = await response.json();
			
			document.querySelector(".card-view-list").innerHTML=printData(result);
		}
		const myCardList = async()=>{
			let response = await fetch("${path}/ajax",{
				 method: "POST",
		         body: new URLSearchParams({
		           key: "main",
		           methodName: "selectMyCardList"
				})
			});
			let result = await response.json();
			document.querySelector(".my-card-list").innerHTML=printData(result);
		}	
		const category=['문화/여가','쇼핑','통신/디지털','외식'];
		//인기차트
		const popularList = async()=>{
			response = await fetch("${path}/ajax",{
				 method: "POST",
		         body: new URLSearchParams({
		           key: "main",
		           methodName: "selectPopularList"
				})
			});
			let result = await response.json();
			category.forEach((c,idx)=>{
				let content='';
				result.forEach((card)=>{
					if(c===card.cardBenefit.category){
						content+=`<li><img src="static/images/cards/\${card.cardImageUrl}">\${card.cardNo} \${card.cardName}</li>`;
					}
				});
				document.getElementById(`category-\${idx}`).innerHTML=content;
			});
		}
		async function loadTopRankedCards() {
  		  try {
  		    const fetchResponse = await fetch("${path}/ajax", {
  		      method: "POST",
  		      body: new URLSearchParams({
  		        key: "rank",
  		        methodName: "getTopCardCovers",
  		      }),
  		    });

  		    if (!fetchResponse.ok) {
  		      throw new Error("서버 응답 오류");
  		    }

  		    const topCards = await fetchResponse.json();
  		    console.log("topCards : ", topCards);
  		    const podiumWrapper = document.querySelector(".podium-wrapper");
  		    podiumWrapper.innerHTML = "";
	  		const rankClassMap = {
		    		1: 'first',
		    		2: 'second',
		    		3: 'third'
		    };
	  		
	  		const top3Cards = topCards.slice(0, 3);

  		    top3Cards.forEach((card) => {
  		      const rankedCardItem = document.createElement('div');
  		      rankedCardItem.classList.add('ranked-card-item');
  		      
  		      const rankClass = rankClassMap[card.cardRank];
		        if (rankClass) {
		    	    rankedCardItem.classList.add(rankClass);
		        }
  		      
  		      const imgContainer = document.createElement("div");
  		      imgContainer.classList.add("img-container");
  		      
	  		  const podiumImg = document.createElement("img");
	  		  podiumImg.src = card.finalCardUrl;
	  		  podiumImg.classList.add("podium-img");

		      const overlayImg = document.createElement("img");
		      overlayImg.src = `${path}/static/images/small_top.png`;
		      overlayImg.alt = "Overlay";
		      overlayImg.classList.add("rank-overlay");
		      
		      imgContainer.appendChild(podiumImg);
		      imgContainer.appendChild(overlayImg);
		      rankedCardItem.appendChild(imgContainer);
		      
		      // 카드 생성 및 랭킹에 따른 추가 클래스 부여
		      const podiumCard = document.createElement("div");
		      podiumCard.classList.add('podium-card');
		      
		      // 랭크 표시
			  const rankDiv = document.createElement('div');
			  rankDiv.classList.add('rank');
			  if (card.cardRank === 1) {
				  rankDiv.classList.add('star');
				  rankDiv.textContent = card.cardRank+"위⭐";
			  } else {
				  rankDiv.textContent = card.cardRank+"위";
			  }
			  podiumCard.appendChild(rankDiv);
			  
			  const cardNameDiv = document.createElement('div');
			  cardNameDiv.classList.add('card-name');
			  cardNameDiv.textContent = card.title;
			  podiumCard.appendChild(cardNameDiv);
			  
			  rankedCardItem.appendChild(podiumCard);
			  podiumWrapper.appendChild(rankedCardItem);
			  		      
  		    });
  		  } catch (error) {
  		    console.error("인기 카드 로드 실패:", error);
  		  }
  		}
		
		const showDetails=(cardNo)=>{
			 window.location.href = "${path}/views/cardMenu/fitCardDetail.jsp?cardNo="+cardNo;
		}
		
		document.addEventListener("DOMContentLoaded", () => {
			  viewCardList();
			  myCardList();
			  popularList(); // ✅ DOM이 다 로드된 뒤에 실행되도록
			  loadTopRankedCards();
			 
			});
		const handleImageLoad=(img)=> {
			  const ratio = img.naturalHeight / img.naturalWidth;
			  if (ratio > 1.3) {
			    img.classList.add('vertical');
			  }
			}
		
		document.addEventListener("DOMContentLoaded", () => {
			  document.querySelectorAll(".card-image-box img").forEach(img => {
			    if (img.complete) {
			      handleImageLoad(img);
			    }
			  });
			});
		
		// JS 예시 (적용 시)
		document.querySelectorAll('.card-item').forEach(card => {
		  const inner = card.querySelector('.card-image-box-inner');
		  card.addEventListener('mousemove', (e) => {
		    const rect = card.getBoundingClientRect();
		    const x = (e.clientX - rect.left) / rect.width - 0.5;
		    const y = (e.clientY - rect.top) / rect.height - 0.5;
		    inner.style.transform = `rotateX(${y * 10}deg) rotateY(${x * 10}deg)`;
		  });
		  card.addEventListener('mouseleave', () => {
		    inner.style.transform = 'rotateX(0deg) rotateY(0deg)';
		  });
		});

		
	</script>
	
	  <!-- 로그인/로그아웃 후 장바구니 초기화 -->
	<% if (session.getAttribute("justLoggedIn") != null) {
	     session.removeAttribute("justLoggedIn");
	%>
	<script>
	  document.addEventListener("DOMContentLoaded", function() {
	    localStorage.removeItem("cartCards");
	    console.log("로그인 후 localStorage 초기화됨");
	  });
	</script>
	<% } %>
	
	<% if (session.getAttribute("justLoggedOut") != null) {
	     session.removeAttribute("justLoggedOut");
	%>
	<script>
	  document.addEventListener("DOMContentLoaded", function() {
	    localStorage.removeItem("cartCards");
	    console.log("로그아웃 후 localStorage 초기화됨");
	  });
	</script>
	<% } %>




</body>
</html>