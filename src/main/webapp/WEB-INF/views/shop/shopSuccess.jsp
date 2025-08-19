<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="../../../assets/css/reset.css">
	<link rel="stylesheet" href="../../../assets/css/Global.css">
	<link rel="stylesheet" href="../../../assets/css/shop/shopSuccess.css">
</head>

<body class="family">
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
				<a href=""><img class="header-icon header-shopping-cart"
					src="../../../assets/icon/icon-shopping-cart.svg"></a>
				<h1 class="header-usermenu">사용자이름</h1>
				<a href=""><img class="header-icon"
					src="../../../assets/icon/icon-caret-down.svg"></a>
			</div>
		</div>
	</header>

	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">상품등록</h2>
		</div>
		<div class="sec-content-main">
			<div class="success-container">
				<div class="success-icon">
					<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
						<circle cx="40" cy="40" r="40" fill="#c9a37e"/>
						<path d="M25 40L35 50L55 30" stroke="white" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</div>
				
				<div class="success-message">
					<h1>상품 등록이 완료되었습니다!</h1>
					<p>고객님의 소중한 상품이 성공적으로 등록되었습니다.</p>
				</div>

				<div class="product-info">
					<div class="info-item">
						<span class="info-label">등록된 상품명:</span>
						<span class="info-value">${productTitle != null ? productTitle : "상품명"}</span>
					</div>
					<div class="info-item">
						<span class="info-label">등록 일시:</span>
						<span class="info-value">
							<script>
								document.write(new Date().toLocaleDateString('ko-KR', {
									year: 'numeric',
									month: '2-digit',
									day: '2-digit',
									hour: '2-digit',
									minute: '2-digit'
								}));
							</script>
						</span>
					</div>
				</div>

				<div class="action-buttons">
					<button class="btn secondary-btn" onclick="location.href='shopform.jsp'">
						다른 상품 올리기
					</button>
					<button class="btn primary-btn" onclick="location.href='myProducts.jsp'">
						상품 확인하러 가기
					</button>
				</div>

				<div class="additional-links">
					<a href="productList.jsp" class="link">전체 상품 목록 보기</a>
				</div>
			</div>
		</div>
	</div>
	</content>

	<!-- 푸터에서 controller 클래스 제거 (전체 너비로) -->
	<footer>
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
					주소: 서울특별시 강동구 천호대로 1027, 5층 | 고객센터: 02-1234-5678
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