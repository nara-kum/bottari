<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>bottari 초대장 전체보</title>
    <link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../assets/css/invitation.css">
</head>

<body class="family">

<!------------------------ Header호출 ----------------------->
<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
<!-- ---------------------------------------------------- -->

    <!-- 본문 -->
    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <h2>초대장 전체보기</h2>
            </div>
            <div class="sec-content-main">

                <div class="list-stack">
                    <div class="section-header">

                    </div>

                    <div class="card-container">

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