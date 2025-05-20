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
		  <div class="card-info">
		    <div class="card-slot-placeholder">
		      <div class="card-slot-icon">+</div>
		      <div class="card-slot-text">카드를 선택해 주세요</div>
		    </div>
		  </div>
		</div>

	
		<div class="card-slot" onclick="openCardModal(1)">
		  <div class="card-info">
		    <div class="card-slot-placeholder">
		      <div class="card-slot-icon">+</div>
		      <div class="card-slot-text">카드를 선택해 주세요</div>
		    </div>
		  </div>
		</div>
	
		<div class="card-slot" onclick="openCardModal(2)">
		  <div class="card-info">
		    <div class="card-slot-placeholder">
		      <div class="card-slot-icon">+</div>
		      <div class="card-slot-text">카드를 선택해 주세요</div>
		    </div>
		  </div>
		</div>
		
		
	  </div>
	</div>

</div>

<!-- 카드 선택 모달 -->
<div id="cardModal" class="modal">
  <div class="modal-content">
    <button class="modal-close" onclick="closeModal()">&times;</button>
    <div class="modal-header">
      <h2 class="modal-title">비교할 카드를 선택해주세요</h2>
    </div>

    <!-- 카드사 필터 버튼 -->
    <div class="provider-buttons">
      <button class="provider-btn" data-provider="국민">국민</button>
      <button class="provider-btn" data-provider="기업">기업</button>
      <button class="provider-btn" data-provider="농협">농협</button>
      <button class="provider-btn" data-provider="롯데">롯데</button>
      <button class="provider-btn" data-provider="삼성">삼성</button>
      <button class="provider-btn" data-provider="신한">신한</button>
      <button class="provider-btn" data-provider="우리">우리</button>
      <button class="provider-btn" data-provider="하나">하나</button>
      <button class="provider-btn" data-provider="현대">현대</button>
    </div>

    <!-- 키워드 검색창 -->
    <div class="search-container">
      <input type="text" class="cart-search-input" placeholder="카드명을 입력하세요">
    </div>

    <!-- 카드 리스트 -->
    <div class="modal-card-list">
      <div class="modal-card-grid"></div>
    </div>
  </div>
</div>

<!-- footer -->
<jsp:include page="/views/common/footer.jsp" />

<script>
let currentSlot = 0;
const selectedCards = [{}, {}, {}];
//[1] 선택된 카드사 상태를 저장하는 전역 변수
let selectedProvider = "";

function openCardModal(slotIndex) {
  currentSlot = slotIndex;
  document.getElementById('cardModal').style.display = 'block';
  loadCardList();
}

function closeModal() {
  document.getElementById('cardModal').style.display = 'none';
}

function selectCard(slotIndex, cardNo) {
	  fetchCardDetail(slotIndex, cardNo);  // 저장은 여기서 하지 않음
	  closeModal();
	}

function updateCartCount() {
	  const count = selectedCards.filter(card => card.cardName).length;
	  const cartCountEl = document.querySelector(".cart-count");
	  if (cartCountEl) {
	    cartCountEl.textContent = count;
	  }
	}

//[4] 카드 리스트 로드 함수 수정 - 선택된 카드사까지 고려
async function loadCardList(keyword = "") {
	  console.log("현재 selectedProvider:", selectedProvider);
	  console.log("현재 keyword:", keyword);
	
	
	let methodName = "selectAll";

	if (keyword && keyword.trim() !== "") {
		  if (selectedProvider) {
		    methodName = "selectByProviderAndKeyword";
		  } else {
		    methodName = "selectByKeyword";
		  }
		} else if (selectedProvider) {
		  methodName = "selectByProvider";
		} else {
		  methodName = "selectAll";
		}
	  
  const params = new URLSearchParams({
    key: "cart",
    methodName: methodName
  });

  if (selectedProvider) params.append("provider", selectedProvider);
  if (keyword) params.append("keyword", keyword);

  try {
    const response = await fetch(`${path}/ajax?${'${params.toString()}'}`);
    if (!response.ok) throw new Error("서버 오류");
    const cards = await response.json();
    renderCardList(cards);
  } catch (err) {
    alert("카드 불러오기 실패: " + err.message);
  }
}

function renderCardList(cards) {
  const container = document.querySelector(".modal-card-grid");
  container.innerHTML = "";

  cards.forEach(card => {
    const item = document.createElement("div");
    item.className = "modal-card-item";
    item.innerHTML = `
      <img src="${path}/static/images/cards/\${card.cardImageUrl}" alt="${'${card.cardName}'}">
      <div>
        <div class="modal-card-name">\${card.cardName}</div>
        <div class="modal-card-company">\${card.provider}</div>
      </div>
    `;
    item.addEventListener("click", () => {
      selectCard(currentSlot, card.cardNo);
    });
    container.appendChild(item);
  });
}

async function loadCardByProvider(provider) {
  const params = new URLSearchParams({
    key: "cart",
    methodName: "selectByProvider",
    provider: provider
  });

  try {
    const response = await fetch(`${path}/ajax?${'${params.toString()}'}`);
    if (!response.ok) throw new Error("서버 오류");
    const cards = await response.json();
    renderCardList(cards);
  } catch (err) {
    alert("카드 불러오기 실패: " + err.message);
  }
}



