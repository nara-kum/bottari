<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
  <div class="screen-wrapper">
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
  </div>

  <!-- 참여자 랭킹 모달 (한 번만 선언) -->
<div id="mfContribModal" class="mf-modal" role="dialog" aria-modal="true" aria-hidden="true">
  <div class="panel" role="document">
    <div class="head">
      <div class="title">참여자 랭킹</div>
      <button type="button" class="close" aria-label="닫기">&times;</button>
    </div>
    <div class="list" id="mfContribList"></div>
  </div>
</div>
<script>
(function(){
  const CTX = "${pageContext.request.contextPath}";

  const fmtKRW = (n)=> (Number(n)||0).toLocaleString('ko-KR') + '원';
  const esc = s => $('<div>').text(s==null?'':String(s)).html();

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
    const productNo   = Number(vo.productNo)||0;   // ★ 추가
    const fundingDate = vo.fundingDate || '';
    const eventName   = vo.eventName || '';
    const brand       = vo.brand || '';
    const title       = vo.title || '';
    const optionName  = vo.optionName ?? vo.option_name ?? '';
    const detailOpt   = vo.detailoptionName ?? vo.detail_option_name ?? '';
    const price       = Number(vo.price)||0;
    const paidAmount  = Number(vo.paidAmount||0);   // 초기분자 (서버 집계)
    const percent     = price>0 ? Math.min(100, Math.round(paidAmount/price*100)) : 0;

    const imgUrl = resolveImage(vo);
    const st = statusView(vo, percent);
    const disabled = (String(vo.fundingStatus||'').toLowerCase() === 'stop');

    return [
      '<div class="card-box" data-funding-no="', fundingNo, '" data-price="', price, '" data-product-no="', productNo, '">',
        '<div class="product-header">',
          '<div class="left-side"><span class="sub-title">', esc(eventName), '</span></div>',
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
              '<button class="btn-funding2 btn-cancel"  data-funding-no="', fundingNo, '"',
                  (disabled ? ' disabled aria-disabled="true"' : ''), '>펀딩중단</button>',
              '<button class="btn-funding2 btn-complete" data-funding-no="', fundingNo, '"',
                  (disabled ? ' disabled aria-disabled="true"' : ''), '>펀딩완료</button>',
            '</div>',
          '</div>',
        '</div>',
      '</div>'
    ].join('');
  }

  /* per-card 총 결제합(정확도 보정) */
  function updateCardMeter($card){
    const fundingNo = Number($card.data('fundingNo'))||0;
    const price     = Number($card.data('price'))||0;
    if(!fundingNo) return;
    $.getJSON(CTX + '/api/funding/total', { fundingNo })
      .done(function(r){
        const paid = Number(r?.data?.totalPaid ?? r?.apiData?.totalPaid ?? 0);
        const pct  = price>0 ? Math.min(100, Math.round(paid/price*100)) : 0;
        $card.find('.mf-meter .fill').css('width', pct + '%');
        $card.find('.mf-meter .goal .curr').text(fmtKRW(paid));
        $card.find('.mf-meter .achv .pct').text(pct + '% 달성');
      });
  }
  function refreshAllMeters(){ $('.card-box').each(function(){ updateCardMeter($(this)); }); }

  function loadMyFunding(){
    $.ajax({ url: CTX + "/api/funding/my-list", type: "GET", dataType: "json" })
      .done(function(json){
        const list = pluckList(json);
        const $area = $("#myFundingList").empty();
        if (!list.length){
          $area.html('<div class="empty">아직 등록된 펀딩이 없습니다.</div>');
          return;
        }
        $area.html(list.map(v=>renderCard(v||{})).join(''));
        refreshAllMeters();
      })
      .fail(function(xhr){
        if (xhr.status === 401){
          const returnUrl = location.pathname + location.search;
          alert('로그인이 필요합니다.');
          location.href = CTX + "/user/loginForm?reason=auth&returnUrl=" + encodeURIComponent(returnUrl);
          return;
        }
        console.error('GET /api/funding/my-list fail:', xhr.status, (xhr.responseText||'').slice(0,200));
        $("#myFundingList").html('<div class="empty">목록을 불러오지 못했습니다.</div>');
      });
  }

  $(function(){ loadMyFunding(); });

  /* 버튼 액션 */
  $(document).on('click', '.btn-cancel', function(){
    const no = Number($(this).data('fundingNo'));
    if (!no){ alert('펀딩 번호가 없습니다.'); return; }
    if (!confirm('정말 이 펀딩을 중단하시겠어요?')) return;

    $.ajax({ url: CTX + "/api/funding/stop", type: "POST", dataType: "json", data: { fundingNo: no } })
      .done(function(res){
      if (res && res.result === 'success'){
        const $card = $('.card-box[data-funding-no="'+no+'"]');
        $card.find('.funding-badge')
             .removeClass('funding-ing funding-done')
             .addClass('funding-stop').text('펀딩중단');

        // ★ 모든 버튼 비활성
        $card.find('.action-buttons .btn-funding2')
             .prop('disabled', true)
             .attr('aria-disabled','true')
             .addClass('is-disabled');

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
      });
  });

  $(document).on('click', '.btn-complete', function(){
    const no = Number($(this).data('fundingNo'));
    if (!no){ alert('펀딩 번호가 없습니다.'); return; }
    if (!confirm('펀딩을 완료 처리하시겠어요?')) return;

    $.ajax({ url: CTX + "/api/funding/complete", type: "POST", dataType: "json", data: { fundingNo: no } })
      .done(function(res){
      if (res && res.result === 'success'){
        const $card = $('.card-box[data-funding-no="'+no+'"]');
        $card.find('.funding-badge')
             .removeClass('funding-ing funding-stop')
             .addClass('funding-done').text('펀딩완료');

        alert('완료 처리되었습니다.');  // ★ 기존 알림 유지

        // ★ 상세로 이동 (남은 금액 자동 선택 힌트 포함)
        const productNo = Number($card.data('productNo'))||0;
        const url = CTX + '/shop/productPage2?productNo=' + productNo + '&fundingNo=' + no + '&auto=remaining';
        location.href = url;
      } else {
        alert((res && res.message) || '완료 처리에 실패했습니다.');
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
      });
  });
})();

// ===== [추가] 참여자 랭킹 =====
(function(){
  const CTX = "${pageContext.request.contextPath}";
  const $modal = $('#mfContribModal');
  const $list  = $('#mfContribList');

  function fmtKRW(n){ return (Number(n)||0).toLocaleString('ko-KR') + '원'; }
  function pctOf(n, base){
    const p = (base>0) ? Math.round((Number(n)||0)/base*100) : 0;
    return Math.max(0, Math.min(100, p));
  }
  function esc(s){ return $('<div>').text(s==null?'':String(s)).html(); }

  // 모달 열기/닫기
  function openModal(){ $modal.css('display','flex').attr('aria-hidden','false'); }
  function closeModal(){ $modal.css('display','none').attr('aria-hidden','true'); }
  $modal.on('click', function(e){ if(e.target === this) closeModal(); });
  $modal.find('.close').on('click', closeModal);
  $(document).on('keydown', function(e){ if(e.key==='Escape') closeModal(); });

  // 서버 요청 → 리스트 렌더
  function loadParticipants(fundingNo, price){
    $list.html('<div style="padding:18px 10px;color:#666;">불러오는 중...</div>');
    $.getJSON(CTX + '/api/funding/participants', { fundingNo })
      .done(function(res){
        const rows = (res && (res.data||res.apiData||res.list||res)) || [];
        if(!Array.isArray(rows) || rows.length===0){
          $list.html('<div style="padding:20px;color:#666;">아직 참여한 친구가 없습니다.</div>');
          return;
        }
        // 정렬: 금액 desc
        rows.sort(function(a,b){ return (Number(b.amount||0) - Number(a.amount||0)); });
        // 렌더
        let html = '';
        for(let i=0;i<rows.length;i++){
          const r = rows[i] || {};
          const rank = (i+1);
          const name = r.userName || r.name || ('친구#'+(r.userNo||'?'));
          const photo = r.profileImg || r.profileUrl || r.profile || '';
          const amt = Number(r.amount||0);
          const pct = pctOf(amt, Number(price||0));
          html += ''
            + '<div class="row" data-user="'+esc(r.userNo||'')+'">'
            +   '<div class="rank">'+rank+'</div>'
            +   '<div class="name">'+esc(name)+'</div>'
            +   '<div class="right"><span class="amt">'+fmtKRW(amt)+'</span><span class="pct">'+pct+'%</span></div>'
            + '</div>';
        }
        $list.html(html);
      })
      .fail(function(xhr){
        let msg = '목록을 불러오지 못했습니다.';
        if(xhr.status===401){
          msg = '로그인이 필요합니다.';
        }
        $list.html('<div style="padding:18px 10px;color:#c00;">'+esc(msg)+'</div>');
      });
  }

  // 카드의 진행바 클릭 시 모달 오픈
  $(document).on('click', '.card-box .mf-meter', function(){
    const $card = $(this).closest('.card-box');
    const fundingNo = Number($card.data('fundingNo'))||0;
    const price     = Number($card.data('price'))||0;
    if(!fundingNo){ return; }
    openModal();
    loadParticipants(fundingNo, price);
  });
})();

</script>
</body>
</html>
