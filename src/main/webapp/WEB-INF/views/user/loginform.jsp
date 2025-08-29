<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/login.css">
	<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>

</head>

<body class="family">
	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->


	<main class="controller">
		<div id="sec-content" class="sector">
			<div class="sec-sub-title">
				<h2 class="header-sub">로그인</h2>
			</div>
			<div class="sec-content-main">

				<!-- 로그인창 -->
				<div class="login-wrapper">
					<div class="login-box">
						<img src="${pageContext.request.contextPath}/assets/icon/Logo_colored.svg" alt="로고" class="login-logo" />
						<form class="form-box" action="${pageContext.request.contextPath}/user/login" method="get">
							<div class="input-group">
								<input type="text" placeholder="아이디" name="id" value="">
							</div>
							<div class="input-group">
								<input type="password" placeholder="비밀번호" name="password" value="">
							</div>
							<div class="extra-options">
								<label><input type="checkbox" /> 로그인 상태 유지</label>
							</div>
							<button type="submit" class="login-btn">로그인</button>
							<div class="help-links">
								<a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</main>

	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
        // JSP에서 loginResult 값을 JavaScript 변수로 전달
        //var loginResult = "<%=request.getAttribute("login")%>" 여기 오류나서 막았음
		

		// 메시지를 DOM에 표시
		var resultDiv = document.getElementById("resultMessage");

		if (loginResult === "success") {
			resultDiv.innerText = "Login Successful!";
			resultDiv.className = "success";
		} else {
			resultDiv.innerText = "Login Failed. Please try again.";
			resultDiv.className = "failed";
		}
	</script>
</body>
</html>