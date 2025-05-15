class Sidebar {
    constructor(container, activePage) {
        this.container = container;
        this.activePage = activePage;
        this.render();
        this.attachEventListeners();
    }

    render() {
        const sidebarHtml = `
            <div class="sidebar">
                <ul class="menu">
                    <li class="menu-item ${this.activePage === 'cardReview' ? 'active' : ''}">
                        ${this.activePage === 'cardReview' ? '<h2>카드리뷰</h2>' : '<p>카드리뷰</p>'}
                    </li>
                    <li class="menu-item ${this.activePage === 'contents' ? 'active' : ''}">
                        ${this.activePage === 'contents' ? '<h2>콘텐츠</h2>' : '<p>콘텐츠</p>'}
                    </li>
                    <li class="menu-item ${this.activePage === 'notice' ? 'active' : ''}">
                        <p>공지</p>
                    </li>
                </ul>
            </div>
        `;
        this.container.innerHTML = sidebarHtml;
    }

    attachEventListeners() {
        const menuItems = this.container.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                const menuText = item.textContent.trim();
                
                if (menuText === '공지') {
                    alert('공지 페이지 구현 중입니다.');
                    return;
                }

                // 모든 메뉴 아이템 비활성화 및 p 태그로 변경
                menuItems.forEach(otherItem => {
                    otherItem.classList.remove('active');
                    const text = otherItem.textContent.trim();
                    otherItem.innerHTML = `<p>${text}</p>`;
                });
                
                // 클릭된 아이템 활성화 및 h2 태그로 변경
                item.classList.add('active');
                item.innerHTML = `<h2>${menuText}</h2>`;

                // 라우팅 처리
                switch (menuText) {
                    case '카드리뷰':
                        window.location.href = 'index.html';
                        break;
                    case '콘텐츠':
                        window.location.href = 'content.html';
                        break;
                }
            });
        });
    }
}

// 전역 스코프로 내보내기
window.Sidebar = Sidebar; 