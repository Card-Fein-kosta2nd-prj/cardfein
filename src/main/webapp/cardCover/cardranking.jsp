<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
            <img src="img/sample1.png" alt="Card1" />
            <div class="title">나의견 카드 커버</div>
            <div class="author">개발자몽</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">2.</div>
            <img src="img/sample2.png" alt="Card2" />
            <div class="title">고양 고양이의꿈</div>
            <div class="author">코딩러</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">3.</div>
            <img src="img/sample3.png" alt="Card3" />
            <div class="title">간바레 루루</div>
            <div class="author">히어로</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">4.</div>
            <img src="img/sample4.png" alt="Card4" />
            <div class="title">고른 선택은 댕기</div>
            <div class="author">삼색이</div>
          </div>
          <div class="rank-card">
            <div class="rank-num">5.</div>
            <img src="img/sample5.png" alt="Card5" />
            <div class="title">전공과 커버링</div>
            <div class="author">공돌이</div>
          </div>
        </div>
      </div>

      <!-- 카드 목록 -->
      <div class="card-grid">
        <div class="card-item">
          <img src="img/sample6.png" alt="Card6" />
          <div class="title">고른 선택, 댕기</div>
        </div>
        <div class="card-item">
          <img src="img/sample7.png" alt="Card7" />
          <div class="title">커엽 댕기+곰곰</div>
        </div>
        <div class="card-item">
          <img src="img/sample8.png" alt="Card8" />
          <div class="title">게임을 한다면?</div>
        </div>
        <div class="card-item">
          <img src="img/sample9.png" alt="Card9" />
          <div class="title">냥카드, 귀요쓰</div>
        </div>
        <div class="card-item">
          <img src="img/sample10.png" alt="Card10" />
          <div class="title">노을빛 찐-카드</div>
        </div>
      </div>
    </div>

    <jsp:include page="/views/common/footer.jsp" />
  </body>
</html>
