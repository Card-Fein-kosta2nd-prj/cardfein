<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<main class="container">
    <h2 class="text-2xl font-semibold mb-4">📷 명세서 이미지 업로드</h2>
    <form id="ocrForm" enctype="multipart/form-data">
      <input type="file" id="ocrInput" class="mb-4" required />
      <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">업로드</button>
    </form>
    <br>
    <div id="resultBox">
      <h2 class="text-2xl font-semibold mb-4">📄 인식된 텍스트 결과</h2>
      <div id="resultText">
        <!-- 분석 결과가 여기에 표시됩니다 -->
      </div>
    </div>
    <div id="startButton">

    </div>
    
    
  </main>

  <script>
    document.getElementById('ocrForm').addEventListener('submit', async (e)=>{
      e.preventDefault();
      // 실제 OCR 분석 생략, 결과 페이지로 이동
      const fileInput = document.getElementById('ocrInput');
      if (!fileInput.files.length) {
        alert("이미지를 업로드해주세요.");
        return;
      }
      const formData = new FormData();
      formData.append("image", fileInput.files[0]); // <-- 파일 첨부
      formData.append("key", "ocr");
      formData.append("methodName", "recognize");

      let response = await fetch("${path}/ajax", {
        method: "POST",
        body: formData
      });
      const simulatedOCR = await response.text();
      // 실제 OCR 처리 대신 샘플 텍스트 표시
     /* const simulatedOCR = `
        [2025.04.01] 스타벅스 - 4,500원
        [2025.04.02] 이마트 - 23,000원
        [2025.04.03] 넷플릭스 - 9,500원
        [2025.04.05] GS25 - 3,200원
      `;*/

      document.getElementById('resultText').textContent = simulatedOCR.trim();
      document.getElementById('resultBox').style.display = 'block';
      document.getElementById('startButton').innerHTML=
      `<button id="start" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700" onclick="window.location.href = 'result.jsp'"> 분석시작 </button>`
      
    });
    
  </script>
</body>
</html>