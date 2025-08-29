<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="../../../assets/css/reset.css">
	<link rel="stylesheet" href="../../../assets/css/Global.css">
	<link rel="stylesheet" href="../../../assets/css/shop/shopSuccess.css">
	
	<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>

<body class="family">
	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">상품등록</h2>
		</div>
		<div class="sec-content-main">
			<div class="success-container">
				<div class="success-icon">
					<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
						<circle cx="40" cy="40" r="40" fill="#c9a37e"/>
						<path d="M25 40L35 50L55 30" stroke="white" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</div>
				
				<div class="success-message">
					<h1>상품 등록이 완료되었습니다!</h1>
					<p>고객님의 소중한 상품이 성공적으로 등록되었습니다.</p>
				</div>


				<div class="product-info">
					<div class="info-item">
						<span class="info-label">등록된 상품명:</span> <span class="info-value">${productTitle}</span>
					</div>
					<div class="info-item">
						<span class="info-label">등록 일시:</span> <span class="info-value">
							<script>
								document.write(new Date().toLocaleDateString(
										'ko-KR', {
											year : 'numeric',
											month : '2-digit',
											day : '2-digit',
											hour : '2-digit',
											minute : '2-digit'
										}));
							</script>
						</span>
					</div>
				</div>

				<div class="action-buttons">
					<a class="btn secondary-btn"
						href="${pageContext.request.contextPath}/shop/productform"> 다른 상품 올리기
					</a> 
					<a class="btn primary-btn"
						href="${pageContext.request.contextPath}/shop/productPage?productNo=${productVO.product_no}">
						상품 확인하러 가기 
					</a>
				</div>

				<div class="additional-links">
					<a href="productList.jsp" class="link">전체 상품 목록 보기</a>
				</div>
			</div>
		</div>
	</div>
	</content>


	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

</body>

</html>