<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../../assets/css/nonewish.css">
</head>

<body class="family">
    <header class="controller">
        <div id="sec-header" class="sector">
            <div class="left-side">
                <a href="">
                    <img class="header-logo" src="../../../assets/icon/Logo_colored.svg">
                </a>
                <h1 class="header-menu"><a href="">캘린더</a></h1>
                <h1 class="header-menu"><a href="">펀딩</a></h1>
                <h1 class="header-menu"><a href="">초대장</a></h1>
                <h1 class="header-menu"><a href="">구매내역</a></h1>
            </div>
            <div class="right-side">
                <a href="">
                    <img class="header-icon header-shopping-cart" src="../../../assets/icon/icon-shopping-cart.svg">
                </a>

                <h1 class="header-usermenu">사용자이름</h1>
                <a href="">
                    <img class="header-icon" src="../../../assets/icon/icon-caret-down.svg" alt="아래화살표아이콘">
                </a>
            </div>
        </div>
    </header>

    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <h2 class="header-sub"><a href="">펀딩 관리</a></h2>
                <h2 class="funding">
                    <div class="my-fun"><a href="">마이 펀딩</a></div>
                    <div class="friend-fun"><a href="">친구 펀딩</a></div>
                </h2>
            </div>

            <div class="sec-content-main">

                <div class="left-main content-height">

                    <h2 class="top-text">위시리스트</h2>
                    <div class="box-open-empty">
                        <img src="../../../assets/images/icon-box-open-empty.jpg" alt="비어있는 위시리스트">
                    </div>

                    <div class="none-wish">
                        <div class="text-wish">위시리스트가 비었어요</div>
                        <button><a href="">위시리스트 등록</a></button>
                    </div>


                </div> <!-- <div class="left-main content-height"> -->

                <div class="right-main content-height">
                    <h2 class="top-text">선택한 펀딩</h2>
                    <div class="funding-controls">
                        <select id="funding-table">
                            <option value="">-- 기념일 선택 --</option>
                            <option value="a">7월 11일 어머니 환갑잔치</option>
                            <option value="b">7월 16일 ○○○생일</option>
                            <option value="c">7월 27일 내 생일</option>
                            <option value="d">8월 4일 결혼 기념일</option>
                            <option value="e">8월 8일 돌잔치</option>
                            <option value="f">9월 5일 쫑파티</option>
                        </select>
                    </div>

                    <button class="btn-funding1" type="submit">펀딩시작하기</button>
                </div> <!-- right-main content-height -->
            </div>  <!--sec-content-main-->
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
    
</body>
</html>