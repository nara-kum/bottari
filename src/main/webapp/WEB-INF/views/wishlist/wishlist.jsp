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
			<!-- <div class="left-main content-height"> -->

			<div class="right-main content-height">
				<h2 class="top-text">선택한 펀딩</h2>

				<!-- 기념일 체크박스 -->
				<div class="funding-controls">
					<select id="funding-table">
						<option value=""></option>
					</select>
				</div>

				<!-- 펀딩 목록 -->
				<div id="selectedList" class="selected-list"></div>

				<button id="btnStartFunding" class="btn-funding1" type="button"
					disabled>펀딩시작하기</button>

			</div>
			<!-- right-main content-height -->

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

	    //위시리스트
		fetchList();

        //기념일 리스트
        loadAnniversaryOptions();
        
        // 체크/해제
        $('#wListArea').on('change', '.product-checkbox', function(){
            const $card     = $(this).closest('.a-product');
            const wishId    = $card.data('wish-id');
            const productId = $card.data('product-id');
            const brand     = $card.find('.buy').text().trim();
            const title     = $card.find('.product-name').text().trim();
            const priceText = $card.find('.price').text().trim();
            const priceNum  = toNumber(priceText);                   // ← 숫자화
            const img       = $card.find('img.product-image').attr('src');

            if (this.checked) {
                addSelected({wishId, productId, brand, title, priceText, priceNum, img});
            } else {
                removeSelected(wishId);
            }
            updateStartButtonState();
        });

        // 우측 목록 - 추가 제거
        $('#selectedList').on('click', '.selected-remove', function(){
            const $item = $(this).closest('.selected-item');
            const wishId = $item.data('wish-id');
            // 좌측 체크 해제
            $(`.a-product[data-wish-id="\${wishId}"] .product-checkbox`).prop('checked', false);
            // 우측에서 제거
            $item.remove();
            updateStartButtonState();
        });

        //옵션 선택 라디오
        $('#selectedList').on('change', '.sel-amount input[type=radio]', function(){
            const $item = $(this).closest('.selected-item');
            const base  = Number($item.data('price')) || 0;

            let amount = base, type = 'FULL', percent = 100;
            if (this.value === 'P5') {
            type = 'PERCENT'; percent = 5;
            amount = Math.floor(base * 0.05);     // 소수점 버림
            }

            // 데이터 보관 + 화면 반영
            $item.data('amountType', type)
            .data('percent', percent)
            .data('amount', amount);

            $item.find('.selected-amount-value').text(fmtKRW(amount));
        });


        // 기념일 선택 변경 시 버튼 활성화 재판정
        $('#funding-table').on('change', updateStartButtonState);

        // 펀딩 시작하기
        $('#btnStartFunding').on('click', startFunding);
        
    });

    //서버 응답 키가 제각각일 수도 있어 방어적으로 정규화
    //여기는 이해못했음ㅠㅜㅠ
    let __tmpSeq = 1;
    function normalizeWish(w){
        return {
        wishId    : w.wishId ?? w.wish_id ?? w.wishlist_no ?? w.wish_no ?? ('tmp_'+(__tmpSeq++)),
        productId : w.productId ?? w.product_id ?? w.product_no ?? w.prod_no ?? null,
        brand     : w.brand ?? '',
        title     : w.title ?? w.product_name ?? '',
        price     : w.price ?? w.sale_price ?? w.price_text ?? '',
        image     : w.image ?? w.image_url ?? (CTX + "/assets/images/eki.jpg")
        };
    }

    //위시리스트
    function fetchList(){
        $.ajax({

            //보낼때 옵션
			url : "${pageContext.request.contextPath}/api/wishlist",
			type : "get",
			dataType : "json",
			success : function(jsonResult){
				/*성공시 처리해야될 코드 작성*/
				console.log(jsonResult);
				console.log(jsonResult.result);
				console.log(jsonResult.apiData);
				
				if(jsonResult.result == 'success'){
					//화면에 그린다
					for(let i=0; i<jsonResult.apiData.length; i++){
						rander(jsonResult.apiData[i], 'down');
					}
				}else{
					console.log("알 수 없는 오류");
				}
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}

        })

    }

    //기념일 리스트
    function loadAnniversaryOptions(){
        $.ajax({
            url  : "${pageContext.request.contextPath}/api/eventlist",
            type : "get",
            dataType : "json",
            success  : function(jsonResult){
                let data = [];
                if (jsonResult && jsonResult.result === 'success' && Array.isArray(jsonResult.apiData)) {
                    data = jsonResult.apiData;
                } else if (jsonResult && jsonResult.result === 'success' && Array.isArray(jsonResult.data)) {
                    data = jsonResult.data;
                } else if (Array.isArray(jsonResult)) {
                    data = jsonResult;
                } else {
                    console.warn("예상치 못한 응답 형태:", jsonResult);
                } 
                
                const $sel = $("#funding-table");
                $sel.empty().append('<option value="">------- 기념일 선택 -------</option>');

                if (!data.length) {
                    $sel.append('<option value="" disabled>기념일이 없습니다</option>');
                    return;
                }
                
                for (let i = 0; i < data.length; i++) {
                    const ev = data[i];

                    // ✅ 백엔드 snake_case 그대로 사용
                    const eventNo   = ev.event_no;
                    const eventName = ev.event_name || "";
                    const eventDate = ev.event_date; // 없으면 undefined

                    if (eventNo == null) continue; // id 없으면 스킵

                    const label = (eventDate ? (formatDate(eventDate) + " ") : "") + escapeHtml(eventName);

                    $sel.append(
                        $('<option>').val(eventNo).text(label)
                    );
                }
            },
            error : function(xhr, status, error) {
                console.error(status, xhr.status, xhr.getResponseHeader('content-type'), error);
                console.error((xhr.responseText || '').slice(0, 200)); // 원인 파악용
                $("#funding-table").append('<option value="" disabled>불러오기 실패</option>');
            }
        });
    }
    
    function formatDate(iso){
        if (!iso) return "";
        const p = String(iso).split("-");
        
        if (p.length === 3) {
            const m = +p[1], d = +p[2];
            
            if (m && d) return m + "월 " + d + "일";
        }
        const d = new Date(iso);
        return isNaN(d) ? String(iso) : (d.getMonth()+1) + "월 " + d.getDate() + "일";
    }

    // 간단 XSS 이스케이프
    function escapeHtml(str){
    return String(str)
        .replaceAll("&","&amp;")
        .replaceAll("<","&lt;")
        .replaceAll(">","&gt;")
        .replaceAll('"',"&quot;")
        .replaceAll("'","&#039;");
    }

    /* ===========================
        위시리스트 렌더
    =========================== */

    function rander(wishVO, updown){
        const w = normalizeWish(wishVO);

        let str = '';
        str += `<div class="a-product" data-wish-id="\${w.wishId}" data-product-id="\${w.productId}">`;
        str += `    <div class="image-row">`;
        str += `        <input type="checkbox" class="product-checkbox">`;
        str += `        <img class="product-image" src="\${w.image}">`;
        str += `        <div class="product-info">`;
        str += `            <div class="buy">\${escapeHtml(w.brand)}</div>`;
        str += `            <div class="product-name">\${escapeHtml(w.title)}</div>`;
        str += `            <div class="price">\${escapeHtml(w.price)}</div>`;
        str += `            <div class="image-row">`;
        str += `                <div class="shopping-cart"><img src="\${CTX}/assets/icon/icon-shopping-cart.svg"></div>`;
        str += `                <img src="\${CTX}/assets/images/heart.jpg">`;
        str += `            </div>`;
        str += `        </div>`;
        str += `    </div>`;
        str += `</div>`;

        if(updown == 'up'){
            $('#wListArea').prepend(str);
        }else{
            $('#wListArea').append(str);
        }
    }

    /* ===========================
        우측 선택목록
    =========================== */
    
    function addSelected({wishId, productId, brand, title, priceText, priceNum, img}){
        
        //이미 담긴 항목은 무시
        //이해못하겠당...ㅠㅠㅠ
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
                    data-amount="\${priceNum}">
                <img class="selected-thumb" src="\${img}">
                <div class="selected-meta">
                <div class="selected-brand">\${escapeHtml(brand)}</div>
                <div class="selected-title">\${escapeHtml(title)}</div>
                <div class="selected-price">\${escapeHtml(priceText)}</div>

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
        $(`#selectedList .selected-item[data-wish-id="\${wishId}"]`).remove();
    }
    
    function updateStartButtonState(){
        
        const hasSelected = $('#selectedList .selected-item').length > 0;
        const hasEvent    = !!$('#funding-table').val();
        $('#btnStartFunding').prop('disabled', !(hasSelected && hasEvent));
    }

    // "12,340원" → 12340
    function toNumber(text){
    return Number(String(text).replace(/[^\d]/g,'') || 0);
    }
    // 12340 → "12,340원"
    function fmtKRW(n){
    return (Number(n)||0).toLocaleString('ko-KR') + '원';
    }

    /* ===========================
        펀딩 시작하기 (POST)
    =========================== */

    function startFunding(){
        var eventNo = $('#funding-table').val();
        if(!eventNo){
            alert('기념일을 먼저 선택해주세요.');
            return;
        }

        var items = $('#selectedList .selected-item').map(function(){
            const $it = $(this);
            return {
            wishlist_no: $it.data('wish-id'),
            product_no : $it.data('product-id'),
            amount_type: $it.data('amountType') || 'FULL',
            percent    : $it.data('percent') || 100,
            amount     : $it.data('amount') || Number($it.data('price')) || 0
            };
        }).get();

        if(!items.length){
            alert('선택된 상품이 없습니다.'); 
            return;
        }

        var payload = {
            event_no: eventNo,
            items: items
        };

        // 중복클릭 방지
        var $btn = $('#btnStartFunding').prop('disabled', true);

        $.ajax({
            url: CTX + '/api/funding',
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(payload)
            })

            .done(function (json) {

                // 서버 성공 응답 체크(프로젝트 규칙에 맞게 조절)
                if (json && json.result === 'success') {

                    // 좌/우 UI에서 제거
                    items.forEach(it => {
                        $('.a-product').filter(function(){ return $(this).data('wish-id') == it.wishlist_no; }).remove();
                        $('#selectedList .selected-item').filter(function(){ return $(this).data('wish-id') == it.wishlist_no; }).remove();
                    });

                    updateStartButtonState();
                    // 마이펀딩으로 이동
                    location.href = CTX + '/funding/my';
                } else {
                    alert('처리에 실패했습니다. 잠시 후 다시 시도해주세요.');
                }
            })
            .fail(function (xhr, status, err) {
                console.error(status, err, xhr.responseText);
                alert('펀딩 시작에 실패했습니다. 잠시 후 다시 시도해주세요.');
            })
            .always(function () {
                $btn.prop('disabled', false);
            });
    }


</script>
</body>
</html>