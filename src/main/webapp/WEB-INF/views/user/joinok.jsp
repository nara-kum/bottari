<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>

		<html lang="ko">

		<head>
			<meta charset="UTF-8">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/join.css">

			<title>보따리몰</title>
		</head>

		<body class="family">
			<!------------------------ Header호출 ----------------------->
			<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
			<!-- ---------------------------------------------------- -->
			<div class="screen-wrapper">
				<main class="controller">
					<div id="sec-content" class="sector">
						<div class="sec-sub-title">
							<h2 class="header-sub">회원정보</h2>
						</div>
						<div class="sec-content-main">

							<!-- 로그인창 -->
							<div class="login-wrapper">
								<div class="login-box">
									<img src="${pageContext.request.contextPath}/assets/icon/Logo_colored.svg" alt="로고"
										class="login-logo" />
									<form class="form-box">
										<h2>회원가입을 축하합니다.</h2>
										<h2>이제 로그인하여 다양한 서비스를 이용해보세요.</h2>
										<button type="submit" class="login-btn">
											<a href="${pageContext.request.contextPath}/user/loginForm">로그인</a>
										</button>
										<button type="submit" class="home-btn">
											<a href="${pageContext.request.contextPath}/shop/shoppingMall">홈으로</a>
										</button>
									</form>
								</div>
							</div>

						</div>
					</div>
				</main>

				<!------------------------ Footer호출 ----------------------->
				<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
				<!-- ---------------------------------------------------- -->
			</div>
		</body>

		</html>