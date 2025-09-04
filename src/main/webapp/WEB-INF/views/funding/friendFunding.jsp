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

  <title>보따리몰</title>
</head>

<body class="family">
  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
<div class="screen-wrapper">
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
</div>
<script>
(function(){
  const CTX = "${pageContext.request.contextPath}";

  const fmtKRW = (n)=> (Number(n)||0).toLocaleString('ko-KR') + '원';
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

  // 금액 규칙: 카드 가격/분모 = product.price, 진행바 분자 = paidAmount(결제합계)
  const price       = Number(vo.price)||0;                      // 분모/카드가격
  const paidAmount  = Number(vo.paidAmount || 0);               // 분자(누적 결제합)
  const percent     = price > 0 ? Math.min(100, Math.round(paidAmount / price * 100)) : 0;

  // 상태/비활성 판정
  const statusRaw   = String(vo.fundingStatus || vo.status || '').toLowerCase();
  const statusName  = String(vo.statusName || '').trim();
  const disabledByServer = Number(vo.cancelButtonEnabled) === 0; // 서버 플래그(0이면 비활성)
  const doneOrStopped =
      statusRaw === 'done' ||
      statusRaw === 'stop' ||
      percent >= 100 ||
      statusName.includes('완료');

  const cancelDisabled = doneOrStopped || disabledByServer;

  // 오버레이 문구(이유)
  const disabledReason =
      statusRaw === 'stop' ? '펀딩 중단'
    : (statusRaw === 'done' || percent >= 100 || statusName.includes('완료')) ? '펀딩 완료'
    : (disabledByServer ? '참여 취소' : '');

  const cancelAttr = cancelDisabled ? ' disabled aria-disabled="true" tabindex="-1"' : '';
  const cancelCls  = cancelDisabled ? ' is-disabled' : '';

  // sub-title: eventName(있으면) → fundingDate(없으면)
  const eventName   = (vo.eventName ?? vo.event_name ?? '').toString().trim();
  const fundingDate = vo.fundingDate || '';
  const subTitle    = eventName || fundingDate;

  const brand       = vo.brand || '';
  const title       = vo.title || '';
  const optionName  = vo.optionName ?? vo.option_name ?? '';
  const detailOpt   = vo.detailoptionName ?? vo.detail_option_name ?? '';
  const imgUrl      = resolveImage(vo);
  const st          = statusView(vo, percent);
  const esc         = s => $('<div>').text(s||'').html();

  const cardCls     = cancelDisabled ? ' is-card-disabled' : '';
  const cardData    = cancelDisabled && disabledReason ? ' data-disabled-reason="'+esc(disabledReason)+'"' : '';

  return [
    '<div class="card-box', cardCls, '" data-funding-no="', fundingNo, '" data-price="', price, '"', cardData, '>',
      '<div class="product-header">',
        '<div class="left-side"><span class="sub-title">', esc(subTitle), '</span></div>',
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
            '<button class="btn-funding2 btn-cancel-friend', cancelCls, '" data-funding-no="', fundingNo, '"', cancelAttr, '>펀딩취소</button>',
            '<button class="btn-funding2 btn-history" data-funding-no="', fundingNo, '">구매내역</button>',
          '</div>',
        '</div>',
      '</div>',
    '</div>'
  ].join('');
}



  function drawList(json){
    const list = pluckList(json);
    const $area = $("#friendFundingList").empty();
    if (!Array.isArray(list) || list.length===0){
      $area.html('<div class="empty">내가 참여한 펀딩이 없습니다.</div>');
      return;
    }
    $area.html(list.map(v=>renderCard(v||{})).join(''));
  }

  function reloadList(){
    $.ajax({ url: CTX + "/api/funding/friend-list", type: "GET", dataType: "json" })
      .done(drawList)
      .fail(function(xhr){
        if (xhr.status === 401){
          const returnUrl = location.pathname + location.search;
          alert('로그인이 필요합니다.');
          location.href = CTX + "/user/loginForm?reason=auth&returnUrl=" + encodeURIComponent(returnUrl);
          return;
        }
        console.error('GET /api/funding/friend-list fail:', xhr.status, (xhr.responseText||'').slice(0,200));
        $("#friendFundingList").html('<div class="empty">목록을 불러오지 못했습니다.</div>');
      });
  }

  $(function(){ reloadList(); });

  // (옵션) 펀딩 취소 – 서버에 맞춰 엔드포인트 조정 가능
$(document).on('click', '.btn-cancel-friend', function(e){
  const $btn = $(this);
  if ($btn.prop('disabled') || $btn.hasClass('is-disabled')) {
    e.preventDefault();
    return; // 완료건은 무시
  }
  // ↓ 기존 취소 로직 그대로
  const fundingNo = Number($btn.data('fundingNo'))||0;
  if (!fundingNo){ alert('펀딩 번호가 없습니다.'); return; }
  if (!confirm('펀딩을 취소하시겠습니까?')) return;

  $.ajax({
    url: CTX + "/api/funding/friend/cancel",
    type: "POST",
    dataType: "json",
    data: { fundingNo }
  })
  .done(function(res){
  if (res && res.result === 'success'){
    // 1) 취소 버튼 잠그기
    $btn.prop('disabled', true)
        .attr('aria-disabled', 'true')
        .addClass('is-disabled');
    // 2) 최신 데이터 반영 (서버에서 cancel 상태 플래그 내려줌)
    reloadList();
  } else {
    alert((res && res.message) || '취소에 실패했습니다.');
  }
})
  .fail(function(xhr){
    if (xhr.status === 401){
      const returnUrl = location.pathname + location.search;
      alert('로그인이 필요합니다.');
      location.href = CTX + "/user/loginForm?reason=auth&returnUrl=" + encodeURIComponent(returnUrl);
      return;
    }
    alert('처리 중 오류가 발생했습니다.');
    console.error('[POST /api/funding/friend/cancel] fail', xhr.status, (xhr.responseText||'').slice(0,200));
  });
});

})();
</script>
</body>
</html>
