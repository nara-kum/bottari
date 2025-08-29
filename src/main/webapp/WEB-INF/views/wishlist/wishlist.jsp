<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>펀딩 관리 - 위시리스트</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wishlist/wishlist.css">
  <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>
<body class="family">

  <!-- Header -->
  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

  <content class="controller">
  <div id="sec-content" class="sector">

    <!-- 상단 탭 -->
    <div class="sec-sub-title">
      <div class="tab-row" role="navigation">
        <h2 class="header-sub is-active">
          <a href="${pageContext.request.contextPath}/wishlist" aria-current="page">펀딩 관리</a>
        </h2>
        <h2 class="header-sub">
          <a href="${pageContext.request.contextPath}/myfunding">마이 펀딩</a>
        </h2>
        <h2 class="header-sub">
          <a href="${pageContext.request.contextPath}/friendfunding">친구 펀딩</a>
        </h2>
      </div>
    </div>

    <div class="sec-content-main">
      <!-- 좌측 -->
      <div class="left-main content-height">
        <h2 class="top-text">위시리스트</h2>
        <div id="wListArea"></div>
      </div>

      <!-- 우측 -->
      <div class="right-main content-height">
        <h2 class="top-text">선택한 펀딩</h2>

        <div class="funding-controls">
          <select id="funding-table">
            <option value="">------- 기념일 선택 -------</option>
          </select>
          <button id="btnStartFunding" class="btn-funding1" type="button" disabled>펀딩시작하기</button>
        </div>

        <div id="selectedList" class="selected-list"></div>
      </div>
    </div>
  </div>
  </content>

  <!-- Footer -->
  <c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>

<script>
/* =========================
   공통: 경로/유틸
========================= */
window.CTX = "${pageContext.request.contextPath}";

function toInt(v){
  const n = Number(String(v ?? '').replace(/[^\d-]/g,'')); return Number.isFinite(n) ? n : 0;
}
function toPrice(v){ return toInt(v); }
function fmtKRW(n){ return (Number(n)||0).toLocaleString('ko-KR') + '원'; }
function escapeHtml(str){
  return String(str)
    .replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;")
    .replaceAll('"',"&quot;").replaceAll("'","&#039;");
}

