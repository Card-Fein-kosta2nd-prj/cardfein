document.addEventListener('DOMContentLoaded', function() {
    /* 스티키 네비게이션 구현 */
    const nav = document.getElementById('sticky-nav');
    if (nav) {
        // 네비게이션 바 초기 높이 저장
        const navHeight = nav.offsetHeight;
        const navTop = nav.offsetTop;
        
        // 높이 일정하게 유지하기 위한 투명 요소 div 생성
        const navPlaceholder = document.createElement('div');
        navPlaceholder.style.height = navHeight + 'px'; //높이를 네비게이션 바의 높이와 동일하게
        navPlaceholder.style.display = 'none'; // 초기에는 숨김
        nav.parentNode.insertBefore(navPlaceholder, nav.nextSibling); // 네비게이션 바 다음에 투명 div 삽입
        
        // 스크롤 이벤트 핸들러 - 사용자가 페이지를 스크롤할 때마다 호출
        function handleScroll() {
            if (window.scrollY >= navTop) { // 사용자가 스크롤한 위치가 네비게이션 바의 위치보다 크거나 같을 때
                nav.classList.add('sticky'); // 스티키 클래스 추가
                navPlaceholder.style.display = 'block'; // 투명 요소 블록으로 표시
            } else {
                nav.classList.remove('sticky');
                navPlaceholder.style.display = 'none'; // 투명 요소 숨김
            }
        }

        window.addEventListener('scroll', handleScroll); //스크롤 이벤트에 handleScroll 함수 등록
    }

    /* 드롭다운 메뉴 효과 구현 */
    const dropdowns = document.querySelectorAll('.dropdown'); //드롭다운 될 요소들 (랭킹, 카드)
    dropdowns.forEach(dropdown => { //드롭다운 요소들 각각에 대해
        const dropbtn = dropdown.querySelector('.dropbtn');
        const dropdownContent = dropdown.querySelector('.dropdown-content'); //드롭다운 내용 요소

        dropdown.addEventListener('mouseenter', function () {
            dropdownContent.style.visibility = 'visible'; //드롭다운 내용 요소 보이기
            dropdownContent.style.opacity = '1'; //보이기
            dropdownContent.style.transform = 'translateY(0)'; //드롭다운 내용 요소 위치 초기화
        });

        dropdown.addEventListener('mouseleave', function () {
            dropdownContent.style.visibility = 'hidden'; //드롭다운 내용 요소 숨기기
            dropdownContent.style.opacity = '0'; //숨기기
            dropdownContent.style.transform = 'translateY(-10px)'; //드롭다운 내용 요소 위치 위로 이동
        });
    });

	/* 장바구니 수 표시 업데이트 */
	const cartCountEl = document.querySelector(".cart-count");
	if (cartCountEl) {
	    const saved = localStorage.getItem("cartCards");
	    if (saved) {
	        try {
	            const parsed = JSON.parse(saved);
	            const count = parsed.filter(c => c && c.cardNo).length;
	            cartCountEl.textContent = count;
	        } catch (e) {
	            cartCountEl.textContent = 0;
	        }
	    } else {
	        cartCountEl.textContent = 0;
	    }
	}
	
	
});