<%@page import="cardfein.kro.kr.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String path = request.getContextPath();
  LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
  int userNo = (loginUser != null) ? loginUser.getUserNo() : -1;
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="${path}/static/css/common.css" />
    <link rel="stylesheet" href="${path}/static/css/cardranking.css" />
  </head>
  <body>
    <jsp:include page="/views/common/header.jsp" />
    <div class="container">
      <!-- 로고 및 상단 네비게이션 -->
      <div class="top-bar">
        <div class="logo">카드커버</div>
        <div class="nav">
          <a href="#">베스트</a>
          <a href="#">카드커버</a>
          <a href="#">DIY카드</a>
          <a href="#">스티커제작소</a>
          <a href="#">스티커샵</a>
          <a href="#">쇼룸</a>
          <a href="#">뉴스룸</a>
        </div>
      </div>

      <!-- TOP100 랭킹 -->
      <div class="ranking-section">
        <h2>카드커버 TOP100 <span class="powered">Powered by @gif</span></h2>
        <div class="ranking-list">
          
        </div>
      </div>

      <!-- 카드 목록 -->
      <div class="card-grid">
        <div class="card-item">
          <img src="" alt="Card6" />
          <div class="title">고른 선택, 댕기</div>
        </div>
        
      </div>
    </div>

    <jsp:include page="/views/common/footer.jsp" />
  
    <script type="text/javascript">
    	const userNo = <%= userNo %>;
    	const path = '<%= path %>';
    	const ajaxUrl = `${path}/ajax`;
    	
    	async function handleLikeClick(event) {
    		  const likeBtn = event.currentTarget;
    		  if (userNo === -1) {
    		    alert("로그인 후 이용해주세요.");
    		    return;
    		  }

    		  const coverNo = likeBtn.getAttribute("data-cover-no");

    		  try {
    		    const likeResponse = await fetch(ajaxUrl, {
    		      method: "POST",
    		      body: new URLSearchParams({
    		        key: "like",
    		        methodName: "liked",
    		        cover_no: coverNo,
    		        user_no: userNo,
    		      }),
    		    });

    		    if (!likeResponse.ok) throw new Error("서버 저장 실패");

    		    const likeResult = await likeResponse.json();

    		    console.log("서버 응답:", likeResult);

    		    if (likeResult.liked) {
    		      likeBtn.classList.add("liked");
    		      likeBtn.innerHTML = "🤍";
    		    } else {
    		      likeBtn.classList.remove("liked");
    		      likeBtn.innerHTML = "♡";
    		    }
    		  } catch (err) {
    		    console.error("좋아요 요청 실패:", err);
    		    alert("좋아요 처리 중 오류가 발생했습니다.");
    		  }
    		}

    		// 사용자가 좋아요 했는지 확인
    		async function initializeLikeButton(likeBtn, coverNo) {
    		  if (userNo !== -1) {
    		    try {
    		      const checkLikeResponse = await fetch(ajaxUrl, {
    		        method: "POST",
    		        body: new URLSearchParams({
    		          key: "like",
    		          methodName: "hasUserLiked",
    		          cover_no: coverNo,
    		          user_no: userNo,
    		        }),
    		      });

    		      if (!checkLikeResponse.ok) throw new Error("좋아요 확인 요청 실패");
    		      const likeResult = await checkLikeResponse.json();

    		      if (likeResult.liked) {
    		        likeBtn.classList.add("liked");
    		        likeBtn.innerHTML = "🤍";
    		      }
    		    } catch (err) {
    		      console.error("초기 좋아요 상태 확인 실패:", err);
    		    }
    		  }

    		  likeBtn.addEventListener("click", handleLikeClick);
    		}

    		// 커버 이미지 랭킹 호출
    		async function loadTopRankedCards() {
    		  try {
    		    const fetchResponse = await fetch(ajaxUrl, {
    		      method: "POST",
    		      body: new URLSearchParams({
    		        key: "rank",
    		        methodName: "getTopCardCovers",
    		      }),
    		    });

    		    if (!fetchResponse.ok) {
    		      throw new Error("서버 응답 오류");
    		    }

    		    const topCards = await fetchResponse.json();
    		    console.log("topCards : ", topCards);
    		    const rankingList = document.querySelector(".ranking-list");

    		    topCards.forEach((card) => {
    		      const rankCard = document.createElement("div");
    		      rankCard.classList.add("rank-card");

    		      const rankNum = document.createElement("div");
    		      rankNum.classList.add("rank-num");
    		      rankNum.textContent = card.cardRank + "위";

    		      const imgContainer = document.createElement("div");
    		      imgContainer.classList.add("rank-img-container");

    		      const img = document.createElement("img");
    		      img.src = card.finalCardUrl;
    		      img.classList.add("rank-img");

    		      const overlayImg = document.createElement("img");
    		      overlayImg.src = `${path}/static/images/small_top.png`;
    		      overlayImg.alt = "Overlay";
    		      overlayImg.classList.add("rank-overlay");

    		      imgContainer.appendChild(img);
    		      imgContainer.appendChild(overlayImg);

    		      const titleDiv = document.createElement("div");
    		      titleDiv.classList.add("title");
    		      titleDiv.textContent = card.title;

    		      rankCard.appendChild(rankNum);
    		      rankCard.appendChild(imgContainer);
    		      rankCard.appendChild(titleDiv);

    		      rankingList.appendChild(rankCard);
    		    });
    		  } catch (error) {
    		    console.error("인기 카드 로드 실패:", error);
    		  }
    		}

    		// 전체 커버 이미지 요청
    		async function loadCards() {
    		  try {
    		    const fetchResponse = await fetch(ajaxUrl, {
    		      method: "POST",
    		      body: new URLSearchParams({
    		        key: "rank",
    		        methodName: "getAllCardCover",
    		      }),
    		    });
    		    if (!fetchResponse.ok) throw new Error("서버 응답 오류");

    		    const cards = await fetchResponse.json();

    		    console.log("온 거 :", cards);
    		    const grid = document.querySelector(".card-grid");
    		    grid.innerHTML = "";

    		    cards.forEach(async (card) => {
    		      const cardItem = document.createElement("div");
    		      cardItem.classList.add("card-item");

    		      const likeBtn = document.createElement("button");
    		      likeBtn.classList.add("like-button");
    		      likeBtn.innerHTML = "♡";
    		      likeBtn.setAttribute("data-cover-no", card.cover_no);
    		      initializeLikeButton(likeBtn, card.cover_no); // 초기 상태 설정

    		      const imgContainer = document.createElement("div");
    		      imgContainer.classList.add("img-container");

    		      const img = document.createElement("img");
    		      img.src = card.finalCardUrl;
    		      img.alt = `User ${card.userId}`;
    		      img.classList.add("imgBox");

    		      const overlayImg = document.createElement("img");
    		      overlayImg.src = `${path}/static/images/small_top.png`;
    		      overlayImg.alt = "Overlay";
    		      overlayImg.classList.add("overlay");

    		      imgContainer.appendChild(img);
    		      imgContainer.appendChild(overlayImg);

    		      const title = document.createElement("div");
    		      title.classList.add("title");
    		      title.textContent = card.title;

    		      cardItem.appendChild(likeBtn);
    		      cardItem.appendChild(imgContainer);
    		      cardItem.appendChild(title);

    		      grid.appendChild(cardItem);
    		    });
    		  } catch (error) {
    		    console.error("카드 로드 실패:", error);
    		  }
    		}

    		// 페이지 로드되면 자동 실행
    		window.addEventListener("DOMContentLoaded", () => {
    		  loadTopRankedCards();
    		  // 10분마다 커버 랭킹 업데이트
    		  setInterval(loadTopRankedCards, 600000);
    		  loadCards();
    		});
    </script>
    <%-- <script src="${path}/static/js/cardCover/cardranking.js"></script> --%>
  </body>
</html>
