<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- contextPath 변수 설정 --%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
								src="${pageContext.request.contextPath}/static/images/main/slide_chart.png"
								alt="카드 랭킹" class="carousel-img">
							<div class="carousel-text-box">
								<p class="carousel-text">
									실시간 인기카드부터<br> 카드사별, 혜택별 순위까지!<br> <br> 필요한 카드
									정보를 한눈에 확인하세요.
								</p>
							</div>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="carousel-item-horizontal">
							<img
								src="${pageContext.request.contextPath}/static/images/main/slide_ocr.png"
								alt="명세서 추천" class="carousel-img">
							<div class="carousel-text-box">
								<p class="carousel-text">
									내 소비 패턴을 분석해주는<br> 명세서 기반 카드 추천<br> <br> 한 장의
									명세서로 꼭 맞는 카드 찾기!
								</p>
							</div>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="carousel-item-horizontal">
							<img
								src="${pageContext.request.contextPath}/static/images/main/slide_customcover.png"
								alt="커스텀 카드" class="carousel-img">
							<div class="carousel-text-box">
								<p class="carousel-text">
									나만의 감성을 담은<br> 카드 커버 만들기<br> <br> 직접 꾸미고, 좋아요
									순위도 확인해보세요!
								</p>
							</div>
						</div>
					</div>
					<!-- 추가 슬라이드 -->
				</div>
				<!-- 네비게이션 버튼 -->
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
				<!-- 페이지네이션 -->
				<div class="swiper-pagination"></div>
			</div>
		</section>

		<!-- 사람들이 많이 살펴본 카드 -->
		<section class="card-section">
			<h2>🔎 사람들이 많이 살펴본 카드!</h2>
			<div class="card-view-list list"></div>
		</section>

		<!-- 사람들이 많이 가진 카드 -->
		<section class="card-section">
			<h2>💳 지금, 지갑에 가장 많이 지니고 있는 카드는?</h2>
			<div class="my-card-list list"></div>
		</section>

		<!-- 인기차트 -->
		<section class="popular-chart-section">
			<h2>혜택별 인기 차트</h2>


			<!-- 탭 콘텐츠 영역 -->
			<div class="chart-tab-contents">
				<div class="chart-content">
					<div class="chart-box" id="문화/여가">
						<h3>문화/여가 TOP10</h3>
						<ol id="category-0">

						</ol>
						<button class="btn-more">차트 더보기</button>
					</div>

					<div class="chart-box" id="쇼핑">
						<h3>쇼핑 TOP10</h3>
						<ol id="category-1">
							<li><img src="static/images/cards/redcard.png"> 신한카드
								Mr.Life</li>
							<li><img src="static/images/cards/pinkcard.png"> 삼성카드
								taptap O</li>
							<li><img src="static/images/cards/blackcard.png"> KB국민
								My WE:SH</li>
							<li>LOCA 365 카드</li>
						</ol>
						<button class="btn-more">차트 더보기</button>
					</div>
					<div class="chart-box" id="통신/디지털">
						<h3>통신 TOP10</h3>
						<ol id="category-2">
							<li><img src="static/images/cards/redcard.png"> 신한카드
								Mr.Life</li>
							<li><img src="static/images/cards/pinkcard.png"> 삼성카드
								taptap O</li>
							<li><img src="static/images/cards/blackcard.png"> KB국민
								My WE:SH</li>
							<li>LOCA 365 카드</li>
						</ol>
						<button class="btn-more">차트 더보기</button>
					</div>
					<div class="chart-box" id="외식">
						<h3>외식 TOP10</h3>
						<ol id="category-3">
							<li><img src="static/images/cards/redcard.png"> 신한카드
								Mr.Life</li>
							<li><img src="static/images/cards/pinkcard.png"> 삼성카드
								taptap O</li>
							<li><img src="static/images/cards/blackcard.png"> KB국민
								My WE:SH</li>
							<li>LOCA 365 카드</li>
						</ol>
						<button class="btn-more">차트 더보기</button>
					</div>
				</div>
			</div>
		</section>

		<!-- 카드 투표 -->
		<section class="vote-ranking-section">
			<h2>🎖️ 당신의 카드에 투표하세요</h2>
			<div class="podium-wrapper">
				<!-- 2위 카드 -->
				<div class="podium-card second">
					<img src="static/images/cards/card2.png" alt="2위카드" />
					<div class="rank">2위</div>
					<div class="card-name">녹색카드</div>
					<div class="provider">신한카드</div>
				</div>

				<!-- 1위 카드 -->
				<div class="podium-card first">
					<img src="static/images/cards/card1.png" alt="1위카드" />
					<div class="rank star">1위⭐</div>
					<div class="card-name">아메리카카드</div>
					<div class="provider">카드사</div>
				</div>

				<!-- 3위 카드 -->
				<div class="podium-card third">
					<img src="static/images/cards/card3.png" alt="3위카드" />
					<div class="rank">3위</div>
					<div class="card-name">노란카드</div>
					<div class="provider">현대카드</div>
				</div>
			</div>

			<!-- ✅ 투표하러 가기 버튼 -->
			<a href="\${path}/views/vote/vote.jsp" class="vote-btn">투표하러 가기</a>
		</section>
	</main>

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
					<img src="static/images/cards/\${card.cardImageUrl}" alt="카드이미지">
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
			console.log(result);
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
		
		document.addEventListener("DOMContentLoaded", () => {
			  viewCardList();
			  myCardList();
			  popularList(); // ✅ DOM이 다 로드된 뒤에 실행되도록
			 
			});
	</script>

</body>
</html>
