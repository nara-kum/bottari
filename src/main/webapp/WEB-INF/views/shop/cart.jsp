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
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
</body>

</html>