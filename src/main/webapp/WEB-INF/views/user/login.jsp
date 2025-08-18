<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
	<link rel="stylesheet" href="../../../assets/css/login.css">
	<title>로그인</title>
</head>

<body class="family">
	<header class="controller">
		<div id="sec-header" class="sector">
			<div class="left-side">
				<a href=""><img class="header-logo" src="../../../assets/icon/Logo_colored.svg"></a>
				<h1 class="header-menu"><a href="">캘린더</a></h1>
				<h1 class="header-menu"><a href="">펀딩</a></h1>
				<h1 class="header-menu"><a href="">초대장</a></h1>
				<h1 class="header-menu"><a href="">구매내역</a></h1>
			</div>
			<div class="right-side">
				<a href=""><img class="header-icon header-shopping-cart" src="../../../assets/icon/icon-shopping-cart.svg"></a>
				<h1 class="header-usermenu">사용자이름</h1>
				<a href=""><img class="header-icon" src="../../../assets/icon/icon-caret-down.svg"></a>
			</div>
		</div>
	</header>

	<main class="controller">
		<div id="sec-content" class="sector">
			<div class="sec-sub-title">
				<h2 class="header-sub">로그인</h2>
				<!-- 여기부터 코딩 시작!! -->
			</div>
			<div class="sec-content-main">

				<!-- 로그인창 -->
				<div class="login-wrapper">
					<div class="login-box">
						<img src="../../../assets/icon/Logo_colored.svg" alt="로고" class="login-logo" />
						<form>
							<div class="input-group">
								<input type="text" placeholder="아이디" required />
							</div>
							<div class="input-group">
								<input type="password" placeholder="비밀번호" required />
							</div>
							<div class="extra-options">
								<label><input type="checkbox" /> 로그인 상태 유지</label>
							</div>
							<button type="submit" class="login-btn">로그인</button>
							<div class="help-links">
								<a href="#">아이디 찾기</a> |
								<a href="#">비밀번호 찾기</a>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</main>
	<footer class="controller">
		<div id="sec-footer" class="sector">
			<div class="footer-links">
				<a href="#terms">이용약관</a> |
				<a href="#privacy">개인정보처리방침</a> |
				<a href="#exchange">교환/반품 안내</a> |
				<a href="#faq">자주 묻는 질문</a> |
				<a href="#contact">1:1 문의</a>
			</div>
			<div class="company-info">
				<p>
					<span class="company-name">상호: 주식회사 보따리</span> |
					<span class="company-name">대표: 김보따리</span> |
					<span>사업자등록번호: 123-45-67890</span> |
					<span>통신판매업신고: 제2025-서울강동-0001</span>
				</p>
				<p class="contact-info">
					주소: 서울특별시 강동구 천호대로 1027, 5층 |
					고객센터: 02-1234-5678
				</p>
				<p class="contact-info">
					운영시간: 평일 10:00 ~ 18:00 (점심시간 12:00~13:00)
				</p>
			</div>

			<div class="copyright">
				<p>© 2025 bottari.com. All rights reserved.</p>
			</div>
		</div>
	</footer>
</body>

</html>