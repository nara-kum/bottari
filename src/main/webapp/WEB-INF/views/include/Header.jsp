<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header class="controller">
	<div id="sec-header" class="sector">
		<div class="left-side">
			<a href="${pageContext.request.contextPath}/shop/bottarimall"><img class="header-logo"
				src="/assets/icon/Logo_colored.svg"></a>
			<h1 class="header-menu">
				<a href="${pageContext.request.contextPath}/shop/bottarimall">쇼핑</a>
			</h1>
			<h1 class="header-menu">
				<a href="${pageContext.request.contextPath}/calender">캘린더</a>
			</h1>
			<h1 class="header-menu">
				<a href="${pageContext.request.contextPath}/funding/wish">펀딩</a>
			</h1>
			<h1 class="header-menu">
				<a href="${pageContext.request.contextPath}/invitation/list">초대장</a>
			</h1>
			<h1 class="header-menu">
				<a href="${pageContext.request.contextPath}/history">구매내역</a>
			</h1>
		</div>
		<div class="right-side">
			<a href="${pageContext.request.contextPath}/cart"><img class="header-icon header-shopping-cart"
				src="/assets/icon/icon-shopping-cart.svg"></a>
			<!-- 세션에 값이 있을때 -->

			<c:choose>
				<c:when test="${sessionScope.authUser == null}">
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/user/loginForm">로그인</a>
					</h1>
					<a href=""><img class="header-icon"
						src="/assets/icon/icon-caret-down.svg"></a>
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/user/joinform">회원가입</a>
					</h1>
				</c:when>
				<c:otherwise>
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/user/editform">${sessionScope.authUser.name}</a>
					</h1>
					<a href=""><img class="header-icon"
						src="/assets/icon/icon-caret-down.svg"></a>
					<h1>
						<a class="header-usermenu"
							href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
					</h1>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</header>
