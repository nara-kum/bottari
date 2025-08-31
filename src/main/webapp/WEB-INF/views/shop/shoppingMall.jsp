<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop/shoppingMall.css">
</head>

<body class="family">

	<!------------------------ Header호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<content class="controller">
	<div id="sec-contetnt" class="sector">
		<div class="sec-sub-title">
			<div class="sub-title-container">
				<!-- 카테고리 선택 영역 -->
				<h2 class="select-this">전체</h2>
				<div class="category-buttons">
					<button class="sub-title-menu ${empty categoryNo || categoryNo == 0 ? 'active' : ''}" data-category="0" onclick="selectCategory(this, '전체', 0)">전체</button>
					<button class="sub-title-menu ${categoryNo == 1 ? 'active' : ''}" data-category="1" onclick="selectCategory(this, '결혼', 1)">결혼</button>
					<button class="sub-title-menu ${categoryNo == 2 ? 'active' : ''}" data-category="2" onclick="selectCategory(this, '생일', 2)">생일</button>
					<button class="sub-title-menu ${categoryNo == 3 ? 'active' : ''}" data-category="3" onclick="selectCategory(this, '돌잔치', 3)">돌잔치</button>
					<button class="sub-title-menu ${categoryNo == 4 ? 'active' : ''}" data-category="4" onclick="selectCategory(this, '이벤트', 4)">이벤트</button>
					<button class="sub-title-menu ${categoryNo == 5 ? 'active' : ''}" data-category="5" onclick="selectCategory(this, '축하', 5)">축하</button>
					<button class="sub-title-menu ${categoryNo == 6 ? 'active' : ''}" data-category="6" onclick="selectCategory(this, '감사', 6)">감사</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 검색 폼 (강의와 동일한 방식) -->
		<div class="search-price-field">
			<div class="price-filter">
				<div class="price ${empty priceRange || priceRange == 0 ? 'active' : ''}" onclick="selectPriceRange(0)">
					<a>전체</a>
				</div>
				<div class="price ${priceRange == 1 ? 'active' : ''}" onclick="selectPriceRange(1)">3만원 미만</div>
				<div class="price ${priceRange == 2 ? 'active' : ''}" onclick="selectPriceRange(2)">3~5만원대</div>
				<div class="price ${priceRange == 3 ? 'active' : ''}" onclick="selectPriceRange(3)">6~9만원대</div>
				<div class="price ${priceRange == 4 ? 'active' : ''}" onclick="selectPriceRange(4)">10만원 이상</div>
			</div>
		
		<!-- 검색 영역 - 강의와 동일한 방식으로 폼 구성 -->
		<form action="${pageContext.request.contextPath}/shop/bottarimall" method="get">
			<!-- 현재 카테고리 유지를 위한 hidden input -->
			<input type="hidden" name="categoryNo" value="${categoryNo}">
			<input type="hidden" name="priceRange" value="${priceRange}">
			<!-- 검색시 페이지를 1로 리셋 -->
			<input type="hidden" name="crtpage" value="1">
			
			<div class="search-area">
				<input name="kwd" class="rectangle-2" type="text" placeholder="검색어를 입력하세요" value="${kwd}"> 
				<button type="submit" class="search-btn">
					<img class="icon-search" src="${pageContext.request.contextPath}/assets/icon/icon-search.svg">
				</button>
			</div>
		</form>
	</div>
	
	<!-- 검색 결과 정보 표시 -->
	<div class="search-result-info">
		<div class="result-count">
			총 <strong>${pMap.totalCount}</strong>개의 상품이 있습니다
			<c:if test="${not empty kwd}">
				('<strong>${kwd}</strong>' 검색 결과)
			</c:if>
		</div>
	</div>
	
	<!-- 상품 목록 영역 (4x4 그리드로 16개씩 표시) -->
	<div class="sec-content-main">
		<!-- 상품 목록 반복영역 -->
		<c:choose>
			<c:when test="${not empty pMap.productList}">
				<c:forEach var="product" items="${pMap.productList}">
					<div class="goods-wrap" onclick="location.href='${pageContext.request.contextPath}/shop/productPage?productNo=${product.product_no}'" style="cursor: pointer;">
						<div class="goods-img">
							<c:choose>
								<c:when test="${not empty product.itemimg}">
									<img class="main-image"
										src="${pageContext.request.contextPath}/upload/${product.itemimg}"
										alt="${product.title}">
								</c:when>
								<c:otherwise>
									<img class="main-image"
										src="${pageContext.request.contextPath}/assets/upload/default-product.jpg"
										alt="기본 상품 이미지">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="brand-name">${product.brand}</div>
						<div class="goods-title">${product.title}</div>
						<div class="pay-wrap">
							<div class="payment">
								<fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>
							</div>
							<div class="won">원</div>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="no-products">
					<c:choose>
						<c:when test="${not empty kwd}">
							<p>'${kwd}'에 대한 검색 결과가 없습니다.</p>
							<p>다른 검색어를 입력해보세요.</p>
						</c:when>
						<c:otherwise>
							<p>등록된 상품이 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	
	<!-- 페이징 네비게이션 (수정됨: priceRange 파라미터 추가) -->
	<c:if test="${pMap.totalCount > 0}">
		<div id="paging">
			<ul>
				<!-- 이전 화살표 (첫페이지 그룹이 아닐때만 표시) -->
				<c:if test="${pMap.prev}">
					<li><a href="${pageContext.request.contextPath}/shop/bottarimall?crtpage=${pMap.startPageBtnNo-1}&kwd=${kwd}&categoryNo=${categoryNo}&priceRange=${priceRange}">◀</a></li>
				</c:if>
				
				<!-- 페이지 번호들 (1~5 또는 6~10 이런식으로 5개씩 표시) -->
				<c:forEach begin="${pMap.startPageBtnNo}" end="${pMap.endPageBtnNo}" step="1" var="page">
					<c:choose>
						<c:when test="${page == pMap.crtPage}">
							<!-- 현재 페이지는 링크 없이 강조 표시 -->
							<li class="active">${page}</li>
						</c:when>
						<c:otherwise>
							<!-- 다른 페이지는 링크 표시 (수정됨: priceRange 파라미터 추가) -->
							<li><a href="${pageContext.request.contextPath}/shop/bottarimall?crtpage=${page}&kwd=${kwd}&categoryNo=${categoryNo}&priceRange=${priceRange}">${page}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- 다음 화살표 (마지막 페이지 그룹이 아닐때만 표시) -->
				<c:if test="${pMap.next}">
					<li><a href="${pageContext.request.contextPath}/shop/bottarimall?crtpage=${pMap.endPageBtnNo+1}&kwd=${kwd}&categoryNo=${categoryNo}&priceRange=${priceRange}">▶</a></li>
				</c:if>
			</ul>
		</div>
	</c:if>
	
	</content>
	
	<!------------------------ Footer호출 ----------------------->
	<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
	<!-- ---------------------------------------------------- -->

	<script>
	// 카테고리 선택 함수 (기존 함수 수정)
	function selectCategory(element, categoryName, categoryNo) {
		// 모든 버튼의 active 클래스 제거
		document.querySelectorAll('.sub-title-menu').forEach(btn => {
			btn.classList.remove('active');
		});
		
		// 클릭된 버튼에 active 클래스 추가
		element.classList.add('active');
		
		// 제목 변경
		document.querySelector('.select-this').textContent = categoryName;
		
		// 카테고리 변경시 페이지를 1로 리셋하고 이동 (현재 가격대와 검색어 유지)
		location.href = '${pageContext.request.contextPath}/shop/bottarimall?categoryNo=' + categoryNo + '&crtpage=1&kwd=${kwd}&priceRange=${priceRange}';
	}
	
	// 가격대 선택 함수 (수정됨: event.target 처리 개선)
	function selectPriceRange(priceRange) {
		// 모든 가격 버튼의 active 클래스 제거
		document.querySelectorAll('.price').forEach(btn => {
			btn.classList.remove('active');
		});
		
		// 클릭된 버튼에 active 클래스 추가
		event.target.closest('.price').classList.add('active');
		
		// 가격대 변경시 페이지를 1로 리셋하고 이동 (현재 카테고리와 검색어 유지)
		location.href = '${pageContext.request.contextPath}/shop/bottarimall?priceRange=' + priceRange + '&crtpage=1&kwd=${kwd}&categoryNo=${categoryNo}';
	}
	
	// 페이지 로드시 카테고리 제목 설정 (기존 함수 유지)
	window.onload = function() {
		const categoryButtons = document.querySelectorAll('.sub-title-menu');
		categoryButtons.forEach(button => {
			if(button.classList.contains('active')) {
				document.querySelector('.select-this').textContent = button.textContent;
			}
		});
	};
	</script>

</body>

</html>