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
											<img class="list-img-100" src="${vo.itemimg}"
												alt="상품 이미지">
											<div class="column-flex-box gap-10 margin-5">
												<p class="text-16">${vo.brand}</p>
												<p class="item-name">${vo.title}</p>
												<p class="text-16 bold">${vo.price}원</p>
											</div>
										</div>
										<div class="row-flex-box">
											<div class="column-flex-box">
												<select class="btn-basic size-normal">
													<option>옵션 변경</option>
													<option>선택 안함</option>
													<option>옵션 A</option>
													<option>옵션 B</option>
												</select> 
												<select class="btn-basic size-normal">
													<option>1개</option>
													<option>2개</option>
													<option>3개</option>
												</select> 
												<select class="btn-basic size-normal">
													<option>기념일 선택</option>
													<option>생일</option>
													<option>결혼</option>
													<option>이벤트</option>
													<option>돌잔치</option>
												</select>
											</div>
											<div class="column-flex-box column-align size-normal">
												<label for="select">담기</label>
												<input type="checkbox" id="select">
											</div>
											<button class="btn-basic size-normal btn-orange column-align">삭제</button>
										</div>
									</div>
								</div>
						</c:forEach>
					</div>

					<!-- 총 금액 -->
					<div class="summary ">
						<div class="text-16">
							상품금액: 36,000원
						</div>
						<div class="text-16">
							배송비: 3,000원
						</div>
						<div class="text-18 bold">
							총 결제금액: 39,000원
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