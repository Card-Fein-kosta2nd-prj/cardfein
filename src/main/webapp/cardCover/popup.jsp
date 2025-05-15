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
                            src="${path}/static/images/icons/user-img.png"
                            alt="Image" />
                        <span>IMAGE</span>
                    </div>
                </div>
                <div class="card-preview">
                    <div class="image-wrapper">
                        <canvas id="cardCanvas" width="300" height="448"></canvas>
                        <img id="baseImage" class="base-image" src="${path}/static/images/small_top.png" alt="Base Image"/>
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
        const baseImage = document.getElementById('baseImage');
        console.log("이미지 경로:", baseImage.src);

        let baseRectObj = null;
        let overlayImageObj = null;
        let templateOverlayObj = null;

        const cardAreaWidth = 300;
        const cardAreaHeight = 448;

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

        const openPopupBtn = document.getElementById("openPopupBtn");
        const popupOverlay = document.getElementById("popupOverlay");
        const closePopupBtn = document.getElementById("closePopupBtn");

        // 팝업이 열릴 때, baseRectObj를 만들어 canvas에 추가, 그리고 기본 마그네틱 이미지도 캔버스에 추가
        if (openPopupBtn) {
            openPopupBtn.addEventListener("click", async () => {
                canvas.clear();
                baseRectObj = null;
                overlayImageObj = null;
                templateOverlayObj = null;

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
                
                const base64 = await imageToBase64(baseImage);
                fabric.Image.fromURL(base64, function(img) {
                	templateOverlayObj = img;
                	templateOverlayObj.set({
                		left: (canvas.width - img.width) / 2,
                		top: (canvas.height - img.height) / 2,
                		selectable: false,
                		evented: false
                	});
                	if (img.width > canvas.width || img.height > canvas.height) {
                		img.scaleToWidth(canvas.width);
                	}
                	
                	canvas.add(templateOverlayObj);
                	arrangeLayersInOrder();
                	canvas.renderAll();
                });

                /* fetchTemplateOverlayImage(); */

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
            /* clipZone = null; */
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
        
     // HTMLImageElement → base64 string으로 변환
        function imageToBase64(imgElement) {
            return new Promise((resolve) => {
                const canvas = document.createElement("canvas");
                canvas.width = imgElement.naturalWidth;
                canvas.height = imgElement.naturalHeight;

                const ctx = canvas.getContext("2d");
                ctx.drawImage(imgElement, 0, 0);

                const dataURL = canvas.toDataURL("image/png");
                resolve(dataURL);
            });
        }
        
     // 레이어 순서 재조정 함수 (재사용을 위해 별도 함수로 분리)
        function arrangeLayersInOrder() {
        	/* const objects = canvas.getObjects();
            canvas.clear(); // 캔버스 초기화 */
            canvas.remove(...canvas.getObjects());

            // 순서대로 객체 추가
            if (baseRectObj) {
                canvas.add(baseRectObj);
            }
            if (overlayImageObj) {
                canvas.add(overlayImageObj);
            }
            if (templateOverlayObj) {
                canvas.add(templateOverlayObj);
            }

            canvas.renderAll();
        }
		
     // 카드커버 저장
        saveButton.addEventListener('click', async function() {
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

            // 최종 레이어 순서 설정
            arrangeLayersInOrder();

            console.log("캔버스 객체 (저장 직전):", canvas.getObjects().map(obj => ({
                type: obj.type,
                zIndex: canvas.getObjects().indexOf(obj),
                src: obj.getSrc ? obj.getSrc() : 'N/A'
            })));

         // 캔버스를 base64 → Blob으로 변환
            const dataURL = canvas.toDataURL('image/png');

            // base64 → Blob 변환 함수
            function base64ToBlob(base64, mime = 'image/png') {
                const base64Data = base64.split(',')[1];
                const binary = atob(base64Data);
                const array = new Uint8Array(binary.length);
                for (let i = 0; i < binary.length; i++) {
                    array[i] = binary.charCodeAt(i);
                }
                return new Blob([array], { type: mime });
            }

            const imageBlob = base64ToBlob(dataURL);

            // FormData로 전송 (multipart/form-data)
            const formData = new FormData();
            const fileName = coverName+".png";
            
            formData.append('key', 'cover');
            formData.append('methodName', "saveFinalCard")
            formData.append('title', coverName);
            formData.append('finalImage', imageBlob, fileName);

            try {
                const response = await fetch('${path}/ajax', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const result = await response.json();

                if (result.success) {
                    alert(result.message || '카드 저장 성공');
                    closePopupBtn.click();
                } else {
                    alert(result.message || "카드 저장에 실패");
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