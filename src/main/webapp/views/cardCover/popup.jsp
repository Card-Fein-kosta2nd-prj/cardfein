<%@page import="cardfein.kro.kr.dto.LoginDto"%>
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

	<%
    	LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
    	int userNo = (loginUser != null) ? loginUser.getUserNo() : -1;
    %>
    <script type="text/javascript">
    const userNo = <%= userNo %>;
    const path = "${path}";
    </script>
    <script src="${path}/static/js/cardCover/popup.js"></script>
</body>
</html>