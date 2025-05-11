<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <div id="popupOverlay" class="popup-overlay">
      <div class="popup-content">
        <div class="popup-header">
          <h2 class="popup-title">나만의 카드 미리보기</h2>
          <button id="closePopupBtn" class="close-button">×</button>
        </div>
        <div class="popup-body">
          <div class="popup-menu">
            <div class="menu-item">
              <img src="image_icon.png" alt="Image" /> <span>IMAGE</span>
            </div>
            <div class="menu-item">
              <img src="text_icon.png" alt="Text" /> <span>TEXT</span>
            </div>
          </div>
          <div class="card-preview">
            <img src="" alt="카드 미리보기 이미지" />
            <p>십자(+) 영역까지 이미지를 충분히 채워주세요.</p>
          </div>
        </div>
      </div>
    </div>

    <script>
      const openPopupBtn = document.getElementById("openPopupBtn");
      const closePopupBtn = document.getElementById("closePopupBtn");
      const popupOverlay = document.getElementById("popupOverlay");

      openPopupBtn.addEventListener("click", () => {
        popupOverlay.style.display = "flex";
      });

      closePopupBtn.addEventListener("click", () => {
        popupOverlay.style.display = "none";
      });

      popupOverlay.addEventListener("click", (event) => {
        if (event.target === popupOverlay) {
          popupOverlay.style.display = "none";
        }
      });

      document
        .getElementById("openPopupBtn")
        .addEventListener("click", function () {
          fetchBaseImage();
          document.getElementById("popupOverlay").style.display = "flex";
        });

      const baseUrl = "${pageContext.request.contextPath}";

      function fetchBaseImage() {
        fetch(baseUrl + "/ajax?action=getBaseImage", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded", // 명시적으로 지정
          },
        })
          .then((res) => {
            if (!res.ok) {
              throw new Error("서버 응답 실패");
            }
            return res.json();
          })
          .then((data) => {
            const imgUrl = data.baseImageUrl;
            console.log("받은 이미지 URL:", imgUrl); // 디버깅용
            const previewImg = document.querySelector(".card-preview img");
            if (previewImg && imgUrl) {
              previewImg.src = imgUrl;
            }
          })
          .catch((error) => {
            console.error("기본 이미지 불러오기 실패:", error);
          });
      }
    </script>
  </body>
</html>
