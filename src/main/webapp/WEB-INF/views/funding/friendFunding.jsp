<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myfunding.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wishlist.css">
<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>

<title>마이 펀딩</title>
</head>

<body class="family">

	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
	
	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<div class="tab-row" role="navigation">
				<!-- 펀딩 관리 -->
				<h2 class="header-sub">
					<a href="${pageContext.request.contextPath}/wishlist">
					펀딩 관리
					</a>
				</h2>

				<!-- 마이 펀딩 -->
				<h2 class="header-sub">
				<a href="${pageContext.request.contextPath}/myfunding">
					마이 펀딩
				</a>
				</h2>

				<!-- 친구 펀딩 -->
				<h2 class="header-sub is-active">
					<a href="${pageContext.request.contextPath}/friendfunding" aria-current="page">
					친구 펀딩
					</a>
				</h2>
			</div>
		</div>

		<div class="sec-content-main">
			<div id="myFundingList" class="content"></div>
		  </div>
	  
		</div>
		</content>
	  
		<!------------------------ Footer ------------------------>
		<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
		<!------------------------------------------------------->
	  
	  <script>
	  (function(){
	  
		function fmtKRW(n){ return (Number(n)||0).toLocaleString('ko-KR') + '원'; }
    function escapeHtml(s){
      return String(s).replaceAll('&','&amp;').replaceAll('<','&lt;')
                      .replaceAll('>','&gt;').replaceAll('"','&quot;')
                      .replaceAll("'",'&#039;');
    }

    // ✅ 응답에서 리스트만 뽑아내는 유틸 (모든 케이스 커버)
    function pluckList(json){
      if (Array.isArray(json)) return json;
      if (!json || typeof json !== 'object') return [];
      if (Array.isArray(json.data)) return json.data;
      if (Array.isArray(json.apiData)) return json.apiData;
      if (json.data && Array.isArray(json.data.list)) return json.data.list;
      if (Array.isArray(json.list)) return json.list;
      return [];
    }

    function renderCard(vo){
      const fundingNo     = Number(vo.fundingNo)||0;
      const fundingDate   = vo.fundingDate || '';
      // const eventName     = vo.eventName || '';
      const brand         = vo.brand || '';
      const title         = vo.title || '';
      const price         = Number(vo.price)||0;
      const amount        = Number(vo.amount)||0;
      const percent       = Number(vo.percent)||0;
      const fundingStatus = vo.fundingStatus || 'O';
      const image         = vo.image || ('${pageContext.request.contextPath}/assets/images/eki.jpg');
      const statusText    = (fundingStatus === 'O') ? '펀딩진행중' : '펀딩완료';
      // const leftText   = eventName ? (fundingDate + ' | ' + eventName) : fundingDate;

      return [
        '<div class="card-box" data-funding-no="', fundingNo, '">',
          '<div class="product-header">',
            '<div class="left-side"><span class="sub-title">', escapeHtml(fundingDate), '</span></div>',
            '<div class="right-side"><span class="', (fundingStatus==='O'?'funding-ing':'funding-done'), '">', statusText, '</span></div>',
          '</div>',
          '<div class="product-body">',
            '<div class="product-image"><img src="', image, '" alt="상품 이미지"></div>',
            '<div class="product-details">',
              '<div class="product-brand">', escapeHtml(brand), '</div>',
              '<div class="product-description">', escapeHtml(title), '</div>',
              '<div class="price">', fmtKRW(price), '</div>',
            '</div>',
            '<div class="left-price-right-price">',
              '<div class="progress-bar"><div class="progress-fill" style="width:', Math.max(0, Math.min(100, percent)), '%;"></div></div>',
            '</div>',
            '<div class="percent">', percent, '%</div>',
            '<div class="price-participation">', fmtKRW(amount), '</div>',
            '<div class="funding-action-wrapper">',
              '<div class="action-buttons">',
                '<button class="btn-funding1 btn-cancel"  data-funding-no="', fundingNo, '">펀딩 중단</button>',
                '<button class="btn-funding1 btn-complete" data-funding-no="', fundingNo, '">펀딩 완료</button>',
              '</div>',
            '</div>',
          '</div>',
        '</div>'
      ].join('');
    }
	  
		// 목록 로드
		function loadMyFunding(){
      const CTX = "${pageContext.request.contextPath}";
      $.ajax({
        url: CTX + "/api/myfunding",
        type: "GET",
        dataType: "json"
      })
      .done(function(json){
        console.log("[myfunding] raw:", json);
        const list = pluckList(json);
        console.log("[myfunding] parsed length:", list.length);

        const $area = $("#myFundingList").empty();
        if (!list.length){
          // 빈값이어도 안내는 보여주기
          $area.html('<div class="empty">아직 등록된 펀딩이 없습니다.</div>');
          return;
        }

        let html = '';
        for (let i=0; i<list.length; i++) html += renderCard(list[i]||{});
        $area.html(html);
      })
      .fail(function(xhr, status, err){
        console.error('GET /api/myfunding fail:', status, err, xhr.status, (xhr.responseText||'').slice(0,200));
        $("#myFundingList").html('<div class="empty">목록을 불러오지 못했습니다.</div>');
      });
    }

    $(function(){
      loadMyFunding();
      $("#myFundingList").on('click', '.btn-cancel',  e => alert('펀딩 중단 API 준비중'));
      $("#myFundingList").on('click', '.btn-complete', e => alert('펀딩 완료 API 준비중'));
    });
  })();
	  </script>
	  
	  </body>
	  </html>