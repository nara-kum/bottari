<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/Global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/shop/productPage_funding.css">
</head>

<!-- js -->
<script
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>


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
							<c:when
								test="${not empty fundingProductDetailMap.productViewVO.itemimg}">
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
							<fmt:formatNumber
								value="${fundingProductDetailMap.productViewVO.price}"
								pattern="#,###" />
							원
						</div>
						<div class="brand-name">${fundingProductDetailMap.productViewVO.brand}</div>

						<!-- 카테고리 타이틀 자리1 -->

						<div class="product-options">
							<div class="option-label">배송 정보</div>
							<div class="delivery-info">
								<span class="icon">🚚</span>
								<c:choose>
									<c:when
										test="${fundingProductDetailMap.productViewVO.shipping_cost == 0}">
											택배비 무료
										</c:when>
									<c:otherwise>
											배송비 <fmt:formatNumber
											value="${fundingProductDetailMap.productViewVO.shipping_cost}"
											pattern="#,###" />원
										</c:otherwise>
								</c:choose>
							</div>
							<div class="delivery-info">
								<span class="icon">📍</span> 배송지:
								${fundingProductDetailMap.productViewVO.address}
								${fundingProductDetailMap.productViewVO.detail_address}
								(${fundingProductDetailMap.productViewVO.zipcode})
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


						<!-- 펀딩 진행 상황 표시 -->
						<div class="funding-progress-info">
							<div class="progress-box">
								<div class="progress-title">현재 펀딩 진행 상황</div>
								<div class="progress-amount">
									<span class="current-amount"> <fmt:formatNumber
											value="${fundingProductDetailMap.fundingTotalPay}"
											pattern="#,###" />원
									</span> <span class="target-amount"> / <fmt:formatNumber
											value="${fundingProductDetailMap.productViewVO.price}"
											pattern="#,###" />원
									</span>
								</div>
								<div class="progress-bar">
									<div class="progress-fill"
										style="width: ${(fundingProductDetailMap.fundingTotalPay / fundingProductDetailMap.productViewVO.price * 100)}%"></div>
								</div>
								<div class="progress-percent">
									<fmt:formatNumber
										value="${(fundingProductDetailMap.fundingTotalPay / fundingProductDetailMap.productViewVO.price * 100)}"
										pattern="#.#" />
									% 달성
								</div>


								<!-- 남은 펀딩 가능 금액 표시 -->
								<div class="remaining-amount-info">
									<div class="remaining-title">펀딩 가능한 남은 금액</div>
									<div class="remaining-amount">
										<fmt:formatNumber
											value="${fundingProductDetailMap.productViewVO.price - fundingProductDetailMap.fundingTotalPay}"
											pattern="#,###" />
										원
									</div>
								</div>
							</div>
						</div>


						<!-- 펀딩 완료 여부 체크 -->
						<c:choose>
							<c:when test="${fundingProductDetailMap.fundingProductVO.funding_status=='done'}">
								<!-- 펀딩 완료 상태 -->
								<div class="partial-funding-control" id="partialFundingControl">
									<div class="funding-box">
										<div class="complete-message">🎉 펀딩이 완료되었습니다!</div>
										<div class="complete-desc">목표 금액을 모두 달성했습니다.</div>
									</div>
								</div>
							</c:when>
							
							<c:when test="${fundingProductDetailMap.fundingProductVO.funding_status=='stop'}">
								<!-- 펀딩 완료 상태 -->
								<div class="partial-funding-control" id="partialFundingControl">
									<div class="funding-box">
										<div class="complete-message">🎉 펀딩이 취소되었습니다!</div>
										div class="complete-desc">환불내역을 확인하세요</div>
									</div>
								</div>
							</c:when>
							
							<c:otherwise>
								<!-- 부분 펀딩 컨트롤 (percent가 100이 아닐 때 표시) -->
								<c:if test="${fundingProductDetailMap.fundingProductVO.percent != 100}">
									<div class="partial-funding-control" id="partialFundingControl">
										<div class="funding-box">
											<div class="funding-box-font" id="productName">
												${fundingProductDetailMap.productViewVO.title}</div>
											<div class="funding-box-font2" id="productOption">브랜드:
												${fundingProductDetailMap.productViewVO.brand}</div>
											<div class="funding-control">
												<button class="quantity-btn" id="decreaseBtn">-</button>
												<div class="funding-display" id="fundingDisplay">5%
													(1개)</div>
												<button class="quantity-btn" id="increaseBtn">+</button>
											</div>
										</div>
									</div>
								</c:if>
								
								<!-- 전액 펀딩 정보 (percent가 100일 때만 표시) -->
								<c:if test="${fundingProductDetailMap.fundingProductVO.percent == 100}">
									<div class="full-funding-info" id="fullFundingInfo">
										<div class="full-funding-price">
											<fmt:formatNumber
												value="${fundingProductDetailMap.productViewVO.price}"
												pattern="#,###" />
											원
										</div>
										<div class="full-funding-desc">상품 전체 금액을 한번에 결제합니다</div>
									</div>
								</c:if>
							
								<div class="total-price">
									총 결제 금액: 
									<span id="totalPrice"> 
								    	<c:choose>
            								<c:when test="${fundingProductDetailMap.fundingProductVO.percent == 100}">
                								<fmt:formatNumber value="${fundingProductDetailMap.productViewVO.price}" pattern="#,###" />원
            								</c:when>
           									<c:otherwise>
               									<fmt:formatNumber value="${fundingProductDetailMap.productViewVO.price * 0.05}" pattern="#,###" />원
								            </c:otherwise>
								        </c:choose>
									</span>
								</div>


								<!-- 
								상품번호
								펀딩번호
								결제금액 -->
								<form action=""  method="get">
									
									<input type="hidden" name="funding_no" value="${fundingProductDetailMap.fundingProductVO.funding_no}">
									<input id="quantity" type="hidden" name="count" value="1">
									
									<%-- 
									<input id="payPrice" type="text" name="price" value="${fundingProductDetailMap.fundingProductVO.amount}">
									<input type="text" name="productNo" value="${fundingProductDetailMap.fundingProductVO.product_no}">
									 --%>
									<a href=""></a><button class="funding-btn" type="submit">펀딩하러가기</button>
								</form>
						
							</c:otherwise>
							
						</c:choose>

				
					</div>
				</div>


				<!-- 상품 설명 -->
				<div class="product-description">
					<c:forEach
						items="${fundingProductDetailMap.productViewVO.detailedImageList}"
						var="detailedImageVO">
						<img class="detailproduct"
							src="${pageContext.request.contextPath}/upload/${detailedImageVO.image_URL}"
							alt="상품상세이미지">
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
	///////////////////////////////////////////////////////////////////////////////////////////////
											
											
	//전체금액
	//단가
	let totalPrice = ${fundingProductDetailMap.productViewVO.price};
	let fundingTotalPay = ${fundingProductDetailMap.fundingTotalPay};
	let amount = ${fundingProductDetailMap.fundingProductVO.amount};
	let quantity = 1
	
	$(document).ready(function() {

		//-버튼 체크
		if(quantity <=1 ){
			$('#decreaseBtn').prop('disabled', true);
		}
		
		
		
		//-버튼을 클릭했을때
		$('#decreaseBtn').on('click', function(){
			console.log("-클릭");
			
			quantity--;
			let str = 5*quantity +'% ('+quantity+'개)';
			$('#fundingDisplay').text(str);
			
			
			$('#totalPrice').text(addComma(amount*quantity));	
		
			//-버튼 체크
			if(quantity <=1 ){
				$('#decreaseBtn').prop('disabled', true);
			}else{
				$('#decreaseBtn').prop('disabled', false);
			}
			
			//+버튼 체크
			if(totalPrice - fundingTotalPay - (amount*quantity) == 0){
				$('#increaseBtn').prop('disabled', true);
			}else{
				$('#increaseBtn').prop('disabled', false);
			}	
			
			
			$('#quantity').val(quantity);
			/* $('#payPrice').val(amount*quantity); */
			
		});

		
		//+버튼을 클릭했을때
		$('#increaseBtn').on('click', function(){
			console.log("+클릭");
			
			quantity++;
			let str = 5*quantity +'% ('+quantity+'개)';
			$('#fundingDisplay').text(str);
			
			$('#totalPrice').text(addComma(amount*quantity));
			
			//-버튼 체크
			if(quantity <=1 ){
				$('#decreaseBtn').prop('disabled', true);
			}else{
				$('#decreaseBtn').prop('disabled', false);
			}
			
			//+버튼 체크
			if(totalPrice - fundingTotalPay - (amount*quantity) == 0){
				$('#increaseBtn').prop('disabled', true);
			}else{
				$('#increaseBtn').prop('disabled', false);
			}	
			
			$('#quantity').val(quantity);
			/* $('#payPrice').val(amount*quantity); */
		});
			
		
		function addComma(num) {
		   return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		
	});
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	

	</script>
</body>

</html>