<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>
		<html lang="ko">

		<head>
			<meta charset="UTF-8">
			<title>로그인</title>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/login.css">
			<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
		</head>

		<body class="family">
			<!-- 공통 헤더 -->
			<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
			<div class="screen-wrapper">
				<main class="controller">
					<div id="sec-content" class="sector">
						<div class="sec-sub-title">
							<h2 class="header-sub">로그인</h2>
						</div>

						<div class="sec-content-main">
							<div class="login-wrapper">
								<div class="login-box">
									<img src="${pageContext.request.contextPath}/assets/icon/Logo_colored.svg" alt="로고"
										class="login-logo" />

									<!-- 반드시 POST -->
									<form class="form-box" action="${pageContext.request.contextPath}/user/login"
										method="post" autocomplete="on">
										<!-- param.returnUrl 우선, 없으면 model 의 returnUrl 사용 -->
										<input type="hidden" name="returnUrl"
											value="${not empty param.returnUrl ? param.returnUrl : returnUrl}" />

										<div class="input-group">
											<input type="text" placeholder="아이디" name="id" autocomplete="username"
												required>
										</div>
										<div class="input-group">
											<input type="password" placeholder="비밀번호" name="password"
												autocomplete="current-password" required>
										</div>

										<div class="extra-options">
											<label><input type="checkbox"> 로그인 상태 유지</label>
										</div>

										<!-- 로그인 실패 메시지 -->
										<c:if test="${param.error == '1'}">
											<p class="login-error" style="color: #d33; margin: 8px 0 0;">아이디
												또는 비밀번호가 올바르지 않습니다.</p>
										</c:if>

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

				<!-- 공통 푸터 -->
				<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
			</div>
			<!-- 알럿 표준화 + returnUrl 정규화 -->
			<script>
				(function () {
					// reason=auth 가 있으면 폼 로드시 알럿
					var params = new URLSearchParams(location.search);
					if (params.get('reason') === 'auth') {
						alert('로그인이 필요합니다.');
					}

					// 보안상 내부 경로만 유지하도록 returnUrl 정규화
					function normalizeReturnUrl(raw) {
						if (!raw)
							return "";
						try {
							if (raw.startsWith("/"))
								return raw; // 내부 경로 OK
							var u = new URL(raw, window.location.origin);
							if (u.origin === window.location.origin)
								return u.pathname + u.search;
							return "";
						} catch (e) {
							return "";
						}
					}

					document.addEventListener('DOMContentLoaded', function () {
						var form = document.querySelector('form.form-box');
						if (!form)
							return;
						var hid = form.querySelector('input[name="returnUrl"]');
						if (!hid)
							return;

						// param 우선 → 없으면 model → 없으면 쿼리에서 가져와 정규화
						var fromInput = hid.value || "";
						var fromQuery = new URLSearchParams(location.search)
							.get('returnUrl')
							|| "";
						var raw = fromInput || fromQuery;
						hid.value = normalizeReturnUrl(raw);
					});
				})();
			</script>
		</body>

		</html>