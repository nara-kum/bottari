<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <title>Calendar - v7</title> <!-- 버전 표시 -->
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

	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<section class="controller">
		<div id="sec-content" class="sector">
			<div class="sec-sub-title">
				<!-- 여기부터 코딩 시작!! -->
				<div class="between-flex-box">
					<h2 class="header-sub">캘린더</h2>
					<div id="date-info" class="header-sub"></div>
				</div>
			</div>
			<c:choose>
				<c:when test="${sessionScope.authUser.userNo == null}">
					<script>
						alert("로그인이 필요합니다.");
	            		window.location.href = "/loginForm";  // 로그인 페이지 경로 맞게 수정하세요
					</script>
				</c:when>
				<c:otherwise>
					<div class="sec-content-main">
						<div class="left-main content-height">
							<div id='calendar'></div>
						</div>
						<div class="right-main content-height">
							<div id="event-info"></div>
							<div id="event-details-info"></div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>



		</div>
	</section>
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->


	<script>
        // 전역에서 클릭된 날짜를 저장하는 변수
        let lastClickedDate = null;
        let selectedEventId = null;

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
    const eventDetailDiv = document.getElementById('event-details-info'); // v6: 이벤트 상세 div 참조 추가
			console.log('돔트리 완료');
		
            let lastClickTime = 0;

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
                
                editable: false,
                
            	 // 이벤트 렌더링 커스터마이징
                eventContent: function (arg) {
                    const icon = arg.event.extendedProps.icon;
                    let iconSrc = '';

                    // 아이콘 타입에 따른 이미지 경로 설정
                    switch (icon) {
                        case 'birthday':
                            iconSrc = '../../../assets/icon/icon-cake-birthday.svg';
                            break;
                        case 'wedding':
                            iconSrc = '../../../assets/icon/icon-rings-wedding.svg';
                            break;
                        case 'thanks':
                            iconSrc = '../../../assets/icon/icon-hand-holding-heart.svg';
                            break;
                        case 'baby':
                            iconSrc = '../../../assets/icon/icon-child-head.svg';
                            break;
                        case 'event':
                            iconSrc = '../../../assets/icon/icon-glass-cheers.svg';
                            break;
                        case 'celebrate':
                            iconSrc = '../../../assets/icon/icon-party-horn.svg';
                            break;
                        default:
                            iconSrc = '../../../assets/icon/icon-interrogation.svg';
                    }

                 	// 커스텀 HTML 반환
                    return {
                        html: '<div class="custom-event">' +
                              '<img src="' + iconSrc + '" class="event-icon" />' +
                              '<span class="event-title">' + arg.event.title + '</span>' +
                              '</div>'
                    };
                },
                
                dateClick: function (info) {
                    console.log('debug: detected click date');
                    document.getElementById('event-info').style.display = 'none';
                    document.getElementById('event-info').innerHTML = '';
                    setClickedDate(info.dateStr);

                    const events = calendar.getEvents().filter(ev => ev.startStr.startsWith(info.dateStr));
                    showDateInfo(info.dateStr, events.length > 0);
                    
                    if (events.length > 0) {
                        // 수정: events[0] 대신 events[0].title과 events[0].start 전달
                        const firstEvent = events[0];
    					const comment = firstEvent.extendedProps && firstEvent.extendedProps.comment ? firstEvent.extendedProps.comment : '';
    					const icon = firstEvent.extendedProps && firstEvent.extendedProps.icon ? firstEvent.extendedProps.icon : '';
                        showEventInfo(firstEvent.id, firstEvent.title, firstEvent.start, comment, icon);
                        selectedEventId = events[0].id; // 첫 번째 이벤트 ID 저장
                        
                        const formData = new URLSearchParams();
                        formData.append("event_id", firstEvent.id);

                        fetch("/api/calender/event-details", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded"
                            },
                            body: formData.toString()
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                        .then(res => {
                            if (!res.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return res.json();
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
.then(data => {
    // [v7] 이벤트 데이터 없으면 상세 패널 숨김
    if (!data || (typeof data === 'object' && Object.keys(data).length === 0)) {
        eventDetailDiv.innerHTML = '';
        eventDetailDiv.style.display = 'none';
        return;
    }
    // [수정됨 v3] 이벤트 없으면 바로 종료 (출력 안함)
    if (!data || (!data.invitation && (!data.fundingList || data.fundingList.length === 0))) {
        eventDetailDiv.innerHTML = "";
        eventDetailDiv.style.display = "none";
        return;
    }
    showEventDetails(data);
                            console.log("서버 응답 성공:", data);
                            
                            if (data.success) {
                                console.log("초대장 목록:", data.invitationList);
                                console.log("펀딩 목록:", data.fundingList);
                                updateEventDetailsUI(data, selectedEventId);
                            } else {
                                console.error("서버 에러:", data.error);
                            }
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                        .catch(err => {
                            console.error("요청 실패:", err);
                        });
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
					
                    let eventId = arg.event.id;
                    let title = arg.event.title;
                    let day = arg.event.start;
                    let comment = arg.event.extendedProps && arg.event.extendedProps.comment ? arg.event.extendedProps.comment : '';
                    let icon = arg.event.extendedProps && arg.event.extendedProps.icon ? arg.event.extendedProps.icon : '';
                    
                    // 이벤트가 있는 날짜 정보 가져오기
                    const eventDateStr = arg.event.startStr;
                    
                    // 클릭된 날짜 설정
                    setClickedDate(eventDateStr);
                    
                    // 선택된 이벤트 ID 설정
                    selectedEventId = arg.event.id;
                    
                    // 날짜 정보 표시 (이벤트가 있으므로 true)
                    showDateInfo(eventDateStr, true);
                    
                    //이벤트의 id를 controller로 전송
                    const formData = new URLSearchParams();
                        formData.append("event_id", eventId);

                        fetch("/api/calender/event-details", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded"
                            },
                            body: formData.toString()
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                        .then(res => {
                            if (!res.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return res.json();
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
.then(data => {
    // [v7] 이벤트 데이터 없으면 상세 패널 숨김
    if (!data || (typeof data === 'object' && Object.keys(data).length === 0)) {
        eventDetailDiv.innerHTML = '';
        eventDetailDiv.style.display = 'none';
        return;
    }
    // [수정됨 v3] 이벤트 없으면 바로 종료 (출력 안함)
    if (!data || (!data.invitation && (!data.fundingList || data.fundingList.length === 0))) {
        eventDetailDiv.innerHTML = "";
        eventDetailDiv.style.display = "none";
        return;
    }
    showEventDetails(data);
                            console.log("서버 응답 성공:", data);
                            
                            if (data.success) {
                                console.log("초대장 목록:", data.invitationList);
                                console.log("펀딩 목록:", data.fundingList);
                                updateEventDetailsUI(data, selectedEventId);
                            } else {
                                console.error("서버 에러:", data.error);
                            }
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                        .catch(err => {
                            console.error("요청 실패:", err);
                        });
                    
                    // 이벤트 정보 표시
                    showEventInfo(eventId, title, day, comment, icon);
                    
                    // 모든 날짜 칸의 색상 초기화
                    document.querySelectorAll('.fc-daygrid-day').forEach(cell => {
                        cell.style.backgroundColor = '';
                        cell.querySelector('.fc-daygrid-day-number').style.color = '';
                    });

                    // 클릭된 이벤트가 있는 날짜 칸의 색상 변경
                    const clickedCell = document.querySelector('.fc-daygrid-day[data-date="' + eventDateStr + '"]');
                    if (clickedCell) {
                        console.log('debug: detected changed color for event date');
                        clickedCell.style.backgroundColor = '#EF5327';
                        const dayNumber = clickedCell.querySelector('.fc-daygrid-day-number');
                        if (dayNumber) {
                            dayNumber.style.color = '#fff';
                        }
                    }
                },
                
                dayMaxEvents: true,
                
                //임시 이벤트들
                events: [
                	<c:forEach items="${requestScope.cList}" var="calendervo" varStatus="status">
                    {
                        id: '<c:out value="${calendervo.event_no}" />',
                        title: '<c:out value="${calendervo.event_name}" />',
                        start: '<c:out value="${calendervo.event_date}" />', 
                        extendedProps: {
                            icon: '<c:out value="${calendervo.icon_id}" />',
                            comment: '<c:out value="${calendervo.event_memo}" />'
                        }
                    }
                    <c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ]
            });

            calendar.render();

         	// 오늘 날짜에 이벤트가 있으면 우측에 출력
            const todayStr = new Date().toISOString().slice(0, 10);
            setClickedDate(todayStr);

            const todayEvents = calendar.getEvents().filter(ev => ev.startStr.startsWith(todayStr));
            
            // 날짜 정보 항상 표시
            showDateInfo(todayStr, todayEvents.length > 0);
            
            if (todayEvents.length > 0) {
            	const firstEvent = todayEvents[0];
                const comment = firstEvent.extendedProps && firstEvent.extendedProps.comment ? firstEvent.extendedProps.comment : '';
                const icon = firstEvent.extendedProps && firstEvent.extendedProps.icon ? firstEvent.extendedProps.icon : '';
                showEventInfo(firstEvent.id, firstEvent.title, firstEvent.start, comment, icon);
                selectedEventId = firstEvent.id; // 첫 번째 이벤트 ID 저장
                
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
            function showEventInfo(eventId, title, day, comment, icon) {
				console.log('debug: detect event');
				console.log('debug request event id=' + eventId)
                const eventInfoDiv = document.getElementById('event-info');
				
				// 아이콘 경로 설정
                let iconSrc = '';
                switch (icon) {
                    case 'birthday':
                        iconSrc = '../../../assets/icon/icon-cake-birthday.svg';
                        break;
                    case 'wedding':
                        iconSrc = '../../../assets/icon/icon-rings-wedding.svg';
                        break;
                    case 'thanks':
                        iconSrc = '../../../assets/icon/icon-hand-holding-heart.svg';
                        break;
                    case 'baby':
                        iconSrc = '../../../assets/icon/icon-child-head.svg';
                        break;
                    case 'event':
                        iconSrc = '../../../assets/icon/icon-glass-cheers.svg';
                        break;
                    case 'celebrate':
                        iconSrc = '../../../assets/icon/icon-party-horn.svg';
                        break;
                    default:
                        iconSrc = '../../../assets/icon/icon-comment.svg'; // 기본 아이콘
                }
                
                let htmlStr = '';
                htmlStr += '<div class="event-detail-area">';
                htmlStr += '	<div class="row-flex-box">'
                htmlStr += '		<img class="middle-icon" src="' + iconSrc + '">'
                htmlStr += '		<div class="column-flex-box event-detail">'
                htmlStr += '			<div class="text-16 bold">'+title+'</div>'
                htmlStr += '			<div class="text-14">'+ (comment || '코멘트가 없습니다')  +'</div>'
                htmlStr += '		</div>'
                htmlStr += '	</div>'
                htmlStr += '</div>'
                htmlStr += ''
                
                eventInfoDiv.innerHTML = htmlStr;
                eventInfoDiv.style.display = 'block';
            }

            // 이벤트가 없을 때
            function showNoEventInfo(dateStr) {
			    const eventInfoDiv = document.getElementById('event-info');
			    eventInfoDiv.innerHTML = '<div class="no-event">' +
			                           '<img class="middle-icon" src="../../../assets/icon/icon-calendar-exclamation.svg" />' +
			                           '<div class="text-18">등록된 기념일이 없어요</div>' +
			                           '<button class="btn-basic btn-orange size-normal create-event-btn">기념일 등록하기</button>' +
			                           '</div>';
			    eventInfoDiv.style.display = 'block';
			    selectedEventId = null;
			    
			    // "기념일 등록하기" 버튼 클릭 시 일정 추가 팝업 호출
			    document.querySelector('#event-info .create-event-btn').onclick = function () {
			        console.log('기념일 등록하기');
			        openScheduleModal(dateStr);
			    };
			}
            
            // --- 전역 함수로 분리 끝 ---
            
            // updateEventDetailsUI (펀드리스트, 초대장 호출 함수)
            function updateEventDetailsUI(data, selectedEventId) {
		    var eventDetailDiv = document.getElementById('event-details-info');
		    if (!selectedEventId) {
		        eventDetailDiv.innerHTML = '<div style="display:none;"></div>';
		        return;
		    }
		
		    var html = '';
		
		    // 초대장 영역
		    if (!data.invitationList || data.invitationList.length === 0) {
		        html += ''
		          + '<div class="column-flex-box celebrate-card-area row-align no-event">'
		          + '  <img class="middle-icon" src="../../../assets/icon/icon-cross.svg" />'
		          + '  <div class="text-18">초대장이 없어요</div>'
		          + '  <button class="btn-basic btn-orange size-normal">초대장 만들기</button>'
		          + '</div>';
		    } else {
		        var inv = data.invitationList[0]; // 필요한 만큼 루프 돌려도 됨
		        html += ''
		          + '<div class="celebrate-card-area">'
		          + '  <div class="text-16 bold">내가 만든 초대장</div>'
		          + '  <img class="celebrate-card-img" src="' + (inv.photo_url || '') + '">'
		          + '  <div class="show-detail">'
		          + '    <a href="/invitation/invitation?invitation_no=' + (inv.invitation_no || '') + '">자세히보기&gt;</a>'
		          + '  </div>'
		          + '</div>';
		    }
		
		    // 펀딩 영역
		    if (!data.fundingList || data.fundingList.length === 0) {
		        html += ''
		          + '<div class="column-flex-box celebrate-card-area row-align no-event">'
		          + '  <img class="middle-icon" src="../../asset/icon-cross.svg" />'
		          + '  <div class="text-18">펀딩 리스트가 비었어요</div>'
		          + '  <button class="btn-basic btn-orange size-normal">펀딩 관리하기</button>'
		          + '</div>';
		    } else {
		        html += ''
		          + '<div class="funding-area column-flex-box">'
		          + '  <div class="text-16 bold">진행중인 펀딩</div>';
		
		        data.fundingList.forEach(function (product) {
		            html += ''
		              + '  <a href="">'
		              + '    <div class="list-basic list-360 row-flex-box">'
		              + '      <img class="list-img-50 column-align" src="' + (product.itemimg || '') + '">'
		              + '      <div class="column-flex-box column-align funding-detail">'
		              + '        <div class="text-12">' + (product.brand || '') + '</div>'
		              + '        <div class="text-12">' + (product.title || '') + '</div>'
		              + '        <div class="text-16 bold">' + (product.price || 0) + '원</div>'
		              + '      </div>'
		              + '    </div>'
		              + '  </a>';
		        });
		
		        html += ''
		          + '  <div class="show-detail">'
		          + '    <a href="/funding/fundingList">전체보기&gt;</a>'
		          + '  </div>'
		          + '</div>';
		    }
		
		    eventDetailDiv.innerHTML = html;
		    eventDetailDiv.style.display = 'block';
		}

         	// 1. 일정 추가 팝업 - 완전 수정된 버전
            function openScheduleModal(dateStr) {
                Swal.fire({
                    html: '<div id="event-add-popup">' +
                          '  <div class="cancel">' +
                          '    <button id="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../../assets/icon/icon-cross.svg"></button>' +
                          '  </div>' +
                          '  <div class="event-name">' +
                          '    <div class="event-icon-box">' +
                          '      <div class="icon-selector">' +
                          '        <div class="selected-icon" onclick="toggleIconDropdown()">' +
                          '          <img src="../../../assets/icon/icon-cake-birthday.svg" id="selected-icon-img">' +
                          '          <img class="dropdown-arrow" src="../../../assets/icon/icon-caret-down.svg">' +
                          '        </div>' +
                          '        <div class="icon-dropdown" id="icon-dropdown" style="display: none;">' +
                          '          <div class="icon-option" data-value="birthday" onclick="selectIcon(\'birthday\', \'../../../assets/icon/icon-cake-birthday.svg\')">' +
                          '            <img src="../../../assets/icon/icon-cake-birthday.svg">' +
                          '          </div>' +
                          '          <div class="icon-option" data-value="wedding" onclick="selectIcon(\'wedding\', \'../../../assets/icon/icon-rings-wedding.svg\')">' +
                          '            <img src="../../../assets/icon/icon-rings-wedding.svg">' +
                          '          </div>' +
                          '          <div class="icon-option" data-value="thanks" onclick="selectIcon(\'thanks\', \'../../../assets/icon/icon-hand-holding-heart.svg\')">' +
                          '            <img src="../../../assets/icon/icon-hand-holding-heart.svg">' +
                          '          </div>' +
                          '          <div class="icon-option" data-value="baby" onclick="selectIcon(\'baby\', \'../../../assets/icon/icon-child-head.svg\')">' +
                          '            <img src="../../../assets/icon/icon-child-head.svg">' +
                          '          </div>' +
                          '          <div class="icon-option" data-value="event" onclick="selectIcon(\'event\', \'../../../assets/icon/icon-glass-cheers.svg\')">' +
                          '            <img src="../../../assets/icon/icon-glass-cheers.svg">' +
                          '          </div>' +
                          '          <div class="icon-option" data-value="celebrate" onclick="selectIcon(\'celebrate\', \'../../../assets/icon/icon-party-horn.svg\')">' +
                          '            <img src="../../../assets/icon/icon-party-horn.svg">' +
                          '          </div>' +
                          '        </div>' +
                          '      </div>' +
                          '      <input type="hidden" id="selected-icon-value" value="birthday">' +
                          '    </div>' +
                          '    <div class="event-name-box">' +
                          '      <input name="eventName" class="input-name" placeholder="일정 제목" type="text">' +
                          '    </div>' +
                          '  </div>' +
                          '  <div class="event-comment">' +
                          '    <img class="popup-icon" src="../../../assets/icon/icon-comment.svg">' +
                          '    <textarea class="input-comment" placeholder="메모 입력"></textarea>' +
                          '  </div>' +
                          '  <button id="event-save-btn" class="btn-basic btn-orange size-normal" type="button">저장</button>' +
                          '</div>',
                    showCancelButton: false,
                    showConfirmButton: false,
                    customClass: {
                        popup: 'swal2-no-padding'  // 패딩 제거를 위한 클래스
                    },
                    showClass: {
                        popup: ''
                    },
                    hideClass: {
                        popup: ''
                    },
                    didOpen: () => {
                        // CSS 스타일 추가
                        const style = document.createElement('style');
                        style.textContent = `
                            .swal2-no-padding .swal2-html-container {
                                padding: 0 !important;
                                margin: 0 !important;
                            }
                            .swal2-popup {
                                padding: 0 !important;
                                width: 480px !important;
                                height: 365px !important;
                            }
                        `;
                        document.head.appendChild(style);

                        // 아이콘 드롭다운 관련 함수들을 전역으로 설정
                        window.toggleIconDropdown = function () {
                            const dropdown = document.getElementById('icon-dropdown');
                            if (dropdown) {
                                dropdown.style.display = dropdown.style.display === 'none' ? 'block' : 'none';
                            }
                        };

                        window.selectIcon = function (value, imageSrc) {
                            const iconImg = document.getElementById('selected-icon-img');
                            const iconValue = document.getElementById('selected-icon-value');
                            const dropdown = document.getElementById('icon-dropdown');
                            
                            if (iconImg) iconImg.src = imageSrc;
                            if (iconValue) iconValue.value = value;
                            if (dropdown) dropdown.style.display = 'none';
                        };

                        // 드롭다운 외부 클릭시 닫기
                        document.addEventListener('click', function handleOutsideClick(event) {
                            const iconSelector = document.querySelector('.icon-selector');
                            const dropdown = document.getElementById('icon-dropdown');
                            if (iconSelector && dropdown && !iconSelector.contains(event.target)) {
                                dropdown.style.display = 'none';
                            }
                        });
                        
                        // 저장 버튼 클릭 이벤트
                        const saveBtn = document.getElementById('event-save-btn');  // ID로 찾기
                        if (saveBtn) {
                            saveBtn.addEventListener('click', () => {
                                const titleInput = document.querySelector("input[name='eventName']");
                                const commentInput = document.querySelector(".input-comment");
                                const selectedIconInput = document.getElementById('selected-icon-value');
                                
                                const title = titleInput ? titleInput.value : '';
                                const comment = commentInput ? commentInput.value : '';
                                const selectedIcon = selectedIconInput ? selectedIconInput.value : 'birthday';
                                
                                if (title && title.trim()) {

                                	// 서버 DB에 저장 (fetch 추가)
                                 	// 저장 버튼 클릭 내부에서 실행
                                    const formData = new URLSearchParams();
								    formData.append("event_date", eventData.date);
								    formData.append("event_name", eventData.title);
								    formData.append("event_memo", eventData.comment);
								    formData.append("icon_id", eventData.icon);
								
								    fetch("/api/calender/event/insert", {
								        method: "POST",
								        headers: {
								            "Content-Type": "application/x-www-form-urlencoded"
								        },
								        body: formData.toString()
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
								    .then(res => {
								        if (!res.ok) {
								            throw new Error(`HTTP error! status: ${res.status}`);
								        }
								        return res.json();
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
								    .then(data => {
								        console.log("이벤트 등록 결과:", data);
								        
								        if (data.success) {
								            console.log("이벤트 등록 성공:", data.message);
								            // 성공 처리 로직
								        } else {
								            console.error("이벤트 등록 실패:", data.error);
								            alert("이벤트 등록에 실패했습니다: " + data.error);
								        }
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
								    .catch(err => {
								        console.error("이벤트 등록 요청 실패:", err);
								        alert("서버 연결에 실패했습니다.");
								    });

                                	//화면에 이벤트를 축가하는 문장
                                    try {
                                        const newEvent = calendar.addEvent({
                                            title: title,
                                            start: dateStr,
                                            allDay: true,
                                            extendedProps: {
                                                comment: comment,
                                                icon: selectedIcon
                                            }
                                        });
                                        console.log('이벤트 생성 성공:', newEvent);
                                        Swal.close();
                                        
                                        // 이벤트 생성 후 우측 패널 업데이트
                                        showDateInfo(dateStr, true);
                                        showEventInfo(newEvent.id, newEvent.title, newEvent.start, comment, selectedIcon);
                                        selectedEventId = newEvent.id;
                                        
                                    } catch (error) {
                                        console.error('이벤트 생성 실패:', error);
                                    }
                                } else {
                                    alert('일정 제목을 입력해주세요.');
                                }
                            });
                        }

                        // 닫기 버튼 클릭 이벤트
                        const cancelBtn = document.getElementById('event-cancel-btn');  // ID로 찾기
                        if (cancelBtn) {
                            cancelBtn.addEventListener('click', () => {
                                Swal.close();
                            });
                        }
                    },
                    willClose: () => {
                        // 팝업 닫힐 때 전역 함수들 정리
                        if (window.toggleIconDropdown) delete window.toggleIconDropdown;
                        if (window.selectIcon) delete window.selectIcon;
                    }
                });
            }

         // 2. 일정 수정 팝업 - 괄호 오류 수정 버전
            function openEditScheduleModal(event) {
                const existingComment = (event.extendedProps && event.extendedProps.comment) ? event.extendedProps.comment : '';
                const existingIcon = (event.extendedProps && event.extendedProps.icon) ? event.extendedProps.icon : '';
                
                // 아이콘 경로 설정
                let iconSrc = '';
                switch (existingIcon) {
                    case 'birthday':
                        iconSrc = '../../../assets/icon/icon-cake-birthday.svg';
                        break;
                    case 'wedding':
                        iconSrc = '../../../assets/icon/icon-rings-wedding.svg';
                        break;
                    case 'thanks':
                        iconSrc = '../../../assets/icon/icon-hand-holding-heart.svg';
                        break;
                    case 'baby':
                        iconSrc = '../../../assets/icon/icon-child-head.svg';
                        break;
                    case 'event':
                        iconSrc = '../../../assets/icon/icon-glass-cheers.svg';
                        break;
                    case 'celebrate':
                        iconSrc = '../../../assets/icon/icon-party-horn.svg';
                        break;
                    default:
                        iconSrc = '../../../assets/icon/icon-comment.svg'; // 기본 아이콘
                }
                
                Swal.fire({
                    html: '<div id="event-add-popup">' +
                          '  <div class="cancel">' +
                          '    <button id="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../../assets/icon/icon-cross.svg"></button>' +
                          '  </div>' +
                          '  <div class="event-name">' +
                          '    <div class="event-icon-box">' +
                          '      <img class="popup-icon" src="../../../assets/icon/icon-interrogation.svg">' +
                          '      <img class="popup-icon" src="../../../assets/icon/icon-caret-down.svg">' +
                          '    </div>' +
                          '    <div class="event-name-box">' +
                          '      <input name="eventName" class="input-name" placeholder="일정 제목" value="' + event.title +'">' +
                          '    </div>' +
                          '  </div>' +
                          '  <div class="event-comment">' +
                          '    <img class="popup-icon" src="' + iconSrc + '">' +
                          '    <textarea class="input-comment" placeholder="메모 입력">' + existingComment + '</textarea>' +
                          '  </div>' +
                          '  <div class="row-flex-box align-right">' +
                          '    <button id="event-delete-btn" class="btn-basic btn-gray size-normal" type="button">삭제</button>' +
                          '    <button id="event-edit-btn" class="btn-basic btn-orange size-normal" type="button">수정</button>' +
                          '  </div>' +
                          '</div>',
                    showCancelButton: false,
                    showConfirmButton: false,
                    customClass: {
                        popup: 'swal2-no-padding'
                    },
                    showClass: {
                        popup: ''
                    },
                    hideClass: {
                        popup: ''
                    },
                    didOpen: () => {
                        // CSS 스타일 추가
                        const style = document.createElement('style');
                        style.textContent = `
                            .swal2-no-padding .swal2-html-container {
                                padding: 0 !important;
                                margin: 0 !important;
                            }
                            .swal2-popup {
                                padding: 0 !important;
                                width: 480px !important;
                                height: 365px !important;
                            }
                        `;
                        document.head.appendChild(style);

                        // 수정 버튼 클릭 이벤트
                        document.getElementById('event-edit-btn').addEventListener('click', () => {
                            const title = document.querySelector("input[name='eventName']").value;
                            const comment = document.querySelector(".input-comment").value;

                            if (title && title.trim()) {
                                // 서버 DB에 수정 요청
                                const formData = new URLSearchParams();
                                formData.append("event_no", selectedEventId);
                                formData.append("event_name", title);
                                formData.append("event_memo", comment);
                                formData.append("icon_id", existingIcon);

                                fetch("/api/calender/event/update", {
                                    method: "POST",
                                    headers: {
                                        "Content-Type": "application/x-www-form-urlencoded"
                                    },
                                    body: formData.toString()
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                                .then(res => {
                                    if (!res.ok) {
                                        throw new Error(`HTTP error! status: ${res.status}`);
                                    }
                                    return res.json();
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                                .then(data => {
                                    console.log("이벤트 수정 결과:", data);
                                    
                                    if (data.success) {
                                        console.log("이벤트 수정 성공:", data.message);
                                        // 성공 처리 로직
                                        try {
                                            event.setProp('title', title);
                                            event.setExtendedProp('comment', comment);
                                            console.log('이벤트 수정 성공:', event);
                                            
                                            // 우측 패널도 업데이트
                                            showEventInfo(selectedEventId, title, event.start, comment, existingIcon);
                                        } catch (error) {
                                            console.error('이벤트 수정 실패:', error);
                                        }
                                    } else {
                                        console.error("이벤트 수정 실패:", data.error);
                                        alert("이벤트 수정에 실패했습니다: " + data.error);
                                    }
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                                .catch(err => {
                                    console.error("이벤트 수정 요청 실패:", err);
                                    alert("서버 연결에 실패했습니다.");
                                });
                            } else {
                                alert('일정 제목을 입력해주세요.');
                            }
                            Swal.close();            
                        }); // 수정 버튼 이벤트 리스너 종료

                        // 닫기 버튼 클릭 이벤트
                        document.getElementById('event-cancel-btn').addEventListener('click', () => {
                            Swal.close();
                        });

                        // 삭제 버튼 클릭 이벤트
                        document.getElementById('event-delete-btn').addEventListener('click', () => {
                            deleteSelectedEvent();
                        });
                    } // didOpen 함수 종료
                }); // Swal.fire 종료
            } // openEditScheduleModal 함수 종료
         	
            function deleteSelectedEvent() {
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
                        },
                        showClass: {
                            popup: ''
                        },
                        hideClass: {
                            popup: ''
                        }
                    }).then(function (result) {
                        if (result.value) {
                            // 서버에서 삭제 처리
                            const formData = new URLSearchParams();
                            formData.append("event_no", eventNo);

                            fetch("/api/calendar/events/delete", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/x-www-form-urlencoded"
                                },
                                body: formData.toString()
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                            .then(res => {
                                if (!res.ok) {
                                    throw new Error(`HTTP error! status: ${res.status}`);
                                }
                                return res.json();
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                            .then(data => {
                                console.log("이벤트 삭제 결과:", data);

                                if (data.success) {
                                    console.log("이벤트 삭제 성공:", data.message);

                                    // ✅ 성공적으로 삭제된 경우에만 화면에서 제거
                                    event.remove();
                                    document.getElementById('event-info').style.display = 'none';
                                    document.getElementById('event-info').innerHTML = '';
                                    selectedEventId = null;
                                } else {
                                    console.error("이벤트 삭제 실패:", data.error);
                                    alert("이벤트 삭제에 실패했습니다: " + data.error);
                                }
}) // [수정 전: 잘못 닫힌 fetch 옵션 객체]
                            .catch(err => {
                                console.error("이벤트 삭제 요청 실패:", err);
                                Swal.fire("삭제 실패", "서버 오류가 발생했습니다.", "error");
                            });
                        }
                    });
                }
            }
        });
    </script>
</body>

</html>