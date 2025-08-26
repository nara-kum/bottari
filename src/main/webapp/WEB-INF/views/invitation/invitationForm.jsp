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
                            <img id="preview-image" src="${pageContext.request.contextPath}/assets/images/placeholder.png" alt="대표 이미지">
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
(function(){
  const CTX = "${pageContext.request.contextPath}";
  let SELECTED_CATEGORY_NO = 0;  // 카테고리(결혼/생일/…)
  let SELECTED_TEMPLATE_NO = 0;  // 타입 A/B/C/D → 1/2/3/4

  // ---------- 유틸 ----------
  function esc(s){ if (s==null) return ""; return String(s)
    .replace(/&/g,"&amp;").replace(/</g,"&lt;")
    .replace(/>/g,"&gt;").replace(/"/g,"&quot;"); }

  function getArrayFromJsonResult(json){
    // 서버 JsonResult 포맷: { result:"success", data:[], apiData:[], list:[] }
    if (!json) return [];
    if (Array.isArray(json)) return json;
    if (json.result === "success"){
      if (Array.isArray(json.apiData)) return json.apiData;
      if (Array.isArray(json.data))    return json.data;
      if (Array.isArray(json.list))    return json.list;
    }
    return [];
  }

  // ---------- 기념일 옵션 로드 ----------
  function loadAnniversaryOptions(){
    $.ajax({
      url: CTX + "/api/eventlist",
      type: "GET",
      dataType: "json"
    })
    .done(function(json){
      const rows = getArrayFromJsonResult(json);
      const $sel = $("#funding-table").empty()
        .append('<option value="">------- 기념일 선택 -------</option>');

      if (!rows.length){
        $sel.append('<option value="" disabled>기념일이 없습니다</option>');
        return;
      }
      for (let i=0;i<rows.length;i++){
        const ev = rows[i]||{};
        const eventNo   = Number(ev.eventNo != null ? ev.eventNo : ev.event_no);
        const eventName = (ev.eventName != null ? ev.eventName : ev.event_name) || '';
        if (!eventNo) continue;
        $sel.append($('<option>', { value: eventNo, text: eventName }));
      }
    })
    .fail(function(xhr){
      console.error("[GET /api/eventlist] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      $("#funding-table").empty()
        .append('<option value="">------- 기념일 선택 -------</option>')
        .append('<option value="" disabled>불러오기 실패</option>');
    });
  }

  // ---------- 카테고리 버튼 ----------
  function bindCategoryButtons(){
    $(document).on("click", ".category-buttons .cat", function(){
      SELECTED_CATEGORY_NO = Number($(this).data("cat") || 0);
      $(this).closest(".category-buttons").find(".cat").removeClass("is-active");
      $(this).addClass("is-active");
    });
  }

  // ---------- 템플릿 카드 ----------
  function initTemplateCards(){
    const $cards = $(".template-grid .template-card");
    $cards.each(function(idx){
      if (!$(this).attr("data-tpl")) $(this).attr("data-tpl", idx+1); // 1,2,3,4
    });
    $(document).on("click", ".template-grid .template-card", function(){
      const tpl = parseInt($(this).attr("data-tpl"), 10) || 0;
      if (!tpl) return;
      SELECTED_TEMPLATE_NO = tpl;
      $(".template-grid .template-card").removeClass("is-active").attr("aria-selected","false");
      $(this).addClass("is-active").attr("aria-selected","true");
    });
  }

  // ---------- 대표 이미지 프리뷰(외부 도메인 X + 무한 onerror 방지) ----------
  function bindPreview(){
    const $file    = $("#main-image-upload");
    const $preview = $(".preview-box img").first();

    const LOCAL_PLACEHOLDER = CTX + "/assets/images/placeholder.png";
    const DATA_PLACEHOLDER =
      'data:image/svg+xml;utf8,' +
      encodeURIComponent(
        '<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300">' +
        '<rect width="100%" height="100%" fill="#f3f4f6"/>' +
        '<text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" ' +
        'font-family="sans-serif" font-size="16" fill="#9ca3af">대표 이미지</text>' +
        '</svg>'
      );

    if (!$preview.attr("src")) $preview.attr("src", LOCAL_PLACEHOLDER);

    $preview.on("error", function(){
      const img = this;
      if (!img.dataset.fallbackTriedLocal){
        img.dataset.fallbackTriedLocal = "1";
        img.src = LOCAL_PLACEHOLDER;   // 로컬 정적 파일 재시도
        return;
      }
      if (!img.dataset.fallbackTriedData){
        img.dataset.fallbackTriedData = "1";
        img.onerror = null;            // 더 이상 onerror 루프 금지
        img.src = DATA_PLACEHOLDER;    // 최후의 보루(항상 성공)
        return;
      }
    });

    $file.on("change", function(){
      const f = this.files && this.files[0];
      if (!f) return;
      const objUrl = URL.createObjectURL(f);
      $preview.attr("src", objUrl);
      setTimeout(()=>URL.revokeObjectURL(objUrl), 30000);
    });
  }

  // ---------- 파일 업로드 ----------
  async function uploadMainImageIfAny(){
    const $file = $("#main-image-upload");
    const f = $file[0] && $file[0].files && $file[0].files[0];
    if (!f) return null; // 파일 선택 안 했으면 업로드 생략

    const fd = new FormData();
    fd.append("file", f);

    // 서버 응답 예: {result:"success", data:{url:"/upload/2025/08/11/xxx.jpg"}}
    const res = await $.ajax({
      url: CTX + "/api/upload/public",
      type: "POST",
      data: fd,
      processData: false,
      contentType: false,
      dataType: "json"
    });
    if (res && res.result === "success"){
      // data.url 또는 url 키 지원
      return (res.data && res.data.url) || res.url || null;
    }
    throw new Error(res && res.message ? res.message : "이미지 업로드 실패");
  }

  // ---------- 저장 ----------
  async function handleSave(btn){
    const $btn = $(btn).prop("disabled", true);

    try{
      const categoryNo    = SELECTED_CATEGORY_NO;
      const eventNo       = Number($("#funding-table").val() || 0);
      const celebrateDate = $("#celebrate-date").val();

      if (!categoryNo){ alert("기념일 카테고리를 선택하세요."); return; }
      if (!eventNo){ alert("기념일을 선택하세요."); return; }
      if (!celebrateDate){ alert("행사 날짜를 선택하세요."); return; }

      // 1) 대표 이미지 업로드(선택된 경우)
      let photoUrl = null;
      try{
        photoUrl = await uploadMainImageIfAny(); // 없으면 null
      }catch(e){
        console.warn("[upload] skip or fail:", e.message||e);
        // 업로드 실패 시 저장 중단하고 싶으면 여기서 return 처리
        // return;
      }

      // 2) 초대장 저장
      const payload = {
        categoryNo,
        eventNo,
        celebrateDate,
        celebrateTime: $("#celebrate-time").val() || null,
        greeting:      $("#greeting").val() || null,
        place:         $("#place").val() || null,
        address1:      $("#address1").val() || null,
        address2:      $("#address2").val() || null,
        themeNo:       SELECTED_TEMPLATE_NO || 0,
        photoUrl:      photoUrl,

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

      const res = await $.ajax({
        url: CTX + "/api/invtreg",
        type: "POST",
        contentType: "application/json; charset=UTF-8",
        dataType: "json",
        data: JSON.stringify(payload)
      });

      if (res && res.result === "success"){
        alert("초대장이 등록되었습니다.");
        location.href = CTX + "/invitationList";
      } else {
        alert(res && res.message ? res.message : "초대장 등록에 실패했습니다.");
      }
    }catch(err){
      console.error("[save] error:", err);
      alert("초대장 등록에 실패했습니다. 잠시 후 다시 시도해주세요.");
    }finally{
      $btn.prop("disabled", false);
    }
  }

  // ---------- 바인딩 ----------
  $(function(){
    loadAnniversaryOptions();
    bindCategoryButtons();
    initTemplateCards();
    bindPreview();

    $(document).on("click", ".save-btn", function(){
      handleSave(this);
    });
  });
})();
</script>


</body>

</html>