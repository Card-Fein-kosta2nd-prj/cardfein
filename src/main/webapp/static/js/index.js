const carousel = document.querySelector('.carousel');
const items = document.querySelectorAll('.carousel-item');
const prevBtn = document.querySelector('.prev');
const nextBtn = document.querySelector('.next');
const indicators = document.querySelectorAll('.indicator');
const carouselWrapper = document.getElementById('carouselWrapper');

let currentIndex = 0;
let autoPlayInterval;
const autoPlayDelay = 4000; // 4초마다 자동 슬라이드

function showSlide(index) {
	items.forEach(item => item.classList.remove('active'));
	indicators.forEach(indicator => indicator.classList.remove('active'));

	if (index < 0) {
		currentIndex = items.length - 1;
	} else if (index >= items.length) {
		currentIndex = 0;
	} else {
		currentIndex = index;
	}

	items[currentIndex].classList.add('active');
	indicators[currentIndex].classList.add('active');
}

function startAutoPlay() {
	autoPlayInterval = setInterval(() => {
		showSlide(currentIndex + 1);
	}, autoPlayDelay);
}

function stopAutoPlay() {
	clearInterval(autoPlayInterval);
}

prevBtn.addEventListener('click', () => {
	stopAutoPlay();
	showSlide(currentIndex - 1);
	startAutoPlay();
});

nextBtn.addEventListener('click', () => {
	stopAutoPlay();
	showSlide(currentIndex + 1);
	startAutoPlay();
});

indicators.forEach(indicator => {
	indicator.addEventListener('click', () => {
		stopAutoPlay();
		const index = parseInt(indicator.getAttribute('data-index'));
		showSlide(index);
		startAutoPlay();
	});
});

// 마우스가 캐러셀 위에 있을 때 자동 재생 중지
carousel.addEventListener('mouseenter', stopAutoPlay);

// 마우스가 캐러셀에서 벗어났을 때 자동 재생 시작
carousel.addEventListener('mouseleave', startAutoPlay);

// 페이지 로드 시 자동 재생 시작
startAutoPlay();

// 모바일 환경에서 캐러셀 래퍼 위치 조정
function handleMobileView() {
	const isMobile = window.innerWidth <= 768;

	if (isMobile) {
		// 모바일 환경에서는 white-circle 안에서 carousel-wrapper를 빼내기
		const container = document.querySelector('.carousel-container');
		container.appendChild(carouselWrapper);
	} else {
		// 데스크톱 환경에서는 원래 위치로 되돌리기
		const whiteCircle = document.querySelector('.white-circle');
		whiteCircle.appendChild(carouselWrapper);
	}
}

// 페이지 로드 및 화면 크기 변경 시 호출
window.addEventListener('DOMContentLoaded', handleMobileView);
window.addEventListener('resize', handleMobileView);