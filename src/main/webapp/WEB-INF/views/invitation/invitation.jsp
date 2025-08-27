<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>bottari 초대장 전체보기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/invitation/invitation.css"><!-- ↑ 위 CSS 교체 -->
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

  // 쿼리스트링에서 no 가져오기
  function qs(name){
    var m = new RegExp("[?&]"+name+"=([^&#]*)").exec(location.search);
    return m ? decodeURIComponent(m[1].replace(/\+/g,"%20")) : "";
  }

  function fmtDate(s){ // yyyy-mm-dd -> yyyy . mm . dd
    if(!s) return "";
    var d = String(s).substring(0,10);
    return d.replace(/-/g, " . ");
  }
  function weekName(dateStr){
    try{
      var d = new Date(dateStr);
      return ["일","월","화","수","목","금","토"][d.getDay()];
    }catch(e){ return ""; }
  }
  function esc(x){
    return (x==null?"":String(x))
      .replace(/&/g,"&amp;").replace(/</g,"&lt;")
      .replace(/>/g,"&gt;").replace(/"/g,"&quot;");
  }

  // 데이터 렌더링
  function render(vo){
    // 대표 이미지 (지금은 이미지 없어도 됨. photoUrl 있으면 넣어줌)
    if (vo.photoUrl){
      $("#hero").addClass("has-photo").empty()
        .append('<img alt="대표 이미지" src="'+esc(vo.photoUrl)+'" onerror="this.remove();">');
    }

    // 날짜 / 이름 / 메타
    $("#v-date").text(fmtDate(vo.celebrateDate || vo.celebrate_date));
    var groom = vo.groomName || vo.groom_name || "신랑";
    var bride = vo.brideName || vo.bride_name || "신부";
    $("#v-names").text(groom + "  &  " + bride);

    var time = vo.celebrateTime || vo.celebrate_time || "";
    var place = vo.place || "";
    var wday = weekName(vo.celebrateDate || vo.celebrate_date);
    var timeText = time ? (" " + time.substring(0,5)) : "";
    var meta = (vo.celebrateDate?fmtDate(vo.celebrateDate):"") + " " + wday + "요일" + timeText
             + (place?(" / " + place):"");
    $("#v-meta").text(meta.trim());

    // 선물 CTA (hasFunding 있으면 활성 / 없으면 비활)
    var hasFunding = !!(vo.hasFunding || vo.has_funding);
    if (!hasFunding){
      $("#btn-funding").prop("disabled", true).text("펀딩이 연결되지 않았어요");
    } else {
      var to = CTX + "/funding?eventNo=" + (vo.eventNo || vo.event_no || "");
      $("#btn-funding").on("click", function(){ location.href = to; });
    }
  }

  // 데이터 로드
  function load(){
    var no = qs("no") || qs("id");
    if(!no){ // no 없으면 최소 안내만
      render({});
      return;
    }
    $.ajax({
      url: CTX + "/api/invtview",
      type: "GET",
      data: { no: no },
      dataType: "json"
    })
    .done(function(res){
      var vo = (res && res.data) ? res.data :
               (res && res.apiData) ? res.apiData : res;
      if (!vo || res.result === "fail"){
        alert(res && res.message ? res.message : "초대장을 불러오지 못했습니다.");
        render({});
        return;
      }
      render(vo);
    })
    .fail(function(xhr){
      console.error("[GET /api/invtview] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      render({});
    });
  }

  // 공유 버튼(샘플)
  $(document)
    .on("click", "#btn-copy", function(){
      var url = location.href;
      navigator.clipboard?.writeText(url).then(function(){
        alert("링크를 복사했어요.");
      }, function(){ alert(url); });
    })
    .on("click", "#btn-kakao", function(){
      alert("카카오 공유는 추후 연동합니다 🙂");
    });

  $(load);
})();
</script>
</body>
</html>
