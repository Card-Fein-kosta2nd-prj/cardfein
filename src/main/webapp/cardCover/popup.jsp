<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <canvas id="cardCanvas" width="320" height="448"></canvas>
                        <img id="baseImage" class="base-image" src="" alt="Base Image" style="display:none;" />
                        <img id="overlayImage" class="overlay-image" src="" alt="Overlay Image" style="display:none;" />
                    </div>
                </div>
                <div class="cover-title">
                    <p>생성 커버 이름 :</p>
                    <input type="text" />
                </div>
                <div class="BtnContainer">
                    <button type="button" class="saveBtn">저장하기</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/fabric.js/5.3.1/fabric.min.js"></script>

    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        const canvas = new fabric.Canvas('cardCanvas', {
            backgroundColor: '#f0f0f0'
        });
		
        const baseUrl = "${pageContext.request.contextPath}";
        const uploadImageMenu = document.getElementById('uploadImageMenu');
        const coverNameInput = document.querySelector('.cover-title input[type="text"]');
        const saveButton = document.querySelector('.saveBtn');

        let baseRectObj = null;
        let overlayImageObj = null;
        let templateOverlayObj = null;

        const cardAreaWidth = 298;
        const cardAreaHeight = 418;

        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.accept = 'image/*';
        fileInput.style.display = 'none';
        document.body.appendChild(fileInput);

        uploadImageMenu.addEventListener('click', () => fileInput.click());

        fileInput.addEventListener('change', function (e) {
            const file = e.target.files[0];
            if (!file) return;

            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                fileInput.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function (event) {
                fabric.Image.fromURL(event.target.result, function (img) {
                   
                    if (overlayImageObj && canvas.contains(overlayImageObj)) {
                        canvas.remove(overlayImageObj);
                    }
                    overlayImageObj = img;

                 // 이미지를 원래 크기로 설정
                    overlayImageObj.set({
                        left: (canvas.width - img.width) / 2, // 캔버스 중앙에 배치
                        top: (canvas.height - img.height) / 2, // 캔버스 중앙에 배치
                        hasControls: true,
                        hasBorders: true,
                        selectable: true,
                        evented: true,
                        lockScalingFlip: true
                    });

                    canvas.add(overlayImageObj);
                    canvas.bringToFront(overlayImageObj);
                    canvas.renderAll();
                }, { crossOrigin: 'anonymous' });
            };
            reader.readAsDataURL(file);
            fileInput.value = '';
        });

        async function fetchTemplateOverlayImage() {
            const actionUrl = "/ajax?action=getBaseImage";

            try {
                const response = await fetch(baseUrl + actionUrl, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                    },
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const data = await response.json();
                const imgUrl = data.baseImageUrl;
                console.log("받아온 이미지", imgUrl);

                if (imgUrl) {
                   const baseImage = document.getElementById('baseImage');
                    baseImage.src = baseUrl + imgUrl;
                    baseImage.style.display = 'block';
                    
                    fabric.Image.fromURL(baseImage.src, function (img) {
                        img.set({
                            left: (canvas.width - img.width) / 2, // 중앙에 배치
                            top: (canvas.height - img.height) / 2, // 중앙에 배치
                            hasControls: false,
                            hasBorders: false,
                            selectable: false,
                            evented: false
                        });

                        canvas.add(img);
                        canvas.renderAll();
                    }, { crossOrigin: 'anonymous' });
                } else {
                    console.error("카드 템플릿 이미지 URL을 받지 못했습니다.");
                }
            } catch (err) {
                console.error("카드 템플릿 이미지 불러오기 실패:", err);
            }
        }

        const openPopupBtn = document.getElementById("openPopupBtn");
        const popupOverlay = document.getElementById("popupOverlay");
        const closePopupBtn = document.getElementById("closePopupBtn");

        if (openPopupBtn) {
            openPopupBtn.addEventListener("click", () => {
                canvas.clear();
                baseRectObj = null;
                overlayImageObj = null;
                templateOverlayObj = null;
                clipZone = null;

                baseRectObj = new fabric.Rect({
                    left: (canvas.width - cardAreaWidth) / 2,
                    top: (canvas.height - cardAreaHeight) / 2,
                    width: cardAreaWidth,
                    height: cardAreaHeight,
                    fill: 'white',
                    selectable: false,
                    evented: false,
                    stroke: 'transparent',
                    strokeWidth: 1
                });
                canvas.add(baseRectObj);
                canvas.sendToBack(baseRectObj);

                clipZone = new fabric.Rect({
                    left: baseRectObj.left,
                    top: baseRectObj.top,
                    width: cardAreaWidth,
                    height: cardAreaHeight,
                    absolutePositioned: true
                });

                fetchTemplateOverlayImage();

                popupOverlay.style.display = "flex";
                canvas.renderAll();
            });
        }

        closePopupBtn.addEventListener("click", () => {
            popupOverlay.style.display = "none";
            canvas.clear();
            baseRectObj = null;
            overlayImageObj = null;
            templateOverlayObj = null;
            clipZone = null;
            coverNameInput.value = '';
        });

        popupOverlay.addEventListener("click", (event) => {
            if (event.target === popupOverlay) {
                closePopupBtn.click();
            }
        });

        canvas.on({
            'object:moving': function(e) {
                // 사용자 이미지가 클립 영역 내에서 잘 보이도록 가이드라인을 줄 수 있지만,
                // 자유롭게 움직여서 원하는 부분을 선택하도록 하는 것이 현재 컨셉인 듯 합니다.
            },
            'object:scaling': function(e) {
                const obj = e.target;
                if (obj === overlayImageObj) {
                    const minDim = 50; 
                    if (obj.width * obj.scaleX < minDim) obj.scaleX = minDim / obj.width;
                    if (obj.height * obj.scaleY < minDim) obj.scaleY = minDim / obj.height;
                }
            },
            'object:modified': function(e) {
                console.log("객체 수정 완료:", e.target.toJSON());
            }
        });
		
        // 카드커버 저장
        saveButton.addEventListener('click', function() {
            if (!overlayImageObj) {
                alert("카드를 꾸밀 이미지를 먼저 업로드해주세요.");
                return;
            }
            if (!baseRectObj) {
                alert("카드 영역이 설정되지 않았습니다. 팝업을 다시 열어주세요.");
                return;
            }

            const coverName = coverNameInput.value.trim();
            if (!coverName) {
                alert("생성 커버 이름을 입력해주세요.");
                coverNameInput.focus();
                return;
            }
			// 캔버스 내용을 이미지 데이터 URL로 변환
            const imageDataURL = canvas.toDataURL({
                format: 'png',
                quality: 0.9,
                left: baseRectObj.left,
                top: baseRectObj.top,
                width: baseRectObj.width,
                height: baseRectObj.height
            });

            /* const canvasState = canvas.toJSON(['clipPath']); */

            alert(`'${coverName}' 이름으로 카드 정보가 준비되었습니다`);
            
            const newData = new URLSearchParams();
            newData.append("title", coverName);
            newData.append("finalImageUrl", imageDataURL);

            try {
                const response = fetch(baseUrl + '/ajax?action=saveFinalCard', {
                    method: 'POST',
                    // 서버가 application/x-www-form-urlencoded를 기대하므로 Content-Type을 설정하지 않거나,
                    // 'application/x-www-form-urlencoded'로 명시해야 합니다.
                    // URLSearchParams를 body로 사용하면 Content-Type이 자동으로 설정됩니다.
                    body: newData.toString(), // URLSearchParams 객체를 문자열로 변환하여 보냅니다.
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded' // 명시적으로 설정
                    }
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const result = response.json(); // JSON 응답을 파싱

                if (result.success) {
                    alert('카드가 성공적으로 저장되었습니다!');
                    closePopupBtn.click();
                } else {
                    alert('카드 저장에 실패했습니다: ' + (result.message || '알 수 없는 오류'));
                }
            } catch (error) {
                console.error('카드 저장 실패:', error);
                alert('카드 저장 중 오류가 발생했습니다.');
            }
        });
    });
    </script>
</body>
</html>
