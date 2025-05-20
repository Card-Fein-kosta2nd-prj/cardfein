<%@page import="cardfein.kro.kr.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String path = request.getContextPath();
  LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
  int userNo = (loginUser != null) ? loginUser.getUserNo() : -1;
  String cardNo = request.getParameter("cardNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card:fein - 카드 상세 정보</title>
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/common.css">
	<!-- 페이지 전용 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/cardMenu/fitCardDetail.css">
	
	<!-- 공통 스크립트 -->
	<script src="${path}/static/js/common.js" defer></script>
</head>
<body>

	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />
	
	<div class="CardDetail-container">
	
	</div>
	
	<!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />
	
	<script type="text/javascript">
		const userNo = <%= userNo %>;
		const path = '<%= path %>';
		const ajaxUrl = `${path}/ajax`;
	</script>
	
	<script type="text/javascript">
		
		document.addEventListener("DOMContentLoaded", async () => {
			let cardDetailContainer = document.querySelector('.CardDetail-container');
			
			const cardNo = '<%= cardNo %>';
			
			try {
				const response = await fetch(ajaxUrl, {
					method: "POST",
					body: new URLSearchParams({
						key: "card",
						methodName: "getCardsDetail",
						cardNo: cardNo
					})
				});
				if (!response.ok) {
					throw new Error("서버 오류");
				}
				
				const cardDetail = await response.json();
				console.log("cardDetail: ", cardDetail);
				
				// 1. 이미지
		        const detailImg = document.createElement('img');
		        detailImg.classList.add('detail-img');
		        detailImg.src = "${path}/static/images/cards/" + cardDetail.cardImageUrl;
		        detailImg.alt = cardDetail.cardName;
		        cardDetailContainer.appendChild(detailImg);

		        // 2. 카드 헤더
		        const cardHeader = document.createElement('div');
		        cardHeader.classList.add('card-header');

		        const cardTitleCategory = document.createElement('p');
		        cardTitleCategory.classList.add('card-title-category');
		        cardTitleCategory.textContent = cardDetail.categoryName;
		        cardHeader.appendChild(cardTitleCategory);

		        const cardTitle = document.createElement('h1');
		        cardTitle.classList.add('card-title');
		        cardTitle.textContent = cardDetail.cardName;
		        cardHeader.appendChild(cardTitle);

		        cardDetailContainer.appendChild(cardHeader);

		     // 3. 카드 정보 (혜택 목록으로 변경)
		        const cardInfo = document.createElement('div');
		        cardInfo.classList.add('card-info');
		        const benefitsContainer = document.createElement('div');
		        benefitsContainer.classList.add('card-benefit-descriptions');
		        const benefitsTitle = document.createElement('h3');
		        benefitsTitle.textContent = '주요 혜택';
		        benefitsContainer.appendChild(benefitsTitle);

		        if (cardDetail.cardBenefitList && cardDetail.cardBenefitList.length > 0) {
		            const benefitsList = document.createElement('ul');
		            cardDetail.cardBenefitList.forEach(benefit => {
		                const listItem = document.createElement('li');
		                listItem.classList.add('benefit-item-box');
		                listItem.textContent = benefit.description;
		                benefitsList.appendChild(listItem);
		            });
		            benefitsContainer.appendChild(benefitsList);
		        }
		        cardInfo.appendChild(benefitsContainer); // cardInfo에 혜택 목록 컨테이너 추가
		        cardDetailContainer.appendChild(cardInfo);

		        // 4. 안내 문구
		        const cardNote = document.createElement('div');
		        cardNote.classList.add('card-note');
		        cardNote.textContent = cardDetail.provider + "카드 앱에서만 신청 가능합니다.";
		        cardDetailContainer.appendChild(cardNote);

		        // 5. 연회비
		        const cardFee = document.createElement('div');
		        cardFee.classList.add('card-fee');

		        const feeLabel = document.createElement('div');
		        feeLabel.classList.add('fee');
		        feeLabel.textContent = '연회비';
		        cardFee.appendChild(feeLabel);
		        
		        const feeValue = cardDetail.fee || "";
		        const feeParts = feeValue.split(',');
		        
		     // 국내 연회비 처리
		        const domesticFeePart = feeParts.find(part => part.includes('국내'));
		        if (domesticFeePart) {
		            const domesticFee = document.createElement('div');
		            domesticFee.classList.add('domestic');
		            domesticFee.textContent = domesticFeePart.trim();
		            cardFee.appendChild(domesticFee);
		        }

		        // 해외 연회비 처리
		        const overseasFeePart = feeParts.find(part => part.includes('해외'));
		        if (overseasFeePart) {
		            const overseasFee = document.createElement('div');
		            overseasFee.classList.add('overseas');
		            overseasFee.textContent = overseasFeePart.trim();
		            cardFee.appendChild(overseasFee);
		        }

		        if (domesticFeePart || overseasFeePart) {
		            cardDetailContainer.appendChild(cardFee);
		        }

		        // 6. (기존 혜택 목록 부분 삭제됨)

		    } catch (error) {
		        console.error("데이터를 가져오는 동안 오류 발생:", error);
		        cardDetailContainer.innerHTML = "<p>카드 상세 정보를 불러오는 데 실패했습니다.</p>";
		    }
		});
	
	</script>

</body>
</html>