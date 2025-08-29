<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/join.css">
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

				<form class="signup-form" action="${pageContext.request.contextPath}/user/join" method="get">
					<div class="form-group with-button">
						<label>아이디</label>
						<div class="input-row">
							<input type="text" placeholder="아이디 입력(6~20자)" name="id" id="input-id" required />
							<button type="button" value="중복 확인" id="duplicate-check">중복확인</button>
						</div>
						<p id="id-check-message"></p>
						<!-- 메시지 표시 영역 추가 -->
					</div>

					<div class="form-group">
						<label>비밀번호</label> <input type="password" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자)" name="password" id="pswd1" required />
					</div>

					<div class="form-group">
						<label>비밀번호 확인</label> <input type="password" placeholder="비밀번호 재입력" name="password2" id="pswd1" required />

					</div>

					<div class=" form-group">
						<label>이름</label> <input type="text" placeholder="이름을 입력해주세요" name="name" id="name-msg" required />

					</div>

					<div class="form-group">
						<label>전화번호</label> <input type="tel" placeholder="휴대폰 번호 입력('-' 제외 11자리 입력)" name="phone" required/>
					</div>

					<div class="form-group email-group">
						<label>이메일 주소</label>
						<div class="email-inputs">
							<input type="text" placeholder="이메일 주소" name="email" value=""> <span>@</span> <select>
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
		document.addEventListener('DOMContentLoaded', function() {
			const form = document.querySelector('.signup-form');
			const idInput = document.getElementById('input-id');

			const password1Input = document
					.querySelector('input[name="password1"]');
			const password2Input = document
					.querySelector('input[name="password2"]');
			const nameInput = document.querySelector('input[name="name"]');

			const password1Error = document.querySelector('.password1-error');
			const password2Error = document.querySelector('.password2-error');
			const nameError = document.querySelector('.name-error');

			// ✅ 아이디 한글 입력 방지
			idInput.addEventListener('input', function() {
				// 입력값에서 영어 대소문자와 숫자 외의 문자 제거
				const cleaned = idInput.value.replace(/[^a-zA-Z0-9]/g, '');

				// 변경된 값이 기존과 다르면 다시 세팅
				if (idInput.value !== cleaned) {
					idInput.value = cleaned;
				}
			});

			// ✅ 이름 숫자, 특수문자 입력 방지
			nameInput.addEventListener('input', function() {
				// 한글(가-힣), 영어(a-zA-Z)만 허용
				const cleaned = nameInput.value.replace(/[^a-zA-Z가-힣]/g, '');

				if (nameInput.value !== cleaned) {
					nameInput.value = cleaned;
				}
			});

			form.addEventListener('submit', function(e) {
				let isValid = true;

				// 비밀번호 1 검사
				if (!password1Input.value.trim()) {
					password1Input.classList.add('input-error');
					password1Error.style.display = 'block';
					isValid = false;
				} else {
					password1Input.classList.remove('input-error');
					password1Error.style.display = 'none';
				}

				// 비밀번호 2 검사
				if (!password2Input.value.trim()) {
					password2Input.classList.add('input-error');
					password2Error.style.display = 'block';
					isValid = false;
				} else {
					password2Input.classList.remove('input-error');
					password2Error.style.display = 'none';
				}

				// 이름 검사
				if (!nameInput.value.trim()) {
					nameInput.classList.add('input-error');
					nameError.style.display = 'block';
					isValid = false;
				} else {
					nameInput.classList.remove('input-error');
					nameError.style.display = 'none';
				}

				// 제출 막기
				if (!isValid) {
					e.preventDefault();
				}
			});

			// ------- 중복 아이디 체크 ---------------------------------------------- -->
			const existingIDs = [ '0603skfk', 'ahreum', 'sujin', 'nerunaru',
					'sunny', 'rrrr', 'Yunyoung0822', 'abn', 'gggg', 'roslina',
					'Yunyoung0905', 'roslina0901', 'dgh', 'hhhh', 'ahreum0123',
					'shya', 'nailshop', 'skfk0603', 'obs' ]; // 이미 등록된 ID
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
			// -------중복 아이디 체크---------------------------------------------- -->

		});
	</script>

</body>

</html>