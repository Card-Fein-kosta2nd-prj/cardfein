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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
<!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js" defer></script>

</head>
<body>

	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />


	<div class="com-container">
		<div class="com-header">
			<a href="${path}/views/community/community.jsp"><h1>커뮤니티</h1></a>
			
		
		</div>
		<div class="content-wrapper">
			<div id="sidebar-container">
				<div class="sidebar">
					<div class="menu" id="sidebar-menu">
						<c:if test="${not empty sessionScope.loginUser}">
							<button class="write-content" onclick="window.location.href='${path}/front?key=detail&methodName=selectUserCards'">글쓰기</button>
						</c:if>
						<div class="search-container">
		<!-- 				<select class="search-select">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writer">작성자</option>
							</select> -->
							<input type="text" class="search-input" placeholder="검색어 입력">
							<!-- <button class="search-button">검색</button> -->
						</div>
					</div>
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



	</div>

	<!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />
	
	<script>
	let currentPage = 1;
	
	//페이지 로딩 시 게시글 목록을 가져오는 함수 호출
	document.addEventListener("DOMContentLoaded", () => {
	  fetchData(currentPage, "");
	});
	
	let keywordInput = "";
	let debounceTimer = null;

	document.querySelector('.search-input').addEventListener('keyup', (e) => {
	  keywordInput = e.target.value.trim();
	  currentPage = 1;

	  // 디바운싱: 0.3초 동안 입력 없을 때만 fetch
	  if (debounceTimer) clearTimeout(debounceTimer);
	  debounceTimer = setTimeout(() => {
	    fetchData(currentPage, keywordInput);
	  }, 300);
	});
	
	// 게시글 데이터를 서버에서 가져오는 함수
	const fetchData = async (pageNo, keyword = "") => {
		/* const body = new URLSearchParams({
		  key: "review",
		  methodName: "selectAll",
		  pageNo: pageNo
		}); */
		
		const params = new URLSearchParams({
			  key: "review",
			  methodName: "selectAll",
			  pageNo: pageNo,
			  keyword: keyword
			});

			try {
				const response = await fetch(`${path}/ajax?${"${params.toString()}"}`);
				
	    /* const response = await fetch(`${path}/ajax?${query.toString()}`,  {
            method: "POST",
            body : body
        }); */
	    
	    //응답이 정상적이지 않으면 에러 처리
	    if (!response.ok) {
	    	throw new Error('서버 응답 에러');
	    }
	
	    // 응답 받은 데이터(JSON)를 변환
	    const result = await response.json();
	    console.log("게시글 목록:", result.list);
	    console.log("페이지 정보:", result.page);
		
	    renderList(result.list);
	    renderPagination(result.page);
	  } catch (err) {
	    alert('데이터 불러오기 실패: ' + err);
	  }
	}

	// 게시글 리스트 렌더링
	function renderList(list) {
	  const postsWrapper = document.querySelector('#list-view');
	  let str = '';

	  list.forEach((post) => {
	    str += `
	      <div class="post-item" data-post-id="${post.reviewNo}">
	        <a href="${path}/front?key=detail&methodName=selectDetailByReviewNo&reviewNo=\${post.reviewNo}">
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
	              <span class="reply">
	              	<img src="${path}/static/images/icons/reply.png" alt="views">
	              	\${post.replyCount}
	              </span>
	              <span class="stars">
	              	<img src="${path}/static/images/icons/star.png" alt="rating">
	              	\${post.rating}
	              </span>
	            </div>
	          </div>
	          </a>
	        </div>
	        <div class = "post-image-container">
	        	<img src="${path}/static/images/cards/\${post.cardImg}" alt="${'${post.cardName}'}" class="card-image">
	        </div>
	      </div>
	    `;
	  });

	  postsWrapper.innerHTML = str;
	  
	  };

	//페이징 함수
	function renderPagination(page, keyword = "") {
		  let str = '<div class="pagination">';
		
		  if (page.startPage > 1) {
		    str += `
		      <a href="#" class="prev-page">
		        <i class="fas fa-chevron-left"></i>
		      </a>
		    `;
		  }
		
		  for (let i = page.startPage; i <= page.endPage; i++) {
		    str += '<a href="#" class="page-number' + (i === page.pageNo ? ' active' : '') +
		           '" data-page="' + i + '">' + i + '</a>';
		  }
		
		  if (page.endPage < page.pageCnt) {
		    str += `
		      <a href="#" class="next-page">
		        <i class="fas fa-chevron-right"></i>
		      </a>
		    `;
		  }
		
		  str += '</div>';
		
		  const existing = document.querySelector('.pagination');
		  if (existing) existing.remove();
		
		  document.querySelector('.main-content').insertAdjacentHTML('beforeend', str);
		
		  document.querySelectorAll('.page-number').forEach(btn => {
		    btn.addEventListener('click', (e) => {
		      e.preventDefault();
		      const page = parseInt(btn.dataset.page);
		      if (!isNaN(page)) {
		        currentPage = page;
		        fetchData(currentPage, keyword);
		      }
		    });
		  });
		
		  const prevBtn = document.querySelector('.prev-page');
		  if (prevBtn) {
		    prevBtn.addEventListener('click', (e) => {
		      e.preventDefault();
		      currentPage = page.startPage - 1;
		      fetchData(currentPage, keyword);
		    });
		  }
		
		  const nextBtn = document.querySelector('.next-page');
		  if (nextBtn) {
		    nextBtn.addEventListener('click', (e) => {
		      e.preventDefault();
		      currentPage = page.endPage + 1;
		      fetchData(currentPage, keyword);
		    });
		  }
		}

// 상세 보기 그리기
function renderDetail(post) {
  const detailView = document.getElementById("detail-view");

  detailView.innerHTML = `
    <button class="back-button">← 목록으로</button>
    <h2>${post.title}</h2>
    <p>작성일: ${post.date}</p>
    <img src="${post.imagePath}" alt="${post.title}" style="width:300px;">
    <p>${post.content}</p>
  `;

  // 보기 전환
  document.getElementById("list-view").style.display = "none";
  detailView.style.display = "block";

  // 뒤로가기 버튼 이벤트
  document.querySelector(".back-button").addEventListener("click", () => {
    detailView.style.display = "none";
    document.getElementById("list-view").style.display = "block";
  });
}

// 게시글 클릭 이벤트 바인딩 (라우터 없이)
function attachPostClickEvents() {
  document.querySelectorAll('.post-item').forEach(item => {
    item.addEventListener('click', () => {
      const postId = item.dataset.postId;
      const post = posts[postId];
      renderDetail(post);
    });
  });
}


	
	</script>

</body>
</html>