<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/history.css">

    <title>보따리몰</title>
</head>

<body class="family">

	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title header-sub">
                <h2>구매내역</h2>
            </div>
            <div class="sec-content-main">
                <div class="filter-area">
                    <img class="icon-small" src="../../asset/icon-interrogation.svg">
                    <select name="period" class="filter-period">
                        <option>최근 6개월</option>
                        <option>최근 1년</option>
                        <option>최근 3년</option>
                    </select>
                    <img class="icon-small" src="../../asset/icon-interrogation.svg">
                    <input name="filter-name" class="search-name" type="text">
                    <img class="icon-small" src="../../asset/icon-interrogation.svg">
                    <div class="category-box">
                        <button name="cat-marry" class="filter-category">결혼</button>
                        <button name="cat-birthday" class="filter-category">생일</button>
                        <button name="cat-first-birthday" class="filter-category">돌잔치</button>
                        <button name="cat-event" class="filter-category">이벤트</button>
                        <button name="cat-calebrate" class="filter-category">축하</button>
                        <button name="cat-thanks" class="filter-category">감사</button>
                    </div>
                    <img class="icon-small more-detail" src="../../asset/icon-interrogation.svg">
                </div>
                <div class="purchase-by-date">
                    <div class="date">
                        2025 . 07 . 31
                    </div>
                    <div class="goods-list list-basic list-1200 between-flex-box">
                        <div class="row-flex-box">
                            <img class="list-img-100" src="../임시.JPG">
                            <div class="column-flex-box">
                                <div class="text-14 detail">르라보</div>
                                <div class="text-14 detail">“단독 선출시” [NEW] 퍼퓨밍 핸드 크림 30ML</div>
                                <div class="text-16 bold detail">38,000원</div>
                            </div>
                        </div>
                        <div class="column-flex-box">
                            <div class="show-detail text-align-right">주문번호: 000123123</div>
                            <div class="show-detail text-align-right">임시 펀딩정보</div>
                            <div class="show-detail text-align-right detail"><a href="">상세보기></a></div>
                        </div>
                    </div>
                </div>
                <div class="purchase-by-date">
                    <div class="date">
                        2025 . 06 . 20
                    </div>
                    <div class="goods-list list-basic list-1200 between-flex-box">
                        <div class="row-flex-box">
                            <img class="list-img-100" src="../임시.JPG">
                            <div class="column-flex-box">
                                <div class="text-14 detail">맥(MAC)</div>
                                <div class="text-14 detail">“단하루 루비우 증정” [단독/각인] 맥 BEST 립밤 (=미니립)</div>
                                <div class="text-16 bold detail">38,000원</div>
                            </div>
                        </div>
                        <div class="column-flex-box">
                            <div class="show-detail text-align-right">주문번호: 000123123</div>
                            <div class="show-detail text-align-right">임시 펀딩정보</div>
                            <div class="show-detail text-align-right detail"><a href="">상세보기></a></div>
                        </div>
                    </div>

                    <!-- 여러상품 버전 -->
                    <div class="goods-list list-basic list-1200">
                        <div class="left-side">
                            <div class="multi-goods-img">
                                <img class="img" src="../임시.JPG">
                                <img class="img" src="../임시2.JPG">
                                <img class="img" src="">
                                <img class="img" src="">
                            </div>
                            <div class="column-flex-box">
                                <div class="text-14 detail">맥(MAC)</div>
                                <div class="text-14 detail">“단하루 루비우 증정” [단독/각인] 맥 BEST 립밤 (=미니립)</div>
                                <div class="text-16 bold detail">38,000원</div>
                            </div>
                        </div>
                        <div class="column-flex-box">
                            <div class="show-detail text-align-right">주문번호: 000123123</div>
                            <div class="show-detail text-align-right">임시 펀딩정보</div>
                            <div class="show-detail text-align-right detail"><a href="">상세보기></a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </content>

<!------------------------ Footer호출 ----------------------->
<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
<!-- ---------------------------------------------------- -->
</body>
</html>