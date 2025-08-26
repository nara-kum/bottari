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
                                    <div class="template-card">타입B</div>
                                    <div class="template-card">타입C</div>
                                    <div class="template-card">타입D</div>
                                </div>
                                <div class="upload-info">메인사진<br>이미지의 크기는 15MB 이내로 제한되어 있습니다.</div>

                                <!-- 이미지 업로드 영역 -->
                                <div class="image-upload-box">
                                    <label for="main-image-upload">이미지 첨부</label>
                                    <input type="file" id="main-image-upload" accept="image/*">
                                </div>

                            </div>

                            <!-- <div class="card-box">
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
                            </div> -->

                            <div class="card-box">
                                <div class="sub-title">신랑측 정보</div>
                                <div class="section">
                                    <div class="small-label">신랑 <span class="required">(필수)</span></div>
                                    <div class="input-row">
                                        <input type="text" id="groom-name" placeholder="이름">
                                        <input type="text" id="groom-contect" placeholder="연락처">
                                    </div>

                                    <div class="small-label">아버님</div>
                                    <div class="input-row">
                                        <input type="text" id="groom-father-name" placeholder="이름">
                                        <input type="text" id="groom-father-contect" placeholder="연락처">
                                    </div>

                                    <div class="small-label">어머님</div>
                                    <div class="input-row">
                                        <input type="text" id="groom-mother-name" placeholder="이름">
                                        <input type="text" id="groom-mother-contect" placeholder="연락처">
                                    </div>
                                </div>
                            </div>

                            <div class="card-box">
                                <div class="sub-title">신부측 정보</div>
                                <div class="section">
                                    <div class="small-label">신부 <span class="required">(필수)</span></div>
                                    <div class="input-row">
                                        <input type="text" id="bride-name" placeholder="이름">
                                        <input type="text" id="bride-contect" placeholder="연락처">
                                    </div>

                                    <div class="small-label">아버님</div>
                                    <div class="input-row">
                                        <input type="text" id="bride-father-name" placeholder="이름">
                                        <input type="text" id="bride-father-contect" placeholder="연락처">
                                    </div>

                                    <div class="small-label">어머님</div>
                                    <div class="input-row">
                                        <input type="text" id="bride-mother-name" placeholder="이름">
                                        <input type="text" id="bride-mother-contect" placeholder="연락처">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card-box">
                                <div class="sub-title">아기 정보</div>
                                <div class="section">
                                    <div class="small-label">아기 <span class="required">(필수)</span></div>
                                    <div class="input-row">
                                        <input type="text" id="baby-name" placeholder="이름">
                                    </div>

                                    <div class="small-label">아버님</div>
                                    <div class="input-row">
                                        <input type="text" id="baby-father-name" placeholder="이름">
                                        <input type="text" id="baby-father-contect" placeholder="연락처">
                                    </div>

                                    <div class="small-label">어머님</div>
                                    <div class="input-row">
                                        <input type="text" id="baby-mother-name" placeholder="이름">
                                        <input type="text" id="baby-mother-contect" placeholder="연락처">
                                    </div>
                                </div>
                            </div>

                            <!-- 모시는 글 -->
                            <div class="card-box">
                                <div class="sub-title">모시는 글</div>
                                <div class="section">
                                    <div class="small-label">내용</div>
                                    <textarea id="greeting" class="textarea" rows="6"
                                        placeholder="마음을 담은 인사말을 입력하세요."></textarea>
                                </div>
                            </div>

                            <!-- 행사일 -->
                            <div class="card-box">
                                <div class="sub-title">행사일</div>
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
                                <div class="sub-title">행사장소</div>
                                <div class="section">
                                    <div class="small-label">장소명</div>
                                    <input id="place" type="text" placeholder="예: 보따리 웨딩홀 3층 아모르홀">

                                    <div class="small-label">주소</div>
                                    <input id="address1" type="text" placeholder="도로명 주소">

                                    <div class="input-row">
                                        <input id="address2" type="text" placeholder="상세 주소">
                                        <input type="text" placeholder="지도 링크(URL)">
                                        <button class="invitation-btn" id="address-search">지도 보기</button>
                                    </div>
                                    <!-- 지도 영역 -->
                                    <div id="map" class="map"></div>
                                </div>
                            </div>

                            <div class="footer-row">
                                <button class="save-btn">저장</button>
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
    
let SELECTED_CATEGORY_NO = 0;   // 카테고리(결혼/생일/…)
let SELECTED_TEMPLATE_NO = 0;   // 타입 A/B/C/D → 1/2/3/4

