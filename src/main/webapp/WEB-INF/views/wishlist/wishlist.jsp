<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/Global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/wishlist.css">
<script
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>

<body class="family">

	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">
				<a href="">펀딩 관리</a>
			</h2>
			<h2 class="funding">
				<div class="my-fun">
					<a href="">마이 펀딩</a>
				</div>
				<div class="friend-fun">
					<a href="">친구 펀딩</a>
				</div>
			</h2>
		</div>

		<div class="sec-content-main">

			<div class="left-main content-height">
				<h2 class="top-text">위시리스트</h2>
				<!-- 위시리스트 목록 -->
				<div id="wListArea"></div>
			</div>

			<div class="right-main content-height">
				<h2 class="top-text">선택한 펀딩</h2>

				<!-- 기념일 셀렉트 -->
				<div class="funding-controls">
					<select id="funding-table">
						<option value="">------- 기념일 선택 -------</option>
					</select>

					<button id="btnStartFunding" class="btn-funding1" type="button"
						disabled>펀딩시작하기</button>
				</div>

				<!-- 우측 선택 목록 -->
				<div id="selectedList" class="selected-list"></div>

			</div>

		</div>
		<!--sec-content-main-->
	</div>
	</content>

	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
	$(document).ready(function(){
		console.log('돔');
		window.CTX = "${pageContext.request.contextPath}"; // 공통 컨텍스트

		// 위시리스트
		fetchList();

		// 기념일 옵션
		loadAnniversaryOptions();

		// 좌측 체크/해제 → 우측 추가/제거
		$('#wListArea').on('change', '.product-checkbox', function(){
			const $card     = $(this).closest('.a-product');
			const wishId    = $card.data('wish-id');
			const productId = $card.data('product-id');
			const brand     = $card.find('.buy').text().trim();
			const title     = $card.find('.name').text().trim();
			const priceText = $card.find('.price').text().trim();
			const priceNum  = toNumber(priceText);
			const img       = $card.find('img.product-image').attr('src');
			// 옵션 필드
			const wishlistOptionId = $card.data('wishlist-option-id') || null;
			const detailOptionId   = $card.data('detail-option-id')   || null;
			const detailOptionName = $card.data('detail-option-name') || '';

			if (this.checked) {
				addSelected({wishId, productId, brand, title, priceText, priceNum, img,
							wishlistOptionId, detailOptionId, detailOptionName});
			} else {
				removeSelected(wishId);
			}
			updateStartButtonState();
		});

		// 우측 목록 제거 버튼
		$('#selectedList').on('click', '.selected-remove', function(){
			const $item = $(this).closest('.selected-item');
			const wishId = $item.data('wish-id');

			$(`.a-product[data-wish-id="\${wishId}"] .product-checkbox`).prop('checked', false);
			$item.remove();
			updateStartButtonState();
		});

		// 전액/5% 라디오
		$('#selectedList').on('change', '.sel-amount input[type=radio]', function(){
			const $item = $(this).closest('.selected-item');
			const base  = Number($item.data('price')) || 0;

			let amount = base, type = 'FULL', percent = 100;
			if (this.value === 'P5') {
				type = 'PERCENT'; percent = 5;
				amount = Math.floor(base * 0.05);
			}

			$item.data('amountType', type)
				.data('percent', percent)
				.data('amount', amount);

			$item.find('.selected-amount-value').text(fmtKRW(amount));
		});

		// 기념일 선택 변경 시 버튼 활성화
		$('#funding-table').on('change', updateStartButtonState);

		// 펀딩 시작
		$('#btnStartFunding').on('click', startFunding);
	});

	/* =========================
			공통 유틸
	========================= */
	function toNumber(text){
		return Number(String(text).replace(/[^\d]/g,'') || 0);
	}
	function fmtKRW(n){
		return (Number(n)||0).toLocaleString('ko-KR') + '원';
	}
	function escapeHtml(str){
		return String(str)
		.replaceAll("&","&amp;")
		.replaceAll("<","&lt;")
		.replaceAll(">","&gt;")
		.replaceAll('"',"&quot;")
		.replaceAll("'","&#039;");
	}

	/* =========================
		서버 응답 정규화(선택)
	========================= */
	let __tmpSeq = 1;
	function normalizeWish(w){
		//가격 로컬 변수로 먼저 계산
		const rawPrice = w.price ?? w.sale_price ?? 0;
		const numPrice = Number(rawPrice);

		return {
			userNo            : w.userNo ?? w.user_no ?? null,
			wishId            : w.wishlistNo ?? w.wishlist_no ?? w.wish_id ?? ('tmp_'+(__tmpSeq++)),
			productId         : w.productId ?? w.product_id ?? w.product_no ?? w.prod_no ?? null,
			brand             : w.brand ?? '',
			title             : w.title ?? w.product_name ?? '',
			//여기서 numPrice 사용
			priceNum          : Number.isFinite(numPrice) ? numPrice : 0,
			priceText         : (Number.isFinite(numPrice) ? numPrice.toLocaleString('ko-KR') : String(rawPrice)) + ' 원',
			image             : w.image ?? w.image_url ?? (CTX + "/assets/images/eki.jpg"),
			wishlistOptionId  : w.wishlistoptionNo ?? w.wishlist_option_no ?? null,
			detailOptionId    : w.detailoptionNo   ?? w.detail_option_no   ?? null,
			detailOptionName  : w.detailoptionName ?? w.detail_option_name ?? ''
		};
	}

	/* =========================
	위시리스트 로드
	========================= */
	function fetchList(){
		$.ajax({
			url : "${pageContext.request.contextPath}/api/wishlist",
			type : "get",
			dataType : "json",
			success : function(json){
				const list = Array.isArray(json) ? json
					: (json && json.result === 'success' && Array.isArray(json.apiData)) ? json.apiData
					: (json && json.result === 'success' && Array.isArray(json.data))    ? json.data
					: [];

				const $area = $('#wListArea').empty();

				if (!list.length){
					$area
					.addClass('is-empty')
					.html('<div class="empty">위시리스트가 비어 있어요.</div>');
					return;
				}
				$area.removeClass('is-empty');

				for (let i=0; i<list.length; i++){
					rander(list[i], 'down');
				}
			}
		});
	}

	/* =========================
	위시리스트 렌더
	========================= */
	function rander(wishVO, updown){
		const w = normalizeWish(wishVO);

		let str = '';
		str += `<div class="a-product"
					data-wish-id="\${w.wishId}"
					data-product-id="\${w.productId}"
					data-wishlist-option-id="\${w.wishlistOptionId}"
					data-detail-option-id="\${w.detailOptionId}"
					data-detail-option-name="\${w.detailOptionName}">`;
		str += ` 	<div class="image-row">`;
		str += `		<input type="checkbox" class="product-checkbox">`;
		str += `		<img class="product-image" src="\${w.image}" alt="">`;
		str += `		<div class="product-info">`;
		str += `			<div class="buy">\${escapeHtml(w.brand)}</div>`;
		str += `			<div class="product-row">`;
		str += `				<span class="name">\${escapeHtml(w.title)}</span>`;
		str += `					\${w.detailOptionName ? '<span class="opt-sep"> · </span><span class="option-name">' + escapeHtml(w.detailOptionName) + '</span>' : ''}`;
		str += `			</div>`;
		str += `			<div class="product-price">\${escapeHtml(w.priceText)}</div>`;
		str += `			<div class="actions-row">`;
		str += `				<img class="icon-cart"  src="\${CTX}/assets/icon/icon-shopping-cart.svg" alt="장바구니">`;
		str += `				<img class="icon-heart" src="\${CTX}/assets/images/heart.jpg" alt="찜">`;
		str += `			</div>`;
		str += `		</div>`; // .product-info
		str += `	</div>`;   // .image-row
		str += `</div>`;

		if (updown == 'up'){ $('#wListArea').prepend(str); }
		else { $('#wListArea').append(str); }
	}

	/* =========================
	기념일 옵션 (이름만)
	========================= */
	function loadAnniversaryOptions(){
		$.ajax({
			url  : "${pageContext.request.contextPath}/api/eventlist",
			type : "get",
			dataType : "json",
			success  : function(json){
				let data = [];
				if (json && json.result === 'success' && Array.isArray(json.apiData)) data = json.apiData;
				else if (json && json.result === 'success' && Array.isArray(json.data)) data = json.data;
				else if (Array.isArray(json)) data = json;

				const $sel = $("#funding-table").empty()
				.append('<option value="">------- 기념일 선택 -------</option>');

				if (!data.length){
					$sel.append('<option value="" disabled>기념일이 없습니다</option>');
					return;
				}

				for (let i=0; i<data.length; i++){
					const ev = data[i];
					const eventNo   = ev.event_no;
					const eventName = ev.event_name || "";
					if (eventNo == null) continue;

					// 이름만 표시
					$sel.append($('<option>').val(eventNo).text(eventName));
				}
			},
			error : function(xhr, status, err){
				console.error(status, xhr.status, xhr.getResponseHeader('content-type'), err);
				$("#funding-table").append('<option value="" disabled>불러오기 실패</option>');
			}
		});
	}

	/* =========================
		우측 선택목록
	========================= */
	function addSelected({wishId, productId, brand, title, priceText, priceNum, img,
				wishlistOptionId, detailOptionId, detailOptionName}){
	if ($('#selectedList .selected-item').filter(function(){
	return $(this).data('wish-id') == wishId;
	}).length) return;

	const html = `
		<div class="selected-item"
				data-wish-id="\${wishId}"
				data-product-id="\${productId}"
				data-price="\${priceNum}"
				data-amount-type="FULL"
				data-percent="100"
				data-amount="\${priceNum}"
				data-wishlist-option-id="\${wishlistOptionId || ''}"
				data-detail-option-id="\${detailOptionId || ''}"
				data-detail-option-name="\${detailOptionName || ''}">
			<img class="selected-thumb" src="\${img}">
			<div class="selected-meta">
				<div class="selected-brand">\${escapeHtml(brand)}</div>
				<div class="selected-title">\${escapeHtml(title)}</div>
				<div class="selected-price-row">
					<span class="selected-price">\${escapeHtml(priceText)}</span>
					\${detailOptionName ? '<span class="opt-sep"> · </span><span class="selected-opt">' + escapeHtml(detailOptionName) + '</span>' : ''}
				</div>
				<div class="sel-amount">
					<label><input type="radio" name="amt_\${wishId}" value="FULL" checked> 전액</label>
					<label><input type="radio" name="amt_\${wishId}" value="P5"> 5%</label>
					<span class="selected-amount">펀딩 단위 금액:
					<b class="selected-amount-value">\${fmtKRW(priceNum)}</b>
					</span>
				</div>
			</div>
		</div>`;
		$('#selectedList').append(html);
	}


	function removeSelected(wishId){
		$(`#selectedList .selected-item[data-wish-id="${'$'}{wishId}"]`).remove();
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
		const eventNo = $('#funding-table').val();
		if(!eventNo){
			alert('기념일을 먼저 선택해주세요.'); 
			return; 
		}

		const items = $('#selectedList .selected-item').map(function(){
		const $it = $(this);
			return {
			wishlist_no       : $it.data('wish-id'),
			product_no        : $it.data('product-id'),
			wishlistoption_no : $it.data('wishlist-option-id') || null,
			detailoption_no   : $it.data('detail-option-id')   || null,
			amount_type       : $it.data('amountType') || 'FULL',
			percent           : $it.data('percent')    || 100,
			amount            : $it.data('amount')     || Number($it.data('price')) || 0
			};
		}).get();

	if(!items.length){
		alert('선택된 상품이 없습니다.');
		return;
	}

	const payload = { event_no: eventNo, items };

	const $btn = $('#btnStartFunding').prop('disabled', true);
		$.ajax({
			url: CTX + '/api/openFunding',
			type: 'POST',
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify(payload)
		})
		.done(function (json) {
			if (json && json.result === 'success') {
				location.href = CTX + '/funding/my';
			} else {
				alert('처리에 실패했습니다. 잠시 후 다시 시도해주세요.');
			}
		})
		.fail(function (xhr, status, err) {
			console.error(status, err, (xhr.responseText||'').slice(0,200));
			alert('펀딩 시작에 실패했습니다. 잠시 후 다시 시도해주세요.');
		})
		.always(function () {
			$btn.prop('disabled', false);
		});
	}

</script>
</body>
</html>
