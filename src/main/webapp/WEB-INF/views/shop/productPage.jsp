<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop/productPage.css">

<!-- js -->
<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>    

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
							<fmt:formatNumber value="${productViewVO.price}" pattern="#,###" />원
						</div>
						<div class="brand-name">${productViewVO.brand}</div>

						<div class="product-options">
							<div class="option-label">배송정보</div>
							
							
							
							<!-- 배송 여부에 따른 표시 (1 = 배송가능, 0 = 배송불가능으로 추정) -->
							<c:if test="${productViewVO.shipping_yn == '1' or productViewVO.shipping_yn == 'y' or productViewVO.shipping_yn == 'Y'}">
								<!-- 배송 가능한 경우: 배송비와 출고지 표시 -->
								<div class="delivery-info">
									<span class="icon">🚚</span>
									<c:if test="${productViewVO.shipping_cost == 0}">택배비 무료</c:if>
									<c:if test="${productViewVO.shipping_cost > 0}">배송비 <fmt:formatNumber value="${productViewVO.shipping_cost}" pattern="#,###" />원</c:if>
								</div>
								<div class="delivery-info">
									<span class="icon">📍</span> 출고지: ${productViewVO.address} ${productViewVO.detail_address}
								</div>
							</c:if>
							
							<c:if test="${productViewVO.shipping_yn == '0' or productViewVO.shipping_yn == 'n' or productViewVO.shipping_yn == 'N'}">
								<!-- 배송 불가능한 경우: 메시지만 표시 -->
								<div class="delivery-info no-delivery">
									<span class="icon">🚫</span> 배송이 불가한 상품입니다
								</div>
							</c:if>
							
							<c:if test="${empty productViewVO.shipping_yn}">
								<p style="color: orange;">배송 정보가 설정되지 않았습니다.</p>
							</c:if>
						</div>

						<div class="service-info">
							<div class="option-label">서비스</div>
							<c:if test="${productViewVO.shipping_yn == '1' or productViewVO.shipping_yn == 'y' or productViewVO.shipping_yn == 'Y'}">
								<div class="service-item">원하는 배송지로 상품을 배송 받아요.</div>
							</c:if>
							<c:if test="${productViewVO.shipping_yn == '0' or productViewVO.shipping_yn == 'n' or productViewVO.shipping_yn == 'N'}">
								<div class="service-item">현장에서 직접 수령하는 상품입니다.</div>
							</c:if>
						</div>
					</div>

					<!-- 주문 영역 -->
					<div class="order-section">
						<div class="order-title">상품 선택</div>

						<!-- 옵션 선택 영역 -->
						<c:if test="${not empty productViewVO.productOptionList}">
							<c:forEach items="${productViewVO.productOptionList}" var="productOptionVO" varStatus="status">
								<div class="option-group" style="margin-bottom: 15px;">
									<select class="option-select" data-option-no="${productOptionVO.option_no}" onchange="updateOptionDisplay()">
										<option value="">${productOptionVO.option_name}을(를) 선택하세요</option>
									</select>
								</div>
							</c:forEach>
						</c:if>

						<!-- 수량 선택 -->
						<div class="quantity-control" style="margin: 15px 0;">
							<label class="option-label">수량</label>
							<div style="display: flex; align-items: center; margin-top: 5px;">
								<button type="button" class="quantity-btn" onclick="changeQuantity(-1)">-</button>
								<input type="number" value="1" class="quantity-input" min="1" id="quantity" onchange="updatePrice()">
								<button type="button" class="quantity-btn" onclick="changeQuantity(1)">+</button>
							</div>
						</div>

						<!-- 선택한 옵션과 수량 표시 (처음에는 숨김) -->
						<div class="selected-info" id="selectedInfo" style="background: #f8f9fa; padding: 15px; border-radius: 8px; margin: 15px 0; display: none;">
							<div style="font-weight: bold; margin-bottom: 10px;">선택한 상품</div>
							<div style="background: white; padding: 15px; border-radius: 5px;">
								<div style="font-weight: bold; margin-bottom: 10px;">${productViewVO.title}</div>
								<div id="selectedOptions">
									<!-- 선택한 옵션들이 여기에 표시됩니다 -->
								</div>
								<div style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #eee;">
									수량: <span id="displayQuantity">1</span>개
								</div>
							</div>
						</div>

						<!-- 총 결제 금액 -->
						<div class="total-price" style="font-size: 18px; font-weight: bold; text-align: center; margin: 20px 0; padding: 15px; background: #ffffff; border-radius: 8px; color: #333;">
							총 결제 금액: <span id="totalAmount"><fmt:formatNumber value="${productViewVO.price}" pattern="#,###" /></span>원
						</div>

						<button class="cart-btn">장바구니 담기</button>

						<div class="action-buttons">
							<button class="wishlist-btn">♡ 찜 등록하기</button>
							<c:if test="${productViewVO.shipping_yn == '1' or productViewVO.shipping_yn == 'y' or productViewVO.shipping_yn == 'Y'}">
								<button class="funding-btn">구매하기</button>
							</c:if>
							<c:if test="${productViewVO.shipping_yn == '0' or productViewVO.shipping_yn == 'n' or productViewVO.shipping_yn == 'N'}">
								<button class="funding-btn">예약하기</button>
							</c:if>
							<c:if test="${empty productViewVO.shipping_yn}">
								<button class="funding-btn">구매하기</button>
							</c:if>
						</div>
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
		// 상품 기본 정보
		const productPrice = ${productViewVO.price};
		
		// 페이지 로드 시 옵션 데이터 가져오기
		$(document).ready(function() {
			console.log('상품 가격:', productPrice);
			loadOptionDetails();
		});
		
		// 옵션 상세 데이터 로드
		function loadOptionDetails() {
			$('.option-select').each(function() {
				const optionSelect = $(this);
				const optionNo = optionSelect.data('option-no');
				
				$.ajax({
					url: "${pageContext.request.contextPath}/api/optiondetail",
					type: "post",
					data: {optionNo: optionNo},
					dataType: "json",
					success: function(data) {
						console.log('옵션 데이터:', data);
						data.forEach(function(item) {
							optionSelect.append('<option value="' + item.detailoption_no + '">' + item.detailoption_name + '</option>');
						});
					},
					error: function(xhr, status, error) {
						console.error('옵션 로드 실패:', error);
					}
				});
			});
		}
		
		// 수량 변경
		function changeQuantity(change) {
			const quantityInput = document.getElementById('quantity');
			let currentQuantity = parseInt(quantityInput.value);
			currentQuantity += change;
			
			if (currentQuantity < 1) {
				currentQuantity = 1;
			}
			
			quantityInput.value = currentQuantity;
			updatePrice();
		}
		
		// 옵션 선택 표시 업데이트
		function updateOptionDisplay() {
			let optionText = '';
			let hasSelectedOptions = false;
			
			$('.option-select').each(function() {
				const select = $(this)[0];
				if (select.value !== '') {
					hasSelectedOptions = true;
					const optionName = $(select).find('option:first').text().replace('을(를) 선택하세요', '');
					const selectedText = $(select).find('option:selected').text();
					optionText += '<div style="font-size: 14px; color: #666; margin: 2px 0;">선택한 ' + optionName + ': ' + selectedText + '</div>';
				}
			});
			
			// 옵션이 없는 상품인 경우 (옵션 select가 아예 없음)
			if ($('.option-select').length === 0) {
				optionText = '<div style="font-size: 14px; color: #666;">단일 상품 (옵션 없음)</div>';
				hasSelectedOptions = true; // 단일 상품이므로 선택된 것으로 간주
			}
			
			document.getElementById('selectedOptions').innerHTML = optionText;
			
			// 옵션을 선택했거나 단일 상품인 경우에만 선택한 상품 영역 표시
			const selectedInfo = document.getElementById('selectedInfo');
			if (hasSelectedOptions) {
				selectedInfo.style.display = 'block';
			} else {
				selectedInfo.style.display = 'none';
			}
			
			updatePrice();
		}
		
		// 가격 업데이트
		function updatePrice() {
			const quantity = parseInt(document.getElementById('quantity').value) || 1;
			const totalPrice = productPrice * quantity;
			
			// 수량 표시 업데이트
			document.getElementById('displayQuantity').textContent = quantity;
			
			// 가격 표시 업데이트
			document.getElementById('productTotal').textContent = totalPrice.toLocaleString();
			document.getElementById('totalAmount').textContent = totalPrice.toLocaleString();
			
			// 수량이 1보다 크거나 옵션이 선택된 경우 선택한 상품 영역 표시
			const selectedInfo = document.getElementById('selectedInfo');
			const hasSelectedOptions = $('.option-select').length === 0 || $('.option-select option:selected[value!=""]').length > 0;
			
			if (hasSelectedOptions && quantity >= 1) {
				selectedInfo.style.display = 'block';
				updateOptionDisplay(); // 옵션 표시도 함께 업데이트
			}
			
			console.log('가격 업데이트 - 수량:', quantity, '총 가격:', totalPrice);
		}
	</script>

</body>

</html>