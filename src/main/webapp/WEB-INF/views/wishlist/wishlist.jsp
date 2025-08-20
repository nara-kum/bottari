<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wishlist.css">
	<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>

<body class="family">

	<!-- Header호출 -->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
    <!-- Header호출 -->

    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <h2 class="header-sub"><a href="">펀딩 관리</a></h2>
                <h2 class="funding">
                    <div class = "my-fun"><a href="">마이 펀딩</a></div>
                    <div class = "friend-fun"><a href="">친구 펀딩</a></div>
                </h2>
            </div>

            <div class="sec-content-main">

                <div class="left-main content-height">

                    <h2 class="top-text">위시리스트</h2>
                    
                    <c:forEach items="${requestScope.wishVO}" var="wishVO">
                    <div class="a-product">
                        <div class="image-row">
                            <input id="chk-1" type="checkbox" class="product-checkbox">
                            <img class="product-image" src="${pageContext.request.contextPath}/assets/images/eki.jpg" /> <!--상품이미지-->

                            <!-- 텍스트 가로 정렬 영역 -->
                            <div class="product-info">
                                <div class="buy">${wishVO.brand}</div><!--판매처-->
                                <div class="product-name">${wishVO.title}</div>
                                <div class="price">${wishVO.price} 원</div> <!--가격-->

                                <div class="image-row">
                                    <div class="shopping-cart">
                                        <img src="${pageContext.request.contextPath}/assets/icon/icon-shopping-cart.svg" /> <!--장바구니-->
                                    </div>
                                    <img src="${pageContext.request.contextPath}/assets/images/heart.jpg" /> <!-- 하트(찜) -->
                                </div>
                            </div> <!-- "product-info" 끝나는 지점    -->
                        </div> <!--  image-row 끝나는 지점    -->
                    </div>
                    </c:forEach>

                </div> <!-- <div class="left-main content-height"> -->

                <div class="right-main content-height">
                    <h2 class="top-text">선택한 펀딩</h2>
                    
                    <div class="funding-controls">
                        <select id="funding-table">
                            <option value="">-- 기념일 선택 --</option>
                            <option value="a">7월 11일 어머니 환갑잔치</option>
                        </select>

                        <!-- 1번 상품 5%, 전액 
                        <div class="right-product-box">
                            <div class="right-image">
                                <img src="${pageContext.request.contextPath}/assets/images/eki.jpg" />
                                <div class="product-info">
                                    <div class="form-group2">
                                        <div class="right-choice-product">"신생아 오가닉 선물" [임신/출산축하] "뱀띠 아기선물"</div>
                                    </div>
                                    <div class="form-group">
                                        <span for="rdo-o">전액</span>
                                        <input type="radio" name="range1" value="">
                                        <div class="sale-price">
                                            <span for="rdo-o">5%</span>
                                            <input type="radio" name="range1" value="">
                                        </div>
                                            <span class="text-sale">1,945원</span>
                                    </div>
                                </div>

                            </div>
                        </div>
                        -->
                    </div>

                    <a href=""><button class="btn-funding1" type="submit">펀딩시작하기</button></a>
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

<script>
	$(document).ready(function(){
	    console.log('돔');
	    
	
	})


</script>
</body>
</html>