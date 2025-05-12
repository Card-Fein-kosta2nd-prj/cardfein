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
              <img
                src="${pageContext.request.contextPath}/static/images/icons/user-img.png"
                alt="Image"
              />
              <span>IMAGE</span>
            </div>
          </div>
          <div class="card-preview">
            <div class="image-wrapper">
              <canvas id="cardCanvas" width="300" height="460"></canvas>
              <!-- <img class="base-image" src="" alt="카드 미리보기 이미지" />
            	
            	<div class="overlay-container">
          			<img class="overlay-image" alt="사용자 이미지" src="">            	
            	</div> -->
            </div>
            <p>십자(+) 영역까지 이미지를 충분히 채워주세요.</p>
          </div>
          <div class="cover-title">
            <p>생성 커버 이름 :</p>
            <input type="text" />
          </div>
          <div class="BtnContainer">
            <button type="submit" class="saveBtn" onclick="saveBtn">
              저장하기
            </button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/fabric.js/5.3.1/fabric.min.js"></script>

    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        // Fabric.js 캔버스 초기화
        const canvas = new fabric.Canvas('cardCanvas');

        const menuImage = document.querySelector('.menu-item img');
        const coverNameInput = document.querySelector('.cover-title input[type="text"]');
        const saveButton = document.querySelector('.saveBtn');

        let baseImageObj = null;    // Fabric.js Image 객체를 저장할 변수 (기본 커버)
        let overlayImageObj = null; // Fabric.js Image 객체를 저장할 변수 (사용자 이미지)

        // 파일 업로드 input 생성
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.accept = 'image/*';
        fileInput.style.display = 'none'; // 화면에 보이지 않도록 숨김
        document.body.appendChild(fileInput);

        // 'IMAGE' 메뉴 아이템 클릭 시 파일 업로드 다이얼로그 열기
        menuImage.addEventListener('click', () => fileInput.click());

        // 파일 선택 후 업로드 이미지 처리
        fileInput.addEventListener('change', function (e) {
            const file = e.target.files[0];
            if (!file) return;

            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                return;
            }

            const reader = new FileReader();
            reader.onload = function (event) {
                fabric.Image.fromURL(event.target.result, function (img) {
                    // 기존 오버레이 이미지가 있으면 제거
                    if (overlayImageObj && canvas.contains(overlayImageObj)) {
                        canvas.remove(overlayImageObj);
                    }
                    overlayImageObj = img; // 전역 변수에 현재 이미지 객체 저장

                    // 이미지 크기 조절: 캔버스 크기에 맞게 'cover' 형태로 조절
                    // 이 로직은 사용자가 처음에 이미지를 업로드했을 때 캔버스 영역을 대략적으로 채우도록 합니다.
                    // 이후 사용자가 직접 드래그 및 크기 조절로 세부 조정할 수 있습니다.
                    const canvasWidth = canvas.width;
                    const canvasHeight = canvas.height;
                    const imgAspectRatio = img.width / img.height;
                    const canvasAspectRatio = canvasWidth / canvasHeight;

                    let newWidth, newHeight;

                    if (imgAspectRatio > canvasAspectRatio) {
                        // 이미지가 캔버스보다 가로로 길 때 (높이를 캔버스에 맞춤)
                        newHeight = canvasHeight;
                        newWidth = newHeight * imgAspectRatio;
                    } else {
                        // 이미지가 캔버스보다 세로로 길거나 비율이 비슷할 때 (너비를 캔버스에 맞춤)
                        newWidth = canvasWidth;
                        newHeight = newWidth / imgAspectRatio;
                    }

                    overlayImageObj.set({
                        left: (canvasWidth - newWidth) / 2,  // 캔버스 중앙에 위치
                        top: (canvasHeight - newHeight) / 2, // 캔버스 중앙에 위치
                        width: newWidth,
                        height: newHeight,
                        hasControls: true,  // 크기 조절 핸들 활성화
                        hasBorders: true,   // 경계선 활성화
                        selectable: true,   // 선택 가능
                        evented: true,      // 이벤트 처리 가능
                        lockScalingFlip: true // 뒤집기 스케일링 방지 (선택 사항)
                    });

                    canvas.add(overlayImageObj); // 캔버스에 오버레이 이미지 추가
                    canvas.setActiveObject(overlayImageObj); // 새로 추가된 이미지를 활성 객체로 설정
                    canvas.renderAll(); // 캔버스 다시 그리기
                }, { crossOrigin: 'anonymous' }); // 외부 이미지 로드 시 CORS 문제 방지
            };
            reader.readAsDataURL(file);
        });

        // 기본 이미지 불러오기 함수 (서버에서 미리 정의된 커버 이미지 로드)
        function fetchBaseImage() {
            const baseUrl = "${pageContext.request.contextPath}";
            fetch(baseUrl + "/ajax?action=getBaseImage", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
            })
            .then((res) => res.json())
            .then((data) => {
                const imgUrl = data.baseImageUrl;
                console.log("받은 기본 이미지 URL:", imgUrl);
                if (imgUrl) {
                    fabric.Image.fromURL(baseUrl + imgUrl, function (img) {
                        // 기존 기본 이미지가 있으면 제거
                        if (baseImageObj && canvas.contains(baseImageObj)) {
                            canvas.remove(baseImageObj);
                        }
                        baseImageObj = img; // 전역 변수에 현재 기본 이미지 객체 저장

                        // 캔버스 크기에 맞게 이미지 조절 (cover 형태로)
                        const canvasWidth = canvas.width;
                        const canvasHeight = canvas.height;
                        const imgAspectRatio = img.width / img.height;
                        const canvasAspectRatio = canvasWidth / canvasHeight;

                        let newWidth, newHeight;
                        if (imgAspectRatio > canvasAspectRatio) {
                            newHeight = canvasHeight;
                            newWidth = newHeight * imgAspectRatio;
                        } else {
                            newWidth = canvasWidth;
                            newHeight = newWidth / imgAspectRatio;
                        }

                        baseImageObj.set({
                            left: (canvasWidth - newWidth) / 2,
                            top: (canvasHeight - newHeight) / 2,
                            width: newWidth,
                            height: newHeight,
                            selectable: false,  // 기본 이미지는 선택 불가능하게
                            evented: false,     // 이벤트 발생하지 않도록
                            hasControls: false, // 핸들 숨기기
                            hasBorders: false   // 테두리 숨기기
                        });

                        canvas.add(baseImageObj); // 캔버스에 기본 이미지 추가
                        canvas.sendToBack(baseImageObj); // 기본 이미지를 가장 뒤로 보냄
                        
                        // 마그네틱 부분 마스크 / 클리핑 패스 생성 부분
                        const magneticStripeLeft = 8; // 이미지 왼쪽 끝에서 시작 (캔버스 너비 300px 기준)
                        const magneticStripeTop = 25; // 이미지 상단에서 약 50px 아래 (캔버스 높이 460px 기준)
                        const magneticStripeWidth = 197; // 캔버스 전체 너비 사용
                        const magneticStripeHeight = 52; // 마그네틱 스트라이프의 높이 (추정)

                        // 카드 칩 영역 (예시 값, 실제 카드 디자인과 새로운 캔버스 크기에 맞게 조정 필요)
                        const chipLeft = 35; // 왼쪽에서 30px (캔버스 너비 300px 기준)
                        const chipTop = 110; // 위에서 110px (캔버스 높이 460px 기준)
                        const chipWidth = 40; // 너비 40px (추정)
                        const chipHeight = 30; // 높이 30px (추정)

                        // 마그네틱 스트라이프 클리핑 영역
                        const clipRect1 = new fabric.Rect({
                            left: magneticStripeLeft,
                            top: magneticStripeTop,
                            width: magneticStripeWidth,
                            height: magneticStripeHeight,
                            absolutePositioned: true
                        });

                        // 카드 칩 클리핑 영역
                        const clipRect2 = new fabric.Rect({
                            left: chipLeft,
                            top: chipTop,
                            width: chipWidth,
                            height: chipHeight,
                            absolutePositioned: true
                        });

                        // 두 개의 클리핑 영역을 그룹으로 만듭니다.
                        const clipGroup = new fabric.Group([clipRect1, clipRect2], {
                            left: 0,
                            top: 0,
                            width: canvasWidth,
                            height: canvasHeight,
                            absolutePositioned: true
                        });

                        window.cardClipPath = clipGroup; // 전역 변수로 저장
                        
                        canvas.renderAll(); // 캔버스 다시 그리기
                    }, { crossOrigin: 'anonymous' }); // 외부 이미지 로드 시 CORS 문제 방지
                }
            })
            .catch((err) => {
                console.error("기본 이미지 불러오기 실패", err);
            });
        }

        // 팝업 열기/닫기 기능
        const openPopupBtn = document.getElementById("openPopupBtn"); // 이 ID를 가진 요소가 있는지 확인
        const popupOverlay = document.getElementById("popupOverlay");
        const closePopupBtn = document.getElementById("closePopupBtn");

        if (openPopupBtn) {
            openPopupBtn.addEventListener("click", () => {
                fetchBaseImage(); // 팝업 열릴 때 기본 이미지 로드
                popupOverlay.style.display = "flex";
            });
        }

        closePopupBtn.addEventListener("click", () => {
            popupOverlay.style.display = "none";
            // 팝업 닫을 때 캔버스 초기화 (선택 사항: 매번 새로 시작하고 싶을 때)
            canvas.clear();
            baseImageObj = null;
            overlayImageObj = null;
            window.cardClipPath = null;
        });

        // 팝업 외부 클릭 시 팝업 닫기
        popupOverlay.addEventListener("click", (event) => {
            if (event.target === popupOverlay) {
                popupOverlay.style.display = "none";
                canvas.clear();
                baseImageObj = null;
                overlayImageObj = null;
                window.cardClipPath = null;
            }
        });

        // Fabric.js 객체 이벤트 리스너
        canvas.on({
            'object:moving': function(e) {
                // overlayImageObj는 캔버스 영역 밖으로도 자유롭게 이동 가능해야 합니다.
                // 따라서 이 부분에서 강제로 경계를 제한하는 로직은 제거했습니다.
                // 사용자가 십자(+) 영역까지 이미지를 충분히 채울 수 있도록 허용합니다.
            },
            'object:scaling': function(e) {
                const obj = e.target; // 현재 크기 조절 중인 객체

                if (obj === overlayImageObj) {
                    const minDim = 50; // 이미지의 최소 가로/세로 픽셀

                    // 최소 크기 제한
                    if (obj.width * obj.scaleX < minDim) {
                        obj.scaleX = minDim / obj.width;
                    }
                    if (obj.height * obj.scaleY < minDim) {
                        obj.scaleY = minDim / obj.height;
                    }

                    // 종횡비 유지 (기본: 유지. Shift 키 누르면 자유 조절)
                    // 스케일링 시작 시점의 원본 스케일 비율을 기준으로 종횡비 계산
                    if (e.transform.original.scaleX && e.transform.original.scaleY) {
                        const originalAspectRatio = e.transform.original.scaleX / e.transform.original.scaleY;

                        if (!e.shiftKey) { // Shift 키를 누르지 않았을 때만 종횡비 유지
                            // 현재 변하고 있는 축을 기준으로 다른 축의 스케일 값 조정
                            if (e.transform.corner.includes('ml') || e.transform.corner.includes('mr')) { // 가로 스케일 조절 중 (왼쪽, 오른쪽 중간 핸들)
                                obj.scaleY = obj.scaleX / originalAspectRatio;
                            } else if (e.transform.corner.includes('mt') || e.transform.corner.includes('mb')) { // 세로 스케일 조절 중 (위쪽, 아래쪽 중간 핸들)
                                obj.scaleX = obj.scaleY * originalAspectRatio;
                            } else { // 모서리 핸들 조절 시
                                // 가로 또는 세로 중 더 많이 변한 축을 기준으로 다른 축 조정 (더 자연스러움)
                                if (Math.abs(e.transform.original.width * (obj.scaleX - e.transform.original.scaleX)) > Math.abs(e.transform.original.height * (obj.scaleY - e.transform.original.scaleY))) {
                                    obj.scaleY = obj.scaleX / originalAspectRatio;
                                } else {
                                    obj.scaleX = obj.scaleY * originalAspectRatio;
                                }
                            }
                        }
                    }
                }
                canvas.renderAll(); // 변경사항 즉시 반영
            },
            'object:modified': function(e) {
                // 객체의 드래그 또는 스케일링이 완료되었을 때 호출됩니다.
                // 최종 위치/크기 저장 등 필요한 후처리 로직을 여기에 추가할 수 있습니다.
                console.log("객체 수정 완료:", e.target.toJSON());
            }
        });

        // 저장 버튼 기능
        saveButton.addEventListener('click', function() {
            const coverName = coverNameInput.value;

            // 캔버스의 현재 상태를 이미지로 변환 (Base64 URL)
            // 이 이미지를 서버로 전송하여 파일로 저장할 수 있습니다.
            const imageDataURL = canvas.toDataURL({
                format: 'png', // 'png', 'jpeg', 'webp' 중 선택
                quality: 0.9    // JPEG/WebP의 경우 품질 설정 (0.0 ~ 1.0)
            });

            // Fabric.js 캔버스에 있는 모든 객체의 상태를 JSON으로 직렬화
            // 나중에 이 JSON을 사용하여 캔버스 상태를 정확히 복원할 수 있습니다.
            const canvasState = canvas.toJSON();

            console.log("저장할 카드 정보:");
            console.log("커버 이름:", coverName);
            // console.log("전체 캔버스 이미지 데이터 URL (Base64):", imageDataURL.substring(0, 100) + "..."); // 너무 길어서 일부만 출력
            console.log("전체 캔버스 상태 (JSON):", JSON.stringify(canvasState, null, 2)); // 가독성 좋게 출력

            alert("카드 정보가 저장되었습니다! (실제 서버 저장 로직 필요)");

            // --- 서버로 데이터 전송 예시 ---
            /*
            fetch('/saveCardData', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    coverName: coverName,
                    imageData: imageDataURL, // Base64 이미지 데이터
                    canvasState: canvasState // 캔버스 상태 JSON
                }),
            })
            .then(response => response.json())
            .then(data => {
                console.log('서버 응답:', data);
                alert('저장 완료!');
            })
            .catch((error) => {
                console.error('저장 실패:', error);
                alert('저장 실패!');
            });
            */
        });
    });
</script>
  </body>
</html>
