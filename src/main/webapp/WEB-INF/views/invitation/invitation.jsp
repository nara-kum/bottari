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
  <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js" crossorigin="anonymous"></script>

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
              <!-- 여러 개가 쌓여 들어갑니다 -->
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
});
(function () {
  // 👉 콘솔의 JavaScript 키로 교체
  const KAKAO_JS_KEY = '098b00475c9ea44ee38fafb6b5f39880';

  // 페이지 contextPath (JSP 변수와 동일하게 사용)
  const CTX = "${pageContext.request.contextPath}".replace(/\/+$/, "");

  // SDK init
  if (window.Kakao && !Kakao.isInitialized()) {
    Kakao.init(KAKAO_JS_KEY);
  }

  // 상대/루트경로 -> 절대 URL
  function absUrl(u) {
    if (!u) return "";
    if (/^https?:\/\//i.test(u)) return u;
    // "/..." 형태면 도메인만 붙여줌
    if (u.startsWith("/")) return location.origin + u;
    // 상대경로면 CTX 기준
    return location.origin + CTX + "/" + u.replace(/^\/+/, "");
  }

  // 클릭 시 공유
  // (페이지 상단 IIFE 안) 공유 버튼 클릭
$('#btn-kakao').off('click').on('click', function () {
  if (!(window.Kakao && Kakao.isInitialized())) {
    alert('Kakao SDK 초기화에 실패했습니다. JavaScript 키와 도메인 등록을 확인해주세요.');
    return;
  }

  const shareUrl = location.href;
  const title = ($('#v-names').text().trim() || '초대합니다');
  const desc  = ($('#v-dateplace').text().trim() || '초대장 보기');
  var imgEl   = document.querySelector('#hero img');
  var heroImg = (imgEl && imgEl.src) ? imgEl.src : (CTX + '/assets/icon/Logo_colored.svg');

  Kakao.Share.sendDefault({
    objectType: 'feed',
    content: {
      title: title,
      description: desc,
      imageUrl: absUrl(heroImg), // 절대 URL이어야 함
      link: { mobileWebUrl: shareUrl, webUrl: shareUrl }
    },
    buttons: [
      { title: '초대장 보기', link: { mobileWebUrl: shareUrl, webUrl: shareUrl } }
    ]
  });
});

})();

(function(){
  /* ========= 기본 ========= */
  var CTX = "${pageContext.request.contextPath}".replace(/\/+$/,"");
  var FALLBACK_IMG = CTX + "/assets/icon/Logo_colored.svg";

  function getQuery(k){ return new URLSearchParams(location.search).get(k); }
  function pickPayload(res){ if(!res) return null; return res.apiData || res.data || res; }
  function escapeHtml(s){
    return String(s==null?"":s)
      .replaceAll("&","&amp;").replaceAll("<","&lt;")
      .replaceAll(">","&gt;").replaceAll('"',"&quot;")
      .replaceAll("'","&#039;");
  }
  function fmtKRW(n){ return (Number(n)||0).toLocaleString("ko-KR") + "원"; }

  // 파일명/상대경로를 /upload/ 로 치환
  function resolveImage(vo){
    var raw = vo && (vo.image || vo.imageUrl || vo.image_url ||
                     vo.itemimg || vo.itemImg ||
                     vo.saveName || vo.save_name ||
                     vo.thumbnail || vo.thumb) || "";
    raw = String(raw).trim();
    if(!raw) return FALLBACK_IMG;
    if(/^https?:\/\//i.test(raw)) return raw;
    if(raw.startsWith(CTX + "/"))  return raw;
    if(raw.startsWith("/"))        return CTX + raw;
    return CTX + "/upload/" + raw;
  }

function renderGiftCard(vo){
  const brand   = escapeHtml(vo.brand || '');
  const title   = escapeHtml(vo.title || '');
  const optionName       = escapeHtml(vo.optionName || '');
  const detailOptionName = escapeHtml(vo.detailoptionName || '');

  const price   = Number(vo.price)||0;
  const amount  = Number(vo.amount)||0;
  const percent = Math.max(0, Math.min(100,
                    (vo.percent!=null ? Number(vo.percent)
                     : (price>0 ? Math.round(amount*100/price) : 0))
                  ));
  const imgUrl  = resolveImage(vo);

  // 상세 이동에 필요한 키
  const productNo = (vo.productNo ?? vo.product_no ?? vo.prodNo ?? vo.itemNo ?? '');
  const fundingNo = (vo.fundingNo ?? vo.funding_no ?? vo.fundNo ?? '');

  return [
    '<div class="mf-mini">',
      '<div class="summary">',
        '<div class="left">',
          // ▼ 이미지가 바로 링크가 되도록
          '<a href="#" class="go-detail" data-product-no="', productNo, '" data-funding-no="', fundingNo, '">',
            '<div class="thumbbox"><img src="', imgUrl, '" alt="" onerror="this.src=\'', CTX, '/assets/images/eki.jpg\'"></div>',
          '</a>',
          '<div class="info">',
            '<div class="brand">', brand, '</div>',
            '<div class="row">',
              '<span class="name">', title, '</span>',
              '<span class="opt-sep"> / </span><span class="opt">', optionName, '</span>',
              '<span class="opt-sep"> / </span><span class="opt">', detailOptionName, '</span>',
            '</div>',
            '<div class="price">', fmtKRW(price), '</div>',
          '</div>',
        '</div>',
      '</div>',

      '<div class="mf-meter with-goal">',
        '<div class="bar"><div class="fill" style="width:', percent, '%;"></div></div>',
        '<div class="goal"><span class="curr">', fmtKRW(amount), '</span>',
          '<span class="sep"> / </span><span class="total">', fmtKRW(price), '</span></div>',
        '<div class="achv"><span class="pct">', percent, '% 달성</span></div>',
      '</div>',
    '</div>'
  ].join('');
}




/* ========= 선물 미니카드: 리스트 렌더 ========= */
function renderGiftList(list){
  const html = (list || []).map(renderGiftCard).join('');
  $('#giftPreview').html(html || '<div class="gift-empty">연결된 펀딩이 없습니다.</div>');
}


  /* ========= eventNo 기준으로 펀딩 조회(백엔드 지원 여부에 따라 필터) ========= */
  function fetchGiftsByEvent(eventNo){
  console.log("[INV] fetchGiftsByEvent() called with eventNo:", eventNo);
  return $.ajax({
    url: CTX + "/api/myfunding",
    type: "GET",
    dataType: "json",
    data: $.extend({ _t: Date.now() }, eventNo ? { eventNo: eventNo } : {}) // 캐시 무력화
  })
  .done(function(json){
    console.log("[INV] /api/myfunding OK → raw:", json);
    let list = Array.isArray(json) ? json : (json.data || json.apiData || json.list || []);
    if (eventNo) list = list.filter(x => Number(x.eventNo||x.event_no) === Number(eventNo));
    console.log("[INV] /api/myfunding parsed list len:", list.length);
    renderGiftList(list);
  })
  .fail(function(xhr){
    console.error("[INV] /api/myfunding FAIL:", xhr.status, (xhr.responseText||"").slice(0,200));
    renderGiftList([]);
  });
}


  /* ========= 초대장 본문 렌더 ========= */
  function render(detail, gifts){
  detail = detail || {};

  console.log('[INV] render()', {
    giftsLen: Array.isArray(gifts) ? gifts.length : 0,
    eventNo: (detail.eventNo || detail.event_no || null)
  });

  // ── 대표 이미지
  var $hero = $("#hero").empty();
  var photoUrl = (detail.photoUrl || "").trim();
  if (photoUrl && photoUrl.startsWith("/upload/")){
    $hero.append($('<img>', { src: CTX + photoUrl, alt: "대표 이미지" })
      .on("error", function(){ this.src = FALLBACK_IMG; }));
  } else {
    $hero.append('<div class="ph" aria-hidden="true"></div>');
  }

  // ── 이름
  var groom = (detail.groomName || "").trim();
  var bride = (detail.brideName || "").trim();
  var baby  = (detail.babyName  || "").trim();
  var eventName = (detail.eventName || detail.event_name || ("이벤트 #" + (detail.eventNo||""))).trim();
  var $names = $("#v-names").removeClass("inv-names--duo inv-names--single");
  var namesText = groom && bride ? (groom + "  &  " + bride)
                : baby          ? baby
                : (groom || bride || eventName || "초대합니다");
  $names.text(namesText).addClass((groom && bride) ? "inv-names--duo" : "inv-names--single");

  // ── 날짜 · 장소
  var dateTxt = detail.celebrateDate ? String(detail.celebrateDate).slice(0,10).replaceAll("-", " . ") : "";
  var timeTxt = detail.celebrateTime ? String(detail.celebrateTime).slice(0,5) : "";
  var place   = (detail.place || "").trim();
  $("#v-dateplace").text([[dateTxt, timeTxt].filter(Boolean).join(" "), place].filter(Boolean).join(" · "));

  // ── 모시는 글
  $("#v-greeting").text((detail.greeting || "").trim());

  // ── 선물(미니카드)
  // 1) 서버에서 gifts가 내려왔으면 "먼저" 그려서 초기 화면 즉시 표시
  try{
    const preLen = Array.isArray(gifts) ? gifts.length : 0;
    console.log('[INV] pre-render gifts len:', preLen);
    if (preLen) renderGiftList(gifts);
  }catch(e){
    console.warn('[INV] pre-render error:', e);
  }

  // 2) 그리고 항상 /api/myfunding 재호출해서 최신 데이터로 갱신
  const evNo = detail.eventNo || detail.event_no || null;
  console.log('[INV] now calling /api/myfunding with eventNo =', evNo);
  fetchGiftsByEvent(evNo);
}


  /* ========= 초대장 조회 ========= */
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
  console.log('[INV] /api/invtview OK:', res);
      if (!res || res.result === "fail"){
        alert((res && res.message) || "불러오지 못했습니다."); return;
      }
      var payload = pickPayload(res);                 // { detail:{...}, gifts:[...] } 기대
      var detail  = (payload && payload.detail) || payload || {};
      var gifts   = (payload && (payload.gifts || payload.fundings)) || [];
      render(detail, gifts);
    })
    .fail(function(xhr){
      console.error("[GET /api/invtview] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      alert("불러오지 못했습니다. 잠시 후 다시 시도해주세요.");
    });
  }


// 상품 이미지(링크) 클릭 → 상세로
$(document)
  .off('click.invGo', '.go-detail')
  .on('click.invGo', '.go-detail', function(e){
    e.preventDefault();
    var productNo = $(this).data('productNo') || $(this).data('product-no');
    var fundingNo = $(this).data('fundingNo') || $(this).data('funding-no');
    if (!productNo || !fundingNo) return;

    var LOGIN_URL = CTX + "/user/loginform";

    $.ajax({
      url: CTX + "/api/invtlist",
      type: "GET",
      dataType: "json"
    })
    .done(function(res){
      var loggedIn = res && res.result === "success";
      var qs = $.param({ productNo: productNo, fundingNo: fundingNo });
      location.href = loggedIn ? (CTX + "/shop/productPage2?" + qs) : LOGIN_URL;
    })
    .fail(function(){
      var qs = $.param({ productNo: productNo, fundingNo: fundingNo });
      location.href = CTX + "/shop/productPage2?" + qs;
    });
  });


  /* ========= 공유 ========= */
  $("#btn-copy").on("click", function(){
    var url = location.href;
    (navigator.clipboard?.writeText(url) || Promise.reject())
      .then(function(){ alert("링크가 복사되었습니다."); })
      .catch(function(){ alert("클립보드 복사에 실패했습니다."); });
  });

  $(function(){ loadView(); });
})();

</script>

</body>
</html>