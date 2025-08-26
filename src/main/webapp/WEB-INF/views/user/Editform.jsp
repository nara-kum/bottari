<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>
		<html lang="ko">

		<head>
			<meta charset="UTF-8">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/join.css">

			<!--js-->
			<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js">

			</script>

		</head>

		<body class="family">

			<!------------------------ Header호출 ----------------------->
			<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
			<!-- ---------------------------------------------------- -->

			<content class="controller">
				<div id="sec-content" class="sector">
					<div class="sec-sub-title">
						<h2 class="header-sub">회원정보수정</h2>
					</div>
					<div class="sec-content-main">
						<main class="signup-container">
							<p class="subtitle">회원정보수정!!</p>

							<form class="signup-form" action="${pageContext.request.contextPath}/edit" method="get">
								<div class="form-group with-button">
									<label>아이디</label>
									<div class="input-row">
										${requestScope.userVO.id} <input type="hidden" name="id"
											value="${requestScope.userVO.id}">
									</div>
								</div>

								<div class="form-group">
									<label>비밀번호</label> <input id="txt-pwd" type="password" name="password"
										value="${requestScope.userVO.password}">
								</div>

								<div class="form-group">
									<label>이름</label> <input id="txt-name" type="text" name="name"
										value="${requestScope.userVO.name}">
								</div>

								<div class="form-group">
									<label>전화번호</label> <input type="txt-tel" name="phone"
										value="${requestScope.userVO.phone}">
								</div>

								<div class="form-group email-group">
									<label>이메일 주소</label>
									<div class="email-inputs">
										<input type="text" placeholder="이메일 주소" name="email"
											value="${requestScope.userVO.email}"> <span>@</span> <select>
											<option>naver.com</option>
											<option>gmail.com</option>
											<option>daum.net</option>
											<option>hanmail.net</option>
											<option>hotmail.com</option>
											<option>yahoo.com</option>
										</select>
									</div>
								</div>

								<div class="form-group birth-group">
									<label>생년월일</label>
									<div class="date-selects">
										<select>
											<option>년도</option>
											<option>2005</option>
											<option>2004</option>
											<option>2003</option>
											<option>2002</option>
											<option>2001</option>
											<option>2000</option>
											<option>1999</option>
											<option>1998</option>
											<option>1997</option>
											<option>1996</option>
											<option>1995</option>
											<option>1994</option>
											<option>1993</option>
											<option>1992</option>
											<option>1991</option>
											<option>1990</option>
										</select> <select>
											<option>월</option>
											<option>1월</option>
											<option>2월</option>
											<option>3월</option>
											<option>4월</option>
											<option>5월</option>
											<option>6월</option>
											<option>7월</option>
											<option>8월</option>
											<option>9월</option>
											<option>10월</option>
											<option>11월</option>
											<option>12월</option>
										</select> <select>
											<option>일</option>
											<option>1일</option>
											<option>2일</option>
											<option>3일</option>
											<option>4일</option>
											<option>5일</option>
											<option>6일</option>
											<option>7일</option>
											<option>8일</option>
											<option>9일</option>
											<option>10일</option>
											<option>11일</option>
											<option>12일</option>
											<option>13일</option>
											<option>14일</option>
											<option>15일</option>
											<option>16일</option>
											<option>17일</option>
											<option>18일</option>
											<option>19일</option>
											<option>20일</option>
											<option>21일</option>
											<option>22일</option>
											<option>23일</option>
											<option>24일</option>
											<option>25일</option>
											<option>26일</option>
											<option>27일</option>
											<option>28일</option>
											<option>29일</option>
											<option>30일</option>
											<option>31일</option>
										</select>
									</div>
								</div>


								<div class="form-buttons">
									<button type="submit" class="submit-btn">수정</button>
									<button type="button" class="cancel-btn">취소</button>
								</div>
							</form>
						</main>

					</div>
				</div>
			</content>

			<!------------------------ Footer호출 ----------------------->
			<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
			<!-- ---------------------------------------------------- -->

			<script>
				//돔트리가 완료되었을(때 ------> 이벤트)
				$(document).ready(function () {
					console.log('돔트리완료');

					$("div[class='submit-btn']").click(function(){
						var submit = ".submit-btn" + $(this).attr("class").substr(8,1);
						$(submit).attr("aria-expanded", "false");
						var submitToolTip = $(submit + "ToolTip");
						submitToolTip.attr("aria-hidden","true");
						submitToolTip.css("display","none");
					})


				});	
			</script>
		</body>


		</html>