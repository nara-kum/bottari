<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
			<h2 class="header-sub">회원가입</h2>
		</div>
		<div class="sec-content-main">
			<main class="signup-container">
				<p class="subtitle">회원이 되어 다양한 혜택을 경험해 보세요!</p>

				<form class="signup-form" action="${pageContext.request.contextPath}/join" method="get">
					<div class="form-group with-button">
						<label>아이디</label>
						<div class="input-row">
							<input type="text" placeholder="아이디 입력(6~20자)" name="id" id="input-id" value="">
							<button type="button" value="중복 확인" id="duplicate-check">중복확인</button>
						</div>
						<p id="id-check-message"></p>
						<!-- 메시지 표시 영역 추가 -->
					</div>

					<div class="form-group">
						<label>비밀번호</label> <input type="password" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자)" />
					</div>

					<div class="form-group">
						<label>비밀번호 확인</label> <input type="password" placeholder="비밀번호 재입력" />
					</div>

					<div class="form-group">
						<label>이름</label> <input type="text" placeholder="이름을 입력해주세요" />
					</div>

					<div class="form-group">
						<label>전화번호</label> <input type="tel" placeholder="휴대폰 번호 입력('-' 제외 11자리 입력)" />
					</div>

					<div class="form-group email-group">
						<label>이메일 주소</label>
						<div class="email-inputs">
							<input type="text" placeholder="이메일 주소" /> <span>@</span> <select>
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
						<button type="submit" class="submit-btn">회원가입</button>
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
		function checkDuplicateID(id) {
			const existingIDs = [ '0603skfk', 'ahreum', 'sujin', 'nerunaru',
					'sunny', 'aaaaaaaa', 'idksbhkbdh' ];
			return existingIDs.includes(id.trim());
		}

		document.addEventListener('DOMContentLoaded', function() {
			const existingIDs = [ '0603skfk', 'ahreum', 'sujin', 'nerunaru',
					'sunny', 'aaaaaaaa', 'idksbhkbdh' ]; // 이미 등록된 ID
			const input = document.getElementById('input-id');
			const button = document.getElementById('duplicate-check');
			const message = document.getElementById('id-check-message');

			button.addEventListener('click', function() {
				const enteredID = input.value.trim();

				if (enteredID === '') {
					message.textContent = '아이디를 입력해주세요.';
					message.style.color = 'red';
					return;
				}

				if (existingIDs.includes(enteredID)) {
					message.textContent = '중복 아이디입니다';
					message.style.color = 'red';
				} else {
					message.textContent = '사용 가능한 아이디입니다';
					message.style.color = 'green';
				}
			});
		});
	</script>
</body>

</html>