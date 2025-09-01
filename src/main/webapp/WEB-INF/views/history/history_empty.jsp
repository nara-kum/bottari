<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <!-- CDN(외부 사이트 프리셋) 리셋 css 대용-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    <!-- 난 외부링크 못 믿겠다! 하시는 분은 CDN을 삭제 or 주석처리 후 아래의 css링크 주석 해제 후 사용할것 -->
    <!-- <link rel="stylesheet" href="../Global_css/reset.css"> -->
    <link rel="stylesheet" href="/assets/css/Global.css"> <!-- 본인 파일의 경로에 맞게 수정해야함 -->
    <link rel="stylesheet" href="/assets/css/history.css">
    <link rel="stylesheet" href="/assets/css/moduler.css">
</head>

<body class="family">
    <!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <!-- 여기부터 코딩 시작!! -->
                <h2 class="header-sub">구매내역</h2>
            </div>
            <div class="sec-content-main">
                <div class="filter-area">
                    <img class="icon-small" src="/assets/icon/icon-calendar.svg">
                    <select name="period" class="filter-period">
                        <option value="sixMonth">최근 6개월</option>
                        <option value="oneYear">최근 1년</option>
                        <option value="threeYear">최근 3년</option>
                        <option value="all">전체</option>
                    </select>
                    <img class="icon-small" src="/assets/icon/icon-filter.svg">
                    <input id="filter-name" class="search-name" type="text">
                    <img class="icon-small more-detail" src="/assets/icon/icon-search.svg">
                </div>
                <div class="column-flex-box gap-10 align-center">
                	<div class="text-16"> 이런 구매내역이 비어있어요! </div>
                	<a href="/shop/bottarimall"><button type="button" class="button-basic button-orange size-normal">쇼핑몰 가기</button></a>
                </div>
            </div>
        </div>
    </content>
    <!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
</body>

</html>