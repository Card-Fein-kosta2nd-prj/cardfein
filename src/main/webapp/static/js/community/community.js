/*// 전역 데이터 저장소
let posts = {};
const POSTS_PER_PAGE = 5; // 페이지당 게시물 수
let currentPage = 1;

// 데이터 로드 함수
async function loadData() {
	try {
		const response = await fetch('data.json');
		const data = await response.json();
		posts = data.posts;
		renderListView();
		renderPagination();
	} catch (error) {
		console.error('데이터 로드 실패:', error);
	}
}

// 페이지네이션 렌더링
function renderPagination() {
	const totalPosts = Object.keys(posts).length;
	const totalPages = Math.ceil(totalPosts / POSTS_PER_PAGE);

	const paginationContainer = document.createElement('div');
	paginationContainer.className = 'pagination';

	// 이전 페이지 버튼
	if (currentPage > 1) {
		const prevButton = document.createElement('a');
		prevButton.href = '#';
		prevButton.className = 'prev-page';
		const prevIcon = document.createElement('i');
		prevIcon.className = 'fas fa-chevron-left';
		prevButton.appendChild(prevIcon);

		prevButton.addEventListener('click', (e) => {
			e.preventDefault();
			currentPage--;
			renderListView();
			renderPagination();
		});

		paginationContainer.appendChild(prevButton);
	}

	// 페이지 번호
	for (let i = 1; i <= totalPages; i++) {
		const pageLink = document.createElement('a');
		pageLink.href = '#';
		pageLink.className = `page-number ${i === currentPage ? 'active' : ''}`;
		pageLink.textContent = i;

		pageLink.addEventListener('click', (e) => {
			e.preventDefault();
			currentPage = i;
			renderListView();
			renderPagination();
		});

		paginationContainer.appendChild(pageLink);
	}

	// 다음 페이지 버튼
	if (currentPage < totalPages) {
		const nextButton = document.createElement('a');
		nextButton.href = '#';
		nextButton.className = 'next-page';
		const nextIcon = document.createElement('i');
		nextIcon.className = 'fas fa-chevron-right';
		nextButton.appendChild(nextIcon);

		nextButton.addEventListener('click', (e) => {
			e.preventDefault();
			currentPage++;
			renderListView();
			renderPagination();
		});

		paginationContainer.appendChild(nextButton);
	}

	// 기존 페이지네이션 제거 후 새로운 페이지네이션 추가
	const existingPagination = document.querySelector('.pagination');
	if (existingPagination) {
		existingPagination.remove();
	}
	document.getElementById('list-view').appendChild(paginationContainer);
}

// 목록 뷰 렌더링
function renderListView() {
	const listView = document.getElementById('list-view');
	// 기존 내용 제거
	while (listView.firstChild) {
		listView.removeChild(listView.firstChild);
	}

	const startIndex = (currentPage - 1) * POSTS_PER_PAGE;
	const endIndex = startIndex + POSTS_PER_PAGE;

	Object.values(posts).slice(startIndex, endIndex).forEach(post => {
		const postItem = document.createElement('div');
		postItem.className = 'post-item';
		postItem.dataset.postId = post.id;

		const postContent = document.createElement('div');
		postContent.className = 'post-content';

		const title = document.createElement('h3');
		title.className = 'post-title';
		title.textContent = post.title;

		const meta = document.createElement('p');
		meta.className = 'post-meta';
		meta.textContent = post.content;

		const postInfo = document.createElement('div');
		postInfo.className = 'post-info';

		const date = document.createElement('span');
		date.className = 'post-date';
		date.textContent = `날짜 : ${post.date}`;

		const postStats = document.createElement('div');
		postStats.className = 'post-stats';

		const views = document.createElement('span');
		views.className = 'views';
		const viewsIcon = document.createElement('i');
		viewsIcon.className = 'far fa-eye';
		views.appendChild(viewsIcon);
		views.appendChild(document.createTextNode(` ${post.views}`));

		const stars = document.createElement('span');
		stars.className = 'stars';
		const starsIcon = document.createElement('i');
		starsIcon.className = 'far fa-star';
		stars.appendChild(starsIcon);
		stars.appendChild(document.createTextNode(` ${post.stars}`));

		postStats.appendChild(views);
		postStats.appendChild(stars);

		postInfo.appendChild(date);
		postInfo.appendChild(postStats);

		postContent.appendChild(title);
		postContent.appendChild(meta);
		postContent.appendChild(postInfo);

		const imageContainer = document.createElement('div');
		imageContainer.className = 'post-image-container';

		const image = document.createElement('img');
		image.src = post.imagePath;
		image.alt = post.title;
		image.className = 'card-image';
		image.width = 100;
		image.height = 200;

		imageContainer.appendChild(image);

		postItem.appendChild(postContent);
		postItem.appendChild(imageContainer);

		listView.appendChild(postItem);
	});
	attachPostClickEvents();
}

// 상세 뷰 렌더링

// 게시글 클릭 이벤트 바인딩
function attachPostClickEvents() {
	document.querySelectorAll('.post-item').forEach(item => {
		item.addEventListener('click', () => {
			const postId = item.dataset.postId;
			router.navigate(`?post=${postId}`);
		});
	});
}

// 라우터 설정
const router = {
	init: function() {
		this.handleLocation();
		window.addEventListener('popstate', () => this.handleLocation());
	},

	handleLocation: function() {
		const searchParams = new URLSearchParams(window.location.search);
		const postId = searchParams.get('post');

		if (postId) {
			this.showDetail(postId);
		} else {
			this.showList();
		}
	},

	navigate: function(path) {
		window.history.pushState({}, '', path);
		this.handleLocation();
	},

	showList: function() {
		document.getElementById('detail-view').style.display = 'none';
		document.getElementById('list-view').style.display = 'block';
	},

	showDetail: function(postId) {
		const post = posts[postId];
		if (!post) {
			this.showList();
			return;
		}

		// 상세 페이지로 이동
		window.location.href = `detail.html?id=${postId}`;
	}
};

// 초기화
document.addEventListener('DOMContentLoaded', () => {
	// 데이터 로드
	loadData();

	// 라우터 초기화
	router.init();

	// 메뉴 클릭 이벤트
	document.querySelectorAll('.menu-item').forEach(item => {
		item.addEventListener('click', () => {
			const menuText = item.textContent.trim();

			// 모든 메뉴 아이템 비활성화 및 p 태그로 변경
			document.querySelectorAll('.menu-item').forEach(otherItem => {
				otherItem.classList.remove('active');
				const text = otherItem.textContent.trim();
				otherItem.innerHTML = `<p>${text}</p>`;
			});

			// 클릭된 아이템 활성화 및 h2 태그로 변경
			item.classList.add('active');
			item.innerHTML = `<h2>${menuText}</h2>`;

			// 라우팅 처리
			if (menuText === '카드리뷰') {
				router.navigate('/');
			} else if (menuText === '콘텐츠') {
				window.location.href = 'content.html';
			}
		});
	});

	// 사이드바 초기화
	const sidebarContainer = document.getElementById('sidebar-container');
	new Sidebar(sidebarContainer, 'cardReview');
});*/