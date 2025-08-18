<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<!-- CDN(외부 사이트 프리셋) 리셋 css 대용-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />

<!-- global.css호출 -->
<link rel="stylesheet" href="/assets/css/Global.css">
<!-- 본인 파일의 경로에 맞게 수정해야함 -->

<!-- sweetalert cdn 호출 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- full_calender 호출 -->
<link href='/assets/css/calender/main.css' rel='stylesheet' />
<script src='/assets/js/main.js'></script>

<!-- local css 호출-->
<link rel="stylesheet"
	href="/assets/css/calender/calender_stylesheet.css">
<link rel="stylesheet" href="/assets/css/calender/all_in_one.css">
<!-- 본인 파일의 경로에 맞게 수정해야함 -->
<link rel="stylesheet" href="/assets/css/calender/moduler.css">
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
					src="/assets/icon/icon-shopping-cart.svg"></a>
				<h1 class="header-usermenu">사용자이름</h1>
				<a href=""><img class="header-icon"
					src="/assets/icon/icon-caret-down.svg"></a>
			</div>
		</div>
	</header>
	<section class="controller">
	<div id="sec-content" class="sector">
		<div class="sec-sub-title">
			<!-- 여기부터 코딩 시작!! -->
			<div class="between-flex-box">
				<h2 class="header-sub">캘린더</h2>
				<div id="date-info" class="header-sub"></div>
			</div>
		</div>
		<div class="sec-content-main">
			<div class="left-main content-height">
				<div id='calendar'></div>
			</div>
			<div class="right-main content-height">
				<div id="event-info"></div>
			</div>
		</div>



	</div>
	</section>
	<footer class="controller">
		<div id="sec-footer" class="sector">
			<div class="footer-links">
				<a href="#terms">이용약관</a> | <a href="#privacy">개인정보처리방침</a> | <a
					href="#exchange">교환/반품 안내</a> | <a href="#faq">자주 묻는 질문</a> | <a
					href="#contact">1:1 문의</a>
			</div>
			<div class="company-info">
				<p>
					<span class="company-name">상호: 주식회사 보따리</span> | <span
						class="company-name">대표: 김보따리</span> | <span>사업자등록번호:
						123-45-67890</span> | <span>통신판매업신고: 제2025-서울강동-0001</span>
				</p>
				<p class="contact-info">주소: 서울특별시 강동구 천호대로 1027, 5층 | 고객센터:
					02-1234-5678</p>
				<p class="contact-info">운영시간: 평일 10:00 ~ 18:00 (점심시간
					12:00~13:00)</p>
			</div>

			<div class="copyright">
				<p>© 2025 bottari.com. All rights reserved.</p>
			</div>
		</div>
	</footer>


	<script>
        // 전역에서 클릭된 날짜를 저장하는 변수
        let lastClickedDate = null;

        // 클릭된 날짜를 설정하는 전역 함수
        function setClickedDate(dateStr) {
			console.log('현재 날짜: ' + dateStr);
            lastClickedDate = dateStr;
        }

        function getClickedDate() {
			console.log('debug:return lastClickedDate');
            return lastClickedDate;
        }

        document.addEventListener('DOMContentLoaded', function () {
			console.log('돔트리 완료');
		
            let lastClickTime = 0;
            let selectedEventId = null; // 삭제할 이벤트 추적용

            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prevYear,prev today',
                    center: 'title',
                    right: 'next,nextYear'
                },

                // 타이틀 포맷 변경
                titleFormat: {
                    year: 'numeric',
                    month: 'short'
                },

             	// 날짜 드래그(범위 선택) 비활성화
                selectable: false,
                
                selectMirror: true,
                
                // 클릭시 창 변경 제한
                navLinks: false,
                
                editable: true,
                dateClick: function (info) {
					console.log('debug: detected click date');
                    document.getElementById('event-info').style.display = 'none';
                    document.getElementById('event-info').innerHTML = '';
                    setClickedDate(info.dateStr);

                    const events = calendar.getEvents().filter(ev => ev.startStr.startsWith(info.dateStr));
                    showDateInfo(info.dateStr, events.length > 0); // ← 항상 날짜 출력 함수 호출
					
                    if (events.length > 0) {
                        showEventInfo(events[0], info.dateStr);
                    } else {
                        showNoEventInfo(info.dateStr);
                    }
                    lastClickTime = new Date().getTime();

                    document.querySelectorAll('.fc-daygrid-day').forEach(cell => {
                        cell.style.backgroundColor = '';
                        cell.querySelector('.fc-daygrid-day-number').style.color = '';
                    });

                    const clickedCell = document.querySelector('.fc-daygrid-day[data-date="'+info.dateStr+'"]');
                    if (clickedCell) {
						console.log('debug: detected changed color');
                        clickedCell.style.backgroundColor = '#EF5327';
                        const dayNumber = clickedCell.querySelector('.fc-daygrid-day-number');
                        if (dayNumber) {
                            dayNumber.style.color = '#fff';
                        }
                    }
                },
                eventClick: function (arg) {
					console.log('debug: detected click event');

					let title = arg.event.title;
					let day = arg.event.start;
					
                    showEventInfo(title, day);
                },
                dayMaxEvents: true,
                
                //임시 이벤트들
                events: [
                    {
                        id: '1',
                        title: '임시 이벤트',
                        start: '2025-08-15'
                    },

                    {
                        id: '2',
                        title: '회의',
                        start: '2025-08-15'
                    },

                    {
                        id: '4',
                        title: '프로젝트 마감',
                        start: '2025-08-18'
                    },

                    {
                        id: '3',
                        title: '미팅',
                        start: '2025-08-20'
                    }
                ]
            });

            calendar.render();

            // 오늘 날짜에 이벤트가 있으면 우측에 출력
            const todayStr = new Date().toISOString().slice(0, 10); // YYYY-MM-DD 형식
            setClickedDate(todayStr); // 오늘 날짜를 클릭된 날짜로 설정

            const todayEvents = calendar.getEvents().filter(ev => ev.startStr.startsWith(todayStr));
            if (todayEvents.length > 0) {
				console.log('debuge: there is event here')
                showDateInfo(todayStr, true);   // 이벤트 있음
                showEventInfo(todayEvents[0], todayStr);
                setTimeout(() => {
                    document.querySelectorAll('.fc-daygrid-day').forEach(cell => {
                        cell.style.backgroundColor = '';
                        cell.querySelector('.fc-daygrid-day-number').style.color = '';
                    });
                    const clickedCell = document.querySelector('.fc-daygrid-day[data-date="'+todayStr+'"]');
                    if (clickedCell) {
                        clickedCell.style.backgroundColor = '#EF5327';
                        const dayNumber = clickedCell.querySelector('.fc-daygrid-day-number');
                        if (dayNumber) {
                            dayNumber.style.color = '#fff';
                        }
                    }
                }, 10);
            } else {
                showDateInfo(todayStr, false);  // 이벤트 없음
                showNoEventInfo(todayStr);
            }

            // --- 전역 함수로 분리 ---

            // 날짜 출력 전역함수
            function showDateInfo(dateStr, hasEvent) {
				console.log('debug: detect change date(날짜 변경 감지)');
                const dateInfoDiv = document.getElementById('date-info');
                if (hasEvent) {

                	let htmlStr = '';
                	htmlStr += '<div class="between-flex-box">';
                	htmlStr += '	<div class="header-sub">'+dateStr+'</div>';
                	htmlStr += '	<div class="row-flex-box">';
                	htmlStr += '		<img class="popup-icon create-event-btn" src="../../../assets/icon/icon-add.svg">';
                	htmlStr += '		<img id="edit-event-btn" class="popup-icon" src="../../../assets/icon/icon-menu-dots.svg">';
                	htmlStr += '	</div>';
                	htmlStr += '</div>';
                	htmlStr += '';
                	
                    dateInfoDiv.innerHTML = htmlStr;
  
                } else {
                	let htmlStr = '';
                	htmlStr += '<div class="between-flex-box">';
                	htmlStr += '	<div class="header-sub">'+dateStr+'</div>';
                	htmlStr += '	<div class="row-flex-box">';
                	htmlStr += '		<img class="popup-icon create-event-btn" src="../../../assets/icon/icon-add.svg">';
                	htmlStr += '	</div>';
                	htmlStr += '</div>';
                	htmlStr += '';
                	
                    dateInfoDiv.innerHTML = htmlStr;
                }
                dateInfoDiv.style.display = 'block';

                document.querySelector('#date-info .create-event-btn').onclick = function () {
                    openScheduleModal(dateStr);
                };
                // edit-event-btn이 있을 때만 이벤트 등록
                const editBtn = document.getElementById('edit-event-btn');
                if (editBtn) {
                    editBtn.onclick = function () {
                        openEditScheduleModal(calendar.getEventById(selectedEventId));
                    }
                }
            }

            //이벤트가 있을 때
            function showEventInfo(title, day) {
				console.log('debug: detect event');
                const eventInfoDiv = document.getElementById('event-info');
                
                let htmlStr = '';
                htmlStr += '<div class="event-detail-area">';
                htmlStr += '	<div class="row-flex-box">'
                htmlStr += '		<img class="middle-icon" src="../../../assets/icon/icon-cake-birthday.svg">'
                htmlStr += '		<div class="column-flex-box event-detail">'
                htmlStr += '			<div class="text-16 bold">'+title+'</div>'
                htmlStr += '			<div class="text-14">내 생일이다. 친구들과 함께 생일 파티를 즐길 것이다</div>'
                htmlStr += '		</div>'
                htmlStr += '	</div>'
                htmlStr += '</div>'
                htmlStr += '<div class="column-flex-box celebrate-card-area row-align no-event">'
                htmlStr += '	<img class="middle-icon" src="../../../assets/icon/icon-cross.svg" />'
                htmlStr += '	<div class="text-18">초대장이 없어요</div>'
                htmlStr += '	<button class="btn-basic btn-orange size-normal ">초대장 만들기</button>'
                htmlStr += '</div>'
                htmlStr += '<div class="column-flex-box celebrate-card-area row-align no-event">'
                htmlStr += '	<img class="middle-icon" src="../../../assets/icon/icon-cross.svg" />'
                htmlStr += '	<div class="text-18">펀딩 리스트가 비었어요</div>'
                htmlStr += '	<button class="btn-basic btn-orange size-normal">펀딩 관리하기</button>'
                htmlStr += '</div>'
                htmlStr += '<div class="ad-banner">'
                htmlStr += '	<a href="">'
                htmlStr += '		<img src="">'
                htmlStr += '	</a>'
                htmlStr += '</div>'
                htmlStr += '<div class="history-gift disable"></div>'
                htmlStr += ''
                
                eventInfoDiv.innerHTML = htmlStr;
                
                eventInfoDiv.style.display = 'block';
            }

            // 이벤트가 없을 때
            function showNoEventInfo(dateStr) {
				const eventInfoDiv = document.getElementById('event-info');
                eventInfoDiv.innerHTML = `
                	<div class="no-event">
                    <img class="middle-icon" src="../../../assets/icon/icon-calendar-exclamation.svg" />
                    <div class="text-18">등록된 기념일이 없어요</div>
                    <button class="btn-basic btn-orange size-normal create-event-btn">기념일 등록하기</button>
                </div>
                `;
                eventInfoDiv.style.display = 'block';
                selectedEventId = null;
                
             	// "기념일 등록하기" 버튼 클릭 시 일정 추가 팝업 호출
                document.querySelector('#event-info .create-event-btn').onclick = function () {
					console.log('기념일 등록하기');
                    openScheduleModal(dateStr);
                };
            }
            // --- 전역 함수로 분리 끝 ---

            // 삭제 함수 (구현 필요)
            function deleteSelectedEvent() {
				console.log
                if (!selectedEventId) return;
                const event = calendar.getEventById(selectedEventId);
                if (event) {
                    Swal.fire({
                        text: "이 이벤트를 삭제하시겠습니까?",
                        icon: "warning",
                        showCancelButton: true,
                        buttonsStyling: false,
                        confirmButtonText: "네, 삭제합니다!",
                        cancelButtonText: "아니오",
                        customClass: {
                            confirmButton: "btn btn-primary",
                            cancelButton: "btn btn-active-light"
                        }
                    }).then(function (result) {
                        if (result.value) {
                            event.remove();
                            document.getElementById('event-info').style.display = 'none';
                            document.getElementById('event-info').innerHTML = '';
                            selectedEventId = null;
                        }
                    });
                }
            }

            // 일정 추가 팝업 함수(구현 필요)
            function openScheduleModal(dateStr) {

                Swal.fire({
					html: `
				            <div id="event-add-popup">
				                <div class="cancel">
				                    <button id="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../../assets/icon/icon-cross.svg"></button>
				                </div>
				                <div class="event-name">
				                    <div class="event-icon-box">
				                        <img class="popup-icon" src="../../../assets/icon/assets/icon-interrogation.svg">
				                        <img class="popup-icon" src="../../../assets/icon/assets/icon-caret-down.svg">
				                    </div>
				                    <div class="event-name-box">
				                        <input name="eventName" class="input-name" placeholder="일정 제목">
				                    </div>
				                </div>              
				                <div class="event-comment">
				                    <img class="popup-icon" src="../../../assets/icon/assets/icon-comment.svg">
				                    <textarea class="input-comment" placeholder="메모 입력"></textarea>
				                </div>
				                <button id="event-save-btn" class="btn-save" type="button">저장</button>
				            </div>
				        	`,
                    showCancelButton: false,
                    showConfirmButton: false,

                    showClass: {
                        popup: ''
                    },
                    hideClass: {
                        popup: ''
                    },

                    didOpen: () => {
                        // 저장 버튼 클릭 이벤트
                        document.querySelector('.btn-save').addEventListener('click', () => {
                            const title = document.querySelector("input[name='eventName']").value;
                            const explanation = document.querySelector(".input-comment").value;
                            if (title && title.trim()) {
                                try {
                                    const newEvent = calendar.addEvent({
                                        title: title,
                                        start: dateStr,
                                        allDay: true,
                                        extendedProps: {
                                            explanation: explanation
                                        }
                                    });
                                    console.log('이벤트 생성 성공:', newEvent);
                                } catch (error) {
                                    console.error('이벤트 생성 실패:', error);
                                }
                            } else {
                                console.log('제목이 비어있습니다');
                            }
                            Swal.close();
                        });

                        // 닫기 버튼 클릭 이벤트
                        document.querySelector('.btn-cancel').addEventListener('click', () => {
                            Swal.close();
                        });
                    }
                });
            }

            // 일정 수정 팝업 함수(구현 필요)
            function openEditScheduleModal(event) {
                // event: FullCalendar의 이벤트 객체
                Swal.fire({
                    html: `
            <div id="event-edit-popup">
                <div class="cancel">
                    <button name="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../../assets/icon/icon-cross.svg"></button>
                </div>
                <div class="event-name">
                    <div class="event-icon-box">
                        <img class="popup-icon" src="../../../assets/icon/icon-interrogation.svg">
                        <img class="popup-icon" src="../../../assets/icon/icon-caret-down.svg">
                    </div>
                    <div class="event-name-box">
                        <input name="eventName" class="input-name" placeholder="일정 제목" value='"'+event.title+'"'>
                    </div>
                </div>              
                <div class="event-comment">
                    <img class="popup-icon" src="../../../assets/icon/icon-comment.svg">
                    <textarea class="input-comment" placeholder="메모 입력">event.extendedProps && event.extendedProps.explanation ? event.extendedProps.explanation : ''</textarea>
                </div>
                <button name="event-save-btn" class="btn-save" type="button">저장</button>
            </div>
        `,
                    showCancelButton: false,
                    showConfirmButton: false,
                    didOpen: () => {
                        // 저장 버튼 클릭 이벤트
                        document.querySelector('.btn-save').addEventListener('click', () => {
                            const title = document.querySelector("input[name='eventName']").value;
                            const explanation = document.querySelector(".input-comment").value;

                            if (title && title.trim()) {
                                try {
                                    event.setProp('title', title);
                                    event.setExtendedProp('explanation', explanation);
                                    console.log('이벤트 수정 성공:', event);
                                } catch (error) {
                                    console.error('이벤트 수정 실패:', error);
                                }
                            } else {
                                console.log('제목이 비어있습니다');
                            }
                            Swal.close();
                        });

                        // 닫기 버튼 클릭 이벤트
                        document.querySelector('.btn-cancel').addEventListener('click', () => {
                            Swal.close();
                        });
                    }
                });
            }
        });
    </script>
</body>

</html>