// 카테고리 버튼 클릭 시 활성화 표시
  $(document).on('click', '.category-buttons .cat', function(){
    SELECTED_CATEGORY_NO = Number($(this).data('cat') || 0);
    // 같은 그룹 내에서만 단독 선택
    $(this).closest('.category-buttons').find('.cat').removeClass('is-active');
    $(this).addClass('is-active');
  });

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
        .append('<option value="">----- 기념일 선택 -----</option>')
        .append('<option value="" disabled>불러오기 실패</option>');
    });
  }
  
  function initTemplateCards(){
    var $cards = $(".template-grid .template-card");
    $cards.each(function(idx){
      // 이미 data-tpl 있으면 유지, 없으면 1~4 할당
      if (!$(this).attr("data-tpl")) {
        $(this).attr("data-tpl", (idx+1)); // A=1, B=2, C=3, D=4
      }
    });
  }

  $(function(){
    loadAnniversaryOptions();
    initTemplateCards();
  });

})();
let MAIN_PHOTO_URL = null;

$(document).on('change', '#main-image-upload', function(e){
  const file = e.target.files && e.target.files[0];
  if (!file) return;

  if (!/^image\//.test(file.type)) {
    alert('이미지 파일만 업로드할 수 있어요.');
    this.value = '';
    return;
  }
  if (file.size > 15 * 1024 * 1024) {
    alert('이미지는 15MB 이하여야 해요.');
    this.value = '';
    return;
  }

  if (window._previewObjectURL) {
    URL.revokeObjectURL(window._previewObjectURL);
  }
  const url = URL.createObjectURL(file);
  window._previewObjectURL = url;

  $('.preview-box img')
    .attr('src', url)
    .attr('alt', file.name || '대표 이미지');

  // 3) 필요 시 전송용으로도 들고 있기
  //   (현재는 미리보기만 사용. 서버 업로드 후 받은 실제 URL을 넣는 게 정석)
  MAIN_PHOTO_URL = url; // 미리보기 전용
});

// (선택) 저장 시 photoUrl 보내고 싶다면, 기존 payload에 아래처럼 할당하세요.
// photoUrl: MAIN_PHOTO_URL || null,


$(document).on("click", ".template-grid .template-card", function(){
  var tpl = parseInt($(this).attr("data-tpl"), 10) || 0;
  if (!tpl) return;
  SELECTED_TEMPLATE_NO = tpl;
  $(".template-grid .template-card").removeClass("is-active").attr("aria-selected", "false");
  $(this).addClass("is-active").attr("aria-selected", "true");
});


// 저장
$(document).on("click", ".save-btn", function(){
  const CTX = "${pageContext.request.contextPath}";

  const categoryNo    = SELECTED_CATEGORY_NO;
  const eventNo       = Number($("#funding-table").val() || 0);
  const celebrateDate = $("#celebrate-date").val();

  if (!categoryNo){ alert("기념일 카테고리를 선택하세요."); return; }
  if (!eventNo){ alert("기념일을 선택하세요."); return; }
  if (!celebrateDate){ alert("행사 날짜를 선택하세요."); return; }

  const payload = {
    categoryNo,
    eventNo,
    celebrateDate,
    celebrateTime: $("#celebrate-time").val() || null,
    greeting:      $("#greeting").val() || null,
    place:         $("#place").val() || null,
    address1:      $("#address1").val() || null,
    address2:      $("#address2").val() || null,

    // 타입 A/B/C/D → 1/2/3/4 로 전송 (DB 컬럼 가정: themeNo)
    themeNo:       SELECTED_TEMPLATE_NO || null,

    // 아직 폼에서 안 받는 필드들은 null
    photoUrl:      null,
    groomName:           $("#groom-name").val() || null,
    groomContect:        $("#groom-contect").val() || null,
    groomFatherName:     $("#groom-father-name").val() || null,
    groomFatherContect:  $("#groom-father-contect").val() || null,
    groomMotherName:     $("#groom-mother-name").val() || null,
    groomMotherContect:  $("#groom-mother-contect").val() || null,

    brideName:           $("#bride-name").val() || null,
    brideContect:        $("#bride-contect").val() || null,
    brideFatherName:     $("#bride-father-name").val() || null,
    brideFatherContect:  $("#bride-father-contect").val() || null,
    brideMotherName:     $("#bride-mother-name").val() || null,
    brideMotherContect:  $("#bride-mother-contect").val() || null,

    babyName:            $("#baby-name").val() || null,
    babyFatherName:      $("#baby-father-name").val() || null,
    babyFatherContect:   $("#baby-father-contect").val() || null,
    babyMotherName:      $("#baby-mother-name").val() || null,
    babyMotherContect:   $("#baby-mother-contect").val() || null
    // userNo는 서버 세션에서 주입
  };

  const $btn = $(this).prop("disabled", true);

  $.ajax({
    url: CTX + "/api/invtreg",
    type: "POST",
    contentType: "application/json; charset=UTF-8",
    dataType: "json",
    data: JSON.stringify(payload)
  })
  .done(function(res){
    if (res && res.result === "success"){
      alert("초대장이 등록되었습니다.");
      location.href = CTX + "/invitationList";
    } else {
      alert(res && res.message ? res.message : "초대장 등록에 실패했습니다.");
    }
  })
  .fail(function(xhr){
    console.error("[POST /api/invtreg] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
    alert("초대장 등록에 실패했습니다. 잠시 후 다시 시도해주세요.");
  })
  .always(function(){
    $btn.prop("disabled", false);
  });
});

</script>

</body>

</html>