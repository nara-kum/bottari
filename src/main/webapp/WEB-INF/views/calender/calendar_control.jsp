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

<title>캘린더 ver.0.1.4</title>
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
						window.location.href = "/loginForm"; // 로그인 페이지 경로 맞게 수정하세요
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
		document.addEventListener('DOMContentLoaded', function(){
			console.log('DOMContentLoaded Completed');
			
			let lastClickedDate = null;
			let selectedEventId = null;
			
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
					
                    //아이콘 탑에 따른 이미지 경로 설정
                    const iconSrc = switchIcon(icon);
                    
                 // 커스텀 HTML 반환
                    return {
                        html: '<div class="custom-event">' +
                              '<img src="' + iconSrc + '" class="event-icon" />' +
                              '<span class="event-title">' + arg.event.title + '</span>' +
                              '</div>'
                    };
               	},
               	
               	//dateClick 작동했을 때 함수
               	dateClick: function (clickedDate) {
					console.log('detected dateClick()');
					// 일단 event-info를 숨김처리
					document.getElementById('event-info').style.display = 'none';
					// event-info의 HTML 선언
					document.getElementById('event-info').innerHTML = '';
					
					console.log("clickedDate.dateStr" + clickedDate.dateStr);
					
					//setClickedDate 함수에 클릭된 날짜의 문자열 전송
					setClickedDate(clickedDate.dateStr);
					
					// 변수 events에 clickedDate.dateStr로 시작하는 이벤트들만 필터링하여 담기
					const events = calendar.getEvents().filter(ev => ev.startStr.startsWith(clickedDate.dateStr));
					
					// showDateInfo함수를 호출하여 날짜 문자열과 이벤트의 존재여부를 전송
               		showDateInfo(clickedDate.dateStr, events.length > 0);
               		
					// 만약 이벤트가 있다면
               		if (events.length > 0) {
						// events 배열의 첫 번째 이벤트를 firstEvent 변수에 대입
						const firstEvent = events[0];
						
						// comment함수에 comment가 존재하는지 여부를 확인하고 변수에 대입
						const comment = firstEvent.extendedProps && firstEvent.extendedProps.comment ? firstEvent.extendedProps.comment : '';
						
						// icon 변수에 icon이 존재하는지 확인 후 변수에 대입
						const icon = firstEvent.extendedProps && firstEvent.extendedProps.icon ? firstEvent.extendedProps.icon : '';
						
						// showEventInfo에 첫번째 이벤트의 id, title, start(날짜), comment, icon을 담아서 전송
						showEventInfo(firstEvent.id, firstEvent.title, firstEvent.start, comment, icon);
						
						// 첫 번째 이벤트의 id 저장
						selectedEventId = firstEvent.id;
						
						// Http서버에 POST요청으로 특정 이벤트의 상세 정보를 가져오기
						const formData = new URLSearchParams();
						formData.append("event_no", firstEvent.id);
						
						fetch("/api/calender/event-details", {
							method: "POST",
							headers: {
								"Content-Type": "application/x-www-form-urlencoded"
							},
							
							body: formData.toString()
						})
						
						.then(res => {
                            if (!res.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return res.json();
                        })
                        
                        .then(data => {
							console.log("서버 응답 성공:", data);
                            
                            if (data.success) {
								// 가져온 초대장과 펀딩목록 출력
                                console.log("초대장 목록:", data.invitationList);
                                console.log("펀딩 목록:", data.fundingList);
                                updateEventDetailsUI(data, selectedEventId);
                            } else {
                                console.error("서버 에러:", data.error);
                            }
                        })
                        
                        .catch(err => {
							console.error("요청 실패:", err);
                        });
               		}else {
						
						showNoEventInfo();
					}
					
               		// 날짜간의 색을 변경하는 함수 호출
                    highlightDateCell(clickedDate.dateStr);
               	},
               	
               	// eventClick 작동했을 때 함수
               	eventClick: function (clickedEvent) {
					console.log('detected eventClick()');
					
					// 클릭된 이벤트의 id, title, start(날짜), comment, icon을 변수로 선언
					let event_id = clickedEvent.event.id;
					let title = clickedEvent.event.title;
					let day = clickedEvent.event.start;
					let comment = clickedEvent.event.extendedProps && clickedEvent.event.extendedProps.comment ? clickedEvent.event.extendedProps.comment : '';
                    let icon = clickedEvent.event.extendedProps && clickedEvent.event.extendedProps.icon ? clickedEvent.event.extendedProps.icon : '';
                    
                    // 이벤트가 있는 날짜의 정보를 가져오기
                    const eventDateStr = clickedEvent.event.startStr;
                    
                    // 클릭된 이벤트 id 설정
                    selectedEventId = clickedEvent.event.id;
                    
                    // 날짜 정보 표시 (이벤트가 있으므로 true)
                    showDateInfo(eventDateStr, true);
                    
                    //이벤트의 id를 controller로 전송
                    const formData = new URLSearchParams();
                    formData.append("event_no", event_id);

                    fetch("/api/calender/event-details", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: formData.toString()
                    })
                    .then(res => {
                        if (!res.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return res.json();
                    })
                    .then(data => {
                        console.log("서버 응답 성공:", data);
                        
                        if (data.success) {
							//가져온 초대장과 펀딩목록 출력
                            console.log("초대장 목록:", data.invitationList);
                            console.log("펀딩 목록:", data.fundingList);
                            updateEventDetailsUI(data, selectedEventId);
                        } else {
                            console.error("서버 에러:", data.error);
                        }
                    })
                    .catch(err => {
                        console.error("요청 실패:", err);
                    });
                    
                    // showEventInfo에 id, title, day, comment, icon 담아서 전송
                    showEventInfo(event_id, title, day, comment, icon);
                    
                    // 날짜간의 색을 변경하는 함수 호출
                    highlightDateCell(eventDateStr);
               	},
               	
               	dayMaxEvents: true,
               	
               	//풀캘린더에 출력할 이벤트들
               	events: [
               		<c:forEach items="${requestScope.cList}" var="vo" varStatus="status">
               			{
               				id: '${vo.event_no}',
                            title: '${vo.event_name}',
                            start: '${vo.event_date}', 
                            extendedProps: {
                                icon: '${vo.icon_id}',
                                comment: '${vo.event_memo}'
                            }
               			}
               			<c:if test="${!status.last}">,</c:if>
               		</c:forEach>
               	]
            });
            
            calendar.render();
            // fullcalendar 영역 끝
            
            // /////////////////////////////////////////////////// //
            // ////////////////////함수 영역//////////////////////// //
            // /////////////////////////////////////////////////// //
            
            // 클릭된 날짜를 기본 선택 날짜로 설정하기 위한 함수
            function setClickedDate(dateStr) {
            	console.log('현재 날짜: ' + dateStr);
            	lastClickedDate = dateStr;
            }
            
            // 날짜 출력 함수 (dateStr == 선택된 날짜 문자열, hasEvent == 이벤트 유무 확인)
            function showDateInfo(dateStr, hasEvent) {
				console.log('detected showDateInfo()');
				console.log('dateStr:' + dateStr);
				console.log('hasEvent:' + hasEvent);
				
				const dateInfoDiv = document.getElementById('date-info');
				
				if(hasEvent) {
					let htmlStr = '';
					htmlStr += '<div class="between-flex-box">';
                	htmlStr += '	<div class="header-sub">'+dateStr+'</div>';
                	htmlStr += '	<div class="row-flex-box">';
                	htmlStr += '		<img class="popup-icon create-event-btn" src="../../../assets/icon/icon-add.svg">';
                	htmlStr += '		<img id="edit-event-btn" class="popup-icon" src="../../../assets/icon/icon-menu-dots.svg">';
                	htmlStr += '	</div>';
                	htmlStr += '</div>';
                	
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
				
				// 이벤트 등록 버튼 => 이벤트 등록 모달창 호출
				document.querySelector('#date-info .create-event-btn').onclick = function () {
					openScheduleModal(dateStr);
				};
				// edit-event-btn이 있을 때만 이벤트 등록
				const editBtn = document.getElementById('edit-event-btn');
				if(editBtn) {
					editBtn.onclick = function() {
						openEditScheduleModal(calendar.getEventById(selectedEventId));
					}
				}
            }
            
            //이벤트가 있을 때 이벤트 정보 출력하는 함수
            function showEventInfo(event_id, title, day, comment, icon) {
				console.log("detected showEventInfo()");
				console.log("출력할 이벤트의 아이디:" + event_id);
				const eventInfoDiv = document.getElementById('event-info');
				
				//아이콘의 주소 가져오는 함수 호출
				const iconSrc = switchIcon(icon);
				
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
                
                eventInfoDiv.innerHTML = htmlStr;
                eventInfoDiv.style.display = 'block';
            }
            
            // 이벤트가 없을 때 정보를 출력하는 함수
            function showNoEventInfo(dateStr) {
				const eventInfoDiv = document.getElementById('event-info');
				const eventDetailsDiv = document.getElementById('event-details-info');
				
				let htmlStr = '';
				htmlStr += '<div class="no-event">';
				htmlStr += '	<img class="middle-icon" src="../../../assets/icon/icon-calendar-exclamation.svg" />';
				htmlStr += '	<div class="text-18">등록된 기념일이 없어요</div>';
				htmlStr += '	<button class="btn-basic btn-orange size-normal create-event-btn">기념일 등록하기</button>';
				htmlStr += '</div>';
				
				eventInfoDiv.innerHTML = htmlStr;
				eventInfoDiv.style.display = 'block';
				selectedEventId = null;
				eventDetailsDiv.style.display = 'none';
				
				// 기념일 등록하기 버튼 클릭 시 일정 추가 팝업 호출
				document.querySelector('#event-info .create-event-btn').onclick = function () {
					console.log("기념일 등록 팝업 호출");
					openScheduleModal(dateStr);
				}
            }
            
            // 아이콘의 타입에 따른 이미지 경로를 설정하는 함수
            function switchIcon(icon) {
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
	                    iconSrc = '../../../assets/icon/icon-interrogation.svg';
            	}
                return iconSrc;
            }
            
            // 날짜칸의 색을 바꾸는 함수
            function highlightDateCell(dateStr) {
            	
            	console.log("dateStr: " + dateStr);
            	
                document.querySelectorAll('.fc-daygrid-day').forEach(cell => {
                    cell.style.backgroundColor = '';
                    cell.querySelector('.fc-daygrid-day-number').style.color = '';
                });

                
                const clickedCell = document.querySelector('.fc-daygrid-day[data-date="' + dateStr + '"]');
                if (clickedCell) {
                    console.log('detected highlightDateCell()');
                    clickedCell.style.backgroundColor = '#EF5327';
                    const dayNumber = clickedCell.querySelector('.fc-daygrid-day-number');
                    if (dayNumber) {
                        dayNumber.style.color = '#fff';
                    }
                }
            }
		});
	</script>
</body>