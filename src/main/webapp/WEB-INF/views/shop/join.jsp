<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
	<link rel="stylesheet" href="../../../assets/css/join.css">

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

	<content class="controller">
		<div id="sec-content" class="sector">
			<div class="sec-sub-title">
				<h2 class="header-sub">회원가입</h2>
			</div>
			<div class="sec-content-main">
				<main class="signup-container">
					<p class="subtitle">회원이 되어 다양한 혜택을 경험해 보세요!</p>

					<form class="signup-form">
						<div class="form-group with-button">
							<label>아이디</label>
							<div class="input-row">
								<input type="text" placeholder="아이디 입력(6~20자)" />
								<button type="button">중복확인</button>
							</div>
						</div>

						<div class="form-group">
							<label>비밀번호</label>
							<input type="password" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자)" />
						</div>

						<div class="form-group">
							<label>비밀번호 확인</label>
							<input type="password" placeholder="비밀번호 재입력" />
						</div>

						<div class="form-group">
							<label>이름</label>
							<input type="text" placeholder="이름을 입력해주세요" />
						</div>

						<div class="form-group">
							<label>전화번호</label>
							<input type="tel" placeholder="휴대폰 번호 입력('-' 제외 11자리 입력)" />
						</div>

						<div class="form-group email-group">
							<label>이메일 주소</label>
							<div class="email-inputs">
								<input type="text" placeholder="이메일 주소" />
								<span>@</span>
								<select>
									<option>naver.com</option>
									<option>gmail.com</option>
									<option>daum.net</option>
									<option>hanmail.net</option>
									<option>hotmail.com</option>
									<option>yahoo.com</option>
								</select>
							</div>
						</div>

						<div class="form-group birth-group">
							<label>생년월일</label>
							<div class="date-selects">
								<select>
									<option>년도</option>
									<option>2005</option>
									<option>2004</option>
									<option>2003</option>
									<option>2002</option>
									<option>2001</option>
									<option>2000</option>
									<option>1999</option>
									<option>1998</option>
									<option>1997</option>
									<option>1996</option>
									<option>1995</option>
									<option>1994</option>
									<option>1993</option>
									<option>1992</option>
									<option>1991</option>
									<option>1990</option>
								</select>
								<select>
									<option>월</option>
									<option>1월</option>
									<option>2월</option>
									<option>3월</option>
									<option>4월</option>
									<option>5월</option>
									<option>6월</option>
									<option>7월</option>
									<option>8월</option>
									<option>9월</option>
									<option>10월</option>
									<option>11월</option>
									<option>12월</option>
								</select>
<select>
									<option>일</option>
									<option>1일</option>
									<option>2일</option>
									<option>3일</option>
									<option>4일</option>
									<option>5일</option>
									<option>6일</option>
									<option>7일</option>
									<option>8일</option>
									<option>9일</option>
									<option>10일</option>
									<option>11일</option>
									<option>12일</option>
									<option>13일</option>
									<option>14일</option>
									<option>15일</option>
									<option>16일</option>
									<option>17일</option>
									<option>18일</option>
									<option>19일</option>
									<option>20일</option>
									<option>21일</option>
									<option>22일</option>
									<option>23일</option>
									<option>24일</option>
									<option>25일</option>
									<option>26일</option>
									<option>27일</option>
									<option>28일</option>
									<option>29일</option>
									<option>30일</option>
									<option>31일</option>
								</select>
							</div>
						</div>

						<div class="form-buttons">
							<button type="submit" class="submit-btn">회원가입</button>
							<button type="button" class="cancel-btn">취소</button>
						</div>
					</form>
				</main>

			</div>
		</div>
	</content>
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
	
	<script>
	
	</script>
</body>

</html>