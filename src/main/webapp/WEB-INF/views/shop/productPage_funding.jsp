<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop/productPage_funding.css">
</head>

<!-- js -->
<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>    


<body class="family">
	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
	
	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">상품페이지</h2>
			<!-- 여기부터 코딩 시작!! -->
		</div>
		<div class="sec-content-main">

			<!-- 메인 컨텐츠 -->
			<div class="main-container">
				<!-- 상품 상세 섹션 -->
				<div class="product-section">
					<!-- 상품 이미지 -->
					<div class="product-images">
						<c:choose>
							<c:when test="${not empty productViewVO.itemimg}">
								<img class="main-image"
									src="${pageContext.request.contextPath}/upload/${productViewVO.itemimg}"
									alt="${productViewVO.title}">
							</c:when>
							<c:otherwise>
								<img class="main-image"
									src="${pageContext.request.contextPath}/assets/upload/default-product.jpg"
									alt="기본 상품 이미지">
							</c:otherwise>
						</c:choose>
					</div>

					<!-- 상품 정보 -->
					<div class="product-info">
						<h1 class="product-title">${productViewVO.title}</h1>
						<div class="product-price">
							<fmt:formatNumber value="${productViewVO.price}" pattern="#,###" />
							원
						</div>
						<div class="brand-name">${productViewVO.brand}</div>

						<!-- 카테고리 타이틀 자리1 -->

						<div class="product-options">
							<div class="option-label">배송 정보</div>
							<div class="delivery-info">
								<span class="icon">🚚</span>
								<c:choose>
									<c:when test="${product.shipping_cost == 0}">
											택배비 무료
										</c:when>
									<c:otherwise>
											배송비 <fmt:formatNumber value="${product.shipping_cost}"
											pattern="#,###" />원
										</c:otherwise>
								</c:choose>
							</div>
							<div class="delivery-info">
								<span class="icon">📍</span> 배송지: ${product.address}
								${product.detail_address} (${product.zipcode})
							</div>
						</div>

						<div class="service-info">
							<div class="option-label">서비스</div>
							<div class="service-item">원하는 배송지로 상품을 배송 받아요.</div>
						</div>
					</div>

					<!-- 주문 영역 -->
            <div class="order-section">
                <div class="order-title">펀딩 상품 정보</div>

                <!-- 펀딩 타입 선택 -->
                <div class="funding-type-selector">
                    <div class="funding-type-options">
                        <button class="funding-type-btn active" data-type="partial">부분 펀딩</button>
                        <button class="funding-type-btn" data-type="full">전액 펀딩</button>
                    </div>
                </div>

                <!-- 부분 펀딩 컨트롤 -->
                <div class="partial-funding-control" id="partialFundingControl">
                    <div class="funding-box">
                        <div class="funding-box-font" id="productName">
                            [단독]하겐다즈 프리미엄 수제 아이스크림 케이크<br> 리얼블랙 (바닐라+벨지안 초콜릿)
                        </div>
                        <div class="funding-box-font2" id="productOption">옵션: 바닐라</div>
                        <div class="funding-control">
                            <button class="quantity-btn" id="decreaseBtn">-</button>
                            <div class="funding-display" id="fundingDisplay">5% (1개)</div>
                            <button class="quantity-btn" id="increaseBtn">+</button>
                        </div>
                    </div>
                </div>

                <!-- 전액 펀딩 정보 -->
                <div class="full-funding-info hidden" id="fullFundingInfo">
                    <div class="full-funding-price">32,900원</div>
                    <div class="full-funding-desc">상품 전체 금액을 한번에 결제합니다</div>
                </div>

                <!-- 주문 요약 -->
                <div class="order-summary">
                    <div class="summary-item">
                        <span>상품명</span>
                        <span>하겐다즈 케이크</span>
                    </div>
                    <div class="summary-item">
                        <span>펀딩 타입</span>
                        <span id="summaryType">부분 펀딩</span>
                    </div>
                    <div class="summary-item" id="summaryQuantity">
                        <span>수량</span>
                        <span>5% × 1개</span>
                    </div>
                    <div class="summary-item">
                        <span>결제 금액</span>
                        <span id="summaryAmount">1,645원</span>
                    </div>
                </div>

                <div class="total-price">
                    총 결제 금액: <span id="totalPrice">1,645원</span>
                </div>

                <button class="funding-btn" onclick="goToFunding()">펀딩하러 가기</button>
            </div>
        </div>


				<!-- 상품 설명 -->
				<div class="product-description">
					<c:forEach items="${productViewVO.detailedImageList}" var="detailedImageVO">
						<img class="detailproduct" src="${pageContext.request.contextPath}/upload/${detailedImageVO.image_URL}" alt="상품상세이미지">
					</c:forEach>
				</div>

			</div>

		</div>
	</div>
	</content>
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
	// 상품 정보 (JSP에서 JavaScript로 데이터 전달)
	const productInfo = {
		name: '${product.title}',
		brand: '${product.brand}',
		basePrice: parseInt('${product.price}') || 32900
	};

	console.log('Product Info:', productInfo); // 디버깅용

	// 현재 상태
	let currentFundingType = 'partial';
	let currentPercent = 5; // 5%부터 시작

	// 전역 함수로 선언 (HTML onclick에서 호출 가능)
	window.changeFundingType = function(type) {
		console.log('changeFundingType called:', type);
		currentFundingType = type;
		
		// 버튼 활성화 상태 변경
		const fundingTypeBtns = document.querySelectorAll('.funding-type-btn');
		fundingTypeBtns.forEach(btn => {
			btn.classList.remove('active');
			if (btn.dataset.type === type) {
				btn.classList.add('active');
			}
		});

		// UI 표시/숨김
		const partialFundingControl = document.getElementById('partialFundingControl');
		const fullFundingInfo = document.getElementById('fullFundingInfo');
		
		if (type === 'partial') {
			if (partialFundingControl) partialFundingControl.classList.remove('hidden');
			if (fullFundingInfo) fullFundingInfo.classList.add('hidden');
		} else {
			if (partialFundingControl) partialFundingControl.classList.add('hidden');
			if (fullFundingInfo) fullFundingInfo.classList.remove('hidden');
		}

		updateDisplay();
	};

	// 전역 함수로 선언
	window.decreasePercent = function() {
		console.log('decreasePercent called, current:', currentPercent);
		if (currentPercent > 5) { // 최소 5%
			currentPercent -= 5; // 5%씩 감소
			updateDisplay();
		}
	};

	// 전역 함수로 선언
	window.increasePercent = function() {
		console.log('increasePercent called, current:', currentPercent);
		if (currentPercent < 100) {
			currentPercent += 5; // 5%씩 증가
			updateDisplay();
		}
	};

	// 화면 업데이트
	function updateDisplay() {
		console.log('updateDisplay called:', { type: currentFundingType, percent: currentPercent });
		
		let displayAmount, displayType, displayQuantity;

		if (currentFundingType === 'partial') {
			// 부분 펀딩
			const quantity = currentPercent / 5;
			displayAmount = Math.round((productInfo.basePrice * currentPercent) / 100);
			displayType = '부분 펀딩';
			displayQuantity = currentPercent + '% × ' + quantity + '개';
			
			// 부분 펀딩 컨트롤 업데이트
			const fundingDisplay = document.getElementById('fundingDisplay');
			if (fundingDisplay) {
				fundingDisplay.textContent = currentPercent + '% (' + quantity + '개)';
			}
			
			// 버튼 상태 업데이트
			const decreaseBtn = document.getElementById('decreaseBtn');
			const increaseBtn = document.getElementById('increaseBtn');
			
			if (decreaseBtn) {
				decreaseBtn.disabled = currentPercent <= 5;
				decreaseBtn.style.backgroundColor = decreaseBtn.disabled ? '#f5f5f5' : 'white';
				decreaseBtn.style.color = decreaseBtn.disabled ? '#ccc' : '#333';
				decreaseBtn.style.cursor = decreaseBtn.disabled ? 'not-allowed' : 'pointer';
			}
			
			if (increaseBtn) {
				increaseBtn.disabled = currentPercent >= 100;
				increaseBtn.style.backgroundColor = increaseBtn.disabled ? '#f5f5f5' : 'white';
				increaseBtn.style.color = increaseBtn.disabled ? '#ccc' : '#333';
				increaseBtn.style.cursor = increaseBtn.disabled ? 'not-allowed' : 'pointer';
			}
			
			// 수량 항목 표시
			const summaryQuantityItem = document.getElementById('summaryQuantityItem');
			if (summaryQuantityItem) {
				summaryQuantityItem.style.display = 'flex';
			}
		} else {
			// 전액 펀딩
			displayAmount = productInfo.basePrice;
			displayType = '전액 펀딩';
			displayQuantity = '전체 (1개)';
			
			// 수량 항목 숨김
			const summaryQuantityItem = document.getElementById('summaryQuantityItem');
			if (summaryQuantityItem) {
				summaryQuantityItem.style.display = 'none';
			}
		}

		// UI 업데이트
		const summaryType = document.getElementById('summaryType');
		const summaryQuantity = document.getElementById('summaryQuantity');
		const summaryAmount = document.getElementById('summaryAmount');
		const totalPrice = document.getElementById('totalPrice');
		
		if (summaryType) summaryType.textContent = displayType;
		if (summaryQuantity) summaryQuantity.textContent = displayQuantity;
		if (summaryAmount) summaryAmount.textContent = displayAmount.toLocaleString() + '원';
		if (totalPrice) totalPrice.textContent = displayAmount.toLocaleString() + '원';
		
		console.log('Display updated:', { amount: displayAmount, type: displayType });
	}

	// 전역 함수로 선언
	window.goToFunding = function() {
		const fundingData = {
			productName: productInfo.name,
			brand: productInfo.brand,
			basePrice: productInfo.basePrice,
			fundingType: currentFundingType,
			fundingPercent: currentFundingType === 'partial' ? currentPercent : 100,
			quantity: currentFundingType === 'partial' ? currentPercent / 5 : 1,
			totalAmount: currentFundingType === 'partial' 
				? Math.round((productInfo.basePrice * currentPercent) / 100)
				: productInfo.basePrice
		};
		
		console.log('펀딩 데이터:', fundingData);
		
		let message = '펀딩 진행\n';
		message += '상품: ' + fundingData.productName + '\n';
		message += '펀딩 타입: ' + (fundingData.fundingType === 'partial' ? '부분 펀딩' : '전액 펀딩') + '\n';
		
		if (fundingData.fundingType === 'partial') {
			message += '펀딩 비율: ' + fundingData.fundingPercent + '% (' + fundingData.quantity + '개)\n';
		} else {
			message += '펀딩 비율: 전액 (100%)\n';
		}
		
		message += '결제 금액: ' + fundingData.totalAmount.toLocaleString() + '원';
		
		alert(message);
	};

	// DOM 로드 완료 후 실행
	$(document).ready(function() {
		console.log('DOM Ready - jQuery');
		
		// 기존 이벤트 리스너 제거 (중복 방지)
		$('.funding-type-btn').off('click');
		$('#decreaseBtn').off('click');
		$('#increaseBtn').off('click');
		
		// 펀딩 타입 버튼 클릭 이벤트
		$('.funding-type-btn').on('click', function() {
			const type = $(this).data('type');
			console.log('Button clicked:', type);
			changeFundingType(type);
		});

		// 수량 조절 버튼 클릭 이벤트
		$('#decreaseBtn').on('click', function(e) {
			e.preventDefault();
			e.stopPropagation();
			console.log('Decrease button clicked');
			decreasePercent();
		});
		
		$('#increaseBtn').on('click', function(e) {
			e.preventDefault();
			e.stopPropagation();
			console.log('Increase button clicked');
			increasePercent();
		});

		// 초기 화면 업데이트
		updateDisplay();
		
		console.log('Event listeners attached');
	});

	// DOMContentLoaded 이벤트는 제거 (jQuery만 사용)
	// jQuery가 있으므로 vanilla JS 이벤트 리스너는 제거하여 중복 방지
	</script>
</body>

</html>