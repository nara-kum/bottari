<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <!-- CDN(외부 사이트 프리셋) 리셋 css 대용-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    
    <!-- global.css호출 -->
    <link rel="stylesheet" href="../../../assets/css/Global.css"> <!-- 본인 파일의 경로에 맞게 수정해야함 -->
    
    <!-- sweetalert cdn 호출 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- full_calender 호출 -->
    <link href='../../../assets/css/calender/full_calender/main.css' rel='stylesheet' />
    <script src='../../../assets/js/full_calender/main.js'></script>
    
    <!-- local css 호출-->
    <link rel="stylesheet" href="../../../assets/css/calender/calender_stylesheet.css">
    <link rel="stylesheet" href="../../../assets/css/calender/all_in_one.css"> <!-- 본인 파일의 경로에 맞게 수정해야함 -->
    <link rel="stylesheet" href="../../../assets/css/calender/moduler.css">
</head>

<body class="family">
    <header class="controller">
        <div id="sec-header" class="sector">
            <div class="left-side">
                <a href=""><img class="header-logo" src="../../asset/Logo_colored.svg"></a>
                <h1 class="header-menu"><a href="">캘린더</a></h1>
                <h1 class="header-menu"><a href="">펀딩</a></h1>
                <h1 class="header-menu"><a href="">초대장</a></h1>
                <h1 class="header-menu"><a href="">구매내역</a></h1>
            </div>
            <div class="right-side">
                <a href=""><img class="header-icon header-shopping-cart" src="../../asset/icon-shopping-cart.svg"></a>
                <h1 class="header-usermenu">사용자이름</h1>
                <a href=""><img class="header-icon" src="../../asset/icon-caret-down.svg"></a>
            </div>
        </div>
    </header>
    <content class="controller">
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
    </content>
    <footer class="controller">
        <div id="sec-footer" class="sector">
            <div class="footer-links">
                <a href="#terms">이용약관</a> |
                <a href="#privacy">개인정보처리방침</a> |
                <a href="#exchange">교환/반품 안내</a> |
                <a href="#faq">자주 묻는 질문</a> |
                <a href="#contact">1:1 문의</a>
            </div>
            <div class="company-info">
                <p>
                    <span class="company-name">상호: 주식회사 보따리</span> |
                    <span class="company-name">대표: 김보따리</span> |
                    <span>사업자등록번호: 123-45-67890</span> |
                    <span>통신판매업신고: 제2025-서울강동-0001</span>
                </p>
                <p class="contact-info">
                    주소: 서울특별시 강동구 천호대로 1027, 5층 |
                    고객센터: 02-1234-5678
                </p>
                <p class="contact-info">
                    운영시간: 평일 10:00 ~ 18:00 (점심시간 12:00~13:00)
                </p>
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
            lastClickedDate = dateStr;
        }

        function getClickedDate() {
            return lastClickedDate;
        }

        document.addEventListener('DOMContentLoaded', function () {
            let lastClickTime = 0;
            let selectedEventId = null; // 삭제할 이벤트 추적용

            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prevYear,prev today',
                    center: 'title',
                    right: 'next,nextYear'
                },

                // 타이틀 포매 변경
                titleFormat: {
                    year: 'numeric',
                    month: 'short'
                },


                selectable: false, // 날짜 드래그(범위 선택) 비활성화
                selectMirror: true,
                // 클릭시 창 변경 제한
                navLinks: false,
                editable: true,
                dateClick: function (info) {
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

                    const clickedCell = document.querySelector(`.fc-daygrid-day[data-date="${info.dateStr}"]`);
                    if (clickedCell) {
                        clickedCell.style.backgroundColor = '#EF5327';
                        const dayNumber = clickedCell.querySelector('.fc-daygrid-day-number');
                        if (dayNumber) {
                            dayNumber.style.color = '#fff';
                        }
                    }
                },
                eventClick: function (arg) {
                    showEventInfo(arg.event, arg.event.startStr.split('T')[0]);
                },
                dayMaxEvents: true,
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
                showDateInfo(todayStr, true);   // 이벤트 있음
                showEventInfo(todayEvents[0], todayStr);
                setTimeout(() => {
                    document.querySelectorAll('.fc-daygrid-day').forEach(cell => {
                        cell.style.backgroundColor = '';
                        cell.querySelector('.fc-daygrid-day-number').style.color = '';
                    });
                    const clickedCell = document.querySelector(`.fc-daygrid-day[data-date="${todayStr}"]`);
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
                const dateInfoDiv = document.getElementById('date-info');
                if (hasEvent) {
                    dateInfoDiv.innerHTML = `<div class="between-flex-box">
                                                <div class="header-sub">${dateStr}</div>
                                                <div class="row-flex-box">
                                                    <img id="create-event-btn" class="popup-icon" src="../../asset/icon-add.svg">
                                                    <img id="edit-event-btn" class="popup-icon" src="../../asset/icon-menu-dots.svg">
                                                </div>
                                            </div>`;
                } else {
                    dateInfoDiv.innerHTML = `<div class="between-flex-box">
                                                <div class="header-sub">${dateStr}</div>
                                                <div class="row-flex-box">
                                                    <img id="create-event-btn" class="popup-icon" src="../../asset/icon-add.svg">
                                                </div>
                                            </div>`;
                }
                dateInfoDiv.style.display = 'block';

                document.getElementById('create-event-btn').onclick = function () {
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
            function showEventInfo(event, dateStr) {
                const eventInfoDiv = document.getElementById('event-info');
                selectedEventId = event.id;
                eventInfoDiv.innerHTML = `
                    <strong>${event.title}</strong><br>
                    <span style="font-size:12px;color:#888;">${event.startStr}</span>
                `;
                eventInfoDiv.style.display = 'block';
            }

            // 이벤트가 없을 때
            function showNoEventInfo(dateStr) {
                const eventInfoDiv = document.getElementById('event-info');
                eventInfoDiv.innerHTML = `
                    <div style="margin-bottom:12px;">이 날짜에는 이벤트가 없습니다.</div>
                `;
                eventInfoDiv.style.display = 'block';
                selectedEventId = null;
            }
            // --- 전역 함수로 분리 끝 ---

            // 삭제 함수 (구현 필요)
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
                // alert(dateStr + " 일정 추가 팝업을 구현하세요.");

                Swal.fire({
                    html: `
            <div id="event-add-popup">
                <div class="cancel">
                    <button id="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../asset/icon-cross.svg"></button>
                </div>
                <div class="event-name">
                    <div class="event-icon-box">
                        <img class="popup-icon" src="../../asset/icon-interrogation.svg">
                        <img class="popup-icon" src="../../asset/icon-caret-down.svg">
                    </div>
                    <div class="event-name-box">
                        <input name="eventName" class="input-name" placeholder="일정 제목">
                    </div>
                </div>              
                <div class="event-comment">
                    <img class="popup-icon" src="../../asset/icon-comment.svg">
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
                    <button name="event-cancel-btn" class="btn-cancel"><img class="popup-icon" src="../../asset/icon-cross.svg"></button>
                </div>
                <div class="event-name">
                    <div class="event-icon-box">
                        <img class="popup-icon" src="../../asset/icon-interrogation.svg">
                        <img class="popup-icon" src="../../asset/icon-caret-down.svg">
                    </div>
                    <div class="event-name-box">
                        <input name="eventName" class="input-name" placeholder="일정 제목" value="${event.title}">
                    </div>
                </div>              
                <div class="event-comment">
                    <img class="popup-icon" src="../../asset/icon-comment.svg">
                    <textarea class="input-comment" placeholder="메모 입력">${event.extendedProps && event.extendedProps.explanation ? event.extendedProps.explanation : ''}</textarea>
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