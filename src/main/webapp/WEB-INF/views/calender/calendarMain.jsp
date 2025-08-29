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
<link rel="stylesheet" href="/assets/css/moduler.css">

<title>캘린더 ver.0.5.2</title>
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
						
						showNoEventInfo(lastClickedDate);
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
            
            // --------------------모달 영역-------------------- //
            
            // 이벤트 등록/추가 팝업 //
            function openScheduleModal(dateStr)	{
				console.log('===========================');
				console.log('deteced openScheduleModal()');
				console.log('openScheduleModal().dateStr: ' + dateStr);
				// sweetAlert2 사용
				Swal.fire({
					// createEventModalHTML()함수를 호출하여 html입력 관리
					html: createEventModalHTML(),
					
					// sweetAlert2에서 기본으로 제공되는 confirm, cancel 버튼 비활성화
					showCancelButton: false,
					showConfirmButton: false,
					
					//sweetAlert2의 기본 효과 제거
					customClass: {
						popup: 'swal2-no-padding'	//패딩 제거를 위한 클래스
					},
					showClass: {
						popup: ''
					},
					hideClass: {
						popup: ''
					},
					didOpen: () => {
						// css 스타일 추가
						addModalStyles();
						//아이콘 드롭다운 관련 함수
						setupIconDropdownHandlers();
						// 이벤트 추가 리스너 함수
						setupAddModalListeners(dateStr);
					},
					willClose: () => {
						cleanupIconDropdownHandlers();
					}
				});
            }
            
         // -----------------------------------------------------------------------------------------------------------------------
         
         	// 이벤트 수정 팝업 //
         	function openEditScheduleModal(eventData){
         		console.log('==============================');
				console.log('deteced openEditScheduleModal()');
				console.log('openEditScheduleModal().eventData: ', eventData);
                
				// sweetAlert2 사용
				Swal.fire({
					// editEventModalHTML() 함수를 이용
					html: editEventModalHTML(eventData),
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
						// css 스타일 추가
						addModalStyles();
						// 아이콘 드롭다운 관련 함수
						setupIconDropdownHandlers();
						// 이벤트 수정 리스너 함수
						setupEditModalListeners(eventData);
					},
					willClose: () => {
						cleanupIconDropdownHandlers();
					}
				});
         	}
         
            // /////////////////////////////////////////////////// //
            // ////////////////////함수 영역//////////////////////// //
            // /////////////////////////////////////////////////// //
            
            // 클릭된 날짜를 기본 선택 날짜로 설정하기 위한 함수
            function setClickedDate(dateStr) {
            	console.log('현재 날짜: ' + dateStr);
            	lastClickedDate = dateStr;
            }
            
            // -----------------------------------------------------------------------------------------------------------------------
            
            // 날짜 출력 함수 (dateStr == 선택된 날짜 문자열, hasEvent == 이벤트 유무 확인)
            function showDateInfo(dateStr, hasEvent) {
				console.log('detected showDateInfo()');
				console.log('dateStr:' + dateStr);
				console.log('hasEvent:' + hasEvent);
				
				const dateInfoDiv = document.getElementById('date-info');
				
				if(hasEvent) {
					let htmlStr = '';
					htmlStr += '<div class="between-flex-box">';
                	htmlStr += '	<div class="header-sub">'+ dateStr +'</div>';
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
					console.log('click create-event-btn (dateStr): ' + dateStr);
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
         	// -----------------------------------------------------------------------------------------------------------------------
            
            // 이벤트가 있을 때 이벤트 정보 출력하는 함수 //
            function showEventInfo(event_id, title, day, comment, icon) {
				console.log("detected showEventInfo()");
				console.log("출력할 이벤트의 아이디:" + event_id);
				const eventInfoDiv = document.getElementById('event-info');
				
				//아이콘의 주소 가져오는 함수 호출
				const iconSrc = switchIcon(icon);
				
				let htmlStr = '';
				htmlStr += '<div class="event-detail-area">';
                htmlStr += '	<div class="row-flex-box">';
                htmlStr += '		<img class="middle-icon" src="' + iconSrc + '">';
                htmlStr += '		<div class="column-flex-box event-detail">';
                htmlStr += '			<div class="text-16 bold">'+title+'</div>';
                htmlStr += '			<div class="text-14">'+ (comment || '코멘트가 없습니다')  +'</div>';
                htmlStr += '		</div>';
                htmlStr += '	</div>';
                htmlStr += '</div>';
                
                eventInfoDiv.innerHTML = htmlStr;
                eventInfoDiv.style.display = 'block';
            }
         	
         	// -----------------------------------------------------------------------------------------------------------------------
            
            // 이벤트가 없을 때 정보를 출력하는 함수
            function showNoEventInfo(dateStr) {
				const eventInfoDiv = document.getElementById('event-info');
				const eventDetailsDiv = document.getElementById('event-details-info');
				console.log('showNoEventInfo(): ' + dateStr);
				
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
					console.log('기념일 등록 팝업 호출 dateStr: ' + dateStr);
					openScheduleModal(dateStr);
				}
            }
         	
         	// -----------------------------------------------------------------------------------------------------------------------
            
            // 아이콘의 타입에 따른 이미지 경로를 설정하는 함수
            function switchIcon(icon) {
            	let iconSrc = '';
            	
            	switch (icon) {
	                case 'birthday':
	                    iconSrc = '/assets/icon/icon-cake-birthday.svg';
	                    break;
	                case 'wedding':
	                    iconSrc = '/assets/icon/icon-rings-wedding.svg';
	                    break;
	                case 'thanks':
	                    iconSrc = '/assets/icon/icon-hand-holding-heart.svg';
	                    break;
	                case 'baby':
	                    iconSrc = '/assets/icon/icon-child-head.svg';
	                    break;
	                case 'event':
	                    iconSrc = '/assets/icon/icon-glass-cheers.svg';
	                    break;
	                case 'celebrate':
	                    iconSrc = '/assets/icon/icon-party-horn.svg';
	                    break;
	                default:
	                    iconSrc = '/assets/icon/icon-interrogation.svg';
            	}
                return iconSrc;
            }
         	
         // -----------------------------------------------------------------------------------------------------------------------
            
            // 날짜칸의 색을 바꾸는 함수 //
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
         
         // -----------------------------------------------------------------------------------------------------------------------
         
         
         	// 이벤트 추가 모달 HTML 함수 //
         	function createEventModalHTML() {
				let htmlStr= '';
				
				htmlStr += '<div id="event-add-popup">';
				htmlStr += '	<div class="cancel">';
				htmlStr += '		<button id="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../../assets/icon/icon-cross.svg"></button>';
				htmlStr += '	</div>';
				htmlStr += '	<div class="event-name">';
				htmlStr += '		<div class="event-icon-box">';
				htmlStr += '			<div class="icon-selector">';
				htmlStr += '				<div class="selected-icon" onclick="toggleIconDropdown()">';
				htmlStr += '					<img src="../../../assets/icon/icon-cake-birthday.svg" id="selected-icon-img">';
				htmlStr += '					<img class="dropdown-arrow" src="../../../assets/icon/icon-caret-down.svg">';
				htmlStr += '				</div>';
				htmlStr += '				<div class="icon-dropdown" id="icon-dropdown" style="display: none;">';
				htmlStr += '          			' + createIconDropdownHTML();
				htmlStr += '				</div>';
				htmlStr += '			</div>';
				htmlStr += '			<input type="hidden" id="selected-icon-value" value="birthday">';
				htmlStr += '		</div>';
				htmlStr += '		<div class="event-name-box">';
				htmlStr += '			 <input id="eventName" class="input-name" placeholder="일정 제목" type="text">';
				htmlStr += '		</div>';
				htmlStr += '	</div>';
				htmlStr += '	<div class="event-comment">';
				htmlStr += '		<img class="popup-icon" src="../../../assets/icon/icon-comment.svg">';
				htmlStr += '		<textarea id="eventComment" class="input-comment" placeholder="메모 입력"></textarea>';
				htmlStr += '	</div>';
				htmlStr += '	<button id="event-save-btn" class="btn-basic btn-orange size-normal" type="button">저장</button>';
				htmlStr += '</div>';
				
				return htmlStr;
         	}
         
         	// 이벤트 수정 모달 HTML 함수 //
         	function editEventModalHTML(eventData) {
         		// 기존의 코멘트(메모)와 기존의 아이콘
				const existingComment = (eventData.extendedProps && eventData.extendedProps.comment) ? eventData.extendedProps.comment : '';
                const existingIcon = (eventData.extendedProps && eventData.extendedProps.icon) ? eventData.extendedProps.icon : '';
				
                // switchIcon() 함수를 사용하여 아이콘 경로 설정
				const iconSrc = switchIcon(existingIcon);
         		
				let htmlStr = '';
				
				htmlStr += '<div id="event-add-popup">';
				htmlStr += '	<div class="cancel">';
				htmlStr += '		<button id="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../../assets/icon/icon-cross.svg"></button>';
				htmlStr += '	</div>';
				htmlStr += '	<div class="event-name">';
				htmlStr += '		<div class="event-icon-box">';
				htmlStr += '			<div class="icon-selector">';
				htmlStr += '				<div class="selected-icon" onclick="toggleIconDropdown()">';
				htmlStr += '					<img src="' + iconSrc + '" id="selected-icon-img">';
				htmlStr += '					<img class="dropdown-arrow" src="../../../assets/icon/icon-caret-down.svg">';
				htmlStr += '				</div>';
				htmlStr += '				<div class="icon-dropdown" id="icon-dropdown" style="display: none;">';
				htmlStr += '					' + createIconDropdownHTML();
				htmlStr += '				</div>';
				htmlStr += '			</div>';
				htmlStr += '			<input type="hidden" id="selected-icon-value" value="' + existingIcon + '">';
				htmlStr += '		</div>';
				htmlStr += '		<div class="event-name-box">';
				htmlStr += '			<input id="eventName" class="input-name" placeholder="일정 제목" value="' + eventData.title +'">';
				htmlStr += '		</div>';
				htmlStr += '	</div>';
				htmlStr += '	<div class="event-comment">';
				htmlStr += '		<img class="popup-icon" src="../../../assets/icon/icon-comment.svg">';
				htmlStr += '		<textarea id="eventComment" class="input-comment" placeholder="메모 입력">' + existingComment + '</textarea>';
				htmlStr += '	</div>';
				htmlStr += '	<div class="row-flex-box align-right">';
				htmlStr += '		<button id="event-delete-btn" class="btn-basic btn-gray size-normal" type="button">삭제</button>';
				htmlStr += '		<button id="event-edit-btn" class="btn-basic btn-orange size-normal" type="button">수정</button>';
				htmlStr += '	</div>';
				htmlStr += '</div>';
				
				return htmlStr;
         	}
         
         // -----------------------------------------------------------------------------------------------------------------------
         
         	// 아이콘 정보 관리 함수 //
            function createIconDropdownHTML() {
                // switchIcon 함수에서 사용하는 아이콘 타입들
                const iconTypes = ['birthday', 'wedding', 'thanks', 'baby', 'event', 'celebrate'];

                return iconTypes.map(iconType => {
                    const iconSrc = switchIcon(iconType); // 기존 switchIcon 함수 활용!
                    return `<div class="icon-option" data-value="${iconType}" onclick="selectIcon('${iconType}', '${iconSrc}')">
                                <img src="${iconSrc}">
                             </div>`;
                }).join('');
            }
         
         // -----------------------------------------------------------------------------------------------------------------------
            
            // 모달 스타일 관리 함수 //
            function addModalStyles() {
				// 중복 스타일 추가 방지
				if(document.getElementById('modal-custom-styles')) return;
				
				const style = document.createElement('style');
				style.id = 'modal-custom-styles';
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
            }
         
         // -----------------------------------------------------------------------------------------------------------------------

         	// 아이콘 드롭다운 HTML 함수 //
         	/*
         	function createIconDropdownHTML() {
				let html = '';
				html += '<div class="icon-option" data-value="birthday" onclick="selectIcon(\'birthday\', \'../../../assets/icon/icon-cake-birthday.svg\')">';
				html += '	<img src="../../../assets/icon/icon-cake-birthday.svg">';
				html += '</div>';
				html += '<div class="icon-option" data-value="wedding" onclick="selectIcon(\'wedding\', \'../../../assets/icon/icon-rings-wedding.svg\')">';
				html += '	<img src="../../../assets/icon/icon-rings-wedding.svg">';
				html += '</div>';
				html += '<div class="icon-option" data-value="thanks" onclick="selectIcon(\'thanks\', \'../../../assets/icon/icon-hand-holding-heart.svg\')">';
				html += '	<img src="../../../assets/icon/icon-hand-holding-heart.svg">';
				html += '</div>';
				html += '<div class="icon-option" data-value="baby" onclick="selectIcon(\'baby\', \'../../../assets/icon/icon-child-head.svg\')">';
				html += '	<img src="../../../assets/icon/icon-child-head.svg">';
				html += '</div>';
				html += '<div class="icon-option" data-value="event" onclick="selectIcon(\'event\', \'../../../assets/icon/icon-glass-cheers.svg\')">';
				html += '	<img src="../../../assets/icon/icon-glass-cheers.svg">';
				html += '</div>';
				html += '<div class="icon-option" data-value="celebrate" onclick="selectIcon(\'celebrate\', \'../../../assets/icon/icon-party-horn.svg\')">';
				html += '	<img src="../../../assets/icon/icon-party-horn.svg">';
				html += '</div>';
				return html;
         	}
         	*/
         
         // -----------------------------------------------------------------------------------------------------------------------
            
            // 아이콘 드롭다운 관리 함수 //
            function setupIconDropdownHandlers() {
				//전역 함수 설정
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
                
                //드롭다운 외부 클릭시 닫기
                document.addEventListener('click', function handleOutsideClick(event) {
                    const iconSelector = document.querySelector('.icon-selector');
                    const dropdown = document.getElementById('icon-dropdown');
                    if (iconSelector && dropdown && !iconSelector.contains(event.target)) {
                        dropdown.style.display = 'none';
                    }
                });
            }
         
         // -----------------------------------------------------------------------------------------------------------------------
            
            // 드롭다운 관리 함수 정리 함수 //
            function cleanupIconDropdownHandlers() {
			    if (window.toggleIconDropdown) delete window.toggleIconDropdown;
			    if (window.selectIcon) delete window.selectIcon;
			}
         
         // -----------------------------------------------------------------------------------------------------------------------
            
         	// 폼 데이터 수집 함수 //
         	function getEventFormData() {
				const titleInput = document.getElementById('eventName');
				const commentInput = document.getElementById('eventComment');
				const selectedIconInput = document.getElementById('selected-icon-value');
				
				console.log('getEventFormData()');
				console.log('titleInput: ' + titleInput + ', commentInput: ' + commentInput + ', seletcedIconInput: ' + selectedIconInput);
				
				return {
			        title: titleInput ? titleInput.value.trim() : '',
			        comment: commentInput ? commentInput.value.trim() : '',
			        icon: selectedIconInput ? selectedIconInput.value : 'birthday'
			    };
         	}
         
         	// 일정 제목 확인 함수 //
         	function validateEventForm(eventData) {
				console.log('validateEventForm()');
				console.log('eventData: ' + eventData);
         		
         	    if (!eventData.title || eventData.title.trim() === '') {
         	        alert('일정 제목을 입력해주세요.');
         	        return false;
         	    }
         	    return true;
         	}
         
         // -----------------------------------------------------------------------------------------------------------------------

         	// 공통 이벤트 리스너 함수 //
            function setupCommonListeners() {
				//취소버튼
				const cancelBtn = document.getElementById('event-cancel-btn');
				if(cancelBtn) {
					cancelBtn.addEventListener('click', () => {
						console.log('deteced cancel button click');
						Swal.close();
					});
				}
				
				//esc 버튼으로 닫기
				document.addEventListener('keydown', function(e) {
					if(e.key === 'Escape') {
						console.log('deteced press esc key');
						Swal.close();
					}
				});
            }
         
         // -----------------------------------------------------------------------------------------------------------------------
            
            // 이벤트 추가 전용 리스너 함수 //
            function setupAddModalListeners(dateStr) {
				console.log('이벤트 추가 모달 리스너 (선택된 날짜): ' + dateStr);
				
				// 저장 버튼 클릭시
				const saveBtn = document.getElementById('event-save-btn');
				if(saveBtn) {
					saveBtn.addEventListener('click', () => {
						console.log('detected save button click');
						// 이벤트 저장 함수로 전송
						handleEventSave(dateStr);
					});
				} else {
					console.log('저장 버튼을 찾을 수 없음');
				}
				// 공통 리스너 함수도 호출
				setupCommonListeners();
            }
         
         // -----------------------------------------------------------------------------------------------------------------------
            
            // 이벤트 수정 전용 리스너 함수 //
            function setupEditModalListeners(eventData) {
				console.log('이벤트 수정 모달 리스너 (선택된 이벤트Id): ' + eventData.id);
				
				// 수정 버튼 클릭시
				const updateBtn = document.getElementById('event-edit-btn');
				if(updateBtn) {
					console.log('detected update button click');
					updateBtn.addEventListener('click', () => {
						// 이벤트 수정 함수로 전송
						handleEventUpdate(eventData);					
					});
				}
            	
				// 삭제 버튼 클릭시
				const deleteBtn = document.getElementById('event-delete-btn');
				if(deleteBtn) {
					console.log('detected delete button click');
					deleteBtn.addEventListener('click', () => {
						// 이벤트 삭제 함수로 전송
						handleEventDelete(eventData);
					});
				}
				
				// 공통 리스너도 호출
				setupCommonListeners()
            }
         
         // -----------------------------------------------------------------------------------------------------------------------
         
         	// 이벤트 추가 전용 서버 통신 함수 //
         	async function saveEventToServer(dateStr, eventData) {
				const formData = new URLSearchParams();
				formData.append("event_date", dateStr);
				formData.append("event_name", eventData.title);
				formData.append("event_memo", eventData.comment);
				formData.append("icon_id", eventData.icon);
				
				try {
					const response = await fetch("/api/calender/event/insert", {
						method: "POST",
						headers: {
							"Content-Type": "application/x-www-form-urlencoded"
						},
						body: formData.toString()
					});
					
					// 오류 처리
					if(!response.ok) {
						throw new Error('Http error! status:' + response.status);
					}
					
					return await response.json();
				} catch (error) {
					console.log("서벙청 실패: ", error);
					throw error;
				}
         	}
         
         // -----------------------------------------------------------------------------------------------------------------------

         	// 이벤트 수정 전용 서버 통신 함수 //
         	async function updateEventToServer(eventData, formData) {
				const formParams  = new URLSearchParams();
				formParams.append("event_no", eventData.id);
				formParams.append("event_name", formData.title);
				formParams.append("event_memo", formData.comment);
				formParams.append("icon_id", formData.icon);
				
				try {
					const response = await fetch("/api/calender/event/update", {
						method : "POST",
						headers: {
							"Content-Type": "application/x-www-form-urlencoded"
						},
						body: formParams.toString()
					});
					
					// 오류 처리
					if(!response.ok) {
			            throw new Error('Http error! status:' + response.status);
			        }
			        
			        return await response.json();
				} catch (error) {
			        console.log("서버 요청 실패: ", error);
			        throw error;
			    }
         	}
         
         // -----------------------------------------------------------------------------------------------------------------------

         	// 이벤트 삭제 전용 서버 통신 함수 //
         	async function deleteEventFromServer(eventId) {
         		const formData = new URLSearchParams();
         	    formData.append("event_no", eventId);
         	    
         	   try {
         	        const response = await fetch("/api/calender/event/delete", {
         	            method: "POST",
         	            headers: {
         	                "Content-Type": "application/x-www-form-urlencoded"
         	            },
         	            body: formData.toString()
         	        });
         	        
         	        if(!response.ok) {
         	            throw new Error('Http error! status:' + response.status);
         	        }
         	        
         	        return await response.json();
         	    } catch (error) {
         	        console.log("서버 요청 실패: ", error);
         	        throw error;
         	    }
         	}
         
         // -----------------------------------------------------------------------------------------------------------------------
         	// 캘린더 이벤트 추가 함수
         	function addEventToCalendar(dateStr, eventData, serverResponse) {
				try {
					const newEvent = calendar.addEvent({
						id: serverResponse.event_no.toString(),
						title: eventData.title,
						start: dateStr,
						allDay: true,
						extendedProps: {
							comment: eventData.comment,
							icon: eventData.icon
						}
					});
					
					console.log('이벤트 생성 성공: ', newEvent);
					console.log('새 이벤트 Id: ' + newEvent.id);
					
					// 출력되는 이벤트 UI 업데이트
					// 날짜 문자열, 이벤트 유무
					showDateInfo(dateStr, true);
					showEventInfo(newEvent.id, newEvent.title, newEvent.start, newEvent.extendedProps.comment, newEvent.extendedProps.icon);
					// 안되면 지울 수 있는 주석
					updateEventDetailsUI(newEvent, newEvent.id);
					selectedEventId = newEvent.id;
					
					return newEvent;
				} catch (error) {
					console.log('캘린더 이벤트 생성 실패: ', error);
					throw error;
				}
         	}
         
         // -----------------------------------------------------------------------------------------------------------------------
         
         	// 이벤트 추가 처리 함수 //
         	async function handleEventSave(dateStr) {
				const eventData = getEventFormData();
				
				if(!validateEventForm(eventData)) {
					return;
				}
				
				try {
					const serverResponse = await saveEventToServer(dateStr, eventData);
					
					if(serverResponse.success) {
						console.log("이벤트 서버 저장 완료: ", serverResponse.message);
						console.log("serverResponse: ", serverResponse);						
						addEventToCalendar(dateStr, eventData, serverResponse);
						Swal.close();
					} else {
						console.error("이벤트 서버 저장 실패: ", serverResponse.error);
						Swal.fire("등록 실패", "이벤트 등록에 실패했습니다: " + serverResponse.error , "error");
					}
				} catch (error) {
					console.error("이벤트 저장 실패: ", error);
					Swal.fire("연결 실패", "서버 연결에 실패했습니다.", "error");
				}
         	}
         
         // -----------------------------------------------------------------------------------------------------------------------
         	
         	// 이벤트 수정 처리 함수 //
         	async function handleEventUpdate(eventData) {
				const formData = getEventFormData();
				
				if(!validateEventForm(formData)) {
			        return;
			    }
				
				try {
					const serverResponse = await updateEventToServer(eventData, formData);
					
					if(serverResponse.success) {
			            console.log("이벤트 서버 수정 완료: ", serverResponse.message);
			            
			            // 기존의 이벤트를 찾아서 캘린더 업데이트
			            const event = calendar.getEventById(eventData.id);
			            if(event) {
			                event.setProp('title', formData.title);
			                event.setExtendedProp('comment', formData.comment);
			                event.setExtendedProp('icon', formData.icon);
			                
			                // UI 업데이트
			                const eventDateStr = event.startStr;
			                showEventInfo(event.id, event.title, event.start, formData.comment, formData.icon);
			                console.log("캘린더 이벤트 업데이트 완료");
			            }
			            
			            Swal.close();
					} else {
						console.error("이벤트 서버 수정 실패: ", serverResponse.error);
			            Swal.fire("수정 실패", "이벤트 수정에 실패했습니다: " + serverResponse.error, "error");
					}
				} catch (error) {
			        console.error("이벤트 수정 실패: ", error);
			        Swal.fire("연결 실패", "서버 연결에 실패했습니다.", "error");
			    }
         	}
            
         // -----------------------------------------------------------------------------------------------------------------------
            
         	// 이벤트 삭제 처리 함수 //
         	async function handleEventDelete(eventData) {
         		// 삭제 확인 대화상자
         	    const result = await Swal.fire({
         	        title: '이벤트 삭제',
         	        text: '정말로 이 이벤트를 삭제하시겠습니까?',
         	        icon: 'warning',
         	        showCancelButton: true,
         	        confirmButtonColor: '#EF5327',
         	        cancelButtonColor: '#6c757d',
         	        confirmButtonText: '삭제',
         	        cancelButtonText: '취소',
         	       customClass: {
						popup: 'swal2-no-padding'
					},
					showClass: {
						popup: ''
					},
					hideClass: {
						popup: ''
					}
         	    });
         		
         		if(result.isConfirmed) {
					try{
	         			const serverResponse = await deleteEventFromServer(eventData.id);
	         			
	         			if(serverResponse.success) {
	         				console.log("이벤트 서버 삭제 완료: ", serverResponse.message);
	         				
	         				// 캘린더에서 이벤트 제거
	         				const event = calendar.getEventById(eventData.id);
	         				if(event) {
								const eventDateStr = event.startStr;
								event.remove();
								
								// UI 업데이트 = 해당 날짜에 다른 이벤트가 있는지 확인
								const remainingEvents = calendar.getEvents().filter(ev => ev.startStr.startsWith(eventDateStr));
								
								if(remainingEvents.length > 0) {
									// 다른 이벤트가 있따면 첫 번째 이벤트 표시하기
									const firstEvent = remainingEvents[0];
									const comment = firstEvent.extendedProps && firstEvent.extendedProps.comment ? firstEvent.extendedProps.comment : '';
			                        const icon = firstEvent.extendedProps && firstEvent.extendedProps.icon ? firstEvent.extendedProps.icon : '';
			                        showEventInfo(firstEvent.id, firstEvent.title, firstEvent.start, comment, icon);
			                        selectedEventId = firstEvent.id;
			                        showDateInfo(eventDateStr, true);
								} else {
									//다른 이벤트가 없으면 빈 상태로 표시
									showNoEventInfo(eventDateStr);
									selectedEventId = null;
									showDateInfo(eventDateStr, false);
								}
								
								console.log('캘린더 이벤트 삭제 완료');
	         				}
	         				
	         				console.log('삭제 기능 진행 완료');
	         			} else {
							console.log('이벤트 서버 삭제 실패: ' + serverResponse.error);
	         			}
					} catch (error) {
			            console.error("이벤트 삭제 실패: ", error);
			            Swal.fire("연결 실패", "서버 연결에 실패했습니다.", "error");
					}
         		}
			}
         
         // -----------------------------------------------------------------------------------------------------------------------
         
         	// 펀드리스트, 초대장 호출 함수
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
			          + '  <a href="/invitation/list"><button class="btn-basic btn-orange size-normal">초대장 만들기</button></a>'
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
			          + '  <img class="middle-icon" src="../../../assets/icon/icon-cross.svg" />'
			          + '  <div class="text-18">펀딩 리스트가 비었어요</div>'
			          + '  <a href="/funding/wish"><button class="btn-basic btn-orange size-normal">펀딩 관리하기</button></a>'
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
			          + '    <a href="/funding/myfunding">전체보기&gt;</a>'
			          + '  </div>'
			          + '</div>';
			    }
			
			    eventDetailDiv.innerHTML = html;
			    eventDetailDiv.style.display = 'block';
			}
		});
	</script>
</body>