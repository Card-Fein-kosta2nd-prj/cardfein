// 카드 데이터 예시
const cards = [
    { name: "쇼핑플러스카드", benefit: "쇼핑 할인", company: "신한카드" },
    { name: "마이카드", benefit: "주유 할인", company: "국민카드" },
    { name: "여행드림카드", benefit: "해외 항공 혜택", company: "삼성카드" },
  ];
  
  function searchCards() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    const resultArea = document.getElementById("cardList");
    resultArea.innerHTML = ""; // 초기화
  
    const filtered = cards.filter(card =>
      card.name.toLowerCase().includes(input) || card.benefit.toLowerCase().includes(input)
    );
  
    if (filtered.length === 0) {
      resultArea.innerHTML = "<p>검색 결과가 없습니다.</p>";
      return;
    }
  
    filtered.forEach(card => {
      const div = document.createElement("div");
      div.className = "card";
      div.innerHTML = `
        <h3>${card.name}</h3>
        <p>${card.benefit}</p>
        <p><strong>${card.company}</strong></p>
      `;
      resultArea.appendChild(div);
    });
  }
  
 
  // 탭 전환 기능
document.addEventListener("DOMContentLoaded", () => {
    const tabs = document.querySelectorAll(".chart-tabs div");
    const chartBoxes = document.querySelectorAll(".chart-container .chart-box");
  
    tabs.forEach((tab, index) => {
      tab.addEventListener("click", () => {
        // 탭 스타일 변경
        tabs.forEach(t => t.classList.remove("active"));
        tab.classList.add("active");
  
        // 차트 박스 내용 변경 (예시는 4개 그대로 사용, 실제 연동 시 서버 데이터 연동 필요)
        chartBoxes.forEach((box, i) => {
          const ol = box.querySelector("ol");
          const h3 = box.querySelector("h3");
  
          if (index === 0) {
            h3.textContent = ["신용카드 TOP100", "마일리지형 TOP30", "포인트형 TOP30", "체크카드 TOP100"][i];
            ol.innerHTML = [
              "<li>삼성카드 taptap O</li><li>신한카드 Mr.Life</li><li>삼성카드 & MILEAGE PLATINUM</li><li>LOCA LIKIT 1.2</li>",
              "<li>삼성카드 & MILEAGE PLATINUM</li><li>카드의정석 EVERY MILE</li><li>하나 스카이패스 아멕스</li><li>신한카드 Air One</li>",
              "<li>현대카드 M</li><li>신한카드 처음(ANNIVERSARY)</li><li>JADE Classic</li><li>현대카드 Summit</li>",
              "<li>ONE 체크카드</li><li>노리2 체크카드(KB Pay)</li><li>토스뱅크 체크카드</li><li>신한카드 Deep Dream 체크</li>"
            ][i];
          } else if (index === 1) {
            h3.textContent = ["신한카드 TOP", "삼성카드 TOP", "국민카드 TOP", "하나카드 TOP"][i];
            ol.innerHTML = "<li>신한 Mr.Life</li><li>Deep Dream</li><li>Air One</li><li>Hi-Point</li>";
          } else if (index === 2) {
            h3.textContent = ["쇼핑 혜택 TOP", "교통 혜택 TOP", "주유 혜택 TOP", "통신비 혜택 TOP"][i];
            ol.innerHTML = "<li>카카오뱅크 신한카드</li><li>우리카드 교통패스</li><li>현대 오일카드</li><li>SKT 할인카드</li>";
          } else {
            h3.textContent = ["연회비 저렴 TOP", "직장인 추천 TOP", "사회초년생 추천 TOP", "여행 추천 TOP"][i];
            ol.innerHTML = "<li>Mr.Life</li><li>하나 더 THE카드</li><li>신한 카드 the first</li><li>카카오페이 체크</li>";
          }
        });
      });
    });
  });

  