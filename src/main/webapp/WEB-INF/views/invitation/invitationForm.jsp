<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>bottari 초대장 작성</title>
    <link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/Global.css">
    <link rel="stylesheet" href="../../../assets/css/invitationForm.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>


</head>

<body class="family">

<!------------------------ Header호출 ----------------------->
<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>
<!-- ---------------------------------------------------- -->

    <!-- 본문 -->

    <content class="controller">
        <div id="sec-content" class="sector">
            <div class="sec-sub-title">
                <h2 class="header-sub">초대장 작성</h2>
            </div>
            <div class="sec-content-main">
                <div class="content">

                    <div class="card-box anniversary">
                        <div class="sub-title">기념일</div>
                        <select id="funding-table">
                            <option value="">선택하기</option>
                        </select>
                        <div class="category-buttons">
                            <button class="btn cat" data-cat="1">결혼</button>
                            <button class="btn cat" data-cat="2">생일</button>
                            <button class="btn cat" data-cat="3">돌잔치</button>
                            <button class="btn cat" data-cat="4">이벤트</button>
                            <button class="btn cat" data-cat="5">축하</button>
                            <button class="btn cat" data-cat="6">감사</button>
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
                                <button class="temp-btn">임시저장</button>
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
                                <button class="temp-btn">임시저장</button>
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
                                        <input type="date" id="celebrate-date">
                                    </div>
                                    <div>
                                        <div class="small-label">시간</div>
                                        <input type="time" id="celebrate-time">
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
                                <button class="temp-btn">임시저장</button>
                                <button class="save-btn">완료</button>
                            </div>
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

  function loadAnniversaryOptions(){
    $.ajax({
      url: CTX + "/api/eventlist",
      type: "GET",
      dataType: "json"
    })
    .done(function(json){
      // 다양한 응답 래핑 허용
      var data = [];
      if (Array.isArray(json)) {
        data = json;
      } else if (json && json.result === 'success') {
        if (Array.isArray(json.data)) data = json.data;
        else if (json.data && Array.isArray(json.data.list)) data = json.data.list;
        else if (Array.isArray(json.apiData)) data = json.apiData;
      } else if (json && Array.isArray(json.list)) {
        data = json.list;
      }

      var $sel = $("#funding-table").empty()
        .append('<option value="">------- 기념일 선택 -------</option>');

      if (!data.length){
        $sel.append('<option value="" disabled>기념일이 없습니다</option>');
        return;
      }

      for (var i=0; i<data.length; i++){
        var ev = data[i] || {};
        // camelCase / snake_case 모두 허용
        var eventNo   = Number(ev.eventNo != null ? ev.eventNo : ev.event_no);
        var eventName = (ev.eventName != null ? ev.eventName : ev.event_name) || '';
        if (!eventNo) continue;
        $sel.append($('<option>', { value: eventNo, text: eventName }));
      }
    })
    .fail(function(xhr, status, err){
      console.error("[/api/eventlist] fail:", status, err, xhr.status, (xhr.responseText||'').slice(0,200));
      $("#funding-table").empty()
        .append('<option value="">------- 기념일 선택 -------</option>')
        .append('<option value="" disabled>불러오기 실패</option>');
    });
  }

  $(function(){
    loadAnniversaryOptions();
  });
})();

$(document).on('click', '.save-btn', function(){
  const CTX = "${pageContext.request.contextPath}";

  // 필수값
  const categoryNo    = SELECTED_CATEGORY_NO;
  const eventNo       = Number($("#funding-table").val() || 0);
  const celebrateDate = $("#celebrate-date").val();

  if (!categoryNo){ alert("행사 카테고리를 선택하세요."); return; }
  if (!eventNo){ alert("기념일을 선택하세요."); return; }
  if (!celebrateDate){ alert("예식일(행사 날짜)을 선택하세요."); return; }

  const payload = {
    categoryNo,
    eventNo,
    celebrateDate,
    celebrateTime: $("#celebrate-time").val() || null,
    greeting: $("#greeting").val() || null,
    place: $("#place").val() || null,
    address1: $("#address1").val() || null,
    address2: $("#address2").val() || null
    // userNo ✖ (서버가 세션에서 주입)
  };

  $.ajax({
    url: CTX + "/api/invtreg",
    type: "POST",
    contentType: "application/json; charset=UTF-8",
    data: JSON.stringify(payload),
    dataType: "json"
  })
  .done(function(res){
    if (res && res.result === 'success'){
      alert("초대장이 등록되었습니다.");
      // location.href = CTX + "/invitation";
    } else {
      alert(res && res.message ? res.message : "초대장 등록에 실패했습니다.");
    }
  })
  .fail(function(xhr){
    alert("초대장 등록에 실패했습니다. 잠시 후 다시 시도해주세요.");
    console.error(xhr.responseText);
  });
});


</script>

</body>

</html>