<!DOCTYPE html>
<html lang="ko">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8">
<title>Card:fein - 내카드 등록하기</title>

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
				<input type="text" placeholder='카드명을 입력해주세요.' id="keyword" onkeyup="search(event)" />

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

		</div>
	</main>
	<!-- footer -->
	<jsp:include page="../../views/common/footer.jsp" />

	<script>
	let printList = document.querySelector(".card_list");
	let inquiryForm = document.getElementById('inquiryForm');
	let inquiryContent = document.getElementById('inquiryContent');
	let input = document.querySelector("#keyword");
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
				src="${path}/views/recommend/삼성_2V4.png"
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
		if(result===1) alert('카드가 등록 되었습니다.');
		input.value= '';
		printList.innerHTML='';
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
	
	
	
	</script>
</body>
</html>
