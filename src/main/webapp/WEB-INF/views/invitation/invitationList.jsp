<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>bottari 초대장 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/invitationList.css">
</head>

<body class="family">

<!------------------------ Header호출 ----------------------->
<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
<!-- ---------------------------------------------------- -->

    <!-- 본문 -->
    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <h2 class="header-sub">나의 초대장</h2>
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
                    </div>
                </div>
            </div>
        </div>
    </content>

<!------------------------ Footer호출 ----------------------->
<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
<!-- ---------------------------------------------------- -->

<script>
(function(){
  const CTX = "${pageContext.request.contextPath}";
  document.addEventListener('DOMContentLoaded', function(){
    const btn = document.querySelector('.create-button');
    if (btn) {
      btn.addEventListener('click', function(){
        window.location.href = CTX + "/invitationForm";
      });
    }
  });
})();
</script>
</body>

</html>