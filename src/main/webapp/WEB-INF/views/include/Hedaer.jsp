<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CDN(외부 사이트 프리셋) 리셋 css 대용-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />

<!-- global.css호출 -->
<link rel="stylesheet" href="/assets/css/Global.css">
<title>Insert title here</title>
</head>
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
		<c:choose>
			<c:when test="${sessionScope.authUser != null}">
				<a href=""><img class="header-icon header-shopping-cart"
					src="/assets/icon/icon-shopping-cart.svg"></a>
				<h1 class="header-usermenu">${sessionScope.authUser.name}</h1>
				<a href=""><img class="header-icon"
					src="/assets/icon/icon-caret-down.svg"></a>
			</c:when>
			<c:otherwise>
				<a href=""><img class="header-icon header-shopping-cart"
					src="/assets/icon/icon-shopping-cart.svg"></a>
				<h1 class="header-usermenu">로그인이 필요해요</h1>
				<a href=""><img class="header-icon"
					src="/assets/icon/icon-caret-down.svg"></a>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</header>
</html>