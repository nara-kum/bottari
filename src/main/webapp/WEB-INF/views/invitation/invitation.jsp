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
  <!-- Kakao SDK -->
  <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js" crossorigin="anonymous"></script>
</head>
<body class="family" data-logged-in="${not empty sessionScope.authUser}">

  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

  <content class="controller">
    <div id="sec-content" class="sector">
      <div class="sec-sub-title">
        <h2 class="header-sub">초대장 전체보기</h2>
      </div>

      <div class="sec-content-main">
        <div class="inv-wrap">
          <div class="inv-card">

            <!-- 대표 이미지 -->
            <div class="inv-hero" id="hero">
              <div class="ph" aria-hidden="true"></div>
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
              <div id="giftPreview" class="gift-preview"></div>
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
$(document).ajaxError(function (e, xhr, settings, err) {
  console.error('[INV][AJAX ERROR]', settings.url, xhr.status, err, (xhr.responseText || '').slice(0,200));
  var CTX = "${pageContext.request.contextPath}".replace(/\/+$/,"");
  var returnUrl = location.pathname + location.search;
  alert('로그인이 필요합니다.');
  location.replace(CTX + "/user/loginForm?reason=auth&returnUrl=" + encodeURIComponent(returnUrl));
});

(function () {
  /* ===== 상수/유틸 ===== */
  const CTX = "${pageContext.request.contextPath}".replace(/\/+$/,"");
  const IS_LOGGED_IN = (document.body.dataset.loggedIn === 'true');
  const FALLBACK_IMG = CTX + "/assets/icon/Logo_colored.svg";
  const KAKAO_JS_KEY = "098b00475c9ea44ee38fafb6b5f39880"; // 실제 키

  if (window.Kakao && !Kakao.isInitialized()) Kakao.init(KAKAO_JS_KEY);

  function getQuery(k){ return new URLSearchParams(location.search).get(k); }
  function pickPayload(res){ if(!res) return null; return res.apiData || res.data || res; }
  function escapeHtml(s){
    return String(s==null?"":s)
      .replaceAll("&","&amp;").replaceAll("<","&lt;")
      .replaceAll(">","&gt;").replaceAll('"',"&quot;").replaceAll("'","&#039;");
  }
  function fmtKRW(n){ return (Number(n)||0).toLocaleString("ko-KR") + "원"; }
  function fmtDateYMD(s){ return s ? String(s).slice(0,10).replaceAll("-", ".") : ""; }

  // 절대/루트/상대 → 절대 URL
  function absUrl(u){
    if (!u) return null;
    const s = String(u);
    if (/^https?:\/\//i.test(s)) return s;
    if (s.startsWith(CTX + "/"))  return location.origin + s;
    if (s.startsWith("/"))        return location.origin + s;
    return location.origin + CTX + (s.startsWith("/") ? s : ("/" + s));
  }

  // 업로드/상품 이미지 경로 정규화
  function resolveImage(vo){
    var raw = vo && (vo.image || vo.imageUrl || vo.image_url ||
                     vo.itemimg || vo.itemImg ||
                     vo.saveName || vo.save_name ||
                     vo.thumbnail || vo.thumb) || "";
    raw = String(raw).trim();
    if(!raw) return FALLBACK_IMG;
    return absUrl(raw.startsWith("/") ? raw : ("/upload/" + raw));
  }

 /* ===== 선물 미니카드 (마이펀딩 규칙으로 계산만 변경) =====*/
function renderGiftCard(vo){
  const brand  = escapeHtml(vo.brand || '');
  const title  = escapeHtml(vo.title || '');
  const optionName = escapeHtml(vo.optionName || vo.option_name || '');
  const detailoptionName = escapeHtml(vo.detailoptionName || vo.detail_option_name || vo.detailoptionName || '');
  const price  = Number(vo.price)||0;

  // 총 모금(진행률 기준) 우선순위
  let totalPaid = null;
  if (vo.paidAmount != null) totalPaid = Number(vo.paidAmount);
  else if (vo.total_paid != null) totalPaid = Number(vo.total_paid);
  else if (vo.paidTotal  != null) totalPaid = Number(vo.paidTotal);

  // 내가 낸 금액
  let myPaid = null;
  if (vo.myPaidAmount != null) myPaid = Number(vo.myPaidAmount);
  else if (vo.paid_me != null) myPaid = Number(vo.paid_me);

  // 남들이 낸 금액(others) 우선 사용, 없으면 totalPaid - myPaid, 그래도 없으면 amount 사용
  let othersAmount = null;
  if (vo.othersAmount != null) {
    othersAmount = Number(vo.othersAmount);
  } else if (vo.amount != null && myPaid == null && totalPaid == null) {
    // 구형: amount만 내려오는 경우(의미를 '남들 금액'으로 해석)
    othersAmount = Number(vo.amount);
  }

  // totalPaid 못 구했으면 유추
  if (totalPaid == null) {
    if (myPaid != null && vo.amount != null) totalPaid = Number(vo.amount) + Number(myPaid);
    else if (vo.amount != null) totalPaid = Number(vo.amount);
    else totalPaid = 0;
  }
  // othersAmount 못 구했으면 totalPaid - myPaid
  if (othersAmount == null) {
    othersAmount = Math.max(0, Number(totalPaid) - Number(myPaid || 0));
  }

  const percent = price>0 ? Math.min(100, Math.round((Number(totalPaid)/price)*100)) : 0;

  const imgUrl    = resolveImage(vo);
  const productNo = (vo.productNo ?? vo.product_no ?? '');
  const fundingNo = (vo.fundingNo ?? vo.funding_no ?? '');

  // 기존 코드와 동일한 링크 로직 유지 (로그인 여부는 인터셉터/전역 ajaxError에서 처리)
  const detailUrl  = CTX + "/shop/productPage2?" + $.param({ productNo, fundingNo });
  const returnPath = location.pathname + location.search;
  const loginUrl   = CTX + "/user/loginForm?returnUrl=" + encodeURIComponent(returnPath);
  const href       = (document.body.dataset.loggedIn === 'true') ? detailUrl : loginUrl;

  return [
    '<div class="mf-mini">',
      '<div class="summary">',
        '<div class="left">',
          '<a class="inv-go" href="', href ,'" rel="noopener">',
            '<div class="thumbbox"><img src="', imgUrl, '" alt="" onerror="this.src=\'', CTX, '/assets/icon/Logo_colored.svg', '\'"></div>',
          '</a>',
          '<div class="info">',
            '<div class="brand">', brand, '</div>',
            '<div class="row">',
              '<span class="name">', title, '</span>',
              (optionName ? '<span class="opt-sep"> / </span><span class="opt">'+optionName+'</span>' : ''),
              (detailoptionName ? '<span class="opt-sep"> / </span><span class="opt">'+detailoptionName+'</span>' : ''),
            '</div>',
            '<div class="price">', fmtKRW(price), '</div>',
          '</div>',
        '</div>',
      '</div>',

      // ✅ 바/금액표시: curr=남들 금액, total=가격, percent=총 모금/가격
      '<div class="mf-meter with-goal">',
        '<div class="bar"><div class="fill" style="width:', percent, '%;"></div></div>',
        '<div class="goal">',
          '<span class="curr">', fmtKRW(othersAmount), '</span>',
          '<span class="sep"> / </span>',
          '<span class="total">', fmtKRW(price), '</span>',
        '</div>',
        '<div class="achv"><span class="pct">', percent, '% 달성</span></div>',
      '</div>',
    '</div>'
  ].join('');
}


  function renderGiftList(list){
    const html = (list || []).map(renderGiftCard).join('');
    $('#giftPreview').html(html || '<div class="gift-empty">연결된 펀딩이 없습니다.</div>');
  }

  /* ===== 본문 렌더 (서버 gifts만 사용) ===== */
  function render(detail, gifts){
    detail = detail || {};
    window.__INV_DETAIL__ = detail; // 공유 버튼에서 사용

    // 대표 이미지
    var $hero = $("#hero").empty();
    var photoUrl = (detail.photoUrl || "").trim();
    if (photoUrl && photoUrl.startsWith("/upload/")){
      $hero.append($('<img>', { src: absUrl(photoUrl), alt: "대표 이미지" })
        .on("error", function(){ this.src = FALLBACK_IMG; }));
    } else {
      $hero.append('<div class="ph" aria-hidden="true"></div>');
    }

    // 이름/타이틀
    var groom = (detail.groomName || "").trim();
    var bride = (detail.brideName || "").trim();
    var baby  = (detail.babyName  || "").trim();
    var eventName = (detail.eventName || detail.event_name || ("이벤트 #" + (detail.eventNo||""))).trim();
    var namesText = groom && bride ? (groom + "  &  " + bride)
                  : baby          ? baby
                  : (groom || bride || eventName || "초대합니다");
    var $names = $("#v-names").removeClass("inv-names--duo inv-names--single");
    $names.text(namesText).addClass((groom && bride) ? "inv-names--duo" : "inv-names--single");

    // 날짜 · 장소
    var dateTxt = fmtDateYMD(detail.celebrateDate);
    var timeTxt = (detail.celebrateTime ? String(detail.celebrateTime).slice(0,5) : "");
    var place   = (detail.place || "").trim();
    $("#v-dateplace").text([[dateTxt, timeTxt].filter(Boolean).join(" "), place].filter(Boolean).join(" · "));

    // 모시는 글
    $("#v-greeting").text((detail.greeting || "").trim());

    // 선물 (서버 값 그대로)
    renderGiftList(Array.isArray(gifts) ? gifts : []);
  }

  /* ===== 초대장 조회 ===== */
  function loadView(){
    var no = parseInt(getQuery("no"), 10);
    if (!no){ alert("잘못된 접근입니다. (no 파라미터 없음)"); return; }
    $.ajax({
      url: CTX + "/api/invtview",
      type: "GET",
      dataType: "json",
      data: { no: no }
    })
    .done(function(res){
      if (!res || res.result === "fail"){
    var CTX = "${pageContext.request.contextPath}".replace(/\/+$/,"");
    var returnUrl = location.pathname + location.search;
    var msg = (res && res.message) || "로그인이 필요합니다.";
    alert(msg);
    location.href = CTX + "/user/loginForm?returnUrl=" + encodeURIComponent(returnUrl);
    return;
  }
      var payload = pickPayload(res); // { detail:{...}, gifts:[...] } 기대
      var detail  = (payload && payload.detail) || payload || {};
      var gifts   = (payload && (payload.gifts || payload.fundings)) || [];
      render(detail, gifts);
    })
    .fail(function(xhr){
      console.error("[GET /api/invtview] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      alert("불러오지 못했습니다. 잠시 후 다시 시도해주세요.");
    });
  }

  /* ===== 카카오 공유 (제목=이벤트명, 썸네일=대표 이미지) ===== */
  $('#btn-kakao').off('click').on('click', function () {
    if (!(window.Kakao && Kakao.isInitialized())) {
      alert('Kakao SDK 초기화에 실패했습니다. JavaScript 키와 도메인 등록을 확인해주세요.');
      return;
    }
    const d = window.__INV_DETAIL__ || {};
    const eventName = d.eventName || d.event_name || '';
    const title = (eventName && eventName.trim()) ? eventName.trim() : ($('#v-names').text().trim() || '초대합니다');

    const dateTxt = fmtDateYMD(d.celebrateDate);
    const timeTxt = (d.celebrateTime||'').slice(0,5);
    const place   = (d.place||'').trim();
    const desc    = [ [dateTxt, timeTxt].filter(Boolean).join(' '), place ].filter(Boolean).join(' · ');

    const heroImgEl = document.querySelector('#hero img');
    const heroImg   = heroImgEl && heroImgEl.src ? heroImgEl.src : FALLBACK_IMG;

    const linkUrl = location.href;

    Kakao.Share.sendDefault({
      objectType: 'feed',
      content: {
        title: title,
        description: desc || '초대장 보기',
        imageUrl: absUrl(heroImg),
        link: { webUrl: linkUrl, mobileWebUrl: linkUrl }
      },
      buttons: [
        { title: '초대장 열기', link: { webUrl: linkUrl, mobileWebUrl: linkUrl } }
      ]
    });
  });

  // ★ 다른 스크립트가 .go-detail 을 가로채더라도, 우리는 'inv-go' 만 사용하므로 영향 X
  //    (추가 바인딩 없음)

  $(function(){ loadView(); });
})();

/* ===== 링크 복사 ===== */
$("#btn-copy").on("click", function(){
  var url = location.href;
  (navigator.clipboard?.writeText(url) || Promise.reject())
    .then(function(){ alert("링크가 복사되었습니다."); })
    .catch(function(){ alert("클립보드 복사에 실패했습니다."); });
});
</script>

</body>
</html>
