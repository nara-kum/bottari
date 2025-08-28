<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../../../assets/css/reset.css">
<link rel="stylesheet" href="../../../assets/css/Global.css">
<link rel="stylesheet" href="../../../assets/css/shop/cart.css">
<link rel="stylesheet" href="../../../assets/css/moduler.css">

</head>

<body class="family">
	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->


	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">장바구니</h2>
			<!-- 여기부터 코딩 시작!! -->
		</div>
		<div class="sec-content-main">
			<main class="main">
				<div class="container">
					<div class="column-flex-box gap-10">
						<c:forEach items="${requestScope.cList}" var="vo">
							<div class="list-basic list-1280" data-cart-no="${vo.cart_no}">
								<div class="between-flex-box">
									<div class="row-flex-box">
										<div class="column-flex-box column-align size-normal">
											<input type="checkbox" id="select-${vo.cart_no}" class="cart-checkbox">
										</div>
										<img class="list-img-100" src="${vo.itemimg}" alt="상품 이미지">
										<div class="column-flex-box gap-10 margin-5">
											<p class="text-16">${vo.brand}</p>
											<p class="item-name">${vo.title}</p>
											<p class="text-16 bold"><fmt:formatNumber value="${vo.price}" type="currency" currencySymbol="" /> 원</p>
										</div>
									</div>
									<div class="row-flex-box">
										<div class="column-flex-box">
											<!-- 옵션 컨테이너 (처음에는 숨김) -->
											<div class="optionContainer" id="option-${vo.cart_no}">
												<!-- 서버에서 미리 렌더링된 옵션들 -->
												<div class="row-flex-box">
														<c:forEach items="${vo.options}" var="option">
															<label for="option-${option.option_no}-${vo.cart_no}">${option.option_name}</label>
															<select id="option-${option.option_no}-${vo.cart_no}" 
																class="option-select" 
																data-option-no="${option.option_no}"
																data-cart-no="${vo.cart_no}">
																<c:forEach items="${option.detailList}" var="detail">
																	<c:choose>
																		<c:when
																			test="${detail.detailoption_no == vo.detailoption_no}">
																			<option value="${detail.detailoption_no}" selected>${detail.detailoption_name}</option>
																		</c:when>
																		<c:otherwise>
																			<option value="${detail.detailoption_no}">${detail.detailoption_name}</option>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</select>
														</c:forEach>
													<div class="row-flex-box quantity-container">
														<button type="button" class="quantity-btn subQuantity" data-cart-no="${vo.cart_no}">-</button>
														<div class="text-16 quantity-display" data-cart-no="${vo.cart_no}">${vo.quantity} 개</div>
														<button type="button" class="quantity-btn addQuantity" data-cart-no="${vo.cart_no}">+</button>
													</div>
												</div>
											</div>
											<select class="btn-basic size-normal">
												<option>기념일 선택</option>
												<option>생일</option>
												<option>결혼</option>
												<option>이벤트</option>
												<option>돌잔치</option>
											</select>
										</div>

										<button class="btn-basic size-normal btn-orange column-align delete-btn" 
												data-cart-no="${vo.cart_no}">삭제</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

					<!-- 총 금액 -->
					<div class="summary ">
						<div class="text-16">상품금액: <span id="product-total"><fmt:formatNumber value="${total_price}" type="currency" currencySymbol="" /></span>원</div>
						<div class="text-16">배송비: <span id="shipping-cost"><fmt:formatNumber value="${shipping_cost}" type="currency" currencySymbol="" /></span>원</div>
						<div class="text-18 bold">총 결제금액: <span id="final-total"><fmt:formatNumber value="${total_price + shipping_cost}" type="currency" currencySymbol="" /></span>원</div>
					</div>

					<div class="buy-button" id="purchase-btn">
						<button>구매하기</button>
					</div>
				</div>
		</div>
		</main>
	</div>
	</div>
	</content>
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
	<script>
		document.addEventListener('DOMContentLoaded', function(){
			console.log('DOM 트리 완료');
			
			// 장바구니 업데이트 함수
			function updateCart(cartNo, type, value) {
				const formData = new FormData();
				formData.append('cart_no', cartNo);
				formData.append('type', type);
				formData.append('value', value);
				
				fetch('/cart/update', {
					method: 'POST',
					body: formData,
					headers: {
						'X-Requested-With': 'XMLHttpRequest'
					}
				})
				.then(response => response.json())
				.then(data => {
					if(data.success) {
						console.log('장바구니 업데이트 성공');
						// 필요시 총액 업데이트
						if(data.total_price) {
							updateTotalPrice(data.total_price, data.shipping_cost);
						}
					} else {
						console.error('장바구니 업데이트 실패:', data.message);
						alert('업데이트 중 오류가 발생했습니다.');
					}
				})
				.catch(error => {
					console.error('네트워크 오류:', error);
					alert('네트워크 오류가 발생했습니다.');
				});
			}
			
			// 총 금액 업데이트 함수
			function updateTotalPrice(productTotal, shipping_cost) {
				document.getElementById('product-total').textContent = productTotal.toLocaleString();
				document.getElementById('shipping-cost').textContent = shipping_cost.toLocaleString();
				document.getElementById('final-total').textContent = (productTotal + shipping_cost).toLocaleString();
			}
			
			// 수량 변경 이벤트
			document.addEventListener('click', function(e) {
				const cartNo = e.target.getAttribute('data-cart-no');
				
				if(e.target.classList.contains('addQuantity')) {
					const quantityDiv = e.target.previousElementSibling;
					let currentQuantity = parseInt(quantityDiv.textContent);
					const newQuantity = currentQuantity + 1;
					
					quantityDiv.textContent = newQuantity + '개';
					// type: 'quantity' (수량 변경), value: newQuantity (새로운 수량값)
					updateCart(cartNo, 'quantity', newQuantity);
				}
				
				if(e.target.classList.contains('subQuantity')) {
					const quantityDiv = e.target.nextElementSibling;
					let currentQuantity = parseInt(quantityDiv.textContent);
					
					if(currentQuantity > 1) {
						const newQuantity = currentQuantity - 1;
						quantityDiv.textContent = newQuantity + '개';
						// type: 'quantity' (수량 변경), value: newQuantity (새로운 수량값)
						updateCart(cartNo, 'quantity', newQuantity);
					}
				}
				
				// 삭제 버튼
				if(e.target.classList.contains('delete-btn')) {
					if(confirm('상품을 장바구니에서 삭제하시겠습니까?')) {
						deleteCartItem(cartNo);
					}
				}
			});
			
			// 옵션 변경 이벤트
			document.addEventListener('change', function(e) {
				if(e.target.classList.contains('option-select')) {
					const cartNo = e.target.getAttribute('data-cart-no');
					const optionNo = e.target.getAttribute('data-option-no');
					const newValue = e.target.value;
					
					// type: 'option' (옵션 변경), value: newValue (선택된 옵션의 detailoption_no)
					updateCart(cartNo, 'option', newValue);
				}
				
				// 기념일 선택 변경
				if(e.target.classList.contains('anniversary-select')) {
					const cartNo = e.target.getAttribute('data-cart-no');
					const newValue = e.target.value;
					
					// type: 'anniversary' (기념일 변경), value: newValue (선택된 기념일 값)
					updateCart(cartNo, 'anniversary', newValue);
				}
			});
			
			// 장바구니 아이템 삭제 함수
			function deleteCartItem(cartNo) {
				fetch('/cart/delete', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded',
						'X-Requested-With': 'XMLHttpRequest'
					},
					body: 'cart_no=' + cartNo
				})
				.then(response => response.json())
				.then(data => {
					if(data.success) {
						if(data.isEmpty) {
							// 빈 장바구니일 때 리다이렉트
							window.location.href = data.redirectUrl;
						} else {
							// DOM에서 해당 아이템 제거
							const cartItem = document.querySelector(`[data-cart-no="${cartNo}"]`);
							if(cartItem) {
								cartItem.remove();
							}
							
							// 총액 업데이트
							if(data.total_price !== undefined) {
								updateTotalPrice(data.total_price, data.shipping_cost);
							}
						}
					} else {
						alert('삭제 중 오류가 발생했습니다.');
					}
				})
				.catch(error => {
					console.error('삭제 오류:', error);
					alert('네트워크 오류가 발생했습니다.');
				});
			}
			
			// 구매하기 버튼 이벤트
			document.getElementById('purchase-btn').addEventListener('click', function() {
				const selectedItems = [];
				const checkboxes = document.querySelectorAll('.cart-checkbox:checked');
				
				checkboxes.forEach(function(checkbox) {
					const cartNo = checkbox.id.replace('select-', '');
					selectedItems.push(cartNo);
				});
				
				if(selectedItems.length === 0) {
					alert('구매할 상품을 선택해주세요.');
					return;
				}
				
				// 구매 페이지로 이동 (선택된 아이템들의 정보와 함께)
				const form = document.createElement('form');
				form.method = 'GET';
				form.action = '/checkout';
				
				selectedItems.forEach(function(cartNo) {
					const input = document.createElement('input');
					input.type = 'hidden';
					input.name = 'cart_no';
					input.value = cartNo;
					form.appendChild(input);
				});
				
				document.body.appendChild(form);
				form.submit();
			});
		});
	</script>

</body>

</html>