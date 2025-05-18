<%@page import="cardfein.kro.kr.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
  String path = request.getContextPath();
  LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
  int userNo = (loginUser != null) ? loginUser.getUserNo() : -1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card:fein - 맞춤카드 검색</title>
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/common.css">
	<!-- 페이지 전용 스타일 -->
	<link rel="stylesheet" href="${path}/static/css/cardMenu/fitCard.css" defer>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
	
	<!-- 공통 스크립트 -->
	<script src="${path}/static/js/common.js" defer></script>

</head>
<body>

	<!-- header -->
	<jsp:include page="/views/common/header.jsp" />



    <div class="fitCard-container">
      <div class="search-header">
        <h1>맞춤카드 검색</h1>

        <div class="filter-container">
          <div class="filter-tag">이디어시 직원/할인</div>
          <div class="filter-tag">디지털 콘텐츠</div>
          <div class="filter-tag">해외</div>
          <div class="filter-tag">온라인 쇼핑</div>
          <div class="filter-tag">배우자</div>
          <div class="filter-tag">크래딧</div>
          <div class="filter-tag">렌탈</div>
          <div class="filter-tag">온라인 페이</div>
          <div class="filter-tag">배달 앱</div>
          <div class="filter-tag">오프라인 쇼핑</div>
          <div class="filter-tag">마일리지/공항라운지</div>
          <div class="filter-tag">커피</div>
          <div class="filter-tag active">AUTO</div>
          <div class="filter-tag">주유</div>
          <div class="filter-tag">특급호텔/발레파킹</div>
          <div class="filter-tag">멤버십 이용혜택</div>
          <div class="filter-tag">모빌리티</div>
          <div class="filter-tag">생활편의영업</div>
          <div class="filter-tag">금융</div>
          <div class="filter-tag">개인사업자</div>
          <div class="filter-tag">여행</div>
        </div>
      </div>

      <div class="card-list">
        <!-- 첫 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNmNWY1ZjUiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+QU1FUklDQU4gRVhQUkVTUzwvdGV4dD48L3N2Zz4="
                alt="American Express Card"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">American Express The Platinum Card® Edition2</h2>
              <p class="card-subtitle">아메리칸 익스프레스</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">이디어시 직원/할인</span>
              <span class="card-tag">해외</span>
              <span class="card-tag">마일리지/공항라운지</span>
            </div>
            <div class="card-tag-container">
              <span class="card-tag">특급호텔/발레파킹</span>
              <span class="card-tag">연회비 1,000,000원</span>
            </div>
          </div>
        </div>

        <!-- 두 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNmNWY1ZjUiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+TE9DQTwvdGV4dD48L3N2Zz4="
                alt="LOCA LIKIT 1.2"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">LOCA LIKIT 1.2</h2>
              <p class="card-subtitle">롯데카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">최대 7만원 캐시백</span>
              <span class="card-tag">모든가맹점 1.2% 할인</span>
              <span class="card-tag">온라인 1.5% 할인</span>
            </div>
          </div>
        </div>

        <!-- 세 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNmZmZmZmYiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+WkVSTzwvdGV4dD48L3N2Zz4="
                alt="현대카드ZERO Edition3"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">현대카드ZERO Edition3(할인형)</h2>
              <p class="card-subtitle">현대카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">1.5만원 캐시백</span>
              <span class="card-tag">국내외 가맹점 0.8% 할인</span>
              <span class="card-tag">AUTO</span>
            </div>
          </div>
        </div>

        <!-- 네 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNlMGUwZTAiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+U0hJTkhBTjwvdGV4dD48L3N2Zz4="
                alt="신한카드 Deep Dream"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">신한카드 Deep Dream</h2>
              <p class="card-subtitle">신한카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">신규 발급 5천원 캐시백</span>
              <span class="card-tag">편의점 2.0% 할인</span>
            </div>
          </div>
        </div>

        <!-- 다섯 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNmMGU1ZTUiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+S0I8L3RleHQ+PC9zdmc+"
                alt="KB국민 쏘카카드"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">KB국민 쏘카카드</h2>
              <p class="card-subtitle">국민카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">첫 결제 시 3천 포인트</span>
              <span class="card-tag">자동차 10% 할인</span>
              <span class="card-tag">AUTO</span>
            </div>
          </div>
        </div>

        <!-- 여섯 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNlMGVmZmYiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+V09PUkk8L3RleHQ+PC9zdmc+"
                alt="우리 카드의정석"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">우리 카드의정석</h2>
              <p class="card-subtitle">우리카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">신규 발급 3만원 캐시백</span>
              <span class="card-tag">쇼핑 5% 할인</span>
            </div>
          </div>
        </div>

        <!-- 일곱 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNmNWYwZmYiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+SEFOQUJBSE5LPC90ZXh0Pjwvc3ZnPg=="
                alt="하나 원더카드"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">하나 원더카드</h2>
              <p class="card-subtitle">하나카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">매달 5% 캐시백</span>
              <span class="card-tag">외식 10% 할인</span>
            </div>
          </div>
        </div>

        <!-- 여덟 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNmMWU5ZDIiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+TkhOT05HSFlBUDwvdGV4dD48L3N2Zz4="
                alt="농협 NH올원카드"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">농협 NH올원카드</h2>
              <p class="card-subtitle">NH농협카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">첫 달 연회비 무료</span>
              <span class="card-tag">마트 3% 할인</span>
            </div>
          </div>
        </div>

        <!-- 아홉 번째 카드 아이템 -->
        <div class="card-item">
          <div class="card-info">
            <div class="card-image">
              <img
                src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjgwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNkZGYzZmYiLz48dGV4dCB4PSI2MCIgeT0iNDAiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxMiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzk5OSI+U0FNU1VORzwvdGV4dD48L3N2Zz4="
                alt="삼성카드 taptap O"
              />
            </div>
            <div class="card-title-container">
              <h2 class="card-title">삼성카드 taptap O</h2>
              <p class="card-subtitle">삼성카드</p>
            </div>
            <div class="card-tag-container">
              <span class="card-tag highlight">포인트 더블 적립</span>
              <span class="card-tag">대중교통 10% 할인</span>
              <span class="card-tag">AUTO</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    
    
    <!-- footer -->
	<jsp:include page="/views/common/footer.jsp" />



    <script>
      // 필터 태그 클릭 이벤트
      document.querySelectorAll(".filter-tag").forEach((tag) => {
        tag.addEventListener("click", function () {
          this.classList.toggle("active");
          // 추후에 이 이벤트에다 java에서 필터 조건 추가
          // 예를 들어, 이디어시 직원/할인 태그를 클릭하면 필터 조건에 직원/할인이 추가되도록 함
          // fetch 함수를 사용하여 클릭한 태그의 텍스트를 가져옴
          // const getFilter = async() => {
          //   const response = await fetch("filter.jsp", {
          //     method: "POST",
          //     body: JSON.stringify({ filter: tag.textContent }),
          //   })
          //     .then((response) => response.json())
          //     .then((data) => console.log(data));
          // };
          // getFilter();
          //const getList = async() => {
          // const response = await fetch("xxx.jsp",{
          //  method: "GET",
          //  })
          //  .then((response) => response.json())
          //  .then((data) => console.log(data));
          // };
          // getList();
        });
      });
    </script>
  </body>
</html>