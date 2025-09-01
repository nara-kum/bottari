<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

  <content class="controller">
    <div id="sec-content" class="sector">
      <div class="sec-sub-title">
        <div class="tab-row" role="navigation">
          <h2 class="header-sub"><a href="${pageContext.request.contextPath}/funding/wish">펀딩 관리</a></h2>
          <h2 class="header-sub is-active"><a href="${pageContext.request.contextPath}/funding/my" aria-current="page">마이 펀딩</a></h2>
          <h2 class="header-sub"><a href="${pageContext.request.contextPath}/funding/friend">친구 펀딩</a></h2>
        </div>
      </div>

      <div class="sec-content-main">
        <div id="myFundingList" class="content"></div>
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

  function statusView(vo, percentCalc){
    const raw = String((vo.fundingStatus ?? '') || '').toLowerCase();
    if (raw === 'stop') return {text:'펀딩중단', cls:'funding-stop'};
    if (raw === 'done' || percentCalc >= 100) return {text:'펀딩완료', cls:'funding-done'};
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
    const paidAmount  = Number(vo.paidAmount ?? vo.paymentAmount ?? 0);
    const percentCalc = price > 0 ? Math.min(100, Math.round(paidAmount/price*100)) : 0;

    const imgUrl = resolveImage(vo);
    const st = statusView(vo, percentCalc);
    const esc = s => $('<div>').text(s||'').html();

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
            '<div class="bar"><div class="fill" style="width:', percentCalc, '%;"></div></div>',
            '<div class="goal">',
              '<span class="curr">', fmtKRW(paidAmount), '</span>',
              '<span class="sep"> / </span>',
              '<span class="total">', fmtKRW(price), '</span>',
            '</div>',
            '<div class="achv"><span class="pct">', percentCalc, '% 달성</span></div>',
          '</div>',

          '<div class="funding-action-wrapper">',
            '<div class="action-buttons">',
              '<button class="btn-funding2 btn-cancel"  data-funding-no="', fundingNo, '">펀딩중단</button>',
              '<button class="btn-funding2 btn-complete" data-funding-no="', fundingNo, '">펀딩완료</button>',
            '</div>',
          '</div>',
        '</div>',
      '</div>'
    ].join('');
  }

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
    .fail(function(xhr){
      console.error('GET /api/myfunding fail:', xhr.status, (xhr.responseText||'').slice(0,200));
      $("#myFundingList").html('<div class="empty">목록을 불러오지 못했습니다.</div>');
    });
  }

  // 이벤트 바인딩
  $(document).on('click', '.btn-cancel', function(){
    const no = Number($(this).data('fundingNo'));
    if (!no){ alert('펀딩 번호가 없습니다.'); return; }
    if (!confirm('정말 이 펀딩을 중단하시겠어요?\n(연결된 결제내역도 함께 삭제됩니다)')) return;

    $.ajax({
      url: CTX + "/api/funding/stop",
      type: "POST",
      dataType: "json",
      data: { fundingNo: no }
    })
    .done(function(res){
      if (res && res.result === 'success'){
        const $card = $('.card-box[data-funding-no="'+no+'"]');
        $card.find('.funding-badge')
             .removeClass('funding-ing funding-done')
             .addClass('funding-stop')
             .text('펀딩중단');
        $card.find('.action-buttons .btn-funding2').prop('disabled', true).addClass('is-disabled');
        alert('펀딩이 중단되었습니다.');
      } else {
        alert((res && res.message) || '중단에 실패했습니다.');
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
      console.error('[POST /api/funding/stop] fail', xhr.status, (xhr.responseText||'').slice(0,200));
    });
  });

$("#myFundingList").on('click', '.btn-complete', function(){
  const fundingNo = $(this).data('fundingNo');
  if (!fundingNo) { alert('fundingNo가 없습니다.'); return; }

  // 필요 시 productNo도 함께 보내고 싶다면 버튼/카드에 data-product-no 넣어서 함께 전달 가능
  const productNo = $(this).closest('.card-box').data('productNo');

  // 👉 실제 상세 URL로 바꿔 쓰세요 (기본 예시 경로)
  // 1순위: /funding/purchase/detail?fundingNo=...
  // 필요하면 아래 두 줄 중 하나로 조정:
  // const url = CTX + '/funding/purchase?fundingNo=' + encodeURIComponent(fundingNo);
  // const url = CTX + '/funding/detail?no=' + encodeURIComponent(fundingNo);

  const base = CTX + '/funding/purchase/detail';
  const qs = $.param(productNo ? { fundingNo, productNo } : { fundingNo });
  location.href = base + '?' + qs;
});

  // DOM 준비 후 목록 로드
  $(function(){ loadMyFunding(); });

})(); // <-- 딱 한 번만 닫음
</script>

</body>
</html>
