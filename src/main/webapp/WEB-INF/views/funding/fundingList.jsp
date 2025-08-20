<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../../assets/css/reset.css">
<link rel="stylesheet" href="../../../assets/css/Global.css">
<link rel="stylesheet" href="../../../assets/css/myfunding.css">
<title>마이 펀딩</title>
</head>

<body class="family">
	<header class="controller">
		<div id="sec-header" class="sector">
			<div class="left-side">
				<a href=""><img class="header-logo"
					src="../../../assets/icon/Logo_colored.svg"></a>
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
				<a href=""><img class="header-icon header-shopping-cart"
					src="../../../assets/icon/icon-shopping-cart.svg"></a>
				<!-- 세션에 값이 있을때 -->
				<c:if test="${sessionScope.authUser!=null}">
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/loginform">${sessionScope.authUser.name}</a>
					</h1>
					<a href=""><img class="header-icon"
						src="../../../assets/icon/icon-caret-down.svg"></a>
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/logout">로그아웃</a>
					</h1>
				</c:if>
				<!-- 세션에 값이 없을때 -->
				<c:if test="${sessionScope.authUser==null}">
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/loginForm">로그인</a>
					</h1>
					<a href=""><img class="header-icon"
						src="../../../assets/icon/icon-caret-down.svg"></a>
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/joinForm">회원가입</a>
					</h1>
				</c:if>
			</div>
		</div>
	</header>
	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">
				<a href="">펀딩 관리</a>
			</h2>
			<ul>
				<li class="myfun"><a href="">마이 펀딩</a></li>
				<li class="friend-fun"><a href="">친구 펀딩</a></li>
			</ul>
		</div>

		<div class="sec-content-main">
			<div class="content">
			
				<!-- 한우맘 -->
				<div class="card-box">
					<div class="product-header">
						<div class="left-side">
							<span class="sub-title">2025.09.05 | </span> <span
								class="sub-title">쫑파티</span>
						</div>
						<div class="right-side">
							<span class="funding-ing">펀딩진행중</span>
						</div>

					</div>

					<div class="product-body">
						<div class="product-image">
							<img src="../wishlist/image/5.webp" alt="한우맘 상품 이미지" />
						</div>
						<div class="product-details">
							<div class="product-brand">한우맘</div>
							<div class="product-description">한우맘 1++등급 한우 패밀리 프리미엄 홈마카세
								1.4kg(등심+살치+갈비+안심+채끝)...</div>
							<div class="price">249,000원</div>
							<!-- 원가 -->
						</div>
						<div class="left-price-right-price">

							<div class="progress-bar">
								<div class="progress-fill" style="width: 95%;"></div>
							</div>

						</div>
						<div class="percent">95%</div>
						<div class="price-participation">236,550원</div>
						<!-- 원가에서 펀딩 참여한 % 가격 -->

						<div class="funding-action-wrapper">

							<div class="action-buttons">
								<button>펀딩 중단</button>
								<button>펀딩 완료</button>
							</div>
						</div>

					</div>
					<!-- product-body -->


				</div>

			</div>
			<!--product-body-->
		</div>
		<!-- class="card-box"-->




	</div>
	<!-- class="card-box"-->



	</div>
	</div>

	</div>
	</content>
	<!---푸터----------------------------------------->
	<footer class="controller">
		<div id="sec-footer" class="sector">
			<div class="footer-links">
				<a href="#terms">이용약관</a> | <a href="#privacy">개인정보처리방침</a> | <a
					href="#exchange">교환/반품 안내</a> | <a href="#faq">자주 묻는 질문</a> | <a
					href="#contact">1:1 문의</a>
			</div>
			<div class="company-info">
				<p>
					<span class="company-name">상호: 주식회사 보따리</span> | <span
						class="company-name">대표: 김보따리</span> | <span>사업자등록번호:
						123-45-67890</span> | <span>통신판매업신고: 제2025-서울강동-0001</span>
				</p>
				<p class="contact-info">주소: 서울특별시 강동구 천호대로 1027, 5층 | 고객센터:
					02-1234-5678</p>
				<p class="contact-info">운영시간: 평일 10:00 ~ 18:00 (점심시간
					12:00~13:00)</p>
			</div>

			<div class="copyright">
				<p>© 2025 bottari.com. All rights reserved.</p>
			</div>
		</div>
	</footer>
</body>
</html>