/* 이미지 URL 정규화(플레이스홀더 경로 없음!)
   - http(s)면 그대로
   - "/upload/..." 처럼 루트 기준이면 CTX 붙임
   - 상대경로면 CTX + '/' + 경로
   - 없으면 null 반환(렌더링에서 회색 박스 표시)
*/
function ensureUrl(u){
  if (!u) return null;
  let s = String(u).trim();
  if (!s) return null;
  if (/^https?:\/\//i.test(s)) return s;              // http(s)
  if (s.startsWith(window.CTX + "/")) return s;        // CTX포함
  if (s.startsWith("/")) return window.CTX + s;        // 루트 경로
  if (!s.includes("/")) s = "/upload/" + s;         // ▼ 맨 파일명(슬래시 없음) → /upload/ 접두사 붙임

  return window.CTX + s;
}

/* =========================
   리스트 추출: 응답 형태 무엇이 와도 배열만 뽑기
========================= */
function extractList(json){
  if (Array.isArray(json)) return json;
  if (!json || typeof json !== 'object') return [];
  if (Array.isArray(json.data))    return json.data;
  if (Array.isArray(json.apiData)) return json.apiData;
  if (json.result && Array.isArray(json.data)) return json.data;
  for (const k of Object.keys(json)){
    const v = json[k];
    if (Array.isArray(v)) return v;
    if (v && typeof v === 'object'){
      const inner = extractList(v);
      if (inner.length) return inner;
    }
  }
  return [];
}

/* =========================
   서버 응답 → 프론트 모델
========================= */
function normalizeWish(w){
  let productNo  = toInt(w.productNo ?? w.product_no);
  let wishlistNo = toInt(w.wishlistNo ?? w.wishlist_no);

  const priceNum = toPrice(w.price);
  const rawImg = w.imageUrl || w.image || w.image_url || w.itemimg || null;

  return {
    productNo,
    wishlistNo,
    brand:  w.brand || '',
    title:  w.title || '',
    priceNum,
    priceText: priceNum.toLocaleString('ko-KR') + ' 원',
    img: ensureUrl(rawImg),  // 없으면 null

    wishlistOptionNo: toInt(w.wishlistoptionNo ?? w.wishlist_option_no),
    detailOptionNo:   toInt(w.detailoptionNo   ?? w.detail_option_no),
    optionName: w.optionName ?? w.option_name ?? '',
    detailOptionName: w.detailoptionName ?? w.detail_option_name ?? ''
  };
}

/* =========================
   위시리스트 로드
========================= */
function fetchList(){
  $.ajax({
    url : window.CTX + "/api/wishlist",
    type : "get",
    dataType : "json",
    success : function(json){
      const listRaw = extractList(json);
      const $area = $('#wListArea').empty();

      if (!listRaw.length){
        $area.addClass('is-empty').html('<div class="empty">위시리스트가 비어 있어요.</div>');
        return;
      }
      $area.removeClass('is-empty');

      for (let i=0; i<listRaw.length; i++){
        renderCard(listRaw[i]);
      }
    },
    error: function(xhr, status, err){
      console.error("[wishlist] ajax error:", status, err, xhr.status, (xhr.responseText||'').slice(0,200));
      $('#wListArea').addClass('is-empty').html('<div class="empty">목록 불러오기 실패</div>');
    }
  });
}

/* =========================
   카드 렌더 (이미지 없거나 에러면 회색 박스)
========================= */
function renderCard(wishVO){
  const w = normalizeWish(wishVO);
  if (!w.productNo || !w.wishlistNo) return;

  const optParts = [];
  if (w.optionName)       optParts.push(escapeHtml(w.optionName));
  if (w.detailOptionName) optParts.push(escapeHtml(w.detailOptionName));
  const optionText = optParts.join(' / ');
  const hasImg = !!w.img;

  var str = '';
  str += '<div class="a-product"'
      +  ' data-wishlist-no="' + w.wishlistNo + '"'
      +  ' data-product-no="'  + w.productNo  + '"'
      +  ' data-wishlist-option-no="' + (w.wishlistOptionNo || '') + '"'
      +  ' data-detail-option-no="'   + (w.detailOptionNo   || '') + '"'
      +  ' data-option-name="'        + (w.optionName       || '') + '"'
      +  ' data-detail-option-name="' + (w.detailOptionName || '') + '">';

  // 한 줄 레이아웃
  str += '  <div class="image-row">';

  // 체크박스
  str += '    <input type="checkbox" class="product-checkbox">';

  // 썸네일 (100x100)
  str += '    <div class="thumbbox">';
  if (hasImg){
    str += '      <img class="product-image" src="' + w.img + '" alt=""'
        +  ' onerror="this.style.display=\'none\';this.nextElementSibling.style.display=\'block\';">';
    str += '      <div class="img-ph" style="display:none;"></div>';
  } else {
    str += '      <img class="product-image" src="" alt="" style="display:none">';
    str += '      <div class="img-ph"></div>';
  }
  str += '    </div>';

  // 상품 정보 (가격은 바닥 고정)
  str += '    <div class="product-info">';
  str += '      <div class="buy">' + escapeHtml(w.brand) + '</div>';
  str += '      <div class="product-row">';
  str += '        <span class="name">' + escapeHtml(w.title) + '</span>';
  if (optionText){
    str += '        <span class="opt-sep"> / </span><span class="option-name">' + optionText + '</span>';
  }
  str += '      </div>';
  str += '      <div class="product-price">' + escapeHtml(w.priceText) + '</div>';
  str += '    </div>';

  str += '    <div class="product-actions">';
  str += '      <button type="button" class="cart-btn">장바구니</button>';
  str += '      <button type="button" class="wishlist-btn">찜 해제</button>';
  str += '    </div>';

  str += '  </div>'; // .image-row
  str += '</div>';   // .a-product

  $('#wListArea').append(str);
}


/* =========================
   기념일 옵션 로드
========================= */
function loadAnniversaryOptions(){
  $.ajax({
    url  : window.CTX + "/api/eventlist",
    type : "get",
    dataType : "json",
    success  : function(json){
      const data = extractList(json);
      const $sel = $("#funding-table").empty()
        .append('<option value="">----- 기념일 선택 -----</option>');

      if (!data.length){
        $sel.append('<option value="" disabled>기념일이 없습니다</option>');
        return;
      }
      for (let i=0; i<data.length; i++){
        const ev = data[i];
        const eventNo   = toInt(ev.eventNo ?? ev.event_no);
        const eventName = ev.eventName ?? ev.event_name ?? "";
        if (!eventNo) continue;
        $sel.append($('<option>').val(eventNo).text(eventName));
      }
    },
    error : function(xhr, status, err){
      console.error("[eventlist] ajax error:", status, err, xhr.status, (xhr.responseText||'').slice(0,200));
      $("#funding-table").append('<option value="" disabled>불러오기 실패</option>');
    }
  });
}

/* =========================
   선택 목록
========================= */
function addSelected({
  wishlistNo, productNo, brand, title, priceText, priceNum, img,
  wishlistOptionNo, detailOptionNo, optionName, detailOptionName
}){
  // 중복 방지
  if (
    $('#selectedList .selected-item').filter(function(){
      return Number($(this).attr('data-wishlist-no')) === Number(wishlistNo);
    }).length
  ) return;

  const pid    = Number(productNo) || 0;
  const pprice = Number(priceNum)  || 0;
  const u      = ensureUrl(img); // 있으면 URL, 없으면 null

  // 옵션 문자열(있을 때만 출력)
  const optParts = [];
  if (optionName)       optParts.push(escapeHtml(optionName));
  if (detailOptionName) optParts.push(escapeHtml(detailOptionName));
  const optionText = optParts.join(' / ');

  var html = ''
    + '<div class="selected-item"'
    +   ' data-wishlist-no="' + wishlistNo + '"'
    +   ' data-product-no="'  + pid        + '"'
    +   ' data-price="'       + pprice     + '"'
    +   ' data-wishlist-option-no="' + (wishlistOptionNo || '') + '"'
    +   ' data-detail-option-no="'   + (detailOptionNo   || '') + '"'
    +   ' data-option-name="'        + (optionName       || '') + '"'
    +   ' data-detail-option-name="' + (detailOptionName || '') + '">'

    +     (u
            ? '<img class="selected-thumb" src="' + u + '"'
              + ' onerror="this.style.display=\'none\';this.nextElementSibling.style.display=\'block\';">'
            : '<img class="selected-thumb" src="" style="display:none;">'
          )

    +   '<div class="selected-meta">'
    +     '<div class="selected-brand">' + escapeHtml(brand) + '</div>'
    +     '<div class="selected-title-row">'
    +       '<span class="selected-title">' + escapeHtml(title) + '</span>'
    +       (optionText ? ' <span class="opt-sep"> / </span><span class="selected-option">' + optionText + '</span>' : '')
    +     '</div>'
    +     '<div class="sel-amount">'
    +       '<label><input type="radio" name="amt_' + wishlistNo + '" value="FULL" checked> 전액</label>'
    +       '<label><input type="radio" name="amt_' + wishlistNo + '" value="P5"> 5%</label>'
    +       '<span class="selected-amount">펀딩 단위 금액:'
    +         '<b class="selected-amount-value">' + fmtKRW(pprice) + '</b>'
    +       '</span>'
    +     '</div>'
    +   '</div>'
    + '</div>';

  $('#selectedList').append(html);
}


function removeSelected(wishlistNo){
  $('#selectedList .selected-item[data-wishlist-no="' + wishlistNo + '"]').remove();
}

function updateStartButtonState(){
  const hasSelected = $('#selectedList .selected-item').length > 0;
  const hasEvent    = !!$('#funding-table').val();
  $('#btnStartFunding').prop('disabled', !(hasSelected && hasEvent));
}

/* =========================
   펀딩 시작 (POST)
========================= */
function startFunding(){
  const eventNo = Number($('#funding-table').val()) || 0;
  if(!eventNo){ alert('기념일을 먼저 선택해주세요.'); return; }

  const items = $('#selectedList .selected-item').map(function(){
    const $it = $(this);
    const basePrice = Number($it.attr('data-price')) || 0;
    const sel = String($it.find('.sel-amount input[type=radio]:checked').val() || 'FULL').toUpperCase();

    const percent = (sel === 'P5') ? 5 : 100;
    const amount  = (sel === 'P5') ? Math.floor(basePrice * 0.05) : basePrice;

    const wishlistNo       = Number($it.attr('data-wishlist-no')) || 0;
    const productNo        = Number($it.attr('data-product-no'))  || 0;
    const detailoptionNo   = Number($it.attr('data-detail-option-no'))   || 0;
    const wishlistoptionNo = Number($it.attr('data-wishlist-option-no')) || 0;

    if (!wishlistNo || !productNo) return null;

    return {
      eventNo:    eventNo,
      productNo:  productNo,
      wishlistNo: wishlistNo,
      percent:    percent,
      amount:     amount,
      detailoptionNo:   detailoptionNo,
      wishlistoptionNo: wishlistoptionNo
    };
  }).get().filter(Boolean);

  if(!items.length){ alert('선택된 상품이 없습니다.'); return; }

  const $btn = $('#btnStartFunding').prop('disabled', true);

  $.ajax({
    url: window.CTX + '/api/openfunding',
    type: 'POST',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(items)
  })
  .done(function (json) {
    if (json && json.result === 'success') {
      sessionStorage.setItem('NEW_FUNDING_ITEMS', JSON.stringify(items));
      alert('펀딩이 생성되었습니다.');
      location.href = window.CTX + 'funding/my';
    } else {
      alert('처리에 실패했습니다. 잠시 후 다시 시도해주세요.');
    }
  })
  .fail(function (xhr, status, err) {
    console.error(status, err, (xhr.responseText||'').slice(0,200));
    alert('펀딩 시작에 실패했습니다. 잠시 후 다시 시도해주세요.');
  })
  .always(function () { $btn.prop('disabled', false); });
}

/* =========================
   DOM Ready
========================= */
$(function(){
  fetchList();
  loadAnniversaryOptions();

  // 좌측 체크 → 우측 추가/제거
  $('#wListArea').on('change', '.product-checkbox', function(){
    const $card  = $(this).closest('.a-product');

    const wishlistNo = Number($card.attr('data-wishlist-no')) || 0;
    const productNo  = Number($card.attr('data-product-no'))  || 0;

    const brand  = $card.find('.buy').text().trim();
    const title  = $card.find('.name').text().trim();
    const priceText = $card.find('.product-price').text().trim();
    const priceNum  = toPrice(priceText);

    // 현재 카드의 썸네일 url(이미 ensureUrl 반영 완료)
    const imgEl = $card.find('img.product-image')[0];
    const img   = (imgEl && imgEl.src) ? imgEl.src : null;

    const wishlistOptionNo = $card.attr('data-wishlist-option-no') || null;
    const detailOptionNo   = $card.attr('data-detail-option-no')   || null;
    const optionName       = $card.attr('data-option-name') || '';
    const detailOptionName = $card.attr('data-detail-option-name') || '';

    if (this.checked) {
      if (!wishlistNo || !productNo){
        alert('상품 정보를 불러오지 못했습니다. 새로고침 후 다시 시도해 주세요.');
        this.checked = false;
        return;
      }
      addSelected({
        wishlistNo, productNo, brand, title, priceText, priceNum, img,
        wishlistOptionNo, detailOptionNo, optionName, detailOptionName
      });
    } else {
      removeSelected(wishlistNo);
    }
    updateStartButtonState();
  });

  // 전액/5% 표시만 갱신
  $('#selectedList').on('change', '.sel-amount input[type=radio]', function(){
    const $item = $(this).closest('.selected-item');
    const base  = Number($item.attr('data-price')) || 0;
    let amount = base;
    if (this.value === 'P5') amount = Math.floor(base * 0.05);
    $item.find('.selected-amount-value').text(fmtKRW(amount));
  });

  // 기념일 선택 시 버튼 활성화
  $('#funding-table').on('change', updateStartButtonState);

  // 펀딩 시작
  $('#btnStartFunding').on('click', startFunding);
});
</script>

</body>
</html>
