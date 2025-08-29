<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop/shopform.css">
</head>

<body class="family">
	<!-- Header호출 -->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- Header호출 -->

	<content class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<h2 class="header-sub">상품등록</h2>
		</div>
		<div class="sec-content-main">

			<!-- 폼 시작 -->
			<form action="${pageContext.request.contextPath}/shop/register" method="post" enctype="multipart/form-data">

				<!-- 카테고리 -->
				<main class="container">
					<section class="section">
						<label>카테고리</label>
						<div class="category-wrapper">
							<div class="category-box">
								<label for="rdo-wed" class="selected">결혼</label>
								<input id="rdo-wed" type="radio" name="category_no" value="1">
								
								<label for="rdo-bir">생일</label>
								<input id="rdo-bir" type="radio" name="category_no" value="2">
							
								<label for="rdo-bir1">돌잔치</label>
								<input id="rdo-bir1" type="radio" name="category_no" value="3">
							
								<label for="rdo-eve">이벤트</label>
								<input id="rdo-eve" type="radio" name="category_no" value="4">
							
								<label for="rdo-con">축하</label>
								<input id="rdo-con" type="radio" name="category_no" value="5">
							
								<label for="rdo-tha">감사</label>
								<input id="rdo-tha" type="radio" name="category_no" value="6">
							
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
							<div class="option-group" data-gno="0">
								<div class="option-row">
									<input type="text" name="option_names" placeholder="옵션타이틀 입력 (예: 컬러)"> 
								
									<input type="text" name="optionItems[0]" placeholder="옵션 입력 (예: 하늘)">
									
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
						<input type="file" name="productImage" id="imageFile" accept="image/*" style="display: none;">
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
							<input type="file" name="detailImages" id="detailImages" accept="image/*" multiple style="display: none;" multiple="multiple">
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

							<label for="rdo-dely" class="delivery-type active">배송</label> <input
								id="rdo-dely" type="radio" name="shipping_yn" value="y">

							<label for="rdo-deln" class="delivery-type">배송없음</label> <input
								id="rdo-deln" type="radio" name="shipping_yn" value="n">

						</div>
						<!-- 배송여부 히든 필드 제거 - 라디오 버튼으로 직접 전송 -->
					</section>

					<div class="input-group" id="shipping-cost-group">
						<label for="shipping-cost">배송비</label> <input type="text"
							name="shipping_cost" id="shipping-cost" placeholder="배송비 입력">
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

	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
	// 카테고리 선택 JavaScript
	document.querySelectorAll('.category-box label').forEach(span => {
		span.addEventListener('click', function() {
			document.querySelectorAll('.category-box label').forEach(s => s.classList.remove('selected'));
			this.classList.add('selected');
			document.getElementById('categoryNo').value = this.getAttribute('data-category');
		});
	});

	// 배송여부 선택 JavaScript - 완전 새로 작성
	document.querySelectorAll('.delivery-type').forEach(deliveryType => {
		deliveryType.addEventListener('click', function() {
			// 모든 active 클래스 제거
			document.querySelectorAll('.delivery-type').forEach(dt => dt.classList.remove('active'));
			// 클릭된 라벨에 active 클래스 추가
			this.classList.add('active');
			
			// 연결된 라디오 버튼 체크
			const radioId = this.getAttribute('for');
			document.getElementById(radioId).checked = true;
			
			// 배송비 입력창 제어
			const shippingCostGroup = document.getElementById('shipping-cost-group');
			const shippingCostInput = document.getElementById('shipping-cost');
			
			if (radioId === 'rdo-deln') {
				// 배송없음일 때: 배송비 입력창 숨기고 값을 0으로 설정
				shippingCostGroup.style.display = 'none';
				shippingCostInput.value = '0';
			} else {
				// 배송일 때: 배송비 입력창 보이기
				shippingCostGroup.style.display = 'block';
				shippingCostInput.value = '';
			}
		});
	});

	// 페이지 로드 시 초기 설정
	document.addEventListener('DOMContentLoaded', function() {
		// 기본적으로 배송이 선택되어 있으므로 배송비 입력창은 보이도록 설정
		const shippingCostGroup = document.querySelector('#shipping-cost').closest('.input-group');
		shippingCostGroup.style.display = 'block';
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
					imageDiv.innerHTML = '';
					
					imageDiv.innerHTML += '<img src='+ e.target.result + ' alt="상세 이미지 ' + (index + 1) + '">';
					imageDiv.innerHTML += '<span class="image-name">'+ file.name +'</span>';
					
					previewContainer.appendChild(imageDiv);
				};
				reader.readAsDataURL(file);
			});
		}
	});

	//옵션 추가할때 쓰는 변수
	let optGroupNo = 0;
	let gno; //마지막 사용한 그룹번호

	// 옵션 그룹 추가 함수
	function addOptionGroup() {
		
		const container = document.getElementById('optionContainer');
		const newGroup = document.createElement('div');
		newGroup.className = 'option-group';
		
		optGroupNo = optGroupNo+1;
		newGroup.setAttribute('data-gno', optGroupNo);
		
		gno = newGroup.dataset.gno
		
		let htmlStr ='';
		htmlStr += '<div class="option-row">';
		htmlStr += '	<input type="text" name="option_names" placeholder="옵션타이틀 입력 (예: 사이즈)"> ';
		htmlStr += '	<input type="text" name="optionItems[' + gno + ']" placeholder="옵션 입력 (예: L)"> ';
		htmlStr += '	<button type="button" class="add-detail-option" onclick="addDetailOption(this)">';
		htmlStr += '		<img class="add-logo2" src="../../../assets/icon-add.svg" alt="옵션 추가">';
		htmlStr += '	</button>';
		htmlStr += '	<button type="button" class="remove-option-group" onclick="removeOptionGroup(this)">';
		htmlStr += '		<img class="remove-logo" src="../../../assets/icon-remove.svg" alt="옵션 그룹 제거">';
		htmlStr += '	</button>';
		htmlStr += '</div>';
		
		newGroup.innerHTML = htmlStr;
		
		container.appendChild(newGroup);
	}

	// 세부 옵션 추가 함수
	function addDetailOption(button) {
		const optionGroup = button.closest('.option-group');
		const newRow = document.createElement('div');
		newRow.className = 'option-row detail-only';

		gno = optionGroup.dataset.gno;
		
		
		let htmlStr = '';
		htmlStr += '<input type="text" placeholder="옵션타이틀은 위와 동일">';
		htmlStr += '<input type="text" name="optionItems['+ gno +']" placeholder="옵션 입력 (예: M)">';
		htmlStr += '<button type="button" class="add-detail-option" onclick="addDetailOption(this)">';
		htmlStr += '	<img class="add-logo2" src="../../../assets/icon-add.svg" alt="옵션 추가">';
		htmlStr += '</button>';
		htmlStr += '<button type="button" class="remove-detail-option" onclick="removeDetailOption(this)">';
		htmlStr += '	<img class="remove-logo2" src="../../../assets/icon-remove.svg" alt="옵션 제거">';
		htmlStr += '</button>';
		htmlStr += '';
		newRow.innerHTML = htmlStr;
		
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