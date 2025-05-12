<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>나만의 카드 만들기</title>
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
                    <div class="menu-item" id="uploadImageMenu">
                        <img
                            src="${pageContext.request.contextPath}/static/images/icons/user-img.png"
                            alt="Image" />
                        <span>IMAGE</span>
                    </div>
                </div>
                <div class="card-preview">
                    <div class="image-wrapper">
                        <canvas id="cardCanvas" width="300" height="460"></canvas>
                    </div>
                    <p>십자(+) 영역 안쪽으로 이미지를 충분히 채워주세요.</p>
                </div>
                <div class="cover-title">
                    <p>생성 커버 이름 :</p>
                    <input type="text" />
                </div>
                <div class="BtnContainer">
                    <button type="button" class="saveBtn">저장하기</button> <%-- onclick 제거, type="button" 권장 --%>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/fabric.js/5.3.1/fabric.min.js"></script>

    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        const canvas = new fabric.Canvas('cardCanvas', {
            backgroundColor: '#f0f0f0' // 캔버스 배경색 (필요시)
        });

        const uploadImageMenu = document.getElementById('uploadImageMenu');
        const coverNameInput = document.querySelector('.cover-title input[type="text"]');
        const saveButton = document.querySelector('.saveBtn');

        let baseRectObj = null;         // 흰색 배경 사각형 객체
        let overlayImageObj = null;     // 사용자 업로드 이미지 객체
        let templateOverlayObj = null;  // 서버에서 가져온 카드 템플릿 객체
        let clipZone = null;            // 사용자 이미지 클리핑 영역

        const cardAreaWidth = 300;
        const cardAreaHeight = 460;

        // 파일 업로드 input 생성
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.accept = 'image/*';
        fileInput.style.display = 'none';
        document.body.appendChild(fileInput);

        // 'IMAGE' 메뉴 아이템 클릭 시 파일 업로드 다이얼로그 열기
        uploadImageMenu.addEventListener('click', () => fileInput.click());

        // 파일 선택 후 업로드 이미지 처리
        fileInput.addEventListener('change', function (e) {
            const file = e.target.files[0];
            if (!file) return;

            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                fileInput.value = ''; // 입력값 초기화
                return;
            }

            const reader = new FileReader();
            reader.onload = function (event) {
                fabric.Image.fromURL(event.target.result, function (img) {
                    if (overlayImageObj && canvas.contains(overlayImageObj)) {
                        canvas.remove(overlayImageObj);
                    }
                    overlayImageObj = img;

                    const canvasWidth = canvas.width;
                    const canvasHeight = canvas.height;
                    const imgAspectRatio = img.width / img.height;
                    
                    // 이미지가 클립 영역(cardArea)을 충분히 덮도록 크기 조절
                    let newWidth, newHeight;
                    const clipZoneAspectRatio = cardAreaWidth / cardAreaHeight;

                    if (imgAspectRatio > clipZoneAspectRatio) {
                        newHeight = cardAreaHeight * 1.1; // 약간 더 크게 해서 사용자가 조절할 여지
                        newWidth = newHeight * imgAspectRatio;
                    } else {
                        newWidth = cardAreaWidth * 1.1; // 약간 더 크게
                        newHeight = newWidth / imgAspectRatio;
                    }
                    
                    overlayImageObj.set({
                        left: baseRectObj ? baseRectObj.left + (cardAreaWidth - newWidth) / 2 : (canvasWidth - newWidth) / 2,
                        top: baseRectObj ? baseRectObj.top + (cardAreaHeight - newHeight) / 2 : (canvasHeight - newHeight) / 2,
                        width: newWidth,
                        height: newHeight,
                        hasControls: true,
                        hasBorders: true,
                        selectable: true,
                        evented: true,
                        lockScalingFlip: true,
                        clipPath: clipZone ? clipZone : null // 클립존이 준비되었으면 적용
                    });

                    canvas.add(overlayImageObj);
                    // overlayImageObj는 baseRectObj 위, templateOverlayObj 아래에 위치해야 함.
                    // baseRectObj는 sendToBack으로 항상 맨 뒤에 있음.
                    // templateOverlayObj가 있다면 그것을 맨 앞으로 가져와서 순서를 보장.
                    if (templateOverlayObj) {
                        canvas.bringToFront(templateOverlayObj);
                    }
                    canvas.setActiveObject(overlayImageObj);
                    canvas.renderAll();
                }, { crossOrigin: 'anonymous' });
            };
            reader.readAsDataURL(file);
            fileInput.value = ''; // 다음 파일 선택을 위해 입력값 초기화
        });

        // 서버에서 카드 템플릿 이미지 불러오기 (async/await 사용)
        async function fetchTemplateOverlayImage() {
            const baseUrl = "${pageContext.request.contextPath}";
            // 실제 서버 요청 URL로 변경해야 합니다. 예시: "/ajax?action=getCardTemplateImage"
            const actionUrl = "/ajax?action=getBaseImage"; // 사용자의 기존 URL 유지, 필요시 변경

            try {
                const response = await fetch(baseUrl + actionUrl, {
                    method: "POST", // 또는 "GET" 등 서버 설정에 맞게
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded", // 필요시 변경
                    },
                    // body: new URLSearchParams({ /* 필요한 파라미터 */ }) // POST 요청 시
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const data = await response.json();
                const imgUrl = data.baseImageUrl; // 서버 응답에 따라 키 이름 확인 필요
                console.log("받은 카드 템플릿 이미지 URL:", imgUrl);

                if (imgUrl) {
                    fabric.Image.fromURL(baseUrl + imgUrl, function (img) {
                        if (templateOverlayObj && canvas.contains(templateOverlayObj)) {
                            canvas.remove(templateOverlayObj);
                        }
                        templateOverlayObj = img;
                        console.log("카드 템플릿 이미지", img);

                        // 템플릿 이미지는 캔버스 전체에 맞추거나, 카드 영역에 맞출 수 있습니다.
                        // 여기서는 캔버스 전체에 맞추는 것으로 가정 (기존 로직 유사)
                        // 또는 카드 영역 (215x337)에 정확히 맞추려면 해당 크기로 설정
                        const targetWidth = canvas.width; // 또는 cardAreaWidth
                        const targetHeight = canvas.height; // 또는 cardAreaHeight

                        templateOverlayObj.set({
                            left: (canvas.width - targetWidth) / 2,
                            top: (canvas.height - targetHeight) / 2,
                            width: targetWidth,
                            height: targetHeight,
                            selectable: false,
                            evented: false,
                            hasControls: false,
                            hasBorders: false
                        });

                        canvas.add(templateOverlayObj);
                        canvas.bringToFront(templateOverlayObj); // 항상 가장 위에 위치
                        canvas.renderAll();
                    }, { crossOrigin: 'anonymous' });
                } else {
                    console.error("카드 템플릿 이미지 URL을 받지 못했습니다.");
                }
            } catch (err) {
                console.error("카드 템플릿 이미지 불러오기 실패:", err);
                // 사용자에게 오류 메시지 표시 등의 후속 처리
            }
        }

        // 팝업 열기/닫기 기능
        const openPopupBtn = document.getElementById("openPopupBtn");
        const popupOverlay = document.getElementById("popupOverlay");
        const closePopupBtn = document.getElementById("closePopupBtn");

        if (openPopupBtn) {
            openPopupBtn.addEventListener("click", () => {
                // 1. 캔버스 초기화 (기존 객체들 제거)
                canvas.clear();
                baseRectObj = null;
                overlayImageObj = null;
                templateOverlayObj = null;
                clipZone = null;

                // 2. 흰색 배경 사각형 (baseRectObj) 생성 및 추가
                const baseRectLeft = (canvas.width - cardAreaWidth) / 2;
                const baseRectTop = (canvas.height - cardAreaHeight) / 2;

                baseRectObj = new fabric.Rect({
                    left: baseRectLeft,
                    top: baseRectTop,
                    width: cardAreaWidth,
                    height: cardAreaHeight,
                    fill: 'white',
                    selectable: false,
                    evented: false,
                    stroke: '#ccc', // 구분선 (선택 사항)
                    strokeWidth: 1   // 구분선 두께 (선택 사항)
                });
                canvas.add(baseRectObj);
                canvas.sendToBack(baseRectObj); // 가장 아래로 보냄

                // 3. 클리핑 영역 (clipZone) 생성 (baseRectObj와 동일한 위치 및 크기)
                // 이 객체는 캔버스에 직접 추가되지 않고, overlayImageObj의 clipPath로 사용됩니다.
                clipZone = new fabric.Rect({
                    left: baseRectLeft,
                    top: baseRectTop,
                    width: cardAreaWidth,
                    height: cardAreaHeight,
                    absolutePositioned: true // clipPath는 캔버스 기준 절대 위치
                });

                // 4. 서버에서 카드 템플릿 이미지 로드
                fetchTemplateOverlayImage();

                popupOverlay.style.display = "flex";
                canvas.renderAll(); // 초기 상태 렌더링
            });
        }

        closePopupBtn.addEventListener("click", () => {
            popupOverlay.style.display = "none";
            canvas.clear();
            baseRectObj = null;
            overlayImageObj = null;
            templateOverlayObj = null;
            clipZone = null;
            coverNameInput.value = ''; // 커버 이름 입력 필드 초기화
        });

        popupOverlay.addEventListener("click", (event) => {
            if (event.target === popupOverlay) {
                closePopupBtn.click(); // 닫기 버튼 클릭과 동일한 동작
            }
        });
        
        // Fabric.js 객체 이벤트 리스너 (기존 코드에서 필요한 부분 유지 및 수정)
        canvas.on({
            'object:moving': function(e) {
                // 사용자 이미지가 클립 영역 내에서 잘 보이도록 가이드라인을 줄 수 있지만,
                // 자유롭게 움직여서 원하는 부분을 선택하도록 하는 것이 현재 컨셉인 듯 합니다.
            },
            'object:scaling': function(e) {
                const obj = e.target;
                if (obj === overlayImageObj) {
                    // 최소 크기 제한 등은 유지해도 좋습니다.
                    const minDim = 50; 
                    if (obj.width * obj.scaleX < minDim) obj.scaleX = minDim / obj.width;
                    if (obj.height * obj.scaleY < minDim) obj.scaleY = minDim / obj.height;
                    
                    // 종횡비 유지 로직은 Fabric.js 최신 버전에서 Shift 키 조합으로 기본 제공되는 경우가 많습니다.
                    // 만약 특정 로직이 필요하다면 여기에 구현합니다.
                    // 현재 코드의 종횡비 로직은 복잡하여 Fabric.js 기본 동작에 맡기거나 단순화하는 것을 고려할 수 있습니다.
                }
            },
            'object:modified': function(e) {
                console.log("객체 수정 완료:", e.target.toJSON());
            }
        });


        // 저장 버튼 기능
        saveButton.addEventListener('click', function() {
            if (!overlayImageObj) {
                alert("카드를 꾸밀 이미지를 먼저 업로드해주세요.");
                return;
            }
            if (!baseRectObj) { // baseRectObj가 없으면 저장 기준 영역이 없음
                alert("카드 영역이 설정되지 않았습니다. 팝업을 다시 열어주세요.");
                return;
            }

            const coverName = coverNameInput.value.trim();
            if (!coverName) {
                alert("생성 커버 이름을 입력해주세요.");
                coverNameInput.focus();
                return;
            }

            // 최종 이미지는 baseRectObj(흰색 사각형) 영역만 추출
            const imageDataURL = canvas.toDataURL({
                format: 'png',
                quality: 0.9,
                left: baseRectObj.left,
                top: baseRectObj.top,
                width: baseRectObj.width,
                height: baseRectObj.height
            });

            // 캔버스 전체 상태 (편집 정보 저장용)
            const canvasState = canvas.toJSON(['clipPath']); // clipPath 속성도 포함하여 저장

            console.log("저장할 카드 정보:");
            console.log("커버 이름:", coverName);
            // console.log("추출된 카드 이미지 데이터 URL (Base64):", imageDataURL.substring(0,100) + "...");
            // console.log("전체 캔버스 상태 (JSON):", JSON.stringify(canvasState, null, 2));

            alert(`'${coverName}' 이름으로 카드 정보가 준비되었습니다. (콘솔 확인)\n실제 서버 저장 로직을 구현해야 합니다.`);

            // --- 실제 서버로 데이터 전송 로직 ---
            
            fetch('/saveFinalCard', { // 실제 저장 API 엔드포인트
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    coverName: coverName,
                    imageData: imageDataURL,    // 추출된 카드 영역 이미지
                    canvasFullState: canvasState // 전체 캔버스 상태 (나중에 편집용)
                }),
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('서버 응답:', data);
                if(data.success) { // 서버 응답에 따른 처리
                    alert('카드가 성공적으로 저장되었습니다!');
                    closePopupBtn.click(); // 저장 후 팝업 닫기
                } else {
                    alert('카드 저장에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch((error) => {
                console.error('카드 저장 실패:', error);
                alert('카드 저장 중 오류가 발생했습니다.');
            });
            
        });
    });
    </script>
</body>
</html>