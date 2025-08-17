<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>bottari 초대장 관리</title>
    <link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../assets/css/invitationList.css">
</head>

<body class="family">
    <!-- 헤더 -->
    <header class="controller">
        <div id="sec-header" class="sector">
            <div class="left-side">
                <a href=""><img class="header-logo" src="../../assets/icon/Logo_colored.svg"></a>
                <h1 class="header-menu"><a href="">캘린더</a></h1>
                <h1 class="header-menu"><a href="">펀딩</a></h1>
                <h1 class="header-menu"><a href="">초대장</a></h1>
                <h1 class="header-menu"><a href="">구매내역</a></h1>
            </div>
            <div class="right-side">
                <a href=""><img class="header-icon header-shopping-cart" src="../../assets/icon/icon-shopping-cart.svg"></a>
                <h1 class="header-usermenu">사용자이름</h1>
                <a href=""><img class="header-icon" src="../../assets/icon/icon-caret-down.svg"></a>
            </div>
        </div>
    </header>

    <!-- 본문 -->
    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <h2>나의 초대장</h2>
            </div>
            <div class="sec-content-main">

                <div class="list-stack">
                    <div class="section-header">
                        <button class="create-button">초대장 만들기</button>
                    </div>

                    <div class="card-container">
                        <div class="card">
                            <div class="buttons"><button>수정하기</button><button>전체보기</button></div>
                        </div>
                        <div class="card">
                            <div class="buttons"><button>수정하기</button><button>전체보기</button></div>
                        </div>
                        <div class="card">
                            <div class="buttons"><button>수정하기</button><button>전체보기</button></div>
                        </div>
                        <div class="card">
                            <div class="buttons"><button class="disabled">수정하기</button><button>전체보기</button></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </content>

    <!-- 푸터 -->
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
</body>

</html>