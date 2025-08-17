<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>bottari 초대장 작성</title>
    <link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../assets/css/invitationForm.css">

</head>

<body class="family">
    <!-- 헤더 -->
    <header class="controller">
        <div id="sec-header" class="sector">
            <div class="left-side">
                <a href=""><img class="header-logo" src="../../assets/icon/Logo_colored.svg"></a>
                <h1 class="header-menu"><a href="">캘린더</a></h1>
                <h1 class="header-menu"><a href="">펀딩</a></h1>
                <h1 class="header-menu"><a href="">초대장</a></h1>
                <h1 class="header-menu"><a href="">구매내역</a></h1>
            </div>
            <div class="right-side">
                <a href=""><img class="header-icon header-shopping-cart" src="../../assets/icon/icon-shopping-cart.svg"></a>
                <h1 class="header-usermenu">사용자이름</h1>
                <a href=""><img class="header-icon" src="../../assets/icon/icon-caret-down.svg"></a>
            </div>
        </div>
    </header>

    <!-- 본문 -->

    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <h2>초대장 작성</h2>
            </div>
            <div class="sec-content-main">
                <div class="content">

                    <div class="card-box anniversary">
                        <div class="sub-title">기념일</div>
                        <select>
                            <option>선택하기</option>
                        </select>
                        <div class="category-buttons">
                            <button class="btn">결혼</button>
                            <button class="btn">생일</button>
                            <button class="btn">돌잔치</button>
                            <button class="btn">이벤트</button>
                            <button class="btn">축하</button>
                            <button class="btn">감사</button>
                        </div>
                    </div>

                    <div class="main-content">
                        <div class="preview-box">
                            <img src="https://via.placeholder.com/300x300.png?text=대표+이미지" alt="대표 이미지">
                        </div>

                        <div class="template-section">
                            <div class="card-box">
                                <div class="sub-title">메인 이미지</div>
                                <div class="template-grid">
                                    <div class="template-card">타입A</div>
                                    <div class="template-card">타입A</div>
                                    <div class="template-card">타입A</div>
                                    <div class="template-card">타입A</div>
                                    <div class="template-card">타입A</div>
                                    <div class="template-card">타입A</div>
                                    <div class="template-card">타입A</div>
                                    <div class="template-card">타입A</div>
                                </div>
                                <div class="upload-info">메인사진<br>이미지의 크기는 15MB 이내로 제한되어 있습니다.</div>

                                <!-- 이미지 업로드 영역 -->
                                <div class="image-upload-box">
                                    <label for="main-image-upload">이미지 첨부</label>
                                    <input type="file" id="main-image-upload" accept="image/*">
                                </div>

                            </div>

                            <div class="card-box">
                                <div class="sub-title">디자인</div>
                                <div class="section">
                                    <div class="small-label">배경</div>
                                    <div class="option-group"><button class="btn">종이</button><button
                                            class="btn">화이트</button></div>

                                    <div class="small-label">테마</div>
                                    <div class="option-group">
                                        <span class="btn"
                                            style="width:20px;height:20px;border-radius:50%;padding:0;background:#d9cdbf;"></span>
                                        <span class="btn"
                                            style="width:20px;height:20px;border-radius:50%;padding:0;background:#e9d6cc;"></span>
                                        <span class="btn"
                                            style="width:20px;height:20px;border-radius:50%;padding:0;background:#e0b5a4;"></span>
                                        <span class="btn"
                                            style="width:20px;height:20px;border-radius:50%;padding:0;background:#a3a1dc;"></span>
                                    </div>

                                    <div class="small-label">폰트</div>
                                    <div class="option-group"><button class="btn">돋움1</button><button
                                            class="btn">돋움2</button><button class="btn">바탕1</button><button
                                            class="btn">바탕2</button>
                                    </div>

                                    <div class="small-label">폰트</div>
                                    <div class="option-group"><button class="btn">보통</button><button
                                            class="btn">약간굵게</button><button class="btn">크게</button></div>

                                    <div class="small-label">신랑/신부 표기 순서</div>
                                    <div class="option-group"><button class="btn">약간굵게</button><button
                                            class="btn">신부먼저</button>
                                    </div>
                                </div>
                            </div>

                            <div class="footer-row">
                                <span><strong>1단계</strong> / 4단계</span>
                                <button class="save-btn">임시저장</button>
                            </div>

                            <div class="card-box">
                                <div class="sub-title">신랑측 정보</div>
                                <div class="section">
                                    <div class="small-label">아버님</div>
                                    <div class="input-row"><input type="text" placeholder="성"><input type="text"
                                            placeholder="이름"><input type="text" placeholder="연락처"></div>
                                    <div class="checkbox"><input type="checkbox" id="groom-father-deceased"><label
                                            for="groom-father-deceased">고인</label></div>

                                    <div class="small-label">어머님</div>
                                    <div class="input-row"><input type="text" placeholder="성"><input type="text"
                                            placeholder="이름"><input type="text" placeholder="연락처"></div>
                                    <div class="checkbox"><input type="checkbox" id="groom-mother-deceased"><label
                                            for="groom-mother-deceased">고인</label></div>

                                    <div class="small-label">신랑 <span class="required">(필수)</span></div>
                                    <div class="input-row"><input type="text" placeholder="성"><input type="text"
                                            placeholder="이름"><input type="text" placeholder="연락처"></div>
                                </div>
                            </div>

                            <div class="card-box">
                                <div class="sub-title">신부측 정보</div>
                                <div class="section">
                                    <div class="small-label">아버님</div>
                                    <div class="input-row"><input type="text" placeholder="성"><input type="text"
                                            placeholder="이름"><input type="text" placeholder="연락처"></div>
                                    <div class="checkbox"><input type="checkbox" id="bride-father-deceased"><label
                                            for="bride-father-deceased">고인</label></div>

                                    <div class="small-label">어머님</div>
                                    <div class="input-row"><input type="text" placeholder="성"><input type="text"
                                            placeholder="이름"><input type="text" placeholder="연락처"></div>
                                    <div class="checkbox"><input type="checkbox" id="bride-mother-deceased"><label
                                            for="bride-mother-deceased">고인</label></div>

                                    <div class="small-label">신부 <span class="required">(필수)</span></div>
                                    <div class="input-row"><input type="text" placeholder="성"><input type="text"
                                            placeholder="이름"><input type="text" placeholder="연락처"></div>
                                </div>
                            </div>

                            <div class="footer-row">
                                <span><strong>2단계</strong> / 4단계</span>
                                <button class="save-btn">임시저장</button>
                            </div>
                            <!-- 모시는 글 -->
                            <div class="card-box">
                                <div class="sub-title">모시는 글</div>
                                <div class="section">
                                    <div class="small-label">내용</div>
                                    <textarea class="textarea" rows="6"
                                        placeholder="두 사람의 마음을 담은 인사말을 입력하세요."></textarea>
                                </div>
                            </div>

                            <!-- 예식일 -->
                            <div class="card-box">
                                <div class="sub-title">예식일</div>
                                <div class="section grid-2">
                                    <div>
                                        <div class="small-label">날짜</div>
                                        <input type="date">
                                    </div>
                                    <div>
                                        <div class="small-label">시간</div>
                                        <input type="time">
                                    </div>
                                </div>
                            </div>

                            <!-- 예식장소 -->
                            <div class="card-box">
                                <div class="sub-title">예식장소</div>
                                <div class="section">
                                    <div class="small-label">장소명</div>
                                    <input type="text" placeholder="예: 보따리 웨딩홀 3층 아모르홀">

                                    <div class="small-label">주소</div>
                                    <input type="text" placeholder="도로명 주소">

                                    <div class="input-row">
                                        <input type="text" placeholder="상세 주소">
                                        <input type="text" placeholder="지도 링크(URL)">
                                        <button class="invitation-btn" id="address-search">지도 보기</button>
                                    </div>
                                    <!-- 지도 영역 -->
                                    <div id="map" class="map"></div>
                                </div>
                            </div>

                            <div class="footer-row">
                                <span><strong>3단계</strong> / 4단계</span>
                                <button class="save-btn">임시저장</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </content>

    <!-- 푸터 -->
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