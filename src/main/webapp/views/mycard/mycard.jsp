<!DOCTYPE html>
<html lang="ko">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8">
<title>Card:fein - 내카드 등록하기</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- 공통 스타일 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/common.css">
<!-- 페이지 전용 스타일 -->


<!-- 공통 스크립트 -->
<script src="${pageContext.request.contextPath}/static/js/common.js"
	defer></script>
<!-- 페이지 전용 스크립트 -->
</head>
<body>
	<!-- header -->
	<jsp:include page="../../views/common/header.jsp" />
	<!-- 메인 콘텐츠 -->
	<main>

		<h2>내 카드 등록하기</h2>

		<div class="App">
			<div class="Header"></div>
			<form>
				<div class="Editor"></div>
			</form>

			<div class="List">
				<p>등록할 카드 검색</p>
				<!--widow + .-->
				<input type="text" placeholder='카드명을 입력해주세요.' id="keyword"
					onkeyup="search(event)" />

				<div class="card_list">
					<!--여기에 화면 출력-->
				</div>
				<div class="inquiry-form" id="inquiryForm" style="display: none">
					<h3>❓ 카드가 DB에 없습니다</h3>
					<p>입력한 카드를 등록 요청하시겠어요? 아래 내용을 확인 후 1:1 문의를 남겨주세요.</p>
					<textarea id="inquiryContent" rows="4">카드명: </textarea>
					<button onclick="submitInquiry()">1:1 문의 등록</button>
				</div>


			</div>
			<div class="chart">
				<h2>📊 누적 소비 기반 카드 매칭율 변화</h2>
				<canvas id="lineChart" height="100"></canvas>
			</div>
			<div class="my_cards">
				<h2>📌 내 보유 카드 목록</h2>
				<div class="draw-cards">
				<!-- 여기에 보유카드 목록 출력 -->
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
	
	const search = async(e)=>{
		inquiryForm.style.display = 'none';
		if(!e.target.value) { 
			printList.innerHTML ='';
			return;
		}
        printList.innerHTML=`
		<table>
			<thead>
				<th>카드이미지</th>
				<th>카드사</th>
				<th>카드명</th>
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
			content +=`<tr>
				<td><img
				src="${path}/static/images/cards/\${card.cardImageUrl}"
				alt="카드 이미지"></td>
				<td>\${card.provider}</td>
				<td>\${card.cardName}</td>
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
			      <img src="${path}/static/images/cards/\${img}" class="card-img" alt="카드 이미지" />
			      <div class="card-info">
			        <h3 contenteditable="false">\${cardName}</h3>
			        <div class="benefit" contenteditable="false">
			        \${disList}
			        </div>
			        <div class="btn-group">
			          <button class="btn-sm btn-detail" onclick="alert('상세 페이지로 이동합니다.')">상세 보기</button>
			          <button class="btn-sm btn-compare" onclick="#">비교바구니담기</button>
			          <button class="btn-sm btn-delete" onclick="deleteCard('\${cardNo}')">삭제</button>
			        </div>
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
    
	
	</script>
</body>
</html>
