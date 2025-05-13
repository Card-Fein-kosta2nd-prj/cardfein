<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card:fein - 명세서 맞춤추천</title>

<!-- 공통 스타일 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/common.css">
<!-- 페이지 전용 스타일 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/byBill.css">

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
		<div class="container">
			<section class="card-recommendation">
				<div class="text-content">
					<h2>
						명세서로<br>카드 추천 받기
					</h2>
					<p>내 소비습관에 딱맞춘 카드를 알아보고 추천받아요!</p>

					<div class="card-tags">
						<button class="tag">신한카드</button>
						<button class="tag">삼성카드</button>
						<button class="tag">국민카드</button>
						<button class="tag">하나카드</button>
						<button class="tag">현대카드</button>
						<button class="tag">등등...</button>
					</div>
					<form id="ocrForm" enctype="multipart/form-data">
						<input type="file" id="ocrInput" name="ocrFile" accept="image/*"
							style="display: none;" required />
						<button type="button" id="uploadBtn" class="find-btn">명세서
							이미지 찾기</button>
					</form>
				</div>

				<div class="image-content">
					<img
						src="${pageContext.request.contextPath}/static/images/cards.png"
						alt="카드 이미지">
				</div>
			</section>


		</div>
	</main>
	<section class="ocr-result-section container">
	</section>




	<!-- footer -->
	<jsp:include page="../../views/common/footer.jsp" />

	<script>
	const ocrResultSection = document.querySelector(".ocr-result-section");

	const renderOcrResult = (dataList) => {
		const table = document.createElement('table');
		table.classList.add('ocr-table');
		table.innerHTML = `
			<thead>
				<tr>
					<th>이용일자</th>
					<th>가맹점명</th>
					<th>이용금액</th>
					<th>카테고리</th>
				</tr>
			</thead>
			<tbody id="ocrResultBody">
			</tbody>
		`;
		const tbody = table.querySelector('#ocrResultBody');
		dataList.forEach(item => {
			const row = document.createElement('tr');
			row.innerHTML = `
				<td>\${item.date}</td>
				<td>\${item.merchant}</td>
				<td>\${Number(item.amount).toLocaleString()}원</td>
				<td>\${item.category}</td>
			`;
			tbody.appendChild(row);
		});

		ocrResultSection.innerHTML = ''; // 기존 내용을 비우고 새로 렌더링
		ocrResultSection.appendChild(table);

		const startButton = document.createElement('button');
		startButton.id = 'start';
		startButton.innerText = '명세서 분석시작';
		startButton.classList.add('start-button');
		startButton.onclick = () => location.href = 'result.jsp';
		ocrResultSection.appendChild(startButton);
	}

	const ocrInput = document.getElementById("ocrInput");
	const uploadBtn = document.getElementById("uploadBtn");

	uploadBtn.addEventListener("click", () => {
		ocrInput.click();
	});

	ocrInput.addEventListener("change", async () => {
		if (ocrInput.files.length === 0) return;

		ocrResultSection.innerHTML = `<h3>📄 업로드한 명세서 인식 결과</h3>
			<p class="ocr-progress-text">ocr 인식 진행 중...</p>`;

		const formData = new FormData();
		formData.append("image", ocrInput.files[0]);
		formData.append("key", "ocr");
		formData.append("methodName", "recognize");

		try {
			const response = await fetch("${pageContext.request.contextPath}/ajax", {
				method: "POST",
				body: formData
			});

			const simulatedOCR = await response.json();
			renderOcrResult(simulatedOCR);
		} catch (err) {
			alert("명세서 업로드 중 오류가 발생했습니다.");
			console.error(err);
		}
	});
   </script>
   <style>
		/* OCR 인식 진행 중 메시지 스타일 */
		.ocr-progress-text {
			font-size: 1.5rem;
			font-weight: bold;
			color: #3b82f6; /* 파란색 */
			text-align: center;
			margin-top: 20px;
		}

		/* 명세서 분석 시작 버튼 스타일 */
		.start-button {
			display: block;
			width: 200px;
			margin: 30px auto;
			padding: 12px 24px;
			font-size: 1.1rem;
			color: white;
			background-color: #10b981; /* 초록색 */
			border: none;
			border-radius: 8px;
			cursor: pointer;
			transition: background-color 0.3s ease;
		}

		.start-button:hover {
			background-color: #059669; /* 어두운 초록색 */
		}
	</style>

</body>
</html>