// [2] 카드사 버튼 클릭 이벤트 수정
document.querySelectorAll(".provider-btn").forEach(btn => {
  btn.addEventListener("click", () => {
    const isActive = btn.classList.contains("active");

    // 이미 선택된 상태였다면 해제 (전체 보기로)
    if (isActive) {
      btn.classList.remove("active");
      selectedProvider = "";
      loadCardList(); // 전체 리스트 불러오기
    } else {
      document.querySelectorAll(".provider-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      selectedProvider = btn.dataset.provider;
      loadCardList(document.querySelector(".cart-search-input").value.trim()); // 현재 입력된 키워드로 필터링
    }
  });
});

//[3] 검색어 입력 이벤트 수정 (선택된 카드사와 함께 검색)
document.querySelector(".cart-search-input").addEventListener("input", (e) => {
  const keyword = e.target.value.trim();
  loadCardList(keyword); // 선택된 카드사 상태를 기반으로 검색
});


window.onclick = function(event) {
  const modal = document.getElementById('cardModal');
  if (event.target === modal) {
    closeModal();
  }
};

// 카드 상세 정보 불러오기
async function fetchCardDetail(slotIndex, cardNo) {
  const params = new URLSearchParams({
    key: "cart",
    methodName: "selectByCardNo",
    cardNo: cardNo
  });

  try {
    const response = await fetch(`${path}/ajax?${"${params.toString()}"}`);
    if (!response.ok) throw new Error("서버 오류");
    const card = await response.json();
    renderCardInSlot(slotIndex, card); // 슬롯에 카드 정보 표시
    selectedCards[slotIndex] = card; // 장바구니 상태 저장
    updateCartCount();
    
 	//카드 정보를 다 받은 후에만 localStorage에 저장
    localStorage.setItem("cartCards", JSON.stringify(
      selectedCards.map(c => c.cardNo ? { cardNo: c.cardNo } : {})
    ));
 	
  } catch (err) {
    alert("카드 정보를 불러오는 데 실패했습니다: " + err.message);
  }
}

//슬롯 제거 기능
function removeCard(slotIndex) {
  selectedCards[slotIndex] = {};
  const slot = document.querySelectorAll('.card-slot')[slotIndex];
  if (!slot) return;

  const infoArea = slot.querySelector('.card-info');
  if (!infoArea) return;

  infoArea.innerHTML = `
    <div class="card-slot-placeholder">
      <div class="card-slot-icon">+</div>
      <div class="card-slot-text">카드를 선택해 주세요</div>
    </div>
  `;

  updateCartCount(); // 여기에서만 호출
  infoArea.classList.remove("has-card");
  
  //카드 제거 시 localStorage 업데이트
  localStorage.setItem("cartCards", JSON.stringify(selectedCards));
}



// 슬롯에 카드 상세 정보 렌더링 (카드명/카드사/연회비/혜택)
function renderCardInSlot(slotIndex, card) {
  const slot = document.querySelectorAll('.card-slot')[slotIndex];
  if (!slot) return;

  const infoArea = slot.querySelector('.card-info');
  if (!infoArea) return;

  let benefits = "";
  if (card.cardBenefitList && card.cardBenefitList.length > 0) {
    benefits = card.cardBenefitList.map(b => `
      <div class="benefit-block">
        <div class="benefit-category-text">\${b.category}</div>
        <div class="benefit-description-text">\${b.category}에서 \${b.description}</div>
      </div>
    `).join("");
  } else {
    benefits = "<div class='benefit-block'><div class='benefit-category-text'>없음</div><div class='benefit-description-text'>혜택 정보 없음</div></div>";
  }

  infoArea.innerHTML = `
	  <div class="selected-card">
	    <div class="card-image-wrapper" style="background-image: url('${path}/static/images/cards/\${card.cardImageUrl}');"></div>
	    <div class="selected-card-name">\${card.cardName}</div>
	    <div class="selected-card-company">\${card.provider}</div>

	    <div class="card-detail-table">
	      <div class="detail-row">
	        <div class="detail-label">연회비</div>
	        <div class="detail-value">\${card.fee}</div>
	      </div>
	    </div>

	    <div class="benefit-section">
	      <div class="benefit-title">주요혜택</div>
	      \${benefits}
	    </div>
	  </div>
	`;

  //여기서 X 버튼 생성 및 삽입
  const removeBtn = document.createElement("button");
  removeBtn.className = "remove-btn";
  removeBtn.textContent = "×";
  removeBtn.addEventListener("click", function (event) {
    event.stopPropagation();
    removeCard(slotIndex);
  });
  infoArea.prepend(removeBtn);
  infoArea.classList.add("has-card");
  
  //선택된 카드 정보 localStorage에 저장
  localStorage.setItem("cartCards", JSON.stringify(selectedCards));
}

//페이지 로드 시 localStorage에 저장된 카드 자동 복원 (HTML 요소가 다 그려진 이후)
window.addEventListener("load", () => {
  const saved = localStorage.getItem("cartCards");
  if (saved) {
    const parsed = JSON.parse(saved);
    parsed.forEach((item, index) => {
      if (item && item.cardNo) {
        fetchCardDetail(index, item.cardNo); // ← 여기서 디테일 받아오기
      }
    });
  }
});


console.log("페이지 로드됨");
console.log("저장된 카드:", localStorage.getItem("cartCards"));
console.log("슬롯 DOM 수:", document.querySelectorAll(".card-slot").length);






</script>

</body>
</html>
