<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="../../../assets/css/reset.css">
	<link rel="stylesheet" href="../../../assets/css/Global.css">
	<link rel="stylesheet" href="../../../assets/css/shop/cart.css">
</head>

<body class="family">
	<header class="controller">
		<div id="sec-header" class="sector">
			<div class="left-side">
				<a href=""><img class="header-logo" src="../../../assets/icon/Logo_colored.svg"></a>
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
				<a href=""><img class="header-icon header-shopping-cart" src="../../../assets/icon/icon-shopping-cart.svg"></a>
				<h1 class="header-usermenu">사용자이름</h1>
				<a href=""><img class="header-icon" src="../../../assets/icon/icon-caret-down.svg"></a>
			</div>
		</div>
	</header>

	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">장바구니</h2>
			<!-- 여기부터 코딩 시작!! -->
		</div>
		<div class="sec-content-main">
			<main class="main">
				<div class="container">
					<div class="cart-box">
						<h2 class="section-title">배송상품</h2>

						<div class="cart-item">
							<img src="../../../photo/장바구니박명수.JPG" alt="상품 이미지">
							<div class="item-info">
								<p class="item-name">“활명수 굿즈출시” [명수 4종] 맥세이프 그립 톡 홀더 스마트톡 자석 아이폰...</p>

								<div class="item-options">
									<select class="option-select">
										<option>옵션 선택</option>
										<option>옵션 A</option>
										<option>옵션 B</option>
									</select> <select class="qty-select">
										<option>1개</option>
										<option>2개</option>
										<option>3개</option>
									</select>
								</div>

								<div class="anniversary-select">
									<label for="anniversary">기념일 선택</label> <select id="anniversary">
										<option>선택 안함</option>
										<option>생일</option>
										<option>결혼</option>
										<option>이벤트</option>
										<option>돌잔치</option>
									</select>
								</div>
							</div>

							<button class="delete-btn">삭제</button>
						</div>
					</div>






					<!-- 총 금액 -->
					<div class="summary">
						<div class="summary-row">
							<span>상품금액</span> <span>36,000원</span>
						</div>
						<div class="summary-row">
							<span>배송비</span> <span>3,000원</span>
						</div>
						<div class="summary-row total">
							<span>총 결제금액</span> <span>39,000원</span>
						</div>
					</div>

					<div class="buy-button">
						<button>구매하기</button>
					</div>
				</div>
		</div>
		</main>
	</div>
	</div>
	</content>
	<footer class="controller">
		<div id="sec-footer" class="sector">
			<div class="footer-links">
				<a href="#terms">이용약관</a> | <a href="#privacy">개인정보처리방침</a> | <a href="#exchange">교환/반품 안내</a> | <a href="#faq">자주 묻는 질문</a> | <a href="#contact">1:1 문의</a>
			</div>
			<div class="company-info">
				<p>
					<span class="company-name">상호: 주식회사 보따리</span> | <span class="company-name">대표: 김보따리</span> | <span>사업자등록번호: 123-45-67890</span> | <span>통신판매업신고:
						제2025-서울강동-0001</span>
				</p>
				<p class="contact-info">주소: 서울특별시 강동구 천호대로 1027, 5층 | 고객센터: 02-1234-5678</p>
				<p class="contact-info">운영시간: 평일 10:00 ~ 18:00 (점심시간 12:00~13:00)</p>
			</div>

			<div class="copyright">
				<p>© 2025 bottari.com. All rights reserved.</p>
			</div>
		</div>
	</footer>
</body>

</html>