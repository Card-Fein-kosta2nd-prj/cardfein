<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
          <div class="rank-card top1">
            <div class="rank-num">1.</div>
            <img src="" alt="Card1" />
            <div class="title">나의견 카드 커버</div>
            <div class="author">개발자몽</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">2.</div>
            <img src="" alt="Card2" />
            <div class="title">고양 고양이의꿈</div>
            <div class="author">코딩러</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">3.</div>
            <img src="" alt="Card3" />
            <div class="title">간바레 루루</div>
            <div class="author">히어로</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">4.</div>
            <img src="" alt="Card4" />
            <div class="title">고른 선택은 댕기</div>
            <div class="author">삼색이</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">5.</div>
            <img src="" alt="Card5" />
            <div class="title">전공과 커버링</div>
            <div class="author">공돌이</div>
          </div>
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
    async function loadTopRankedCards() {
    	try {
    		const fetchResponse = await fetch('${path}/ajax', {
    			method: "GET",
    			body: new URLSearchParams({
    				key: "rank",
    				methodName: "getTopCardCovers"
    			})
    		});
    		
    		if (!fetchResponse.ok) {
    			throw new Error('서버 응답 오류');
    		}
    		
    		const topCards = await fetchResponse.json();
    		const rankingList = document.querySelector('.ranking-list');
    		
    		topCards.forEach((card, index) => {
    			const rankCard = document.createElement('div');
    			rankCard.classList.add('rank-card');
    			rankCard.classList.add('top${index + 1}');
    			
    			const rankNum = document.createElement('div');
    		    rankNum.classList.add('rank-num');
    		    rankNum.textContent = `${index + 1}.`;

    		    const img = document.createElement('img');
    		    img.src = card.imageUrl;
    		    img.alt = card.title || `Top ${index + 1} Card`;

    		    const titleDiv = document.createElement('div');
    		    titleDiv.classList.add('title');
    		    titleDiv.textContent = card.title || '제목 없음' ;
    		    
    		    rankCard.appendChild(rankNum);
    		    rankCard.appendChild(img);
    		    rankCard.appendChild(titleDiv);
    		    
    		    rankingList.appendChild(rankCard);
    		});
    	} catch (error) {
    		console.error('인기 카드 로드 실패:', error);
    	}
    }
    window.addEventListener('DOMContentLoaded', loadTopRankedCards);
    
    
    
    async function loadCards() {
    	  try {
    	    const fetchResponse = await fetch('${path}/ajax', {
    	    	method: "POST",
    	    	body:new URLSearchParams({
    	    		key:"rank",
    	    		methodName:"getAllCardCover"
    	    	})
    	    });
    	    if (!fetchResponse.ok) throw new Error('서버 응답 오류');

    	    const cards = await fetchResponse.json(); // [{user_id, img_url}, ...]

    	    const grid = document.querySelector('.card-grid');
    	    grid.innerHTML = '';  // 기존 내용 초기화

    	    cards.forEach(card => {
    	      const cardItem = document.createElement('div');
    	      cardItem.classList.add('card-item');
    	      
    	      const likeBtn = document.createElement('button');
    	      likeBtn.classList.add('like-button');
    	      likeBtn.innerHTML = '♡';
    	      likeBtn.setAttribute('data-cover-no', card.cover_no);
    	      
    	      likeBtn.addEventListener('click', async() => {
    	 
    	    		const isLiked = likeBtn.classList.toggle('liked'); 	    		
    	    		const coverNo = likeBtn.getAttribute('data-cover-no');
    	    		<%-- const userNo = '<%= ((LoginDto)session.getAttribute("loginUser")).getUserNo() %>'; --%>
    	    		
    	    		try {
    	    			const likeResponse = await fetch('${path}/ajax', {
    	    				method: "POST",
    	    				body:new URLSearchParams({
    	    					key:"like",
    	    					methodName: "liked",
    	    					cover_no: coverNo,
    	    					userNo: userNo
    	    				})   	    					
    	    			});
    	    			
    	    			if (!likeResponse.ok) throw new Error('서버 저장 실패');
    	    			
    	    			const likeResult = await likeResponse.json();
    	    			
    	    			console.log('서버 응답:', likeResult);
    	    			
    	    			if (likeResult.liked) {
    	    				likeBtn.classList.remove('liked');
    	    				likeBtn.innerHTML = '♡';
    	    			} else {
    	    				likeBtn.classList.add('liked');
    	    				likeBtn.innerHTML = '🤍';
    	    			}
    	    			
    	    		}catch (err) {
    	    			console.error("좋아요 요청 실패:", err);
    	    		}
    	    	});
    	      
    	      const imgContainer = document.createElement('div');
    	      imgContainer.classList.add('img-container');
			   
    	      const img = document.createElement('img');
    	      img.src = card.finalCardUrl;
    	      img.alt = `User ${card.userId}`;
    	      img.classList.add('imgBox');
    	      
    	      const overlayImg = document.createElement('img');
    	      overlayImg.src = `${path}/static/images/small_top.png`;
    	      overlayImg.alt = 'Overlay';
    	      overlayImg.classList.add('overlay');
    	      
    	      imgContainer.appendChild(img);
    	      imgContainer.appendChild(overlayImg);

    	      const title = document.createElement('div');
    	      title.classList.add('title');
    	      title.textContent = card.title;

    	      cardItem.appendChild(likeBtn);
    	      cardItem.appendChild(imgContainer);
    	      cardItem.appendChild(title);

    	      grid.appendChild(cardItem);
    	    });

    	  } catch (error) {
    	    console.error('카드 로드 실패:', error);
    	  }
    	}

    	// 페이지 로드되면 자동 실행
    	window.addEventListener('DOMContentLoaded', loadCards);
    </script>
  </body>
</html>
