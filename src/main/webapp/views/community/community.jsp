<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>

<!-- 공통 스타일 -->
<link rel="stylesheet" href="${path}/static/css/common.css">
<!-- 페이지 전용 스타일 -->
<link rel="stylesheet" href="${path}/static/css/community/community.css" defer>
<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js" defer></script>

</head>
<body>

	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />


	<div class="com-container">
		<div class="content-wrapper">
			<div id="sidebar-container">
				<div class="sidebar">
					<ul class="menu" id="sidebar-menu">
						<li class="menu-item" data-type="cardReview"><h2>커뮤니티</h2></li>
						<!-- 
						<li class="menu-item" data-type="cardReview"><h2>카드리뷰</h2></li>
						<li class="menu-item" data-type="contents"><p>콘텐츠</p></li>
						<li class="menu-item" data-type="notice"><p>공지</p></li>
						 -->
					</ul>
				</div>
			</div>
		
			<div class="main-content">
				<div id="list-view">
					<!-- 목록이 비동기로 여기에 표시 -->
				</div>
				<div id="detail-view">
					<!-- 상세 내용이 필요 시 여기에 표시 -->
				</div>
			</div>
	</div>


	<!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />

	</div>
	
	<script>
	//페이지 로딩 시 게시글 목록을 가져오는 함수 호출
	document.addEventListener("DOMContentLoaded", () => {
	  initData();
	});
	
	
	// 게시글 데이터를 서버에서 가져오는 함수
	async function initData() {
		
	  // 서버에 전송할 폼 데이터 준비
	  const body = new URLSearchParams({
	    key: 'review', // 예시에서는 "review" 키 사용
	    methodName: 'selectAll' // 모든 게시글을 가져옴
	  });
	
	  try {
	    // 서버로 데이터 요청 (POST 방식)
	    const response = await fetch('${path}/ajax?key=review&methodName=selectAll', {
	    });
	
	    // 응답이 정상적이지 않으면 에러 처리
	    //if (!response.ok) {
	    //  throw new Error('서버 응답 에러');
	    //}
	
	    // 응답 받은 데이터(JSON)를 변환
	    const result = await response.json();
	     console.log(result);
			
	    // 게시글 목록을 출력할 곳
	    const postsWrapper = document.querySelector('#list-view');
	    let str = '';
	
	    // 게시글 목록을 화면에 출력
		result.forEach((post, i) => {
		  console.log(`post[${i}]:`, post); // 실제 값 출력
		  
		  str += `
	          <div class="post-item" data-post-id="\${post.reviewNo}">
	            <div class="post-content">
	              <h3 class="post-title">\${post.reviewTitle}</h3>
	              <p class="post-meta">\${post.reviewContent.length >= 10 
	            	  					? post.reviewContent.substring(0, 10) + "..." 
	            			  			: post.reviewContent}</p>
	              <div class="post-info">
	              	<div class="post-write-info">
		                <span class="post-writer">\${post.userId}</span>
		                &nbsp;·&nbsp;
		                <span class="post-date">\${post.inputDate.split(' ')[0]}</span>
		            </div>
	                <div class="post-stats">
	                  <span class="views">조회수</span>
	                  <span class="stars">⭐\${post.rating}</span>
	                </div>
	              </div>
	            </div>
	          </div>
	        `;
	      });

	
	    // 화면에 출력
	    postsWrapper.innerHTML = str;
	
	  } catch (err) {
	    alert('에러 발생: ' + err);
	  }
	}
	
	</script>

</body>
</html>