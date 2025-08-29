<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/assets/css/reset.css">
<link rel="stylesheet" href="/assets/css/Global.css">
<link rel="stylesheet" href="/assets/css/shop/nocart.css">
<link rel="stylesheet" href="/assets/css/moduler.css">

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
				<section class="main-banner">
					<div class="column-flex-box row-align align-center gap-10">
						<div class="banner-text">아직 담은 선물이 없어요</div>
						<div class="banner-subtext">소중한 마음을 담아 선물을 골라보세요</div>
						<a href="/shop/bottarimall"><button class="btn-basic btn-orange size-normal">장바구니 담으러 가기</button></a>
					</div>
				</section>

			</div>
		</div>
	</content>
	
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
</body>

</html>