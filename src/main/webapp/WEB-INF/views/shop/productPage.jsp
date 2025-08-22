<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../../../assets/css/reset.css">
<link rel="stylesheet" href="../../../assets/css/Global.css">
<link rel="stylesheet" href="../../../assets/css/shop/productPage.css">
</head>

<body class="family">
	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">상품페이지</h2>
		</div>
		<div class="sec-content-main">

			<!-- 메인 컨텐츠 -->
			<div class="main-container">
				<!-- 상품 상세 섹션 -->
				<div class="product-section">
					<!-- 상품 이미지 -->
					<div class="product-images">
						<c:choose>
							<c:when test="${not empty product.itemimg}">
								<img class="main-image"
									src="${pageContext.request.contextPath}/assets/upload/${product.itemimg}"
									alt="${product.title}"
									onerror="this.src='${pageContext.request.contextPath}/assets/upload/default-product.jpg'">
							</c:when>
							<c:otherwise>
								<img class="main-image"
									src="${pageContext.request.contextPath}/assets/upload/default-product.jpg"
									alt="기본 상품 이미지">
							</c:otherwise>
						</c:choose>

						<!-- 상세 이미지들 표시 
					
							-->

					</div>

					<!-- 상품 정보 -->
					<div class="product-info">
						<h1 class="product-title">${product.title}</h1>
						<div class="product-price">
							<fmt:formatNumber value="${product.price}" pattern="#,###" />
							원
						</div>
						<div class="brand-name">${product.brand}</div>
						<!-- 카테고리 타이틀자리1 --> 


						<div class="product-options">
							<div class="option-label">배송정보</div>
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
						<div class="order-title">상품 선택</div>

						<!-- 옵션이 있는 경우
							
							-->

						<div style="font-size: 12px; color: #999; margin-bottom: 15px;">
							선택한 옵션이 표시됩니다</div>

						<div class="quantity-control">
							<button class="quantity-btn" onclick="decreaseQuantity()">-</button>
							<input type="number" value="1" class="quantity-input" min="1"
								id="quantity">
							<button class="quantity-btn" onclick="increaseQuantity()">+</button>
						</div>

						<div class="total-order" id="selectedProduct"
							style="background: white; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 12px; color: #666;">
							${product.title} <br> 수량: <span id="displayQuantity">1</span>개
						</div>

						<div class="total-price" id="totalPrice">
							총 결제 금액 :
							<fmt:formatNumber value="${product.price}" pattern="#,###" />
							원
						</div>

						<button class="cart-btn">장바구니 담기</button>

						<div class="action-buttons">
							<button class="wishlist-btn">♡ 찜 등록하기</button>
							<button class="funding-btn">구매하기</button>
						</div>
					</div>
				</div>

				<!-- 추천 상품 -->
				<div class="recommendation-section">
					<div class="section-title">이런 구성은 어떠세요?</div>
					<div class="product-grid">
						<div class="product-card">
							<div
								style="width: 100%; height: 100px; backgroun d: #8B4513; border-radius: 6px; margin-bottom: 10px; display: flex; align-items: center; justify-content: center; color: white;">
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
	</div>
	</content>

	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
		// 수량 조절 함수
		function increaseQuantity() {
			const quantityInput = document.getElementById('quantity');
			const currentValue = parseInt(quantityInput.value);
			quantityInput.value = currentValue + 1;
			updateTotalPrice();
		}

		function decreaseQuantity() {
			const quantityInput = document.getElementById('quantity');
			const currentValue = parseInt(quantityInput.value);
			if (currentValue > 1) {
				quantityInput.value = currentValue - 1;
				updateTotalPrice();
			}
		}

		// 총 가격 업데이트
		function updateTotalPrice() {
			const quantity = document.getElementById('quantity').value;
			const basePrice = $
			{
				product.price
			}
			;
			const totalPrice = basePrice * quantity;

			document.getElementById('displayQuantity').textContent = quantity;
			document.getElementById('totalPrice').innerHTML = '총 결제 금액 : '
					+ totalPrice.toLocaleString() + '원';
		}

		// 수량 입력 필드 변경 이벤트
		document.getElementById('quantity').addEventListener('input',
				updateTotalPrice);
	</script>
</body>

</html>