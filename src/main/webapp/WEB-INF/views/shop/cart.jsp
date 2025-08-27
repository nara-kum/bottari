<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../../../assets/css/reset.css">
<link rel="stylesheet" href="../../../assets/css/Global.css">
<link rel="stylesheet" href="../../../assets/css/shop/cart.css">
<link rel="stylesheet" href="../../../assets/css/moduler.css">

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
					<div class="column-flex-box gap-10">
						<c:forEach items="${requestScope.cList}" var="vo">
							<div class="list-basic list-1280">
								<div class="between-flex-box">
									<div class="row-flex-box">
										<img class="list-img-100" src="${vo.itemimg}" alt="상품 이미지">
										<div class="column-flex-box gap-10 margin-5">
											<p class="text-16">${vo.brand}</p>
											<p class="item-name">${vo.title}</p>
											<p class="text-16 bold">${vo.price}원</p>
										</div>
									</div>
									<div class="row-flex-box">
										<div class="column-flex-box">
											<div class="btn-basic size-normal changeOptionBtn"
												data-cart-id="${vo.cart_no}">옵션 변경하기</div>

											<!-- 옵션 컨테이너 (처음에는 숨김) -->
											<div class="optionContainer" id="option-${vo.cart_no}"
												style="display: none;">
												<!-- 서버에서 미리 렌더링된 옵션들 -->
												<c:forEach items="${vo.optionList}" var="option">
													<label
														style="display: block; margin-bottom: 5px; font-weight: bold;">
														${option.option_name} </label>
													<select data-option-id="${option.option_no}"
														style="width: 100%; padding: 8px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 4px;">
														<c:forEach items="${option.detailList}" var="detail">
															<option value="${detail.detailoption_no}"
																<c:if test="${detail.isSelected}">selected</c:if>>
																${detail.detailoption_name}</option>
														</c:forEach>
													</select>
												</c:forEach>
											</div>
											<select class="btn-basic size-normal">
												<option>1개</option>
												<option>2개</option>
												<option>3개</option>
											</select> <select class="btn-basic size-normal">
												<option>기념일 선택</option>
												<option>생일</option>
												<option>결혼</option>
												<option>이벤트</option>
												<option>돌잔치</option>
											</select>
										</div>
										<div class="column-flex-box column-align size-normal">
											<label for="select">담기</label> <input type="checkbox"
												id="select">
										</div>
										<button class="btn-basic size-normal btn-orange column-align">삭제</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

					<!-- 총 금액 -->
					<div class="summary ">
						<div class="text-16">상품금액: 36,000원</div>
						<div class="text-16">배송비: 3,000원</div>
						<div class="text-18 bold">총 결제금액: 39,000원</div>
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

<!-- 
	<script>
		document.addEventListener('DOMContentLoaded', function(){
		    console.log('돔트리 완료');
		    
		    let currentOpenContainer = null;
		    
		    // changeOption이 클릭 되었을 때
		    document.querySelectorAll('.changeOptionBtn').forEach(btn => {
		        btn.addEventListener('click', function(e){
		            e.stopPropagation();
		            
		            const cartNo = this.dataset.cartId;
		            
		            // 기존에 열린 컨테이너가 있다면 닫기
		            if (currentOpenContainer) {
		                currentOpenContainer.style.display = 'none';
		                currentOpenContainer = null;
		            }
		            
		            // 해당 상품의 옵션 컨테이너 찾기
		            const optionContainer = document.getElementById('option-' + cartNo);
		            
		            if (optionContainer) {
		                // 컨테이너 표시
		                optionContainer.style.display = 'block';
		                optionContainer.style.cssText += `
		                    background: #f9f9f9;
		                    border: 1px solid #ddd;
		                    border-radius: 4px;
		                    padding: 15px;
		                    margin: 10px 0;
		                    position: relative;
		                    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
		                `;
		                
		                // 현재 열린 컨테이너 추적
		                currentOpenContainer = optionContainer;
		                
		                // 옵션 컨테이너 내부 클릭 시 이벤트 버블링 방지
		                optionContainer.addEventListener('click', function(e) {
		                    e.stopPropagation();
		                });
		            } else {
		                console.error('옵션 컨테이너를 찾을 수 없습니다:', 'option-' + cartNo);
		            }
		        });
		    });
		    
		    // 문서 전체 클릭 이벤트 (옵션 컨테이너 바깥 클릭 시 닫기)
		    document.addEventListener('click', function(e) {
		        if (currentOpenContainer && 
		            !e.target.classList.contains('changeOptionBtn') && 
		            !currentOpenContainer.contains(e.target)) {
		            
		            currentOpenContainer.style.display = 'none';
		            currentOpenContainer = null;
		        }
		    });
		    
		    // ESC 키로 옵션 컨테이너 닫기
		    document.addEventListener('keydown', function(e) {
		        if (e.key === 'Escape' && currentOpenContainer) {
		            currentOpenContainer.style.display = 'none';
		            currentOpenContainer = null;
		        }
		    });
		});
	</script>
	-->
</body>

</html>