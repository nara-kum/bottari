<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../../../assets/css/reset.css">
<link rel="stylesheet" href="../../../assets/css/Global.css">
<link rel="stylesheet"
	href="../../../assets/css/shop/productPage_funding.css">
</head>

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
							<c:otherwise>
								<img class="main-image" src="${product.itemimg}"
									alt="${product.title}">
							</c:otherwise>
						</c:choose>
					</div>

					<!-- 상품 정보 -->
					<div class="product-info">
						<h1 class="product-title">${product.title}</h1>
						<div class="product-price">
							<fmt:formatNumber value="${product.price}" pattern="#,###" />
							원
						</div>
						<div class="brand-name">${product.brand}</div>
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

						<div class="funding-box">
							<div class="funding-box-font" id="productName">
								[단독]하겐다즈 프리미엄 수제 아이스크림 케이크<br> 리얼블랙 (바닐라+벨지안 초코)
							</div>
							<div class="funding-box-font2" id="productOption">옵션: 바닐라</div>
							<div class="funding-controll">
								<button class="quantity-btn" id="decreaseBtn">-</button>
								<div class="funding-five" id="fundingPercent">5%</div>
								<button class="quantity-btn" id="increaseBtn">+</button>
							</div>
						</div>

						<div class="total-order" id="orderSummary">
							<span id="summaryProductName">[단독]하겐다즈 프리미엄 수제 아이스크림 케이크<br>리얼블랙
								(바닐라+벨지안 초코)
							</span><br> <span id="summaryOption">바닐라</span> x 1<br> <span
								id="summaryPercent">5%</span> x <span id="summaryQuantity">1</span>
						</div>

						<div class="total-price">
							총 결제 금액 : <span class="price-highlight" id="totalPrice">1,500원</span>
						</div>

						<button class="cart-btn" onclick="goToFunding()">펀딩하러 가기</button>
					</div>
				</div>

				<!-- 추천 상품 -->
				<div class="recommendation-section">
					<div class="section-title">이런 구성은 어떠세요?</div>
					<div class="product-grid">
						<div class="product-card">
							<div
								style="width: 100%; height: 100px; background: #8B4513; border-radius: 6px; margin-bottom: 10px; display: flex; align-items: center; justify-content: center; color: white;">
								🍫</div>
							<div class="product-card-title">추천 상품 1</div>
							<div class="product-card-price">65,900원</div>
						</div>

						<div class="product-card">
							<div
								style="width: 100%; height: 100px; background: #DDA0DD; border-radius: 6px; margin-bottom: 10px; display: flex; align-items: center; justify-content: center; color: white;">
								🍰</div>
							<div class="product-card-title">추천 상품 2</div>
							<div class="product-card-price">39,900원</div>
						</div>

						<div class="product-card">
							<div
								style="width: 100%; height: 100px; background: #8B4513; border-radius: 6px; margin-bottom: 10px; display: flex; align-items: center; justify-content: center; color: white;">
								🍫</div>
							<div class="product-card-title">추천 상품 3</div>
							<div class="product-card-price">65,900원</div>
						</div>
					</div>
				</div>

				<!-- 상품 설명 -->
				<div class="product-description">
					<img class="detailproduct" src="${product.itemimg}"
						alt="${product.title}">
					<!-- 카테고리 타이틀 자리 2  -->
				</div>

			</div>

		</div>
	</div>
	</content>
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
		// URL 파라미터에서 상품 정보 가져오기
		function getUrlParams() {
			const urlParams = new URLSearchParams(window.location.search);
			return {
				productName: urlParams.get('productName') || '[단독]하겐다즈 프리미엄 수제 아이스크림 케이크 리얼블랙 (바닐라+벨지안 초코)',
				option: urlParams.get('option') || '바닐라',
				basePrice: parseInt(urlParams.get('basePrice')) || 32900
			};
		}

		// 상품 정보 초기화
		const productInfo = getUrlParams();
		let currentPercent = 5;

		// DOM 요소들
		const productNameEl = document.getElementById('productName');
		const productOptionEl = document.getElementById('productOption');
		const fundingPercentEl = document.getElementById('fundingPercent');
		const decreaseBtn = document.getElementById('decreaseBtn');
		const increaseBtn = document.getElementById('increaseBtn');
		const totalPriceEl = document.getElementById('totalPrice');
		const summaryProductNameEl = document.getElementById('summaryProductName');
		const summaryOptionEl = document.getElementById('summaryOption');
		const summaryQuantityEl = document.getElementById('summaryQuantity');

		// 초기 상품 정보 설정
		function initializeProduct() {
			if (productNameEl && productOptionEl) {
				productNameEl.innerHTML = productInfo.productName.replace(' 리얼블랙', '<br> 리얼블랙');
				productOptionEl.textContent = `옵션: ${productInfo.option}`;
			}
			if (summaryProductNameEl && summaryOptionEl) {
				summaryProductNameEl.innerHTML = productInfo.productName.replace(' 리얼블랙', '<br>리얼블랙');
				summaryOptionEl.textContent = productInfo.option;
			}
			updateDisplay();
		}

		// 화면 업데이트
		function updateDisplay() {
			if (fundingPercentEl) {
				fundingPercentEl.textContent = `${currentPercent}%`;
			}
			if (summaryQuantityEl) {
				summaryQuantityEl.textContent = currentPercent / 5; // 5% 단위로 수량 표시
			}
			
			// 총 결제 금액 계산 (기본 가격의 5% × 수량)
			const totalAmount = Math.round((productInfo.basePrice * 5 * (currentPercent / 5)) / 100);
			if (totalPriceEl) {
				totalPriceEl.textContent = `${totalAmount.toLocaleString()}원`;
			}
			
			// 버튼 상태 업데이트
			if (decreaseBtn) {
				decreaseBtn.disabled = currentPercent <= 5;
				if (decreaseBtn.disabled) {
					decreaseBtn.style.backgroundColor = '#f5f5f5';
					decreaseBtn.style.color = '#ccc';
					decreaseBtn.style.cursor = 'not-allowed';
				} else {
					decreaseBtn.style.backgroundColor = 'white';
					decreaseBtn.style.color = '#333';
					decreaseBtn.style.cursor = 'pointer';
				}
			}
			
			if (increaseBtn) {
				increaseBtn.disabled = currentPercent >= 100;
				if (increaseBtn.disabled) {
					increaseBtn.style.backgroundColor = '#f5f5f5';
					increaseBtn.style.color = '#ccc';
					increaseBtn.style.cursor = 'not-allowed';
				} else {
					increaseBtn.style.backgroundColor = 'white';
					increaseBtn.style.color = '#333';
					increaseBtn.style.cursor = 'pointer';
				}
			}
		}

		// 퍼센트 감소 (수량 감소)
		function decreasePercent() {
			if (currentPercent > 5) {
				currentPercent -= 5;
				updateDisplay();
			}
		}

		// 퍼센트 증가 (수량 증가)
		function increasePercent() {
			if (currentPercent < 100) {
				currentPercent += 5;
				updateDisplay();
			}
		}

		// 펀딩하러 가기
		function goToFunding() {
			const fundingData = {
				productName: productInfo.productName,
				option: productInfo.option,
				basePrice: productInfo.basePrice,
				fundingPercent: currentPercent,
				quantity: currentPercent / 5,
				totalAmount: Math.round((productInfo.basePrice * 5 * (currentPercent / 5)) / 100)
			};
			
			// 실제 구현에서는 펀딩 페이지로 이동하거나 결제 프로세스 시작
			console.log('펀딩 데이터:', fundingData);
			alert(`펀딩 진행\n상품: ${productInfo.productName}\n펀딩 비율: 5% x ${currentPercent / 5}개\n결제 금액: ${fundingData.totalAmount.toLocaleString()}원`);
			
			// 실제 펀딩 페이지로 이동하려면 아래 주석을 해제하고 URL을 수정하세요
			// window.location.href = '/funding/process?productId=' + encodeURIComponent(fundingData.productName) + '&amount=' + fundingData.totalAmount;
		}

		// 이벤트 리스너 등록
		document.addEventListener('DOMContentLoaded', function() {
			if (decreaseBtn) decreaseBtn.addEventListener('click', decreasePercent);
			if (increaseBtn) increaseBtn.addEventListener('click', increasePercent);
			initializeProduct();
		});
	</script>
</body>

</html>