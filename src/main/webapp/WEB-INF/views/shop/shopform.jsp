<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

			<!-- 폼 시작 -->
			<form action="/register" method="post" enctype="multipart/form-data">

				<!-- 카테고리 -->
				<main class="container">
					<section class="section">
						<label>카테고리</label>
						<div class="category-wrapper">
							<div class="category-box">
								<span class="selected" data-category="1">결혼</span> 
								<span data-category="2">생일</span> 
								<span data-category="3">돌잔치</span>
								<span data-category="4">이벤트</span> 
								<span data-category="5">축하</span>
								<span data-category="6">감사</span>
							</div>
						</div>
						<!-- 카테고리 번호 히든 필드 -->
						<input type="hidden" name="category_no" id="categoryNo" value="1">
					</section>

					<!-- 상품명/브랜드 -->
					<section class="section">
						<label>상품명</label> 
						<input type="text" name="title" placeholder="상품명을 입력하세요"> 
						
						<label>판매가</label> 
						<input type="text" name="price" placeholder="예: 29,900"> 
						
						<label>브랜드명</label>
						<input type="text" name="brand" placeholder="예: 보따리">
					</section>

					<!-- 옵션 -->
					<section class="section">
						<div class="option-header">
							<label>옵션 설정</label>
							<button type="button" class="add-option-group" onclick="addOptionGroup()">
								<img class="add-logo" src="../../../assets/icon-add.svg" alt="옵션 그룹 추가">
							</button>
						</div>

						<div id="optionContainer">
							<div class="option-group">
								<div class="option-row">
									<input type="text" name="option_name[]" placeholder="옵션타이틀 입력 (예: 컬러)"> 
									<input type="text" name="detailOption_name[]" placeholder="옵션 입력 (예: 하늘)"> 
									<button type="button" class="add-detail-option" onclick="addDetailOption(this)">
										<img class="add-logo2" src="../../../assets/icon-add.svg" alt="옵션 추가">
									</button>
								</div>
							</div>
						</div>
					</section>

					<!-- 상품 이미지 -->
					<section class="section">
						<label>상품 이미지</label> 
						<input type="file" name="imageFile" id="imageFile" accept="image/*" style="display: none;">
						<input type="hidden" name="itemimg" id="itemimg">
						<div class="image-preview">
							<div class="image-container">
								<img id="previewImg" src="" alt="미리보기 이미지" style="display: none;">
								<div class="no-image" id="noImageText">이미지가 선택되지 않았습니다</div>
							</div>
							<button type="button" class="image-select-btn" onclick="document.getElementById('imageFile').click();">
								이미지 선택
							</button>
						</div>
					</section>

					<!-- 상세 설명 -->
					<section class="section">
						<label>상세 설명</label>
						<div class="description-box">
							<input type="file" name="detailImages[]" id="detailImages" accept="image/*" multiple style="display: none;">
							<div class="detail-images-preview" id="detailImagesPreview">
								<div class="no-detail-images">상세 설명 이미지를 등록하세요.</div>
							</div>
							<button class="upload-btn" type="button" onclick="document.getElementById('detailImages').click();">
								등록하기
							</button>
						</div>
					</section>

					<!-- 배송여부 -->
					<section class="section">
						<label>배송여부</label>
						<div class="delivery-box">
							<div class="delivery-type active" data-shipping="1">배송</div>
							<div class="delivery-type" data-shipping="0">배송없음</div>
						</div>
						<!-- 배송여부 히든 필드 -->
						<input type="hidden" name="shipping_yn" id="shippingYn" value="1">
					</section>

					<div class="input-group">
						<label for="shipping-cost">배송비</label> 
						<input type="text" name="shipping_cost" id="shipping-cost" placeholder="배송비 입력">
					</div>

					<div class="input-group">
						<label for="zipcode">우편번호</label>
						<div class="zipcode-group">
							<input type="text" name="zipcode" id="zipcode" class="zipcode-input" placeholder="우편번호">
							<button class="zipcode-btn" type="button">우편번호 찾기</button>
						</div>
					</div>

					<div class="input-group">
						<label for="address">출고지 주소</label> 
						<input type="text" name="address" id="address" placeholder="출고지 주소"> 
						<input type="text" name="detail_address" id="detail-address" placeholder="상세 주소">
					</div>

					<!-- 버튼 -->
					<div class="button-row">
						<button class="cancel-btn" type="button">취소</button>
						<button class="submit-btn" type="submit">등록</button>
					</div>
				</main>

			</form>
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

	<script>
		// 카테고리 선택 JavaScript
		document.querySelectorAll('.category-box span').forEach(span => {
			span.addEventListener('click', function() {
				document.querySelectorAll('.category-box span').forEach(s => s.classList.remove('selected'));
				this.classList.add('selected');
				document.getElementById('categoryNo').value = this.getAttribute('data-category');
			});
		});

		// 배송여부 선택 JavaScript
		document.querySelectorAll('.delivery-type').forEach(deliveryType => {
			deliveryType.addEventListener('click', function() {
				document.querySelectorAll('.delivery-type').forEach(dt => dt.classList.remove('active'));
				this.classList.add('active');
				document.getElementById('shippingYn').value = this.getAttribute('data-shipping');
			});
		});

		// 상품 이미지 파일 선택 JavaScript
		document.getElementById('imageFile').addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					const previewImg = document.getElementById('previewImg');
					const noImageText = document.getElementById('noImageText');
					
					previewImg.src = e.target.result;
					previewImg.style.display = 'block';
					noImageText.style.display = 'none';
				};
				reader.readAsDataURL(file);
				
				document.getElementById('itemimg').value = file.name;
			}
		});

		// 상세 설명 이미지 파일 선택 JavaScript
		document.getElementById('detailImages').addEventListener('change', function(event) {
			const files = event.target.files;
			const previewContainer = document.getElementById('detailImagesPreview');
			
			if (files.length > 0) {
				previewContainer.innerHTML = '';
				
				Array.from(files).forEach((file, index) => {
					const reader = new FileReader();
					reader.onload = function(e) {
						const imageDiv = document.createElement('div');
						imageDiv.className = 'detail-image-item';
						imageDiv.innerHTML = `
							<img src="${e.target.result}" alt="상세 이미지 ${index + 1}">
							<span class="image-name">${file.name}</span>
						`;
						previewContainer.appendChild(imageDiv);
					};
					reader.readAsDataURL(file);
				});
			}
		});

		// 옵션 그룹 추가 함수
		function addOptionGroup() {
			const container = document.getElementById('optionContainer');
			const newGroup = document.createElement('div');
			newGroup.className = 'option-group';
			newGroup.innerHTML = `
				<div class="option-row">
					<input type="text" name="option_name[]" placeholder="옵션타이틀 입력 (예: 사이즈)"> 
					<input type="text" name="detailOption_name[]" placeholder="옵션 입력 (예: L)"> 
					<button type="button" class="add-detail-option" onclick="addDetailOption(this)">
						<img class="add-logo2" src="../../../assets/icon-add.svg" alt="옵션 추가">
					</button>
					<button type="button" class="remove-option-group" onclick="removeOptionGroup(this)">
						<img class="remove-logo" src="../../../assets/icon-remove.svg" alt="옵션 그룹 제거">
					</button>
				</div>
			`;
			container.appendChild(newGroup);
		}

		// 세부 옵션 추가 함수
		function addDetailOption(button) {
			const optionGroup = button.closest('.option-group');
			const newRow = document.createElement('div');
			newRow.className = 'option-row detail-only';
			newRow.innerHTML = `
				<input type="text" placeholder="옵션타이틀은 위와 동일"> 
				<input type="text" name="detailOption_name[]" placeholder="옵션 입력 (예: M)"> 
				<button type="button" class="add-detail-option" onclick="addDetailOption(this)">
					<img class="add-logo2" src="../../../assets/icon-add.svg" alt="옵션 추가">
				</button>
				<button type="button" class="remove-detail-option" onclick="removeDetailOption(this)">
					<img class="remove-logo2" src="../../../assets/icon-remove.svg" alt="옵션 제거">
				</button>
			`;
			optionGroup.appendChild(newRow);
		}

		// 옵션 그룹 제거 함수
		function removeOptionGroup(button) {
			const optionGroup = button.closest('.option-group');
			optionGroup.remove();
		}

		// 세부 옵션 제거 함수
		function removeDetailOption(button) {
			const optionRow = button.closest('.option-row');
			optionRow.remove();
		}
	</script>
</body>

</html>