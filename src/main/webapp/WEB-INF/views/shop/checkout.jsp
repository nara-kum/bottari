<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <!-- CDN(외부 사이트 프리셋) 리셋 css 대용-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    <!-- 난 외부링크 못 믿겠다! 하시는 분은 CDN을 삭제 or 주석처리 후 아래의 css링크 주석 해제 후 사용할것 -->
    <!-- <link rel="stylesheet" href="../Global_css/reset.css"> -->
    <link rel="stylesheet" href="/assets/css/Global.css"> <!-- 본인 파일의 경로에 맞게 수정해야함 -->
    <link rel="stylesheet" href="/assets/css/moduler.css"> <!-- 본인 파일의 경로에 맞게 수정해야함 -->
    <link rel="stylesheet" href="/assets/css/shop/check_out.css">
</head>

<body class="family">
    <!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
    <section class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <!-- 여기부터 코딩 시작!! -->
                <h2 class="header-sub">결제정보</h2>
            </div>
            <div class="sec-content-main">
                <div class="left-main content-height">
					<c:forEach items="${requestScope.pList}" var="vo">
	                    <div class="list-basic margin-10">	
	                        <div class="row-flex-box detail-list">
	                            <img class="img list-img-100" src="">
	                            <div class="column-flex-box">
	                                <div class="text-14">${vo.brand}</div>
	                                <div class="text-14">${vo.title}</div>
	                                <div class="text-12 gray">${vo.option_name}</div>
	                            </div>
	                        </div>
	                        <div class="between-flex-box detail-list">
	                            <div class="text-12">결제금액(${vo.quantity} 개)</div>
	                            <div class="text-14 bold"><fmt:formatNumber value="${vo.item_total}" type="currency" currencySymbol="" />원</div>
	                        </div>
	                    </div>
                	</c:forEach>
                </div>
                <div class="right-main content-height">
                    <div class="payment-method-box column-flex-box">
                        <div class="text-18 bold">결제수단</div>
                        <div class="list-basic between-flex-box">
                            <div class="row-flex-box">
                                <img class="button-icon" src="/assets/icon/icon-insert-credit-card.svg">
                                <div class="text-14 column-align">신용/체크카드 결제</div>
                            </div>
                            <img id="creditCard" class="button-icon" src="/assets/icon/icon-check.svg">
                        </div>
                        <div class="list-basic between-flex-box">
                            <div class="row-flex-box">
                                <img class="button-icon" src="/assets/icon/icon-mobile-hand.svg">
                                <div class="text-14 column-align">휴대폰 결제</div>
                            </div>
                            <img id="phone" class="button-icon" src="/assets/icon/icon-check.svg">
                        </div>
                        <div class="list-basic between-flex-box">
                            <div class="row-flex-box">
                                <img class="button-icon" src="/assets/icon/icon-money-from-bracket.svg">
                                <div class="text-14 column-align">무통장 입금</div>
                            </div>
                            <img id="deposit" class="button-icon" src="/assets/icon/icon-check.svg">
                        </div>
                    </div>
                    <div class="payment-method-box column-flex-box">
                    	<div class="between-flex-box">
                        	<div class="text-18 bold">현금영수증 신청</div>
                            	<img id="cashReceipt" class="button-icon" src="/assets/icon/icon-check.svg">
                            </div>
                        <div class="list-basic between-flex-box">
                            <div class="row-flex-box">
                                <div class="text-14 column-align">개인 소득공제(휴대폰)</div>
                            </div>
                            <div class="text-14 column-align">휴대폰번호</div>
                        </div>
                        <div class="text-12 row-align"> 현금 영수증은 무통장입금, 현금성 포인트와 같은 현금성 결제 수단을 이용한 거래에 한 해 결제가 완료된 시점의 최신
                            정보를 기반으로 발행되요.</div>
                    </div>
                    <div class="payment-method-box">
                        <div class="text-18 bold margin-10">결제정보</div>
                        <div class="between-flex-box margin-10 row-align">
                            <div class="text-14">총 상품금액(<fmt:formatNumber value="${total_quantity}" type="currency" currencySymbol="" />개)</div>
                            <div class="text-14"><fmt:formatNumber value="${total_amount}" type="currency" currencySymbol="" />원</div>
                        </div>
                        <div class="between-flex-box margin-10 row-align">
                            <div class="text-14">배송비</div>
                            <div class="text-14"><fmt:formatNumber value="${shipping_cost}" type="currency" currencySymbol="" />원</div>
                        </div>
                    </div>
                    <div class="text-16 margin-10">최종 결제금액</div>
					<form id="paymentForm" action="${pageContext.request.contextPath}/checkout/payment" method="post">
						<!-- 카트번호 -->
						<input type="hidden" name="cart_no" value="${param.cart_no}">
						<!-- 결제 수단 -->
						<input type="hidden" name="paymentMethod" id="hiddenPaymentMethod">
						<!-- 현금 영수증 여부 -->
						<input type="hidden" name="cashReceiptRequested" id="hiddenCashReceipt" value="false">
						<!-- 최종 결제 가격 -->
						<input type="hidden" name="totalAmount" value="${final_amount}">
						<!-- 총 갯수 (오타 수정: totalQuantitiy -> totalQuantity) -->
						<input type="hidden" name="totalQuantity" value="${total_quantity}">
						<!-- 배달요금 -->
						<input type="hidden" name="shippingCost" value="${shipping_cost}">
						
						<c:forEach items="${requestScope.pList}" var="vo">
							<input type="hidden" name="productId" value="${vo.product_no}">	
							<input type="hidden" name="quantity" value="${vo.quantity}">	
							<input type="hidden" name="itemTotal" value="${vo.item_total}">	
						</c:forEach>
						
                    	<button type="submit" id="paymentButton" class="btn-basic btn-orange size-large text-16 right-align">
                    		<fmt:formatNumber value="${final_amount}" type="currency" currencySymbol="" />원 결제하기
                    	</button>
					</form>
                </div>
            </div>
        </div>
    </section>
    <!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
	
	<script>
		document.addEventListener('DOMContentLoaded', function(){
			console.log('돔트리 완료');
			
			let paymentMethod = null;
			let prevButton = null;
			let count = 0;
			
			// 결제 방식 Id 배열
			const paymentButtons = ['creditCard', 'phone', 'deposit'];
			
			// 신용/체크카드 결제 버튼이 클릭 되었을 때
			document.getElementById('creditCard').onclick = function() {
				console.log('detected creditCard button clicked');
				
				resetAllButtons();
				
				paymentMethod = 'creditCard';
				clickedButton();
			}
			
			// 휴대전화 결제 버튼이 클릭 되었을 때
			document.getElementById('phone').onclick = function() {
				console.log('detected phone button clicked');
				
				resetAllButtons();
				
				paymentMethod = 'phone';
				clickedButton();
			}
			
			// 무통장 입금 버튼이 클릭 되었을 때
			document.getElementById('deposit').onclick = function()	{
				console.log('detected deposit button clicked');
				
				resetAllButtons();
				
				paymentMethod = 'deposit';
				clickedButton();
			}
			
			// 현금영수증 버튼이 클릭 되었을 때
			document.getElementById('cashReceipt').onclick = function() {
				console.log('detected cashReceipt button clicked');
				
				count++;
				
				// cashReceipt는 paymentMethod가 아님
				if(count % 2 !== 0) {
					// 체크 상태
					const cash = document.getElementById('cashReceipt');
					cash.src = "/assets/icon/icon-check-confirm.jpg";
				} else {
					// 체크 해제 상태
					const cash = document.getElementById('cashReceipt');
					cash.src = "/assets/icon/icon-check.svg";
				}
			}
			
			// 결제하기 버튼이 클릭 되었을 때 (오타 수정: ducument -> document)
			document.getElementById('paymentForm').onsubmit = function(e) {
				e.preventDefault();
				
				console.log('결제버튼 클릭');
				console.log('=== 폼 전송 전 값 확인 ===');
			    console.log('paymentMethod:', paymentMethod);
			    console.log('count:', count);
			    console.log('cashReceipt 계산값:', (count % 2 !== 0));
			    
			    // 모든 hidden input 값들 확인
			    const form = this;
			    const formData = new FormData(form);
			    for(let [key, value] of formData.entries()) {
			        console.log(key + ':', value, '(길이:', value.length, ')');
			    }
				
				// 결제 방식 선택 확인
				if(!paymentMethod || paymentMethod === 'cashReceipt') {
					alert('결제 방식을 선택해주세요');
					return false;
				}
				
				// 폼 데이터 설정 (오타 수정: hiddenPaymentmethod -> hiddenPaymentMethod)
				document.getElementById('hiddenPaymentMethod').value = paymentMethod;
				document.getElementById('hiddenCashReceipt').value = (count % 2 !== 0) ? 'true' : 'false';
				
				// 설정 후 값 확인
				console.log('=== 값 설정 후 ===');
				console.log('hiddenPaymentMethod.value:', document.getElementById('hiddenPaymentMethod').value);
				console.log('hiddenCashReceipt.value:', document.getElementById('hiddenCashReceipt').value);
				
				// 폼 전송
				this.submit();
				
				return false;
			}
			
			// check.svg 가 클릭 되었을 때의 함수
			function clickedButton() {
				console.log('clickedButton()');
				
				const changeButtonDiv = document.getElementById(paymentMethod);
				
				if(changeButtonDiv) {
					changeButtonDiv.src = "/assets/icon/icon-check-confirm.jpg";
					prevButton = paymentMethod;
				}
			}
			
			// 모든 버튼의 상태를 원래대로 돌려놓는 함수
			function resetAllButtons() {
				paymentButtons.forEach(function(buttonId) {
					const button = document.getElementById(buttonId);
					if(button) {
						button.src = "/assets/icon/icon-check.svg"
					}
				});
			}
		});
	</script>
</body>

</html>