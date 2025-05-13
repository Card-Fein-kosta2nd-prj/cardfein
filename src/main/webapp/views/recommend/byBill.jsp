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
		<h3>📄 업로드한 명세서 인식 결과</h3>

		<table class="ocr-table">
			<thead>
				<tr>
					<th>이용일자</th>
					<th>가맹점명</th>
					<th>이용금액</th>
					<th>카테고리</th>
				</tr>
			</thead>
			<tbody id="ocrResultBody">
				<!-- JavaScript로 행 추가 -->
			</tbody>
		</table>

		<div id="startButton"></div>
	</section>




	<!-- footer -->
	<jsp:include page="../../views/common/footer.jsp" />

	<script>

	  function renderOcrResult(dataList) {
	    const tbody = document.getElementById('ocrResultBody');
	    tbody.innerHTML = '';

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
	  }

	  const ocrInput = document.getElementById("ocrInput");
	  const uploadBtn = document.getElementById("uploadBtn");
	  const ocrForm = document.getElementById("ocrForm");
	 
	  uploadBtn.addEventListener("click", () => {
	    ocrInput.click();
	  });

	  ocrInput.addEventListener("change", async () => {
		    if (ocrInput.files.length === 0) return;

		    const formData = new FormData();
		    formData.append("image", ocrInput.files[0]); // 파일 파라미터명은 서버에 맞게!
		    formData.append("key", "ocr");
		    formData.append("methodName", "recognize");

		    try {
		      const response = await fetch("${path}/ajax", {
		        method: "POST",
		        body: formData
		      });

		      const simulatedOCR = await response.json();
		      console.log(simulatedOCR);
		      renderOcrResult(simulatedOCR);


		      document.getElementById('startButton').innerHTML = `
		        <button id="start" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
		                onclick="location.href = 'result.jsp'">명세서 분석시작</button>`;
		    } catch (err) {
		      alert("명세서 업로드 중 오류가 발생했습니다.");
		      console.error(err);
		    }
	  });
   </script>

</body>
</html>