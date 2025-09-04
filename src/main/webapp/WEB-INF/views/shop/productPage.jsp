<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop/productPage.css">

<!-- js -->
<script
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>

	<title>보따리몰</title>
</head>

<body class="family">
	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<div class="controller">
		<div id="sec-content" class="sector">
			<div class="sec-sub-title">
				<h2 class="header-sub">상품페이지</h2>
			</div>
			<div class="sec-content-main">
	
				<!-- 메인 컨텐츠 -->
				<div class="main-container">
					
					<!-- 상품 상세 섹션 -->
					<div class="product-order-box">
					
						<div class="product-section">
					
							<div class="img-info-box">
								<!-- 상품 이미지 -->
								<div class="product-images">
									<c:choose>
										<c:when test="${not empty productViewVO.itemimg}">
											<img class="main-image"
												src="${pageContext.request.contextPath}/upload/${productViewVO.itemimg}"
												alt="${productViewVO.title}">
										</c:when>
										<c:otherwise>
											<img class="main-image"
												src="${pageContext.request.contextPath}/assets/upload/default-product.jpg"
												alt="기본 상품 이미지">
										</c:otherwise>
									</c:choose>
								</div>
			
								<!-- 상품 정보 -->
								<div class="product-info">
									<h1 class="product-title">${productViewVO.title}</h1>
									<div class="product-price">
										<fmt:formatNumber value="${productViewVO.price}" pattern="#,###" />
										원
									</div>
									<div class="brand-name">${productViewVO.brand}</div>
			
									<div class="product-options">
										<div class="option-label">배송정보</div>
			
			
			
										<!-- 배송 여부에 따른 표시 (1 = 배송가능, 0 = 배송불가능으로 추정) -->
										<c:if
											test="${productViewVO.shipping_yn == '1' or productViewVO.shipping_yn == 'y' or productViewVO.shipping_yn == 'Y'}">
											<!-- 배송 가능한 경우: 배송비와 출고지 표시 -->
											<div class="delivery-info">
												<span class="icon">🚚</span>
												<c:if test="${productViewVO.shipping_cost == 0}">
													택배비 무료
												</c:if>
												<c:if test="${productViewVO.shipping_cost > 0}">배송비
													<fmt:formatNumber value="${productViewVO.shipping_cost}" pattern="#,###" />원
												</c:if>
											</div>
											<div class="delivery-info">
												<span class="icon">📍</span> 
												출고지: ${productViewVO.address}
												${productViewVO.detail_address}
											</div>
										</c:if>
			
										<c:if
											test="${productViewVO.shipping_yn == '0' or productViewVO.shipping_yn == 'n' or productViewVO.shipping_yn == 'N'}">
											<!-- 배송 불가능한 경우: 메시지만 표시 -->
											<div class="delivery-info no-delivery">
												<span class="icon">🚫</span> 배송이 불가한 상품입니다
											</div>
										</c:if>
			
										<c:if test="${empty productViewVO.shipping_yn}">
											<p style="color: orange;">배송 정보가 설정되지 않았습니다.</p>
										</c:if>
									</div>
			
									<div class="service-info">
										<div class="option-label">서비스</div>
										<c:if
											test="${productViewVO.shipping_yn == '1' or productViewVO.shipping_yn == 'y' or productViewVO.shipping_yn == 'Y'}">
											<div class="service-item">원하는 배송지로 상품을 배송 받아요.</div>
										</c:if>
										<c:if
											test="${productViewVO.shipping_yn == '0' or productViewVO.shipping_yn == 'n' or productViewVO.shipping_yn == 'N'}">
											<div class="service-item">현장에서 직접 수령하는 상품입니다.</div>
										</c:if>
									</div>
								</div>
							</div>
							<!-- //img-info-box -->
							
	
						
							<!-- 상품 설명 -->
							<div class="product-description">
								<c:forEach items="${productViewVO.detailedImageList}"
									var="detailedImageVO">
									<img class="detailproduct"
										src="${pageContext.request.contextPath}/upload/${detailedImageVO.image_URL}"
										alt="상품상세이미지">
								</c:forEach>
							</div>
						
						</div>
						<!-- //product-section -->
					
						<!-- 주문 영역 -->
						<div class="order-section">
							 
							<div class="order-title">상품 선택</div>
		
							<!-- 옵션 선택 영역 -->
							<c:if test="${not empty productViewVO.productOptionList}">
								<c:forEach items="${productViewVO.productOptionList}"
									var="productOptionVO" varStatus="status">
									<div class="option-group" style="margin-bottom: 15px;">
										<span>${productOptionVO.option_name}</span> <select
											class="option-select" name=""
											data-option-no="${productOptionVO.option_no}">
											<option value="">${productOptionVO.option_name}을(를)
												선택하세요</option>
										</select>
									</div>
								</c:forEach>
							</c:if>
		
							<!-- 수량 선택 -->
							<div class="quantity-control" style="margin: 15px 0;">
								<label class="option-label">수량</label>
								<div style="display: flex; align-items: center; margin-top: 5px;">
									<button type="button" class="quantity-btn"
										onclick="changeQuantity(-1)">-</button>
									<input type="number" value="1" class="quantity-input" min="1"
										id="quantity" name="quantity" onchange="updatePrice()">
									<button type="button" class="quantity-btn"
										onclick="changeQuantity(1)">+</button>
								</div>
							</div>
		
		
							<!-- 선택한 옵션과 수량 표시 (처음에는 숨김) -->
		
							<div class="selected-info" id="selectedInfo">
								<div style="font-weight: bold; margin-bottom: 10px;">선택한 상품</div>
								<div
									style="background: white; padding: 15px; border-radius: 5px;">
									<div style="font-weight: bold; margin-bottom: 10px;">${productViewVO.title}</div>
									<div id="selectedOptions">
										<!-- 선택한 옵션들이 여기에 표시됩니다 -->
		
									</div>
									<div
										style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #eee;">
										수량: <span id="displayQuantity">1</span>개
									</div>
								</div>
							</div>
		
		
		
		
							<!-- 총 결제 금액 -->
							<div class="total-price"
								style="font-size: 18px; font-weight: bold; text-align: center; margin: 20px 0; padding: 15px; background: #ffffff; border-radius: 8px; color: #333;">
								총 결제 금액: <span id="totalAmount"><fmt:formatNumber
										value="${productViewVO.price}" pattern="#,###" /></span>원
							</div>
		
		
							<!-- 장바구니 폼 수정 -->
							<form action="${pageContext.request.contextPath}/cart/cartadd" method="get" id="cartForm">
								<input type="hidden" name="productNo"
									value="${productViewVO.product_no}"> <input
									type="hidden" name="categoryNo"
									value="${productViewVO.category_no}"> <input
									type="hidden" name="quantity" id="hiddenQuantity" value="1">
								<!-- 새로 추가: 선택된 옵션들을 저장할 숨겨진 필드 -->
								<input type="hidden" name="selectedOptions"
									id="selectedOptionsInput" value="">
		
								<button type="submit" class="cart-btn"
									onclick="setSelectedOptions()">장바구니 담기</button>
							</form>
		
		
							<div class="action-buttons">
		
								<!-- 위시리스트 폼 추가 -->
								<form action="${pageContext.request.contextPath}/wishlist/wishlistadd" method="get" id="wishlistForm" style="display: inline;">
									<input type="hidden" name="productNo" value="${productViewVO.product_no}"> 
									<input type="hidden" name="quantity" id="wishlistQuantity" value="1">
									<input type="hidden" name="selectedOptions" id="wishlistSelectedOptions" value="">
		
									<button type="button" class="wishlist-btn"
										onclick="submitWishlist()">찜 등록하기</button>
								</form>
								
								
								<!-- 구매하기 폼 추가 -->
								<form action="${pageContext.request.contextPath}/payment/checkout?cartNo=${cartVO.cart_no}" method="get">
								<input type="hidden" name="cartNo" value="${cartVO.cart_no}">
									<button class="funding-btn" type="submit">구매하기</button>
								</form>
							</div>
							 
							 
							 
							 
							 
							 
							 
		
						</div>
						<!-- order-section -->
					
					
					</div>
					<!-- //product-order-box -->
					
				</div>
				<!-- main-container -->
			</div>
			<!-- //sec-content-main -->
		</div>
		<!-- //sec-content -->
	</div>
	<!-- //controller -->

	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
	// 상품 기본 정보
	const productPrice = '${productViewVO.price}';

	// 페이지 로드 시 옵션 데이터 가져오기
	$(document).ready(function() {
		console.log('상품 가격:', productPrice);
		loadOptionDetails();

		
		//옵션을 선택했을때
		$('.option-select').on('change', function() {
			console.log('aaaaa');
			
			console.log($('.option-group>select'))
			let strHtml = '';
			$('.option-group>select').each(function(index, element) {
			
				let optionName = $(this).siblings('span').text();
				//console.log(optionName);
				
				let $selected = $(this).find('option:selected');
				//console.log(optText);
				
				if ($selected.index() !== 0) {
					let optText = $selected.text()
					strHtml += optionName + ":" + optText + "<br>";
				}
				
			});
			
			$('#selectedOptions').html(strHtml);	
			
		});
	
	});

	
	
	// 옵션 상세 데이터 로드
	function loadOptionDetails() {
		$('.option-select').each(function() {
			const optionSelect = $(this);
			const optionNo = optionSelect.data('option-no');
			
			$.ajax({
				url: "${pageContext.request.contextPath}/shop/api/optiondetail",
				type: "post",
				data: {optionNo: optionNo},
				dataType: "json",
				success: function(data) {
					console.log('옵션 데이터:', data);
					data.forEach(function(item) {
						optionSelect.append('<option value="' + item.detailoption_no + '">' + item.detailoption_name + '</option>');
					});
				},
				error: function(xhr, status, error) {
					console.error('옵션 로드 실패:', error);
				}
			});
		});
	}

	// 수량 변경
	function changeQuantity(change) {
		const quantityInput = document.getElementById('quantity');
		let currentQuantity = parseInt(quantityInput.value);
		currentQuantity += change;
		
		if (currentQuantity < 1) {
			currentQuantity = 1;
		}
		
		quantityInput.value = currentQuantity;
		
	    updateHiddenQuantity();
		
		updatePrice();
	}

