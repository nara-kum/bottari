<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../../assets/css/wishlist.css">
    <title>wishlist</title>
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
                    <img class="header-icon" src="../../../assets/icon/icon-caret-down.svg">
                </a>
            </div>
        </div>
    </header>

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
                    <div class="a-product">
                        <div class="image-row">
                            <input id="chk-1" type="checkbox" class="product-checkbox">
                            <img class="product-image" src="../../../assets/images/eki.jpg" /> <!--상품이미지-->

                            <!-- 텍스트 가로 정렬 영역 -->
                            <div class="product-info">
                                <div class="buy">이키</div><!--판매처-->
                                <div class="product-name">&#34;신생아 오가닉 선물&#34; [임신/출산축하] &#34;뱀띠 아기선물&#34; 유기농 7종 맞춤선물세트
                                </div>
                                <div class="price">38,900원</div> <!--가격-->

                                <div class="image-row">
                                    <div class="shopping-cart">
                                        <img src="../../../assets/icon/icon-shopping-cart.svg" /> <!--장바구니-->
                                    </div>
                                    <img src="../../../assets/images/heart.jpg" /> <!-- 하트(찜) -->
                                </div>
                            </div> <!-- "product-info" 끝나는 지점    -->
                        </div> <!--  image-row 끝나는 지점    -->
                    </div>

                    <!--2 번째 상품이미지, 판매처, 상품명, 가격, 장바구니, 하트(찜) -->
                    <div class="a-product">
                        <div class="image-row">
                            <input id="chk-1" type="checkbox" class="product-checkbox">
                            <img class="product-image" src="../../../assets/images/mood-light.jpg" /> <!--상품이미지-->

                            <!-- 텍스트 가로 정렬 영역 -->
                            <div class="product-info">
                                <div class="buy">레이문</div> <!--판매처-->
                                <div class="product-name">&#34;결혼선물 집들이선물&#34; [레이문] 주문제작 드로잉 무드등 L사이즈(인물테두리컷팅) ...
                                </div>
                                <div class="price">39,800원</div> <!--가격-->

                                <div class="image-row">
                                    <div class="shopping-cart">
                                        <img src="../../../assets/icon/icon-shopping-cart.svg" /> <!--장바구니-->
                                    </div>
                                    <img src="../../../assets/images/heart.jpg" /> <!--하트(찜)-->
                                </div>
                            </div> <!-- "product-info" 끝나는 지점    -->
                        </div> <!--  image-row 끝나는 지점    -->
                    </div>

                    <!--3 번째 상품이미지, 판매처, 상품명, 가격, 장바구니, 하트(찜) -->
                    <div class="a-product">
                        <div class="image-row">
                            <input id="chk-1" type="checkbox" class="product-checkbox">
                            <img class="product-image" src="../../../assets/images/cup.jpg" /> <!--상품이미지-->

                            <!-- 텍스트 가로 정렬 영역 -->
                            <div class="product-info">
                                <div class="buy">헤이루미(키친)</div> <!--판매처-->
                                <div class="product-name">&#34;봄날의 우리&#34; [선물포장+엽서증정] Our Marriage 웨딩 머그컵 2P 세트 / 신혼부부
                                </div>
                                <div class="price">20,900원</div> <!--가격-->

                                <div class="image-row">
                                    <div class="shopping-cart">
                                        <img src="../../../assets/icon/icon-shopping-cart.svg" /> <!--장바구니-->
                                    </div>
                                    <img src="../../../assets/images/heart.jpg" /> <!--하트(찜)-->
                                    
                                </div>
                            </div> <!-- "product-info" 끝나는 지점    -->
                        </div> <!--  image-row 끝나는 지점    -->
                    </div>

                    <!--4 번째 상품이미지, 판매처, 상품명, 가격, 장바구니, 하트(찜) -->
                    <div class="a-product">
                        <div class="image-row">
                            <input id="chk-1" type="checkbox" class="product-checkbox">
                            <img class="product-image" src="../../../assets/images/flower.jpg" /> <!--상품이미지-->

                            <!-- 텍스트 가로 정렬 영역 -->
                            <div class="product-info">
                                <div class="buy">댕이네꽃밭</div> <!--판매처-->
                                <div class="product-name">[어버이날 스승의날] &#34;감사합니다사랑합니다&#34; [당일배송] 카네이션꽃다발+고급 하트...</div>
                                <div class="price">22,900원</div> <!--가격-->

                                <div class="image-row">
                                    <div class="shopping-cart">
                                        <img src="../../../assets/icon/icon-shopping-cart.svg" /> <!--장바구니-->
                                    </div>
                                    <img src="../../../assets/images/heart.jpg" /> <!--하트(찜)-->
                                </div>
                            </div> <!-- "product-info" 끝나는 지점    -->
                        </div> <!--  image-row 끝나는 지점    -->
                    </div>

                    <!--5 번째 상품이미지, 판매처, 상품명, 가격, 장바구니, 하트(찜) -->
                    <div class="a-product">
                        <div class="image-row">
                            <input id="chk-1" type="checkbox" class="product-checkbox">
                            <img class="product-image" src="../../../assets/images/cow.jpg" /> <!--상품이미지-->

                            <!-- 텍스트 가로 정렬 영역 -->
                            <div class="product-info">
                                <div class="buy">한우맘</div> <!--판매처-->
                                <div class="product-name">한우맘 1++등급 한우 패밀리 프리미엄 홈마카세 1.4kg(등심+살치+갈비+안심+채끝)...</div>
                                <div class="price">249,000원</div> <!--가격-->

                                <div class="image-row">
                                    <div class="shopping-cart">
                                        <img src="../../../assets/icon/icon-shopping-cart.svg" /> <!--장바구니-->
                                    </div>
                                    <img src="../../../assets/images/heart.jpg" /> <!--하트(찜)-->
                                </div>
                            </div> <!-- "product-info" 끝나는 지점    -->
                        </div> <!--  image-row 끝나는 지점    -->
                    </div> <!--  o-product -->

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

                        <!-- 1번 상품 5%, 전액 -->
                        <div class="right-product-box">
                            <div class="right-image">
                                <img src="../../../assets/images/eki.jpg" />
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
                                            <span class="text-sale">1,945원</span> <!-- 원가에서 5% 가격 -->
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- 2번 상품 5%, 전액 -->
                        <div class="right-product-box">
                            <div class="right-image">
                                <img src="../../../assets/images/mood-light.jpg" />
                                <div class="product-info">
                                    <div class="form-group2">
                                        <div class="right-choice-product">&#34;결혼선물 집들이선물&#34; [레이문] 주문제작 드로잉 무드등...</div>
                                    </div>
                                    <div class="form-group">
                                        <span for="rdo-o">전액</span>
                                        <input type="radio" name="range1" value="">
                                        <div class="sale-price">
                                            <span for="rdo-o">5%</span>
                                            <input type="radio" name="range1" value="">
                                            <span class="text-sale">1,990원</span> <!-- 원가에서 5% 가격 -->
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- 3번 상품 5%, 전액 -->
                        <div class="right-product-box">
                            <div class="right-image">
                                <img src="../../../assets/images/cup.jpg" />
                                <div class="product-info">
                                    <div class="form-group2">
                                        <div class="right-choice-product">&#34;봄날의 우리&#34; [선물포장+엽서증정] 머그컵 세트...</div>
                                    </div>
                                    <div class="form-group">
                                        <span for="rdo-o">전액</span>
                                        <input type="radio" name="range1" value="">
                                        <div class="sale-price">
                                            <span for="rdo-o">5%</span>
                                            <input type="radio" name="range1" value="">
                                            <span class="text-sale">1,045원</span> <!-- 원가에서 5% 가격 -->
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- 4번 상품 5%, 전액 -->
                        <div class="right-product-box">
                            <div class="right-image">
                                <img src="../../../assets/images/flower.jpg" />
                                <div class="product-info">
                                    <div class="form-group2">
                                        <div class="right-choice-product">[어버이날 스승의날] &#34;감사합니다 카네이션꽃...</div>
                                    </div>
                                    <div class="form-group">
                                        <span for="rdo-o">전액</span>
                                        <input type="radio" name="range1" value="">
                                        <div class="sale-price">
                                            <span for="rdo-o">5%</span>
                                            <input type="radio" name="range1" value="">
                                            <span class="text-sale">1,045원</span> <!-- 원가에서 5% 가격 -->
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- 5번 상품 5%, 전액 -->
                        <div class="right-product-box">
                            <div class="right-image">
                                <img src="../../../assets/images/cow.jpg" />
                                <div class="product-info">
                                    <div class="form-group2">
                                        <div class="right-choice-product">한우맘 1++등급 한우 패밀리 프리미엄 1.4kg(채끝)</div>
                                    </div>
                                    <div class="form-group">
                                        <span for="rdo-o">전액</span>
                                        <input type="radio" name="range1" value="">
                                        <div class="sale-price">
                                            <span for="rdo-o">5%</span>
                                            <input type="radio" name="range1" value="">
                                            <span class="text-sale">12,450원</span> <!-- 원가에서 5% 가격 -->
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>

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
        
</body>
</html>