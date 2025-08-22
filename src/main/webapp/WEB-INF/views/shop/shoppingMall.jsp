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
	<header class="controller">
		<div id="sec-header" class="sector">
			<div class="left-side">
				<a href=""><img class="header-logo" src="../../../assets/icon/Logo_colored.svg"></a>
				<h1 class="header-menu">
					<a href="">캘린더</a>
				</h1>
				<h1 class="header-menu">
					<a href="">펀딩</a>
				</h1>
				<h1 class="header-menu">
					<a href="">초대장</a>
				</h1>
				<h1 class="header-menu">
					<a href="">구매내역</a>
				</h1>
			</div>
			<div class="right-side">
				<a href=""><img class="header-icon header-shopping-cart" src="../../../assets/icon/icon-shopping-cart.svg"></a>
				<h1 class="header-usermenu">사용자이름</h1>
				<a href=""><img class="header-icon" src="../../../assets/icon/icon-caret-down.svg"></a>
			</div>
		</div>
	</header>

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
	
	<footer class="controller">
		<div id="sec-footer" class="sector">
			<div class="footer-links">
				<a href="#terms">이용약관</a> | <a href="#privacy">개인정보처리방침</a> | <a href="#exchange">교환/반품 안내</a> | <a href="#faq">자주 묻는 질문</a> | <a href="#contact">1:1 문의</a>
			</div>
			<div class="company-info">
				<p>
					<span class="company-name">상호: 주식회사 보따리</span> | <span class="company-name">대표: 김보따리</span> | <span>사업자등록번호: 123-45-67890</span> | <span>통신판매업신고:
						제2025-서울강동-0001</span>
				</p>
				<p class="contact-info">주소: 서울특별시 강동구 천호대로 1027, 5층 | 고객센터: 02-1234-5678</p>
				<p class="contact-info">운영시간: 평일 10:00 ~ 18:00 (점심시간 12:00~13:00)</p>
			</div>

			<div class="copyright">
				<p>© 2025 bottari.com. All rights reserved.</p>
			</div>
		</div>
	</footer>
	

</body>

</html>