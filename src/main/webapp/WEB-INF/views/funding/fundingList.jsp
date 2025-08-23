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

	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
	
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

	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

</body>
</html>