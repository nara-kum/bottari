<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>친구 펀딩</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/funding/myfunding.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wishlist/wishlist.css">
  <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>

<body class="family">
  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

  <content class="controller">
    <div id="sec-content" class="sector">
      <div class="sec-sub-title">
        <div class="tab-row" role="navigation">
          <h2 class="header-sub"><a href="${pageContext.request.contextPath}/funding/wish">펀딩 관리</a></h2>
          <h2 class="header-sub"><a href="${pageContext.request.contextPath}/funding/my">마이 펀딩</a></h2>
          <h2 class="header-sub is-active"><a href="${pageContext.request.contextPath}/funding/friend" aria-current="page">친구 펀딩</a></h2>
        </div>
      </div>

      <div class="sec-content-main">
        <div id="friendFundingList" class="content"></div>
      </div>
    </div>
  </content>

  <c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>

<script>
(function(){
  const CTX = "${pageContext.request.contextPath}";

  function fmtKRW(n){ return (Number(n)||0).toLocaleString('ko-KR') + '원'; }
  function pluckList(json){
    if (Array.isArray(json)) return json;
    if (!json || typeof json !== 'object') return [];
    if (Array.isArray(json.data)) return json.data;
    if (Array.isArray(json.apiData)) return json.apiData;
    if (json.data && Array.isArray(json.data.list)) return json.data.list;
    if (Array.isArray(json.list)) return json.list;
    return [];
  }
  function resolveImage(vo){
    let raw = vo.image || vo.imageUrl || vo.image_url ||
              vo.itemimg || vo.itemImg ||
              vo.saveName || vo.save_name ||
              vo.thumbnail || vo.thumb || '';
    if (!raw) return CTX + "/assets/images/eki.jpg";
    raw = String(raw).trim();
    if (/^https?:\/\//i.test(raw)) return raw;
    if (raw.startsWith("/upload/")) return raw;
    if (raw.startsWith(CTX + "/upload/")) return raw;
    if (raw.startsWith("/")) return raw;
    return CTX + "/upload/" + raw;
  }
  function statusView(vo, percent){
    const s = String(vo.fundingStatus || '').toLowerCase();
    if (s === 'stop') return {text:'펀딩중단', cls:'funding-stop'};
    if (s === 'done' || percent >= 100) return {text:'펀딩완료', cls:'funding-done'};
    return {text:'펀딩진행중', cls:'funding-ing'};
  }

  function renderCard(vo){
    const fundingNo   = Number(vo.fundingNo)||0;
    const fundingDate = vo.fundingDate || '';
    const brand       = vo.brand || '';
    const title       = vo.title || '';
    const optionName  = vo.optionName ?? vo.option_name ?? '';
    const detailOpt   = vo.detailoptionName ?? vo.detail_option_name ?? '';
    const price       = Number(vo.price)||0;
    const paidAmount  = Number(vo.paidAmount||0); // ← 총 결제합(모든 사람)
    const percent     = price>0 ? Math.min(100, Math.round(paidAmount/price*100)) : 0;

    const imgUrl = resolveImage(vo);
    const st = statusView(vo, percent);
    const esc = s => $('<div>').text(s||'').html();

    // 친구펀딩은 조작버튼 없음 (보기만)
    return [
      '<div class="card-box" data-funding-no="', fundingNo, '">',
        '<div class="product-header">',
          '<div class="left-side"><span class="sub-title">', esc(fundingDate), '</span></div>',
          '<div class="right-side"><span class="funding-badge ', st.cls, '">', st.text, '</span></div>',
        '</div>',
        '<div class="product-body">',
          '<div class="mf-left"><div class="mf-row">',
            '<div class="thumbbox">',
              '<img class="product-image" src="', imgUrl, '" alt="" onerror="this.src=\'', CTX, '/assets/images/eki.jpg\'">',
            '</div>',
            '<div class="product-info">',
              '<div class="buy">', esc(brand), '</div>',
              '<div class="product-row">',
                '<span class="name">', esc(title), '</span>',
                (optionName ? '<span class="opt-sep"> / </span><span class="option-name">'+esc(optionName)+'</span>' : ''),
                (detailOpt ? '<span class="opt-sep"> / </span><span class="option-name">'+esc(detailOpt)+'</span>' : ''),
              '</div>',
              '<div class="product-price">', fmtKRW(price), '</div>',
            '</div>',
          '</div></div>',

          '<div class="mf-meter with-goal">',
            '<div class="bar"><div class="fill" style="width:', percent, '%;"></div></div>',
            '<div class="goal">',
              '<span class="curr">', fmtKRW(paidAmount), '</span>',
              '<span class="sep"> / </span>',
              '<span class="total">', fmtKRW(price), '</span>',
            '</div>',
            '<div class="achv"><span class="pct">', percent, '% 달성</span></div>',
          '</div>',

          '<div class="funding-action-wrapper">',
            '<div class="action-buttons">',
              '<a class="btn-funding2" href="', CTX, '/shop/productPage2?productNo=', (vo.productNo||''), '&fundingNo=', fundingNo, '">상세보기</a>',
            '</div>',
          '</div>',
        '</div>',
      '</div>'
    ].join('');
  }

  function loadFriendFunding(){
    $.ajax({ url: CTX + "/api/friendfunding", type: "GET", dataType: "json" })
    .done(function(json){
      const list = pluckList(json);
      const $area = $("#friendFundingList").empty();
      if (!list.length){ $area.html('<div class="empty">내가 참여한 펀딩이 없습니다.</div>'); return; }
      $area.html(list.map(v=>renderCard(v||{})).join(''));
    })
    .fail(function(xhr){
      if (xhr.status === 401){
        const returnUrl = location.pathname + location.search;
        alert('로그인이 필요합니다.');
        location.href = CTX + "/user/loginForm?reason=auth&returnUrl=" + encodeURIComponent(returnUrl);
        return;
      }
      console.error('GET /api/friendfunding fail:', xhr.status, (xhr.responseText||'').slice(0,200));
      $("#friendFundingList").html('<div class="empty">목록을 불러오지 못했습니다.</div>');
    });
  }

  $(function(){ loadFriendFunding(); });
})();
</script>
</body>
</html>
