<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../assets/css/shop/shoppingMall.css">
</head>

<body class="family">

	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<content class="controller">
	<div id="sec-contetnt" class="sector">
		<div class="sec-sub-title">
			<div class="sub-title-container">
				<!-- 카테고리 선택 영역 -->
				<h2 class="select-this">결혼</h2>
				<div class="category-buttons">
					<button class="sub-title-menu active" data-category="1" onclick="selectCategory(this, '결혼', 1)">결혼</button>
					<button class="sub-title-menu" data-category="2" onclick="selectCategory(this, '생일', 2)">생일</button>
					<button class="sub-title-menu" data-category="3" onclick="selectCategory(this, '돌잔치', 3)">돌잔치</button>
					<button class="sub-title-menu" data-category="4" onclick="selectCategory(this, '이벤트', 4)">이벤트</button>
					<button class="sub-title-menu" data-category="5" onclick="selectCategory(this, '축하', 5)">축하</button>
					<button class="sub-title-menu" data-category="6" onclick="selectCategory(this, '감사', 6)">감사</button>
				</div>
			</div>
		</div>
	</div>
	<div class="search-price-field">
		<!-- 가격 필터 -->
		<div class="price-filter">
			<div class="price">
				<a>전체</a>
			</div>
			<div class="price">2만원 미만</div>
			<div class="price">2만원대</div>
			<div class="price">3만원대</div>
			<div class="price">5만원대</div>
		</div>
		<div class="search-area">
			<input name="search" class="rectangle-2" type="text" placeholder="검색어를 입력하세요"> 
			<img class="icon-search" src="../../../assets/icon/icon-search.svg">
		</div>
	</div>
	
	<div class="sec-content-main">
		<!-- 상품 목록 반복영역 -->
		<c:choose>
			<c:when test="${not empty productList}">
				<c:forEach var="product" items="${productList}">
					<div class="goods-wrap">
						<div class="goods-img">
							<c:choose>
								<c:when test="${not empty product.itemimg}">
									<img class="product-image" src="../../../uploads/${product.itemimg}" 
										 alt="${product.title}" style="width: 100%; height: 100%; object-fit: cover;">
								</c:when>
								<c:otherwise>
									<img class="product-image" src="../../../assets/images/no-image.png" 
										 alt="이미지 없음" style="width: 100%; height: 100%; object-fit: cover;">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="brand-name">${product.brand}</div>
						<div class="goods-title">${product.title}</div>
						<div class="pay-wrap">
							<div class="payment">
								<fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>
							</div>
							<div class="won">원</div>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="no-products">
					<p>등록된 상품이 없습니다.</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	</content>
	
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
	

</body>

</html>