/* 	// 옵션 선택 표시 업데이트
	function updateOptionDisplay() {
		let optionText = '';
		let hasSelectedOptions = false;
		
		$('.option-select').each(function() {
			const select = $(this)[0];
			if (select.value !== '') {
				hasSelectedOptions = true;
				const optionName = $(select).find('option:first').text().replace('을(를) 선택하세요', '');
				const selectedText = $(select).find('option:selected').text();
				optionText += '<div style="font-size: 14px; color: #666; margin: 2px 0;">선택한 ' + optionName + ': ' + selectedText + '</div>';
			}
		});
		
		// 옵션이 없는 상품인 경우 (옵션 select가 아예 없음)
		if ($('.option-select').length === 0) {
			optionText = '<div style="font-size: 14px; color: #666;">단일 상품 (옵션 없음)</div>';
			hasSelectedOptions = true; // 단일 상품이므로 선택된 것으로 간주
		}
		
		document.getElementById('selectedOptions').innerHTML = optionText;
		
		// 옵션을 선택했거나 단일 상품인 경우에만 선택한 상품 영역 표시
		const selectedInfo = document.getElementById('selectedInfo');
		if (hasSelectedOptions) {
			selectedInfo.style.display = 'block';
		} else {
			selectedInfo.style.display = 'none';
		}
		
		updatePrice();
	}
 */
	// 가격 업데이트 (수정된 부분)
	function updatePrice() {
		const quantity = parseInt(document.getElementById('quantity').value) || 1;
		const totalPrice = productPrice * quantity;
		
		
	    // 여기에 추가: hidden input 업데이트
	    updateHiddenQuantity();
		
		// 수량 표시 업데이트
		const displayQuantityElement = document.getElementById('displayQuantity');
		if (displayQuantityElement) {
			displayQuantityElement.textContent = quantity;
		}
		
		// 총 결제 금액 업데이트 (이 부분이 핵심!)
		const totalAmountElement = document.getElementById('totalAmount');
		if (totalAmountElement) {
			totalAmountElement.textContent = totalPrice.toLocaleString();
		}
		
		// 수량이 1보다 크거나 옵션이 선택된 경우 선택한 상품 영역 표시
		const selectedInfo = document.getElementById('selectedInfo');
		const hasSelectedOptions = $('.option-select').length === 0 || $('.option-select option:selected[value!=""]').length > 0;
		
		if (hasSelectedOptions && quantity >= 1) {
			selectedInfo.style.display = 'block';
			updateOptionDisplay(); // 옵션 표시도 함께 업데이트
		}
		
		console.log('가격 업데이트 - 수량:', quantity, '총 가격:', totalPrice);
	}
	
	
	// 장바구니 수량 넘기기
	function updateHiddenQuantity() {
	    var actualQuantity = document.getElementById('quantity').value;
	    document.getElementById('hiddenQuantity').value = actualQuantity;
	    
	    console.log('전송할 수량:', actualQuantity);
	}
	

	//장바구니 옵션
	function setSelectedOptions() {
		var selectedOptions = [];

		// 모든 옵션 선택박스를 확인
		$('.option-select').each(function() {
			var selectedValue = $(this).val();
			if (selectedValue && selectedValue !== '') {
				selectedOptions.push(selectedValue); // detailoption_no 값들을 배열에 추가
			}
		});

		// 선택된 옵션들을 JSON 문자열로 변환해서 숨겨진 필드에 설정
		document.getElementById('selectedOptionsInput').value = JSON
				.stringify(selectedOptions);

		console.log('선택된 옵션들:', selectedOptions);
	}
	
	
	function submitWishlist() {
	    console.log('위시리스트 함수 시작');
	    
	    // 수량 설정
	    var actualQuantity = document.getElementById('quantity').value;
	    document.getElementById('wishlistQuantity').value = actualQuantity;
	    console.log('설정된 수량:', actualQuantity);
	    
	    // 옵션 설정
	    var selectedOptions = [];
	    $('.option-select').each(function() {
	        var selectedValue = $(this).val();
	        console.log('옵션 값:', selectedValue);
	        if (selectedValue && selectedValue !== '') {
	            selectedOptions.push(selectedValue);
	        }
	    });
	    
	    console.log('선택된 옵션들:', selectedOptions);
	    document.getElementById('wishlistSelectedOptions').value = JSON.stringify(selectedOptions);
	    console.log('설정된 JSON:', JSON.stringify(selectedOptions));
	    
	    // 폼 제출
	    document.getElementById('wishlistForm').submit();
	}
	
	
	// 찜하기 버튼 클릭 전에 로그인 상태 확인
	function setWishlistData() {
	    // 세션 확인을 위한 임시 코드
	    console.log('찜하기 버튼 클릭됨');
	    
	    var actualQuantity = document.getElementById('quantity').value;
	    document.getElementById('wishlistQuantity').value = actualQuantity;
	    
	    var selectedOptions = [];
	    $('.option-select').each(function() {
	        var selectedValue = $(this).val();
	        if (selectedValue && selectedValue !== '') {
	            selectedOptions.push(selectedValue);
	        }
	    });
	    
	    document.getElementById('wishlistSelectedOptions').value = JSON.stringify(selectedOptions);
	    
	    console.log('위시리스트 전송 수량:', actualQuantity);
	    console.log('위시리스트 선택된 옵션들:', selectedOptions);
	}
	
	
	
	// 기존 setSelectedOptions 함수를 수정
	function setSelectedOptions() {
	    var selectedOptions = [];
	    var hasRequiredOptions = true;

	    // 모든 옵션 선택박스를 확인
	    $('.option-select').each(function() {
	        var selectedValue = $(this).val();
	        if (selectedValue && selectedValue !== '') {
	            selectedOptions.push(selectedValue); // detailoption_no 값들을 배열에 추가
	        } else {
	            hasRequiredOptions = false; // 선택되지 않은 옵션이 있음
	        }
	    });

	    // 옵션이 있는 상품인데 선택하지 않은 경우
	    if ($('.option-select').length > 0 && !hasRequiredOptions) {
	        showOptionAlert();
	        return false; // 폼 제출 중단
	    }

	    // 선택된 옵션들을 JSON 문자열로 변환해서 숨겨진 필드에 설정
	    document.getElementById('selectedOptionsInput').value = JSON.stringify(selectedOptions);

	    console.log('선택된 옵션들:', selectedOptions);
	    return true;
	}

	// 옵션 선택 알림창 표시 함수
	function showOptionAlert() {
	    // 기존 알림창이 있다면 제거
	    const existingAlert = document.getElementById('optionAlert');
	    if (existingAlert) {
	        existingAlert.remove();
	    }

	    // 알림창 HTML 생성
	    const alertHtml = `
	        <div id="optionAlert" class="option-alert-overlay">
	            <div class="option-alert-box">
	                <div class="alert-icon">⚠️</div>
	                <div class="alert-title">옵션 선택 필요</div>
	                <div class="alert-message">상품 옵션을 선택해주세요.</div>
	                <button class="alert-close-btn" onclick="closeOptionAlert()">확인</button>
	            </div>
	        </div>
	    `;

	    // body에 알림창 추가
	    document.body.insertAdjacentHTML('beforeend', alertHtml);

	    // 0.1초 후에 표시 (애니메이션 효과)
	    setTimeout(() => {
	        const alert = document.getElementById('optionAlert');
	        if (alert) {
	            alert.classList.add('show');
	        }
	    }, 100);
	}

	// 알림창 닫기 함수
	function closeOptionAlert() {
	    const alert = document.getElementById('optionAlert');
	    if (alert) {
	        alert.classList.remove('show');
	        setTimeout(() => {
	            alert.remove();
	        }, 300);
	    }
	}

	// 장바구니 폼 제출 이벤트 수정 (기존 폼 제출을 막고 검증 후 제출)
	$(document).ready(function() {
	    $('#cartForm').on('submit', function(e) {
	        e.preventDefault(); // 기본 제출 막기
	        
	        if (setSelectedOptions()) {
	            // 검증 통과시 폼 제출
	            this.submit();
	        }
	    });
	});

	
	
	// 위시리스트 확인 알림창 표시 함수
	function showWishlistConfirm() {
	    // 기존 알림창이 있다면 제거
	    const existingAlert = document.getElementById('wishlistConfirmAlert');
	    if (existingAlert) {
	        existingAlert.remove();
	    }

	    // 알림창 HTML 생성
	    const alertHtml = `
	        <div id="wishlistConfirmAlert" class="wishlist-confirm-overlay">
	            <div class="wishlist-confirm-box">
	                <div class="confirm-icon">🧡</div>
	                <div class="confirm-title">위시리스트 등록 완료</div>
	                <div class="confirm-message">위시리스트에 등록되었습니다.<br>위시리스트로 이동하시겠습니까?</div>
	                <div class="confirm-buttons">
	                    <button class="confirm-btn" onclick="goToWishlist()">이동하기</button>
	                    <button class="cancel-btn" onclick="closeWishlistConfirm()">취소</button>
	                </div>
	            </div>
	        </div>
	    `;

	    // body에 알림창 추가
	    document.body.insertAdjacentHTML('beforeend', alertHtml);

	    // 0.1초 후에 표시 (애니메이션 효과)
	    setTimeout(() => {
	        const alert = document.getElementById('wishlistConfirmAlert');
	        if (alert) {
	            alert.classList.add('show');
	        }
	    }, 100);
	}



	// 위시리스트로 이동 (폼 제출 방식)
	function goToWishlist() {
	    closeWishlistConfirm();
	    
	    // 위시리스트 폼을 직접 제출
	    document.getElementById('wishlistForm').submit();
	}
	
	

	// 알림창 닫기 함수
	function closeWishlistConfirm() {
	    const alert = document.getElementById('wishlistConfirmAlert');
	    if (alert) {
	        alert.classList.remove('show');
	        setTimeout(() => {
	            alert.remove();
	        }, 300);
	    }
	}

	// 수정된 submitWishlist 함수 - 기존 함수를 완전히 대체
	function submitWishlist() {
	    console.log('위시리스트 함수 시작');
	    
	    // 옵션 검증
	    var hasRequiredOptions = true;
	    var selectedOptions = [];
	    
	    $('.option-select').each(function() {
	        var selectedValue = $(this).val();
	        console.log('옵션 값:', selectedValue);
	        if (selectedValue && selectedValue !== '') {
	            selectedOptions.push(selectedValue);
	        } else if ($('.option-select').length > 0) {
	            hasRequiredOptions = false;
	        }
	    });
	    
	    // 옵션이 있는 상품인데 선택하지 않은 경우
	    if ($('.option-select').length > 0 && !hasRequiredOptions) {
	        showOptionAlert();
	        return false;
	    }
	    
	    // 수량 설정
	    var actualQuantity = document.getElementById('quantity').value;
	    document.getElementById('wishlistQuantity').value = actualQuantity;
	    console.log('설정된 수량:', actualQuantity);
	    
	    console.log('선택된 옵션들:', selectedOptions);
	    document.getElementById('wishlistSelectedOptions').value = JSON.stringify(selectedOptions);
	    console.log('설정된 JSON:', JSON.stringify(selectedOptions));
	    
	    // AJAX로 위시리스트에 즉시 등록
	    var formData = {
	        productNo: $('input[name="productNo"]').val(),
	        quantity: actualQuantity,
	        selectedOptions: JSON.stringify(selectedOptions)
	    };
	    
	    $.ajax({
	        url: "${pageContext.request.contextPath}/wishlist/wishlistadd",
	        type: "GET",
	        data: formData,
	        success: function(response) {
	            console.log('위시리스트 등록 성공');
	            // 등록 성공 후 확인 알림창 표시
	            showWishlistConfirm();
	        },
	        error: function(xhr, status, error) {
	            console.error('위시리스트 등록 실패:', error);
	            alert('위시리스트 등록에 실패했습니다. 다시 시도해주세요.');
	        }
	    });
	}

	// 위시리스트로 이동 함수 (확인 버튼 클릭 시)
	function goToWishlist() {
	    closeWishlistConfirm();
	    // 위시리스트 페이지로 이동 (이미 등록은 완료된 상태)
	    window.location.href = "${pageContext.request.contextPath}/funding/wish";
	}

	// 수정된 showWishlistConfirm 함수 (등록 완료 메시지)
	function showWishlistConfirm() {
	    // 기존 알림창이 있다면 제거
	    const existingAlert = document.getElementById('wishlistConfirmAlert');
	    if (existingAlert) {
	        existingAlert.remove();
	    }

	    // 알림창 HTML 생성 
	    const alertHtml = `
	        <div id="wishlistConfirmAlert" class="wishlist-confirm-overlay">
	            <div class="wishlist-confirm-box">
	                <div class="confirm-icon">🧡</div>
	                <div class="confirm-title">위시리스트 등록 완료</div>
	                <div class="confirm-message">위시리스트에 성공적으로 등록되었습니다.<br>위시리스트로 이동하시겠습니까?</div>
	                <div class="confirm-buttons">
	                    <button class="confirm-btn" onclick="goToWishlist()">이동하기</button>
	                    <button class="cancel-btn" onclick="closeWishlistConfirm()">계속 쇼핑</button>
	                </div>
	            </div>
	        </div>
	    `;

	    // body에 알림창 추가
	    document.body.insertAdjacentHTML('beforeend', alertHtml);

	    // 0.1초 후에 표시 (애니메이션 효과)
	    setTimeout(() => {
	        const alert = document.getElementById('wishlistConfirmAlert');
	        if (alert) {
	            alert.classList.add('show');
	        }
	    }, 100);
	}

	// 취소 버튼 클릭 시 - 알림창만 닫기 (이미 위시리스트에는 등록된 상태)
	function closeWishlistConfirm() {
	    const alert = document.getElementById('wishlistConfirmAlert');
	    if (alert) {
	        alert.classList.remove('show');
	        setTimeout(() => {
	            alert.remove();
	        }, 300);
	    }
	    // 추가: 등록 완료 간단 알림 (선택사항)
	    // alert('위시리스트에 등록되었습니다.');
	}
	
	

	</script>

</body>

</html>