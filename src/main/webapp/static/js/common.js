document.addEventListener('DOMContentLoaded', function() {
    // 스티키 네비게이션 구현
    const nav = document.getElementById('sticky-nav');
    if (nav) {
        const navTop = nav.offsetTop;

        function handleScroll() {
            if (window.scrollY >= navTop) {
                nav.classList.add('sticky');
            } else {
                nav.classList.remove('sticky');
            }
        }

        window.addEventListener('scroll', handleScroll);
    }

    // 드롭다운 메뉴 효과 구현
    const dropdowns = document.querySelectorAll('.dropdown');
    dropdowns.forEach(dropdown => {
        const dropbtn = dropdown.querySelector('.dropbtn');
        const dropdownContent = dropdown.querySelector('.dropdown-content');

        dropdown.addEventListener('mouseenter', function () {
            dropdownContent.style.visibility = 'visible';
            dropdownContent.style.opacity = '1';
            dropdownContent.style.transform = 'translateY(0)';
        });

        dropdown.addEventListener('mouseleave', function () {
            dropdownContent.style.visibility = 'hidden';
            dropdownContent.style.opacity = '0';
            dropdownContent.style.transform = 'translateY(-10px)';
        });
    });
});