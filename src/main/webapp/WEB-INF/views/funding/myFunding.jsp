<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이 펀딩</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/funding/myfunding.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wishlist/wishlist.css">
  <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>

<body class="family">

  <!-- Header -->
  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

  <content class="controller">
  <div id="sec-content" class="sector">
    <div class="sec-sub-title">
      <div class="tab-row" role="navigation">
        <h2 class="header-sub">
          <a href="${pageContext.request.contextPath}/funding/wish">펀딩 관리</a>
        </h2>
        <h2 class="header-sub is-active">
          <a href="${pageContext.request.contextPath}/funding/my" aria-current="page">마이 펀딩</a>
        </h2>
        <h2 class="header-sub">
          <a href="${pageContext.request.contextPath}/funding/friend">친구 펀딩</a>
        </h2>
      </div>
    </div>

    <div class="sec-content-main">
      <div id="myFundingList" class="content"></div>
    </div>
  </div>
  </content>

  <!-- Footer -->
  <c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>

<script>
(function(){
  const CTX = "${pageContext.request.contextPath}";

  /* ---------- 공통 유틸 ---------- */
  function fmtKRW(n){ return (Number(n)||0).toLocaleString('ko-KR') + '원'; }
  function escapeHtml(s){
    return String(s)
      .replaceAll('&','&amp;').replaceAll('<','&lt;')
      .replaceAll('>','&gt;').replaceAll('"','&quot;')
      .replaceAll("'",'&#039;');
  }

  // 서버 응답에서 리스트만 안전하게 뽑기
  function pluckList(json){
    if (Array.isArray(json)) return json;
    if (!json || typeof json !== 'object') return [];
    if (Array.isArray(json.data)) return json.data;
    if (Array.isArray(json.apiData)) return json.apiData;
    if (json.data && Array.isArray(json.data.list)) return json.data.list;
    if (Array.isArray(json.list)) return json.list;
    return [];
  }

  // ✅ 상품 이미지 경로 해결: itemimg/saveName 등 파일명 → /upload/<파일명>
  function resolveImage(vo){
    // 백엔드가 어떤 키로 보내든 최대한 커버
    let raw = vo.image || vo.imageUrl || vo.image_url ||
              vo.itemimg || vo.itemImg ||
              vo.saveName || vo.save_name ||
              vo.thumbnail || vo.thumb || '';

    if (!raw) return CTX + "/assets/images/eki.jpg";         // 최종 폴백

    raw = String(raw).trim();

    // 절대경로/외부URL이면 그대로
    if (/^https?:\/\//i.test(raw)) return raw;
    // 이미 /upload/로 시작하면 그대로
    if (raw.startsWith("/upload/")) return raw;
    // CTX 포함 절대경로면 그대로
    if (raw.startsWith(CTX + "/upload/")) return raw;
    // 다른 절대경로(/assets 등)면 그대로
    if (raw.startsWith("/")) return raw;

    // 나머지는 '파일명'으로 보고 /upload 붙여줌
    return CTX + "/upload/" + raw;
  }

  /* ---------- 카드 렌더 ---------- */
  function renderCard(vo){
    const fundingNo     = Number(vo.fundingNo)||0;
    const fundingDate   = vo.fundingDate || '';
    const brand         = vo.brand || '';
    const title         = vo.title || '';
    const price         = Number(vo.price)||0;
    const amount        = Number(vo.amount)||0;
    const percent       = Math.max(0, Math.min(100, Number(vo.percent)||0));
    const status        = (vo.fundingStatus || 'O').toUpperCase();
    const statusText    = (status === 'O') ? '펀딩진행중' : '펀딩완료';

    const imgUrl        = resolveImage(vo);

    return [
      '<div class="card-box" data-funding-no="', fundingNo, '">',
        '<div class="product-header">',
          '<div class="left-side"><span class="sub-title">', escapeHtml(fundingDate), '</span></div>',
          '<div class="right-side"><span class="', (status==='O'?'funding-ing':'funding-done'), '">', statusText, '</span></div>',
        '</div>',
        '<div class="product-body">',
          '<div class="product-image"><img src="', imgUrl, '" alt="상품 이미지" onerror="this.src=\'', CTX, '/assets/images/eki.jpg\'"></div>',
          '<div class="product-details">',
            '<div class="product-brand">', escapeHtml(brand), '</div>',
            '<div class="product-description">', escapeHtml(title), '</div>',
            '<div class="price">', fmtKRW(price), '</div>',
          '</div>',
          '<div class="left-price-right-price">',
            '<div class="progress-bar"><div class="progress-fill" style="width:', percent, '%;"></div></div>',
          '</div>',
          '<div class="percent">', percent, '%</div>',
          '<div class="price-participation">', fmtKRW(amount), '</div>',
          '<div class="funding-action-wrapper">',
            '<div class="action-buttons">',
              '<button class="btn-funding2 btn-cancel"  data-funding-no="', fundingNo, '">펀딩환불</button>',
              '<button class="btn-funding2 btn-complete" data-funding-no="', fundingNo, '">펀딩완료</button>',
            '</div>',
          '</div>',
        '</div>',
      '</div>'
    ].join('');
  }

  /* ---------- 목록 로드 ---------- */
  function loadMyFunding(){
    $.ajax({
      url: CTX + "/api/myfunding",
      type: "GET",
      dataType: "json"
    })
    .done(function(json){
      const list = pluckList(json);
      const $area = $("#myFundingList").empty();

      if (!list.length){
        $area.html('<div class="empty">아직 등록된 펀딩이 없습니다.</div>');
        return;
      }

      let html = '';
      for (let i=0; i<list.length; i++){
        html += renderCard(list[i]||{});
      }
      $area.html(html);
    })
    .fail(function(xhr, status, err){
      console.error('GET /api/myfunding fail:', status, err, xhr.status, (xhr.responseText||'').slice(0,200));
      $("#myFundingList").html('<div class="empty">목록을 불러오지 못했습니다.</div>');
    });
  }

  /* ---------- 시작 ---------- */
  $(function(){
    loadMyFunding();

    // (추후 API 연결) 버튼 클릭 데모
    $("#myFundingList").on('click', '.btn-cancel',  function(){
      const no = $(this).data('fundingNo');
      alert('펀딩 중단 API 준비중 (fundingNo=' + no + ')');
    });
    $("#myFundingList").on('click', '.btn-complete', function(){
      const no = $(this).data('fundingNo');
      alert('펀딩 완료 API 준비중 (fundingNo=' + no + ')');
    });
  });
})();
</script>

</body>
</html>
