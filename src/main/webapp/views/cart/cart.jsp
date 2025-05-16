<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card:fein - 장바구니</title>

	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/common.css">
	<!-- 페이지 전용 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/cart/cart.css" defer>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
	
	<!-- 공통 스크립트 -->
	<script src="${path}/static/js/common.js" defer></script>
	
</head>
 <body>
 
	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />
	
	
	
    <div class="cart-container">
      <h1>비교할 카드를 선택해 주세요</h1>
      
      <div class="comparison-container">
        <div class="card-slots">
          <div class="card-slot" onclick="openCardModal(0)">
            <div class="card-slot-icon">+</div>
            <div class="card-slot-text">카드를 선택해 주세요</div>
          </div>
          
          <div class="card-slot" onclick="openCardModal(1)">
            <div class="card-slot-icon">+</div>
            <div class="card-slot-text">카드를 선택해 주세요</div>
          </div>
          
          <div class="card-slot" onclick="openCardModal(2)">
            <div class="card-slot-icon">+</div>
            <div class="card-slot-text">카드를 선택해 주세요</div>
          </div>
        </div>
      </div>
      
    </div>
    
    <!-- 카드 선택 모달 -->
    <div id="cardModal" class="modal">
      <div class="modal-content">
        <button class="modal-close" onclick="closeModal()">&times;</button>
        <div class="modal-header">
          <div class="modal-title">비교할 카드를 선택해 주세요</div>
        </div>
        <div class="modal-card-grid">
          <div class="modal-card-item" onclick="selectCard(0, 'American Express The Platinum Card', '아메리칸 익스프레스')">
            <div class="modal-card-name">American Express The Platinum Card</div>
            <div class="modal-card-company">아메리칸 익스프레스</div>
          </div>
          <div class="modal-card-item" onclick="selectCard(0, 'LOCA LIKIT 1.2', '롯데카드')">
            <div class="modal-card-name">LOCA LIKIT 1.2</div>
            <div class="modal-card-company">롯데카드</div>
          </div>
          <div class="modal-card-item" onclick="selectCard(0, '현대카드ZERO Edition3', '현대카드')">
            <div class="modal-card-name">현대카드ZERO Edition3</div>
            <div class="modal-card-company">현대카드</div>
          </div>
          <div class="modal-card-item" onclick="selectCard(0, '신한카드 Deep Dream', '신한카드')">
            <div class="modal-card-name">신한카드 Deep Dream</div>
            <div class="modal-card-company">신한카드</div>
          </div>
        </div>
        <div class="modal-footer">
          <button class="cancel-button" onclick="closeModal()">취소</button>
        </div>
      </div>
    </div>
    
    
        
    <!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />
	
	
	
    <script>
      let currentSlot = 0;
      const selectedCards = [{}, {}, {}];
      
      function openCardModal(slotIndex) {
        currentSlot = slotIndex;
        document.querySelectorAll('.modal-card-item').forEach(item => {
          // 모달 안의 카드 선택 함수의 슬롯 인덱스 업데이트
          const onclick = item.getAttribute('onclick');
          if (onclick) {
            const newOnclick = onclick.replace(/selectCard\(\d+,/, `selectCard(${slotIndex},`);
            item.setAttribute('onclick', newOnclick);
          }
        });
        document.getElementById('cardModal').style.display = 'block';
      }
      
      function closeModal() {
        document.getElementById('cardModal').style.display = 'none';
      }
      
      function selectCard(slotIndex, cardName, company) {
        // 선택한 카드 정보 저장
        selectedCards[slotIndex] = { name: cardName, company: company };
        
        // 슬롯 업데이트
        const slot = document.querySelectorAll('.card-slot')[slotIndex];
        slot.innerHTML = `
          <div class="selected-card">
            <div class="selected-card-name">${cardName}</div>
            <div class="selected-card-company">${company}</div>
          </div>
        `;
        
        closeModal();
      }
      
      // 모달 외부 클릭 시 닫기
      window.onclick = function(event) {
        const modal = document.getElementById('cardModal');
        if (event.target == modal) {
          closeModal();
        }
      }
    </script>
  </body>
</html>