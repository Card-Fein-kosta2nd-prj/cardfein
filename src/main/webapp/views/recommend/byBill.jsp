<%@page import="cardfein.kro.kr.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>Card:fein - 명세서 맞춤추천</title>

<!-- 공통 스타일 -->
<link rel="stylesheet" href="${path}/static/css/common.css">
<!-- 페이지 전용 스타일 -->
<link rel="stylesheet" href="${path}/static/css/recommend/byBill.css">

<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js" defer></script>
</head>
<body>

<!-- header -->
<jsp:include page="../../views/common/header.jsp" />

<!-- 메인 콘텐츠 -->
<main>
	<div class="container">
		<section class="card-recommendation" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; padding: 40px 0;">
			<div class="text-content" style="flex: 1; min-width: 320px; padding-right: 30px;">
				<h2 style="font-size: 2rem; margin-bottom: 20px; line-height: 1.3;">
					명세서로<br>카드 추천 받기
				</h2>
				<p style="font-size: 1rem; margin-bottom: 20px;">내 소비습관에 딱맞춘 카드를 알아보고 추천받아요!</p>

				<div class="card-tags" style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 20px;">
					<button class="tag">신한카드</button>
					<button class="tag">삼성카드</button>
					<button class="tag">국민카드</button>
					<button class="tag">하나카드</button>
					<button class="tag">현대카드</button>
					<button class="tag">등등...</button>
				</div>

				<form id="ocrForm" enctype="multipart/form-data">
					<input type="file" id="ocrInput" name="ocrFile" accept="image/*" style="display: none;" required />
					<button type="button" id="uploadBtn" class="find-btn" style="padding: 10px 20px; background-color: #2563eb; color: white; border: none; border-radius: 8px; font-size: 1rem; cursor: pointer;">📷 명세서 이미지 찾기</button>
				</form>
			</div>

			<div class="image-content" style="flex: 1; text-align: center; min-width: 300px;">
				<img src="${path}/static/images/cards.png" alt="카드 이미지" style="max-width: 100%; height: auto;">
			</div>
		</section>
	</div>

	<section class="ocr-result-section container" style="margin-bottom: 60px;">
	</section>
</main>

<!-- footer -->
<jsp:include page="../../views/common/footer.jsp" />

<script>
const ocrResultSection = document.querySelector(".ocr-result-section");

const renderOcrResult = (dataList) => {
	const header = document.createElement('h3');
	header.textContent = "📄 업로드한 명세서 인식 결과";
	header.style.fontSize = '1.5rem';
	header.style.fontWeight = 'bold';
	header.style.textAlign = 'center';
	header.style.margin = '40px 0 20px';

	const table = document.createElement('table');
	table.classList.add('ocr-table');
	table.style.width = '100%';
	table.style.borderCollapse = 'collapse';
	table.innerHTML = `
		<thead style="background-color: #f9fafb;">
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
		row.style.textAlign = 'center';
		tbody.appendChild(row);
	});

	ocrResultSection.innerHTML = '';
	ocrResultSection.appendChild(header);
	ocrResultSection.appendChild(table);

	const startButton = document.createElement('button');
	startButton.id = 'start';
	startButton.innerText = '명세서 분석 시작';
	startButton.classList.add('start-button');
	startButton.onclick = () => location.href = 'result.jsp';
	ocrResultSection.appendChild(startButton);
}

document.getElementById("uploadBtn").addEventListener("click", () => {
	document.getElementById("ocrInput").click();
});

document.getElementById("ocrInput").addEventListener("change", async () => {
	if (ocrInput.files.length === 0) return;

	// 버튼 비활성화
	  uploadBtn.disabled = true;
	  uploadBtn.innerText = "분석 중..."; // 사용자가 누른 후 기다리는 걸 인지

	
	ocrResultSection.innerHTML = `<p class="ocr-progress-text">🔍 OCR 인식 진행 중...</p>`;

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
	}finally {
	    // 버튼 다시 활성화
	    uploadBtn.disabled = false;
	    uploadBtn.innerText = "명세서 이미지 찾기";
	  }
});
</script>



</body>
</html>