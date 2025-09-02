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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
					<c:forEach items="${requestScope.fList}" var="vo">
	                    <div class="list-basic margin-10">	
	                        <div class="row-flex-box detail-list">
	                            <img class="img list-img-100" src="">
	                            <div class="column-flex-box">
	                                <div class="text-14">${vo.brand}</div>
	                                <div class="text-14">${vo.title}</div>
	                            </div>
	                        </div>
	                        <div class="between-flex-box detail-list">
	                            <div class="text-12">상품금액</div>
	                            <div class="text-14 bold"><fmt:formatNumber value="${vo.price}" type="currency" currencySymbol="" />원</div>
	                        </div>
	                    </div>
                	</c:forEach>
                	<div>
                		<input type="text" id="zipecode" placeholder="우편번호">
                		<input type="button" onclick="DaumZipcode()" value="우편번호 찾기">
                		<input type="text" id="address" placeholder="주소">
                		<input type="text" id="detailAddress" placeholder="상세주소">
                	</div>
                </div>
                <div class="right-main content-height">
                    <!-- 결제 폼 추가 -->
                    <form id="paymentForm">
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
                                <div class="text-14">총 상품금액(${total_percent}%)</div>
                                <div class="text-14"><fmt:formatNumber value="${total_amount}" type="currency" currencySymbol="" />원</div>
                            </div>
                        </div>
                        <div class="text-16 margin-10">최종 결제금액</div>

                        <button type="submit" id="paymentButton" class="btn-basic btn-orange size-large text-16 right-align"><fmt:formatNumber value="${total_amount}" type="currency" currencySymbol="" />원 결제하기</button>
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
			let cashReceiptSelected = false; // 현금영수증 선택 여부
			
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
				
				if(count % 2 != 0) {
					// 현금영수증 선택됨
					cashReceiptSelected = true;
					document.getElementById('cashReceipt').src = "/assets/icon/icon-check-confirm.jpg";
				} else {
					// 현금영수증 선택 해제됨
					cashReceiptSelected = false;
					document.getElementById('cashReceipt').src = "/assets/icon/icon-check.svg";
				}
			}
			
			
			//결제하기 버튼이 클릭 되었을 때
			document.getElementById('paymentForm').onsubmit = function(e) {
				e.preventDefault(); // 기본 폼 제출 방지
				
				console.log('결제버튼 클릭');
				
				// 결제 방식 선택 확인
				if(!paymentMethod) {
					alert('결제 방식을 선택해주세요');
					return false;
				}
				
				// AJAX로 전송할 데이터
				const paymentData = {
					funding_no: '${param.funding_no}',
					product_no: '${requestScope.product_no}', // 수정: requestScope에서 가져오기
					payment_method: paymentMethod,
					payment_amount: ${total_amount},
					quantity: '${param.count}',
					service_type: 'funding(' + cashReceiptSelected + ')',
				}
				
				console.log('결제 데이터:', paymentData);
				
				// AJAX 결제 요청
				fetch('/payment/checkout/api/funding', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json' // 수정: 올바른 Content-Type
					},
					body: JSON.stringify(paymentData)
				})
				.then(response => {
					if (!response.ok) {
						throw new Error('Network response was not ok');
					}
					return response.json();
				})
				.then(data => {
					if (data.success) {
						alert('결제가 완료되었습니다.');
						window.location.href = '/shop/success';
					} else {
						alert('결제 처리 중 오류가 발생했습니다: ' + (data.message || '알 수 없는 오류'));
						window.location.href = '/shop/error';
					}
				})
				.catch(error => {
					console.error('Error:', error);
					alert('결제 처리 중 오류가 발생했습니다.');
					window.location.href = '/shop/error';
				});
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
			
			function DaumZipcode() {
				new daum.Postcode({
					oncomplete: function(data){
						//팝업에서 검색결과 항목을 클릭했을 때 실행할 코드를 작성하는 부분
						
						//내려오는 변수가 값이 없는 경우에는 공백값을 가지므로 이를 참고하여 분기한다
						var addr = '';
						
						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('zipcode').value = data.zonecode;
		                document.getElementById("address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("detailAddress").focus();
					}
				}).open();
			}
		
		});
	</script>
</body>

</html>