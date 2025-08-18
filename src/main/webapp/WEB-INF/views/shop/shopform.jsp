<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../assets/css/shop/shopform.css">
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
				<h2 class="header-sub">상품등록</h2>
				<!-- 여기부터 코딩 시작!! -->
			</div>
			<div class="sec-content-main">

				<!-- 카테고리 -->
				<main class="container">
					<section class="section">
						<label>카테고리</label>
						<div class="category-wrapper">
							<div class="category-box">
								<span class="selected">결혼</span>
								<span>생일</span>
								<span>돌잔치</span>
								<span>이벤트</span>
								<span>축하</span>
								<span>감사</span>
							</div>
							<!-- 숨겨진 필드로 선택된 카테고리 값 전송 -->
							<input type="hidden" name="category_no" id="category_no" value="1">
						</div>
					</section>

					<!-- 상품명/브랜드 -->
					<section class="section">
						<label>상품명</label>
						<input type="text" placeholder="상품명을 입력하세요" value=${ProductVO.title}>

						<label>판매가</label>
						<input type="text" placeholder="예: 29,900" value=${ProductVO.price}>

						<label>브랜드명</label>
						<input type="text" placeholder="예: 보따리" value=${ProductVO.brand}>
					</section>

					<!-- 옵션 -->
					<section class="section">
						<label>옵션 설정
							<a href=""><img class="add-logo" src="../../../assets/icon-add.svg"></a>
						</label>

						<div class="option-row">
							<!-- <select>
							<option>옵션을 선택해주세요.</option>
							<option>컬러</option>
							<option>사이즈</option>
							<option>맛</option>
							<option>케이크호수</option>
						</select> -->
							<input type="text" placeholder="옵션타이틀 입력 (예: 컬러)" value=${ProductOptionVO.option_name}>
							<input type="text" placeholder="옵션 입력 (예: 하늘)" value=${ProductOption.detialOption_name}>
							<a href=""><img class="add-logo2" src="../../../assets/icon-add.svg"></a>
						</div>
					</section>

					<!-- 상품 이미지 -->
					<section class="section">
						<label>상품 이미지</label>
						<div class="image-preview">
							<img src="../../../photo/장바구니박명수.JPG" alt="샘플 이미지">
							<div>삭제</div>
						</div>
					</section>

					<!-- 상세 설명 -->
					<section class="section">
						<label>상세 설명</label>
						<div class="description-box">
							<div class="upload-check">✔ 사진을 등록하세요.</div>
							<button class="upload-btn">등록하기</button>
						</div>
					</section>

					<!-- 배송 -->

					<div class="input-group">
						<label for="shipping-cost">배송비</label>
						<input type="text" id="shipping-cost" placeholder="배송비 입력" value=${ProductVO.shipping_cost}>
					</div>

					<div class="input-group">
						<label for="zipcode">우편번호</label>
						<div class="zipcode-group">
							<input type="text" id="zipcode" class="zipcode-input" placeholder="우편번호">
							<button class="zipcode-btn">우편번호 찾기</button>
						</div>
					</div>

					<div class="input-group">
						<label for="address">출고지 주소</label>
						<input type="text" id="address" placeholder="출고지 주소">
						<input type="text" id="detail-address" placeholder="상세 주소">
					</div>



					<!-- 버튼 -->
					<div class="button-row">
						<button class="cancel-btn">취소</button>
						<button class="submit-btn" type="submit">등록</button>
					</div>
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
		// 카테고리 선택 JavaScript
		document.querySelectorAll('.category-box span').forEach(span => {
			span.addEventListener('click', function() {
				// 기존 선택 제거
				document.querySelectorAll('.category-box span').forEach(s => s.classList.remove('selected'));
				// 현재 선택 추가
				this.classList.add('selected');
				// 숨겨진 input에 값 설정
				document.getElementById('category_no').value = this.getAttribute('data-value');
			});
		});
	</script>
</body>

</html>