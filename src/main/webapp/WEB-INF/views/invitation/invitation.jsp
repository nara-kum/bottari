<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>bottari 초대장 전체보기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/invitation/invitation.css">
  <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>
<body class="family">

  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

  <content class="controller">
    <div id="sec-content" class="sector">
      <div class="sec-sub-title">
        <h2 class="header-sub">초대장 전체보기</h2>
      </div>

      <div class="sec-content-main">
        <div class="inv-wrap">
          <div class="inv-card">

            <!-- 대표 이미지 영역(이미지 없으면 회색 박스) -->
            <div class="inv-hero" id="hero">
              <div class="ph" aria-hidden="true"></div>
              <!-- 이미지가 있으면 아래 img가 들어감 -->
            </div>

            <!-- 본문 -->
            <div class="inv-body">
              <div class="sep">초대합니다</div>

              <div class="inv-date" id="v-date">0000 . 00 . 00</div>
              <div class="inv-names" id="v-names">신랑  &amp;  신부</div>

              <div class="inv-meta" id="v-meta">
                <!-- 예: 2025.08.11 일요일 오전 9시 59분 / 예식장명 · 예식장 층/홀 -->
              </div>
            </div>

            <!-- 선물 보내기 -->
            <div class="gift-panel" id="gift-panel">
              <div class="gift-title">축하 선물 보내기</div>
              <div class="gift-icons">
                <div class="gift-icon"></div><div class="gift-icon"></div><div class="gift-icon"></div><div class="gift-icon"></div>
              </div>
              <button class="gift-cta" id="btn-funding">선물하러 가기</button>
              <div class="gift-note">부담 없는 금액으로 마음을 전할 수 있는 보따리의 ‘펀딩’ 서비스예요.</div>
            </div>

            <!-- 공유 -->
            <div class="share">
              <button type="button" class="sbtn" id="btn-kakao">카카오톡 공유하기</button>
              <button type="button" class="sbtn" id="btn-copy">링크 복사하기</button>
            </div>

          </div>
        </div>
      </div>
    </div>
  </content>

  <c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>

<script>
(function(){
  var CTX = "${pageContext.request.contextPath}";

  // ?no=123 파라미터
  function getQuery(key){
    var s = new URLSearchParams(location.search);
    return s.get(key);
  }

  // 서버 응답에서 payload 뽑기 (apiData 우선, 없으면 data, 그래도 없으면 자체)
  function pickPayload(res){
    if (!res) return null;
    if (res.apiData) return res.apiData;
    if (res.data)    return res.data;
    return res;
  }

  // yyyy-mm-dd -> yyyy. mm. dd
  function fmtDate(s){
    if (!s) return "";
    return String(s).slice(0,10).replaceAll("-", " . ");
  }

  function text(v){ return (v==null || v==="") ? "" : String(v); }

  // DOM 채우기 (기존 마크업을 그대로 활용)
  function render(detail, gifts){
    detail = detail || {};
    gifts  = Array.isArray(gifts) ? gifts : [];

    // 대표/기본 텍스트
    var dateTxt = fmtDate(detail.celebrateDate);
    var timeTxt = (text(detail.celebrateTime) || "").slice(0,5); // HH:mm 형태 가정
    var place   = text(detail.place);
    var addr1   = text(detail.address1);
    var addr2   = text(detail.address2);
    var eventNm = text(detail.eventName);

    // 1) 대표 이미지 (upload 경로만 이미지 삽입, 그 외는 회색 플레이스홀더 유지)
    var $hero = $("#hero").empty();
    var url = text(detail.photoUrl);
    if (url && /^\/upload\//.test(url)) {
      $hero.append($('<img>', {src: url, alt: '대표 이미지'}));
    } else {
      // 이미지가 없으면 플레이스홀더 유지
      $hero.append('<div class="ph" aria-hidden="true"></div>');
    }

    // 2) 본문: 날짜 / 이름 / 메타
    $("#v-date").text(dateTxt || "0000 . 00 . 00");

    // 이름은 종류별로 없을 수 있으므로 유연하게 조합
    var names = [];
    if (detail.groomName || detail.brideName) {
      if (detail.groomName) names.push(detail.groomName);
      if (detail.brideName) names.push(detail.brideName);
    } else if (detail.babyName) {
      names.push(detail.babyName);
    }
    $("#v-names").text(names.length ? names.join("  &  ") : "신랑  &  신부");

    // 메타(날짜·시간 / 장소·주소)
    var meta = [];
    var t1 = [fmtDate(detail.celebrateDate), timeTxt].filter(Boolean).join(" ");
    if (t1) meta.push(t1);
    var t2 = [place, [addr1, addr2].filter(Boolean).join(" ")].filter(Boolean).join(" · ");
    if (t2) meta.push(t2);
    $("#v-meta").text(meta.join(" / "));

    // 3) 선물 패널
    var $panel = $("#gift-panel").hide();
    var $icons = $panel.find(".gift-icons").empty();

    if (gifts.length) {
      // 최대 4개만 아이콘화
      gifts.slice(0,4).forEach(function(g){
        // 이미지 없으므로 텍스트 아이콘: 브랜드나 제품명 첫글자
        var label = (g.title || g.brand || "").trim().charAt(0) || "🎁";
        var $ic = $('<div class="gift-icon" title="'+ (g.title || "") +'"></div>');
        $ic.text(label);
        $icons.append($ic);
      });
      $panel.show();
      // 펀딩 페이지로 이동(이벤트 단위)
      $("#btn-funding").off("click").on("click", function(){
        if (detail.eventNo) {
          location.href = CTX + "/myFunding?eventNo=" + detail.eventNo;
        } else {
          location.href = CTX + "/myFunding";
        }
      });
    }

    // 4) 공유 버튼 (동작 예시)
    $("#btn-copy").off("click").on("click", function(){
      var url = location.href;
      navigator.clipboard?.writeText(url).then(function(){
        alert("링크가 복사되었습니다.");
      }).catch(function(){
        alert("클립보드 복사에 실패했습니다.");
      });
    });
    $("#btn-kakao").off("click").on("click", function(){
      alert("카카오 공유는 나중에 연동할게요 😊");
    });
  }

  function loadView(){
    var no = parseInt(getQuery("no"), 10);
    if (!no){
      alert("잘못된 접근입니다. (no 파라미터 없음)");
      return;
    }

    $.ajax({
      url: CTX + "/api/invtview",
      type: "GET",
      data: { no: no },
      dataType: "json"
    })
    .done(function(res){
      if (!res || res.result === "fail"){
        alert((res && res.message) || "불러오지 못했습니다.");
        return;
      }
      var payload = pickPayload(res);           // { detail:{...}, gifts:[...] } 형태 기대
      var detail  = (payload && payload.detail) || payload || {};
      var gifts   = (payload && payload.gifts)  || [];
      render(detail, gifts);
    })
    .fail(function(xhr){
      console.error("[GET /api/invtview] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      alert("불러오지 못했습니다. 잠시 후 다시 시도해주세요.");
    });
  }

  $(function(){ loadView(); });
})();
</script>

</body>
</html>
