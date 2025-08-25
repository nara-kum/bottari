<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
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

						<div class="product-options">
							<div class="option-label">배송정보</div>
							<div class="delivery-info">
								<span class="icon">🚚</span>
								<c:choose>
									<c:when test="${ProductView.shipping_cost == 0}">
											택배비 무료
										</c:when>
									<c:otherwise>
											배송비 <fmt:formatNumber value="${ProductView.shipping_cost}"
											pattern="#,###" />원
										</c:otherwise>
								</c:choose>
							</div>
							<div class="delivery-info">
								<span class="icon">📍</span> 배송지: ${ProductView.address}
								${ProductView.detail_address} (${ProductView.zipcode})
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

						<!-- 옵션 선택 영역 -->
						<c:if test="${not empty productViewVO.productOptionList}">
							<c:forEach items="${productViewVO.productOptionList}" var="productOptionVO">
								<div class="option-group" style="margin-bottom: 15px;">
									<%-- <label class="option-label">${productOptionVO.option_name}</label> --%> 
									
									<select
										class="option-select" name="option_name${status.index}"
										onchange="updateSelection()">
										<option value="">${productOptionVO.option_name}을(를)선택하세요</option>

										<!-- 상세 옵션 출력 -->
										<%-- 
										<c:forEach var="detail" items="${detailOPtion_name[status.index]}">
											<option value="${detail}">${detail}</option>
										</c:forEach>
										 --%>
									</select>
								</div>
							</c:forEach>
						</c:if>

						<!-- 옵션이 없는 경우 -->
						<c:if test="${empty productViewVO.productOptionList}">
							<div style="font-size: 14px; color: #666; margin-bottom: 15px;">
								이 상품은 단일 옵션입니다.
							</div>
						</c:if>

						<!-- 수량 선택 -->
						<div class="quantity-control" style="margin: 15px 0;">
							<label class="option-label">수량</label>
							<div style="display: flex; align-items: center; margin-top: 5px;">
								<button type="button" class="quantity-btn" onclick="decreaseQuantity()">-</button>
								<input type="number" value="1" class="quantity-input" min="1" id="quantity" onchange="updateSelection()">
								<button type="button" class="quantity-btn" onclick="increaseQuantity()">+</button>
							</div>
						</div>

						<!-- 선택된 옵션 표시 영역 -->
						<div id="selectedOptionsArea" style="background: #f8f9fa; padding: 15px; border-radius: 8px; margin: 15px 0; display: none;">
							<div style="font-weight: bold; margin-bottom: 10px; color: #333;">선택된 옵션</div>
							<div id="selectedOptionsList"></div>
						</div>

						<!-- 총 결제 금액 -->
						<div class="total-price" id="totalPrice" style="font-size: 18px; font-weight: bold; text-align: center; margin: 20px 0; padding: 15px; background: #fffff; border-radius: 8px; color: #333;">
							총 결제 금액 : <span id="totalAmount"><fmt:formatNumber value="${product.price}" pattern="#,###" /></span>원
						</div>

						<button class="cart-btn">장바구니 담기</button>

						<div class="action-buttons">
							<button class="wishlist-btn">♡ 찜 등록하기</button>
							<button class="funding-btn">구매하기</button>
						</div>

					</div>
				</div>

				<!-- 상품 설명 -->
				<div class="product-description">
					<c:forEach items="${productViewVO.detailedImageList}" var="detialedImageVO">
						<img class="detailproduct" src="${pageContext.request.contextPath}/upload/${detialedImageVO.image_URL}" alt="상품상세이미지">
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
		// 상품 기본 정보
		const basePrice = ${product.price};
		const productTitle = "${product.title}";
		
		// 수량 조절 함수들
		function increaseQuantity() {
			const quantityInput = document.getElementById('quantity');
			const currentValue = parseInt(quantityInput.value);
			quantityInput.value = currentValue + 1;
			updateSelection();
		}

		function decreaseQuantity() {
			const quantityInput = document.getElementById('quantity');
			const currentValue = parseInt(quantityInput.value);
			if (currentValue > 1) {
				quantityInput.value = currentValue - 1;
				updateSelection();
			}
		}

		// 선택 사항 업데이트 함수
		function updateSelection() {
			const quantity = parseInt(document.getElementById('quantity').value);
			const optionSelects = document.querySelectorAll('.option-select');
			
			// 선택된 옵션들 수집
			let selectedOptions = [];
			let hasSelectedOption = false;
			
			optionSelects.forEach(function(select, index) {
				if (select.value !== '') {
					selectedOptions.push({
						name: select.previousElementSibling.textContent, // label 텍스트
						value: select.value
					});
					hasSelectedOption = true;
				}
			});
			
			// 선택된 옵션 표시 영역 업데이트
			const selectedOptionsArea = document.getElementById('selectedOptionsArea');
			const selectedOptionsList = document.getElementById('selectedOptionsList');
			
			if (hasSelectedOption) {
				selectedOptionsArea.style.display = 'block';
				
				let optionsHtml = '<div style="background: white; padding: 10px; border-radius: 5px; border: 1px solid #dee2e6;">';
				optionsHtml += '<div style="font-weight: bold; color: #495057;">' + productTitle + '</div>';
				
				selectedOptions.forEach(function(option) {
					optionsHtml += '<div style="font-size: 14px; color: #6c757d; margin: 5px 0;">• ' + option.name + ': ' + option.value + '</div>';
				});
				
				optionsHtml += '<div style="font-size: 14px; color: #495057; margin-top: 8px;">수량: ' + quantity + '개</div>';
				optionsHtml += '</div>';
				
				selectedOptionsList.innerHTML = optionsHtml;
			} else {
				selectedOptionsArea.style.display = 'none';
			}
			
			// 총 금액 계산 및 표시
			const totalPrice = basePrice * quantity;
			document.getElementById('totalAmount').textContent = totalPrice.toLocaleString();
			
			console.log('🔄선택 업데이트:', {
				quantity: quantity,
				selectedOptions: selectedOptions,
				totalPrice: totalPrice
			});
		}

		// 페이지 로드 시 초기화
		document.addEventListener('DOMContentLoaded', function() {
			console.log('📦 상품 정보 로드 완료');
			console.log('기본 가격:', basePrice);
			console.log('상품명:', productTitle);
			
			// 수량 입력 필드 변경 이벤트
			document.getElementById('quantity').addEventListener('input', updateSelection);
			
			// 초기 상태 설정
			updateSelection();
		});
	</script>

</body>

</html>