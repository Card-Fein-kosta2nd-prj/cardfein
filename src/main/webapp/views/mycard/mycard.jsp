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
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Card:fein - 내카드 등록하기</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- 공통 스타일 -->
<link rel="stylesheet"
	href="${path}/static/css/common.css">
<!-- 페이지 전용 스타일 -->
<link rel="stylesheet"
	href="${path}/static/css/mycard/mycard.css">

<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js"
	defer></script>
<!-- 페이지 전용 스크립트 -->
</head>
<body>
	<!-- header -->
	<jsp:include page="../../views/common/header.jsp" />

	<!-- 메인 콘텐츠 -->
	<main class="card-register-container">
		<section class="my-cards-section">
			<div class="inner-wrapper">
				<div class="mycard-header">
					<h2>📌내 카드 목록</h2>
					<button id="openModalBtn" class="register-toggle-btn">+ 내
						카드 등록하기</button>
				</div>
				<div class="draw-cards"></div>
			</div>
		</section>
		<section class="chart-section">
			<div class="inner-wrapper">
				<h2>📊 누적 소비 기반 카드 매칭율 변화</h2>
				<canvas id="lineChart" height="100"></canvas>
			</div>
		</section>

		<div id="tooltipImage"
			style="position: absolute; display: none; z-index: 9999; border: 1px solid #ccc; background-color: white; padding: 4px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);">
			<img id="tooltipImageTag" src="" alt="카드 이미지"
				style="width: 160px; height: auto;" />
		</div>
		

		<!-- 모달 팝업 -->
		<div id="searchModal" class="modal-overlay" style="display: none;">
			<div class="modal-content">
				<button class="modal-close" id="closeModalBtn">×</button>
				<h2>💳 내 카드 등록하기</h2>
				<p class="section-desc">등록할 카드명을 입력하세요. 존재하지 않는 카드는 1:1 문의를 통해
					추가 요청할 수 있습니다.</p>

				<input type="text" placeholder="카드명을 입력해주세요." id="keyword"
					onkeyup="search(event)" />
				<div class="card_list"></div>

				<div class="inquiry-form" id="inquiryForm" style="display: none;">
					<h3>❓ 카드가 DB에 없습니다</h3>
					<p>입력한 카드를 등록 요청하시겠어요? 아래 내용을 확인 후 1:1 문의를 남겨주세요.</p>
					<textarea id="inquiryContent" rows="4">카드명: </textarea>
					<button onclick="submitInquiry()">1:1 문의 등록</button>
				</div>
			</div>
		</div>

	</main>

	<!-- footer -->
	<jsp:include page="../../views/common/footer.jsp" />

	<script>
	let printList = document.querySelector(".card_list");
	let inquiryForm = document.getElementById('inquiryForm');
	let inquiryContent = document.getElementById('inquiryContent');
	let input = document.querySelector("#keyword");
	let matchChart = null;
	let mycards = document.querySelector(".draw-cards");
	const openModalBtn = document.getElementById("openModalBtn");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const searchModal = document.getElementById("searchModal");
	const closeModal = () => {
	  searchModal.style.display = "none";
	  document.body.style.overflow = "auto";
	};
	const search = async(e)=>{
		inquiryForm.style.display = 'none';
		if(!e.target.value) { 
			printList.innerHTML ='';
			return;
		}
        printList.innerHTML=`
		<table>
			<thead>
				<th>카드명</th>
				<th>카드사</th>
				<th></th>
			</thead>
			<tbody id="cards">
			</tbody>
		</table>
		`;
		let response = await fetch("${path}/ajax",{
          method :"POST",
          body:new URLSearchParams({
            key:"mycard",
		    methodName:"selectCard",
            word : e.target.value
            })
        });
		
        let result = await response.json();
        
        console.log(result);
		if(result.length===0){
			inquiryForm.style.display = 'block';
			inquiryContent.value = `카드명: \${e.target.value}\n카드 추가 요청드립니다.`;
			return;
		}
        printData(result);
    };
	const printData=(cardList)=>{
		let content = '';
		cardList.forEach(card => {
			content += `<tr>
				  <td class="card-name-cell" data-img="${path}/static/images/cards/\${card.cardImageUrl}">
				    \${card.cardName}
				  </td>
				  <td>\${card.provider}</td>
				  <td><button id="\${card.cardNo}" onclick="register(this.id)">등록</button></td>
				</tr>`;
		});
		document.getElementById("cards").innerHTML=content;
	};
	const register= async(cardNo)=>{
		let response = await fetch("${path}/ajax",{
	          method :"POST",
	          body:new URLSearchParams({
	            key:"mycard",
			    methodName:"registerCard",
	            cardNo
	            })
	        });
		let result = await response.json();
		if(result===1) {alert('카드가 등록 되었습니다.');
		input.value= '';
		printList.innerHTML='';
		 closeModal();
		drawTrend();
		 printMyCards();
		}
	};
	
	const submitInquiry=async()=>{
		let content = inquiryContent.value;
		let response = await fetch("${path}/ajax",{
			method :"POST",
	          body:new URLSearchParams({
	            key:"mycard",
			    methodName:"submitInquiry",
			    content
	            })
		});
		let result = await response.json();
		if(result===1) alert('문의가 등록 되었습니다.');
		input.value= '';
		printList.innerHTML='';
	};
	
	const lineCtx = document.getElementById('lineChart').getContext('2d');
    const drawTrend =async()=>{
    	let response = await fetch("${path}/ajax",{
    		method :"POST",
	          body:new URLSearchParams({
	            key:"mycard",
			    methodName:"matchingTrend"})
    	});
    	let result = await response.json();
    	let labels = result.DateSet;
    	let matchHistory = result.matchTrend;
    	
    	
    	const datasets = Object.entries(matchHistory).map(([cardName, dateRateMap]) => {
    		let data = labels.map(date => dateRateMap[date] ?? 0); // 누락된 월은 0 처리
    		let avg = (data.reduce((a, b) => a + b, 0) / data.length).toFixed(1);
    		return {
    			label: `\${cardName} (평균 \${avg}%)`,
    			data: data, //매칭율
    			borderWidth: 2,
    			tension: 0.3
    		};
    	});
    	
    	 if (matchChart) {
    	        // 이미 생성된 차트가 있다면 데이터만 갱신
    	        matchChart.data.labels = labels;
    	        matchChart.data.datasets = datasets;
    	        matchChart.update();
    	    } else {
    	        // 없으면 새로 생성
    	        matchChart = new Chart(document.getElementById('lineChart').getContext('2d'), {
    	            type: 'line',
    	            data: {
    	                labels: labels,
    	                datasets: datasets
    	            },
    	            options: {
    	                plugins: {
    	                    title: { display: false }
    	                },
    	                scales: {
    	                    y: { beginAtZero: true, max: 100 }
    	                }
    	            }
    	        });
    	    }
    	
    };
    const printMyCards = async()=>{
    	let response = await fetch("${path}/ajax",{
	          method :"POST",
	          body:new URLSearchParams({
	            key:"mycard",
			    methodName:"selectMyCards"
	            })
	        });
		let result = await response.json();
		console.log(result);
		let lists='';
		const cardNos =  Object.keys(result);
		cardNos.forEach(cardNo => {
			let cardName = result[cardNo].cardName;
			let discount = result[cardNo].discount;
			let img=result[cardNo].cardImageUrl;
			let disList='';
			discount.forEach((item)=>{
				disList+=`☑️ \${item}% 할인<br>`
			});
			
				
				lists+=`
				<div class="card-box" id="card\${cardNo}">
				 <div class="card-top">
				 <div class="card-img-box">
			      <img src="${path}/static/images/cards/\${img}" class="card-img" alt="카드 이미지" />
			    	  </div>  
			      <div class="card-info">
			        <h3>\${cardName}</h3>
			        <div class="benefit">\${disList}</div>
			      </div>
			      </div>
			      <div class="btn-group">
		          <button class="btn-sm btn-detail" onclick="showDetail(\${cardNo})">상세 보기</button>
		          <button class="btn-sm btn-compare" onclick="addToCart(\${cardNo})">비교바구니담기</button>
		          <button class="btn-sm btn-delete" onclick="deleteCard('\${cardNo}')">삭제</button>
		        </div>
			    </div>
			`;
			
		});

		mycards.innerHTML=lists;
		
    }
    
    const deleteCard=async(cardNo)=> {
    	if (!confirm("이 카드를 삭제하시겠습니까?")) return;
    	let response = await fetch("${path}/ajax", {
            method: "POST",
            body: new URLSearchParams({
                key: "mycard",
                methodName: "deleteMyCard",
                cardNo
            })
        });

        let result = await response.json();
        if (result === 1) {
            alert("카드가 삭제되었습니다.");
            printMyCards();   
            drawTrend();      
        } else {
            alert("삭제에 실패했습니다. 다시 시도해주세요.");
        }
      }
    printMyCards();
    drawTrend();
    document.addEventListener('DOMContentLoaded', () => {
    	  const tooltip = document.getElementById('tooltipImage');
    	  const tooltipImg = document.getElementById('tooltipImageTag');

    	  document.addEventListener('mouseover', (e) => {
    	    const cell = e.target.closest('.card-name-cell');
    	    if (cell) {
    	      const imgUrl = cell.getAttribute('data-img');
    	      tooltipImg.src = imgUrl;
    	      tooltip.style.opacity = 1;
    	      tooltip.style.display = 'block';
    	    }
    	  });

    	  document.addEventListener('mousemove', (e) => {
    	    if (tooltip.style.display === 'block') {
    	      tooltip.style.top = (e.pageY + 20) + 'px';
    	      tooltip.style.left = (e.pageX + 20) + 'px';
    	    }
    	  });

    	  document.addEventListener('mouseout', (e) => {
    	    if (e.target.closest('.card-name-cell')) {
    	      tooltip.style.opacity = 0;
    	      setTimeout(() => tooltip.style.display = 'none', 500); // 부드럽게 사라짐
    	    }
    	  });
    	});
    

    openModalBtn.addEventListener("click", () => {
      searchModal.style.display = "flex";
      document.body.style.overflow = "hidden"; // 스크롤 방지
    });

    closeModalBtn.addEventListener("click", () => {
      searchModal.style.display = "none";
      document.body.style.overflow = "auto";
    });

    // 바깥 영역 클릭 시 닫기
    searchModal.addEventListener("click", (e) => {
      if (e.target === searchModal) {
        searchModal.style.display = "none";
        document.body.style.overflow = "auto";
      }
    });
    
    const showDetail =(cardNo)=>{
  	  window.location.href = "${path}/views/cardMenu/fitCardDetail.jsp?cardNo="+cardNo;
    }
    
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
	</script>
</body>
</html>
