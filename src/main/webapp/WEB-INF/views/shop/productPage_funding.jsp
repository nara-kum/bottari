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
							<c:when test="${not empty fundingProductDetailMap.productViewVO.itemimg}">
								<img class="main-image"
									src="${pageContext.request.contextPath}/upload/${fundingProductDetailMap.productViewVO.itemimg}"
									alt="${fundingProductDetailMap.productViewVO.title}">
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
						<h1 class="product-title">${fundingProductDetailMap.productViewVO.title}</h1>
						<div class="product-price">
							<fmt:formatNumber value="${fundingProductDetailMap.productViewVO.price}" pattern="#,###" />
							원
						</div>
						<div class="brand-name">${fundingProductDetailMap.productViewVO.brand}</div>

						<!-- 카테고리 타이틀 자리1 -->

						<div class="product-options">
							<div class="option-label">배송 정보</div>
							<div class="delivery-info">
								<span class="icon">🚚</span>
								<c:choose>
									<c:when test="${fundingProductDetailMap.productViewVO.shipping_cost == 0}">
											택배비 무료
										</c:when>
									<c:otherwise>
											배송비 <fmt:formatNumber value="${fundingProductDetailMap.productViewVO.shipping_cost}"
											pattern="#,###" />원
										</c:otherwise>
								</c:choose>
							</div>
							<div class="delivery-info">
								<span class="icon">📍</span> 배송지: ${fundingProductDetailMap.productViewVO.address}
								${fundingProductDetailMap.productViewVO.detail_address} (${fundingProductDetailMap.productViewVO.zipcode})
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

                <!-- 전액 펀딩일 때만 타입 표시 -->
                <c:if test="${wishlistVO.percent == 100}">
                    <div class="funding-type-display">
                        <div class="funding-type-info full-type">전액 펀딩</div>
                    </div>
                </c:if>

                <!-- 부분 펀딩 컨트롤 (percent가 100이 아닐 때 표시) -->
                <c:if test="${wishlistVO.percent != 100}">
                    <div class="partial-funding-control" id="partialFundingControl">
                        <div class="funding-box">
                            <div class="funding-box-font" id="productName">
                                ${productViewVO.title}
                            </div>
                            <div class="funding-box-font2" id="productOption">브랜드: ${productViewVO.brand}</div>
                            <div class="funding-control">
                                <button class="quantity-btn" id="decreaseBtn">-</button>
                                <div class="funding-display" id="fundingDisplay">5% (1개)</div>
                                <button class="quantity-btn" id="increaseBtn">+</button>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- 전액 펀딩 정보 (percent가 100일 때만 표시) -->
                <c:if test="${wishlistVO.percent == 100}">
                    <div class="full-funding-info" id="fullFundingInfo">
                        <div class="full-funding-price">
                            <fmt:formatNumber value="${productViewVO.price}" pattern="#,###" />원
                        </div>
                        <div class="full-funding-desc">상품 전체 금액을 한번에 결제합니다</div>
                    </div>
                </c:if>

                <!-- 주문 요약 -->
                <div class="order-summary">
                    <div class="summary-item">
                        <span>상품명</span>
                        <span>${productViewVO.title}</span>
                    </div>
                    <div class="summary-item">
                        <span>펀딩 타입</span>
                        <span id="summaryType">
                            <c:choose>
                                <c:when test="${wishlistVO.percent == 100}">전액 펀딩</c:when>
                                <c:otherwise>부분 펀딩</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <c:if test="${wishlistVO.percent != 100}">
                        <div class="summary-item" id="summaryQuantity">
                            <span>수량</span>
                            <span>5% × 1개</span>
                        </div>
                    </c:if>
                    <div class="summary-item">
                        <span>결제 금액</span>
                        <span id="summaryAmount">
                            <c:choose>
                                <c:when test="${wishlistVO.percent == 100}">
                                    <fmt:formatNumber value="${productViewVO.price}" pattern="#,###" />원
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${productViewVO.price * 0.05}" pattern="#,###" />원
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <div class="total-price">
                    총 결제 금액: 
                    <span id="totalPrice">
                        <c:choose>
                            <c:when test="${wishlistVO.percent == 100}">
                                <fmt:formatNumber value="${productViewVO.price}" pattern="#,###" />원
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${productViewVO.price * 0.05}" pattern="#,###" />원
                            </c:otherwise>
                        </c:choose>
                    </span>
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
		name: '${productViewVO.title}',
		brand: '${productViewVO.brand}',
		basePrice: parseInt('${productViewVO.price}') || 0
	};

	// wishlistVO에서 percent 값 가져오기
	const wishlistPercent = parseInt('${wishlistVO.percent}') || 5;
	
	console.log('Product Info:', productInfo);
	console.log('Wishlist Percent:', wishlistPercent);

	// 현재 상태 (wishlistVO.percent 기반으로 설정)
	let currentFundingType = wishlistPercent == 100 ? 'full' : 'partial';
	let currentPercent = wishlistPercent == 100 ? 100 : 5; // 부분펀딩은 5%부터 시작

	// 부분 펀딩일 때만 퍼센트 조절 함수들이 작동
	window.decreasePercent = function() {
		if (currentFundingType === 'partial' && currentPercent > 5) {
			currentPercent -= 5;
			updateDisplay();
		}
	};

	window.increasePercent = function() {
		if (currentFundingType === 'partial' && currentPercent < 100) {
			currentPercent += 5;
			updateDisplay();
		}
	};

	// 화면 업데이트 (부분 펀딩일 때만 필요)
	function updateDisplay() {
		if (currentFundingType !== 'partial') return;
		
		console.log('updateDisplay called:', { type: currentFundingType, percent: currentPercent });
		
		const quantity = currentPercent / 5;
		const displayAmount = Math.round((productInfo.basePrice * currentPercent) / 100);
		const displayQuantity = currentPercent + '% × ' + quantity + '개';
		
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

		// 요약 정보 업데이트
		const summaryQuantity = document.getElementById('summaryQuantity');
		const summaryAmount = document.getElementById('summaryAmount');
		const totalPrice = document.getElementById('totalPrice');
		
		if (summaryQuantity) {
			summaryQuantity.querySelector('span:last-child').textContent = displayQuantity;
		}
		if (summaryAmount) {
			summaryAmount.textContent = displayAmount.toLocaleString() + '원';
		}
		if (totalPrice) {
			totalPrice.textContent = displayAmount.toLocaleString() + '원';
		}
		
		console.log('Display updated:', { amount: displayAmount, quantity: displayQuantity });
	}

	// 펀딩 진행 함수
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

	// DOM 로드 완료 후 실행 (부분 펀딩일 때만 이벤트 리스너 설정)
	$(document).ready(function() {
		console.log('DOM Ready - jQuery');
		console.log('Current funding type:', currentFundingType);
		
		// 부분 펀딩일 때만 이벤트 리스너 설정
		if (currentFundingType === 'partial') {
			// 기존 이벤트 리스너 제거 (중복 방지)
			$('#decreaseBtn').off('click');
			$('#increaseBtn').off('click');
			
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
			
			console.log('Event listeners attached for partial funding');
		} else {
			console.log('Full funding mode - no event listeners needed');
		}
	});
	</script>
</body>

</html>