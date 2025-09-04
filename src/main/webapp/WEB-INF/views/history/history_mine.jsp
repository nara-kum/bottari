<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

				<title>보따리몰</title>
			</head>

			<body class="family">
				<!------------------------ Header호출 ----------------------->
				<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
				<!-- ---------------------------------------------------- -->

				<div class="screen-wrapper">
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
								<c:forEach items="${hMap}" var="entry">
									<div class="purchase-by-date">
										<div class="date">
											${entry.key}
										</div>
										<div class="column-flex-box gap-10">
											<c:forEach items="${entry.value}" var="main">
												<c:forEach items="${main.productDetailList}" var="product">
													<c:choose>
														<c:when test="${product.funding_no != 0}">
															<c:forEach items="${main.fundingDetailList}" var="funding">
																<c:if
																	test="${product.funding_no == funding.funding_no}">
																	<div class="list-basic list-1200 between-flex-box">
																		<div class="row-flex-box">
																			<a href="/shop/productPage?productNo=${product.product_no}">
																				<img class="list-img-100" src="${product.itemimg}">
																			</a>
																			<div class="column-flex-box">
																				<a href="/shop/productPage?productNo=${product.product_no}">
																					<div class="text-14 detail">${product.brand}</div>
																				</a>
																				<div class="text-14 detail">
																					${product.title}</div>
																				<div class="text-14 detail"><span
																						class="inv-badge"
																						aria-label="펀딩 있음">🎁 펀딩</span>
																				</div>
																				<div class="text-16 bold detail">
																					<fmt:formatNumber
																						value="${product.payment_amount}"
																						type="currency"
																						currencySymbol="" />원
																				</div>
																			</div>
																		</div>
																		<div class="column-flex-box">
																			<div class="show-detail text-align-right">
																				주문번호: ${product.order_no}</div>
																			<div class="show-detail text-align-right">
																				<c:if
																					test="${funding.funding_status == 'ing'}">
																					펀딩 진행중
																				</c:if>
																				<c:if
																					test="${funding.funding_status == 'done'}">
																					펀딩 완료됨
																				</c:if>
																				<c:if
																					test="${funding.funding_status != 'ing' && funding.funding_status != 'done'}">
																					펀딩 취소됨
																				</c:if>
																			</div>
																			<div
																				class="show-detail text-align-right detail">
																				<a
																					href="/history/detail?order_no=${product.order_no}">상세보기></a>
																			</div>
																		</div>
																	</div>
																</c:if>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="list-basic list-1200 between-flex-box">
																<div class="row-flex-box">
																	<img class="list-img-100" src="${product.itemimg}">
																	<div class="column-flex-box">
																		<div class="text-14 detail">${product.brand}
																		</div>
																		<div class="text-14 detail">${product.title}
																		</div>
																		<div class="text-14 detail">
																			<fmt:formatNumber value="${product.price}"
																				type="currency" currencySymbol="" />원 |
																			수량: ${product.quantity}개
																		</div>
																		<div class="text-16 bold detail">결제금액:
																			<fmt:formatNumber
																				value="${product.payment_amount}"
																				type="currency" currencySymbol="" />원
																		</div>
																	</div>
																</div>
																<div class="column-flex-box">
																	<div class="show-detail text-align-right">주문번호:
																		${product.order_no}</div>
																	<div class="show-detail text-align-right detail"><a
																			href="/history/detail?order_no=${product.order_no}">상세보기></a>
																	</div>
																</div>
															</div>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:forEach>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</content>
					<!------------------------ Footer호출 ----------------------->
					<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
					<!-- ---------------------------------------------------- -->
				</div>
			</body>

			</html>