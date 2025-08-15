<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <!-- CDN(외부 사이트 프리셋) 리셋 css 대용-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    <!-- 난 외부링크 못 믿겠다! 하시는 분은 CDN을 삭제 or 주석처리 후 아래의 css링크 주석 해제 후 사용할것 -->
    <!-- <link rel="stylesheet" href="../Global_css/reset.css"> -->
    <link rel="stylesheet" href="../../Global_css/Global.css">     <!-- 본인 파일의 경로에 맞게 수정해야함 -->
    <link rel="stylesheet" href="../css/calender_stylesheet.css">
    <link rel="stylesheet" href="../../Global_css/moduler.css">
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
                <h2 class="header-sub">캘린더</h2>
            </div>
            <div class="sec-content-main">
                <div class="left-main content-height">
                    <img class="dummy-calender" src="../dummy_calender.JPG">
                </div>
                <div class="right-main content-height">
                    <div class="no-event">
                        <img class="middle-icon" src="../../asset/icon-calendar-exclamation.svg" />
                        <div class="text-18">등록된 기념일이 없어요</div>
                        <button class="btn-basic btn-orange size-normal">기념일 등록하기</button>
                    </div>
                </div>
            </div>


        </div>
    </content>
    <footer class="controller">
        <div id="sec-footer" class="sector">
            <div class="footer-links">
                <a href="#terms">이용약관</a>  |
                <a href="#privacy">개인정보처리방침</a> |
                <a href="#exchange">교환/반품 안내</a>  |
                <a href="#faq">자주 묻는 질문</a>   |
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
</body>
</html>