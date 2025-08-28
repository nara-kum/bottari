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
                <div class="inv-names" id="v-names"></div>

                <div class="inv-dateplace" id="v-dateplace"></div>

                <div class="inv-greeting" id="v-greeting"></div>
            </div>

            <!-- 선물 보내기 -->
            <div class="gift-panel" id="gift-panel">
              <div class="gift-title">축하 선물 보내기</div>
              <div class="gift-icons">
                <div class="gift-icon"></div>
              </div>
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

  // 대표 이미지: /upload/로 시작할 때만 보여주고 아니면 placeholder 유지
  var $hero = $("#hero").empty();
  var photoUrl = (detail.photoUrl || "");
  if (/^\/upload\//.test(photoUrl)) {
    $hero.append($('<img>', { src: photoUrl, alt: '대표 이미지' }));
  } else {
    $hero.append('<div class="ph" aria-hidden="true"></div>');
  }

  // ====== 이름 라인 구성 (두 명 vs 한 명) ======
  var groom = (detail.groomName || "").trim();
  var bride = (detail.brideName || "").trim();
  var baby  = (detail.babyName || "").trim();
  var eventName = (detail.eventName || detail.event_name || ("이벤트 #" + (detail.eventNo || ""))).trim();

  var $names = $("#v-names").removeClass("inv-names--duo inv-names--single");
  var namesText = "";
  if (groom && bride) {                 // 두 명
    namesText = groom + "  &  " + bride;
    $names.addClass("inv-names--duo");
  } else if (baby) {                    // 아기만
    namesText = baby;
    $names.addClass("inv-names--single");
  } else if (groom || bride) {          // 한 명(단독)
    namesText = groom || bride;
    $names.addClass("inv-names--single");
  } else if (eventName) {                 // 아무도 없으면 이벤트명
    namesText = eventName;
    $names.addClass("inv-names--single");
  }else {                              // 이벤트명도 없으면 기본 문구
  namesText = "초대합니다";
  $names.addClass("inv-names--single");
}
  $names.text(namesText);

  // ====== 날짜 + (시간) + 장소 ======
  var dateTxt = (detail.celebrateDate ? String(detail.celebrateDate).slice(0,10).replaceAll("-", " . ") : "");
  var timeTxt = (detail.celebrateTime ? String(detail.celebrateTime).slice(0,5) : "");
  var place   = (detail.place || "").trim();
  var left = [dateTxt, timeTxt].filter(Boolean).join(" ");
  var right = place;
  $("#v-dateplace").text([left, right].filter(Boolean).join(" · "));

  // ====== 모시는 글 ======
  var greeting = (detail.greeting || "").trim();
  $("#v-greeting").text(greeting);

  // ====== 선물 패널 (기존 로직 유지) ======
var $panel = $("#gift-panel").hide();
var $icons = $panel.find(".gift-icons").empty();

if (Array.isArray(gifts) && gifts.length) {
  gifts.slice(0, 4).forEach(function(g){
    var label = (g.title || g.brand || "").trim().charAt(0) || "🎁";
    // 접근성 + 클릭 편의 위해 button으로 생성
    var $ic = $('<button type="button" class="gift-icon" title="'+ (g.title || "") +'"></button>');
    $ic.text(label);
    $ic.attr("data-product-no", g.productNo);
    $ic.attr("data-funding-no", g.fundingNo);
    $icons.append($ic);
  });
  $panel.show();
  $("#btn-funding").off("click").on("click", function(){
    if (detail.eventNo) {
      location.href = CTX + "/myFunding?eventNo=" + detail.eventNo;
    } else {
      location.href = CTX + "/myFunding";
    }
  });
}
$(document).on("click", ".gift-icon", function(){
  var productNo = $(this).data("product-no");
  var fundingNo = $(this).data("funding-no");

  if (!productNo || !fundingNo) return;

  var LOGIN_URL = CTX + "/user/loginform"; // 프로젝트 로그인 URL과 맞춰주세요

  // 권한 필요한 API를 핑해서 로그인 여부 판별
  $.ajax({
    url: CTX + "/api/invtlist",
    type: "GET",
    dataType: "json"
  })
  .done(function(res){
    var loggedIn = res && res.result === "success";
    if (loggedIn){
      var qs = $.param({ productNo: productNo, fundingNo: fundingNo });
      location.href = CTX + "/productPage2?" + qs;
    } else {
      location.href = LOGIN_URL;
    }
  })
  .fail(function(){
    // 네트워크/기타 오류시 서버 권한체크에 맡김
    var qs = $.param({ productNo: productNo, fundingNo: fundingNo });
    location.href = CTX + "/productPage2?" + qs;
  });
});

  // 공유 버튼(유지)
  $("#btn-copy").off("click").on("click", function(){
    var url = location.href;
    (navigator.clipboard?.writeText(url) || Promise.reject())
      .then(function(){ alert("링크가 복사되었습니다."); })
      .catch(function(){ alert("클립보드 복사에 실패했습니다."); });
  });
  $("#btn-kakao").off("click").on("click", function(){
    alert("카카오 공유는 추후 연동 예정입니다 😊");
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
