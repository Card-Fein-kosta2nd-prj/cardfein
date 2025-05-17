/**
 * popup
 */

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
              previewImg.src = baseUrl +"/"+ imgUrl;
            }
          })
          .catch((error) => {
            console.error("기본 이미지 불러오기 실패:", error);
          });
      }