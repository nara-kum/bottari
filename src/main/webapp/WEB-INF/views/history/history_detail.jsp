<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/history.css">
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
            <c:forEach items="${requestScope.hList}" var="vo">
                <div class="list-basic list-1200 between-flex-box">
                    <div class="row-flex-box">
                        <img class="list-img-100" src="${vo.itemimg}">
                        <div class="column-flex-box">
                            <div class="text-14 detail">${vo.brand}</div>
                            <div class="text-14 detail">${vo.title} | ${vo.quantity}개</div>
                            <div class="text-16 bold detail"><fmt:formatNumber value="${vo.price}" type="currency" currencySymbol="" />원</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
                <div class="list-basic list-1200 between-flex-box detail">
                    <div class="row-flex-box align-center">
                        <div>주문번호 |&nbsp;</div>
                        <div>${param.order_no}</div>
                    </div>
                    <button type="button" class="btn-basic btn-gray size-small">영수증 보기</button>
                </div>
                <div class="list-basic list-1200 column-flex-box detail">
                    <div class="between-flex-box box-line">
                        <div class="text-16 bold">결제정보</div>
                        <img class="popup-icon" src="">
                    </div>
                    <div class="between-flex-box">
                        <div class="text-14"> 상품금액(${total_quantity}개)</div>
                        <div class="text-14"><fmt:formatNumber value="${total_price}" type="currency" currencySymbol="" />원</div>
                    </div>
                    <div class="between-flex-box">
                        <div class="text-14">배송비</div>
                        <div class="text-14"><fmt:formatNumber value="${shipping_cost}" type="currency" currencySymbol="" />원</div>
                    </div>
                    <div class="between-flex-box">
                        <div class="text-14">총 결제 금액</div>
                        <div class="text-14"><fmt:formatNumber value="${total_amount}" type="currency" currencySymbol="" />원</div>
                    </div>
                </div>
                <div class="list-basic list-1200 column-flex-box detail">
                	<div class="between-flex-box box-line">
                		<div class="text-16 bold">배송정보</div>
                		<img class="popup-icon" alt="택배차" src="/assets/icon/icon-truck-box.svg">
                	</div>
                	<div class="between-flex-box">
                		<div class="text-14">배송상태</div>
                		<div>${delivery_status}</div>
                	</div>
                </div>
                <div class="list-basic list-1200 column-flex-box detail">
                    <div class="between-flex-box box-line">
                        <div class="text-16 bold">배송상품 취소 및 교환/환불 안내</div>
                        <img class="popup-icon" src="/assts/icon/icon-edit.svg">
                    </div>
                    <div class="text-12">구매하신 배송상품의 취소/환불 또는 교환/반품을 원하실 경우에는 다음 내용을 참고해 주세요.
                        > 물품 배송 전 청약 철회 (취소/환불)상품(재화)을 판매자가 배송하기 이전에는 취소 및 환불 가능유효기간 이내에 배송지를 입력하지 않을 경우 자동 취소/환불 절차 진행*
                        청약 철회 방법선물하기 > 선물함 > 주문내역의 해당 주문 상세화면에서 취소/환불 선택
                        > 물품 배송 후 청약 철회 (교환/반품 환불)상품(재화)의 공급을 받은 날로부터 7일 이내 청약 철회 가능* 청약 철회를 할 수 없는 경우소비자의 책임으로 상품(재화)이
                        멸실 또는 훼손된 경우소비자의 사용 또는 일부 소비에 의해 상품(재화)의 가치가 감소한 경우시간의 경과에 의하여 재판매가 곤란한 경우청약 철회 등으로 제 3자에게 중대한
                        피해가 예상되어 사전에 고지한 경우* 청약 철회 방법선물하기 > 선물함 > 주문내역의 해당 주문 상세화면에서 반품/교환 선택수신자가 교환을 신청한 경우 관련 안내는 수신자만
                        받을 수 있습니다.* 청약 철회 비용 부담 안내구매 철회 시 상품 회수 후 3영업일 이내에 환불 조치당사 과실로 인한 반품 교환 비용은 당사 부담고객 변심 또는 동종 상품의
                        사이즈나 색상 교환 시 비용은 고객 부담반품 / 교환비 안내 : 상품상세 > 교환/반품/환불 안내 영역에서 확인* 청약 철회서 양식주문자 계정 :주문일자 :철회일자 :상품명
                        :금액 :철회사유 :
                        > 환불 금액 안내환불은 실제 결제한 금액으로 구매자에게 진행되며, 이로 인해 결제 취소/환불 신청 시 안내된 금액과 다를 수 있습니다.> 환불지연 배상금 안내환불지연이
                        발생하였을 경우 전자상거래법에 따라 환불지연배상금 지급을 요청하실 수 있습니다.* 환불지연에 해당하는 경우카카오의 책임으로 상품공급이 불가한 상태로 결제일로부터 3영업일이
                        경과한 경우반품 상품을 수령한 날로부터 3영업일이 경과하도록 상품대금을 환불하지 않은 경우
                        > 소비자 피해보상, 재화 등에 대한 불만 및 소비자와 사업자간 분쟁 처리에 관한 사항소비자 불만 신청 : 보따리 고객센터 (전화번호)- 상담가능시간 : 평일 09:00 ~
                        18:00 (※ 점심시간 12:00 ~ 13:00)소비자 피해 분쟁 조정의 요청: 공정거래위원회 및 공정거래위원회가 지정한 분쟁 조정 기구
                        > 이용약관(회원약관)보따리 이용약관 참조
                    </div>
                </div>
            </div>
    </content>

	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->
</body>
</html>