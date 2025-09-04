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
    <link rel="stylesheet" href="../../../assets/css/invitation/invitationForm.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>

    <title>보따리몰</title>
</head>

<body class="family">

<!-- Header -->
<c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

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
            <img id="preview" src="${pageContext.request.contextPath}/assets/images/noimage.png" alt="대표 이미지">
          </div>

          <div class="template-section">
            <div class="card-box">
              <div class="sub-title">메인 이미지</div>
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
              <div class="sub-title">주인공 정보</div>
              <div class="section">
                <div class="small-label">주인공<span class="required">(필수)</span></div>
                <div class="input-row">
                  <input type="text" id="baby-name" placeholder="이름">
                </div>

                <div class="small-label">연락망</div>
                <div class="input-row">
                  <input type="text" id="baby-father-name" placeholder="이름">
                  <input type="text" id="baby-father-contect" placeholder="연락처">
                </div>
              </div>
            </div>

            <!-- 모시는 글 -->
            <div class="card-box">
              <div class="sub-title">모시는 글</div>
              <div class="section">
                <div class="small-label">내용</div>
                <textarea id="greeting" class="textarea" rows="6" placeholder="마음을 담은 인사말을 입력하세요."></textarea>
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

            <!-- 행사장소 -->
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
                  <button class="invitation-btn" id="address-search" type="button">지도 보기</button>
                </div>
                <div id="map" class="map"></div>
              </div>
            </div>

            <div class="footer-row">
              <button class="save-btn" type="button">저장</button>
              <!-- 수정 모드일 때만 동적으로 삭제 버튼 추가됨 -->
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</content>

<!-- Footer -->
<c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>

<script>
(function(){
  const CTX = "${pageContext.request.contextPath}";
  const editNo = (new URLSearchParams(location.search)).get("no"); // 수정모드면 존재

  let SELECTED_CATEGORY_NO = 0;
  let CURRENT_PHOTO_URL = null; // 업로드/불러오기 된 대표이미지 URL

  // 공통: JsonResult 언래핑
  function pickPayload(res){ return res ? (res.apiData || res.data || res) : null; }

  /* ============ 카테고리 ============ */
  function setCategory(no){
    SELECTED_CATEGORY_NO = Number(no) || 0;
    const $btns = $('.category-buttons .cat');
    $btns.removeClass('is-active').attr('aria-pressed','false');
    $btns.filter('[data-cat="'+SELECTED_CATEGORY_NO+'"]').addClass('is-active').attr('aria-pressed','true');
  }
  $(document).on('click', '.category-buttons .cat', function(e){
    e.preventDefault();
    setCategory($(this).data('cat'));
  });

  /* ============ 기념일 옵션 ============ */
  function loadAnniversaryOptions(){
    return $.ajax({
      url: CTX + "/api/eventlist",
      type: "GET",
      dataType: "json"
    })
    .done(function(json){
      let data = [];
      if (Array.isArray(json)) data = json;
      else if (json && json.result === 'success'){
        if (Array.isArray(json.data)) data = json.data;
        else if (json.data && Array.isArray(json.data.list)) data = json.data.list;
        else if (Array.isArray(json.apiData)) data = json.apiData;
      } else if (json && Array.isArray(json.list)) data = json.list;

      const $sel = $("#funding-table").empty()
        .append('<option value="">------- 기념일 선택 -------</option>');
      if (!data.length){
        $sel.append('<option value="" disabled>기념일이 없습니다</option>');
        return;
      }
      data.forEach(function(ev){
        const eventNo = Number(ev.eventNo != null ? ev.eventNo : ev.event_no);
        const eventName = (ev.eventName != null ? ev.eventName : ev.event_name) || '';
        if (eventNo) $sel.append($('<option>', { value: eventNo, text: eventName }));
      });
    })
    .fail(function(xhr){
      console.error("[/api/eventlist] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      $("#funding-table").empty()
        .append('<option value="">------- 기념일 선택 -------</option>')
        .append('<option value="" disabled>불러오기 실패</option>');
    });
  }

  /* ============ 이미지 프리뷰 & 업로드 ============ */
  $("#main-image-upload").on("change", function(){
    const file = this.files && this.files[0];
    if (file){
      const url = URL.createObjectURL(file);
      $("#preview").attr("src", url);
    }
  });

  // 파일이 있으면 업로드하여 URL 반환, 없으면 기존 URL 반환
  function maybeUploadPhoto(){
    const inp = document.getElementById("main-image-upload");
    const file = (inp && inp.files && inp.files[0]) ? inp.files[0] : null;
    const d = $.Deferred();

    if (!file){
      d.resolve(CURRENT_PHOTO_URL || null);
      return d.promise();
    }

    const form = new FormData();
    form.append("file", file);

    $.ajax({
      url: CTX + "/api/upload",
      type: "POST",
      data: form,
      processData: false,
      contentType: false,
      dataType: "json"
    })
    .done(function(res){
      const payload = pickPayload(res);
      const url = payload && (payload.url || payload.photoUrl);
      if (res && res.result === "success" && url){
        CURRENT_PHOTO_URL = url;
        d.resolve(url);
      } else {
        d.reject("업로드 응답이 올바르지 않습니다.");
      }
    })
    .fail(function(xhr){
      console.error("[/api/upload] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      d.reject("이미지 업로드 실패");
    });

    return d.promise();
  }

  /* ============ 폼 바인딩 ============ */
  function collectPayload(){
    return {
      categoryNo:    SELECTED_CATEGORY_NO,
      eventNo:       Number($("#funding-table").val() || 0),
      celebrateDate: $("#celebrate-date").val() || null,
      celebrateTime: $("#celebrate-time").val() || null,
      greeting:      $("#greeting").val() || null,
      place:         $("#place").val() || null,
      address1:      $("#address1").val() || null,
      address2:      $("#address2").val() || null,

      groomName: $("#groom-name").val() || null,
      groomContect: $("#groom-contect").val() || null,
      groomFatherName: $("#groom-father-name").val() || null,
      groomFatherContect: $("#groom-father-contect").val() || null,
      groomMotherName: $("#groom-mother-name").val() || null,
      groomMotherContect: $("#groom-mother-contect").val() || null,

      brideName: $("#bride-name").val() || null,
      brideContect: $("#bride-contect").val() || null,
      brideFatherName: $("#bride-father-name").val() || null,
      brideFatherContect: $("#bride-father-contect").val() || null,
      brideMotherName: $("#bride-mother-name").val() || null,
      brideMotherContect: $("#bride-mother-contect").val() || null,

      babyName: $("#baby-name").val() || null,
      babyFatherName: $("#baby-father-name").val() || null,
      babyFatherContect: $("#baby-father-contect").val() || null,
      babyMotherName: $("#baby-mother-name").val() || null,
      babyMotherContect: $("#baby-mother-contect").val() || null
    };
  }

  function fillForm(detail){
    if (!detail) return;

    setCategory(detail.categoryNo || 0);
    if (detail.eventNo) $("#funding-table").val(String(detail.eventNo));

    $("#celebrate-date").val(detail.celebrateDate || "");
    $("#celebrate-time").val((detail.celebrateTime || "").slice(0,5));
    $("#greeting").val(detail.greeting || "");
    $("#place").val(detail.place || "");
    $("#address1").val(detail.address1 || "");
    $("#address2").val(detail.address2 || "");

    $("#groom-name").val(detail.groomName || "");
    $("#groom-contect").val(detail.groomContect || "");
    $("#groom-father-name").val(detail.groomFatherName || "");
    $("#groom-father-contect").val(detail.groomFatherContect || "");
    $("#groom-mother-name").val(detail.groomMotherName || "");
    $("#groom-mother-contect").val(detail.groomMotherContect || "");

    $("#bride-name").val(detail.brideName || "");
    $("#bride-contect").val(detail.brideContect || "");
    $("#bride-father-name").val(detail.brideFatherName || "");
    $("#bride-father-contect").val(detail.brideFatherContect || "");
    $("#bride-mother-name").val(detail.brideMotherName || "");
    $("#bride-mother-contect").val(detail.brideMotherContect || "");

    $("#baby-name").val(detail.babyName || "");
    $("#baby-father-name").val(detail.babyFatherName || "");
    $("#baby-father-contect").val(detail.babyFatherContect || "");
    $("#baby-mother-name").val(detail.babyMotherName || "");
    $("#baby-mother-contect").val(detail.babyMotherContect || "");

    CURRENT_PHOTO_URL = detail.photoUrl || null;
    if (CURRENT_PHOTO_URL) $("#preview").attr("src", CURRENT_PHOTO_URL);
  }

  /* ============ 저장 (등록/수정 분기: POST만 사용) ============ */
  $(document).on("click", ".save-btn", function(){
    const $btn = $(this).prop("disabled", true);

    maybeUploadPhoto()
      .then(function(uploadedUrl){
        const payload = collectPayload();

        if (!payload.categoryNo){ throw new Error("행사 카테고리를 선택하세요."); }
        if (!payload.eventNo){ throw new Error("기념일을 선택하세요."); }
        if (!payload.celebrateDate){ throw new Error("행사 날짜를 선택하세요."); }

        payload.photoUrl = uploadedUrl || CURRENT_PHOTO_URL || null;

        // 등록/수정 분기
        if (editNo){
          payload.invitationNo = Number(editNo);
          return $.ajax({
            url: CTX + "/api/invt/update",        // ★ 수정: POST /api/invt/update
            type: "POST",
            contentType: "application/json; charset=UTF-8",
            dataType: "json",
            data: JSON.stringify(payload)
          });
        } else {
          return $.ajax({
            url: CTX + "/api/invtreg",            // ★ 등록: POST /api/invtreg
            type: "POST",
            contentType: "application/json; charset=UTF-8",
            dataType: "json",
            data: JSON.stringify(payload)
          });
        }
      })
      .done(function(res){
        if (res && res.result === "success"){
          alert(editNo ? "수정되었습니다." : "등록되었습니다.");
          location.href = CTX + "/invitation/list";
        } else {
          throw new Error((res && res.message) || "처리에 실패했습니다.");
        }
      })
      .fail(function(err){
        const msg = (err && err.message) ? err.message : "처리에 실패했습니다. 잠시 후 다시 시도해주세요.";
        alert(msg);
        if (err && err.status){ console.error("[SAVE FAIL]", err.status, (err.responseText||"").slice(0,200)); }
      })
      .always(function(){ $btn.prop("disabled", false); });
  });

  /* ============ 삭제 (DELETE /api/invt/{no}) ============ */
  function addDeleteButtonIfEdit(){
    if (!editNo) return;
    if (!$(".footer-row .delete-btn").length){
      $(".footer-row").append('<button type="button" class="delete-btn" style="margin-left:8px;">삭 제</button>');
    }
  }
  $(document).on("click", ".delete-btn", function(){
    if (!confirm("정말 삭제할까요?")) return;
    $.ajax({
      url: CTX + "/api/invt/" + encodeURIComponent(editNo), // ★ 삭제: DELETE
      type: "DELETE",
      dataType: "json"
    })
    .done(function(res){
      if (res && res.result === "success"){
        alert("삭제되었습니다.");
        location.href = CTX + "/invitation/list";
      } else {
        alert((res && res.message) || "삭제에 실패했습니다.");
      }
    })
    .fail(function(xhr){
      console.error("[DELETE FAIL]", xhr.status, (xhr.responseText||"").slice(0,200));
      alert("삭제에 실패했습니다.");
    });
  });

  /* ============ 상세 로드 (수정모드: GET /api/invtdetail) ============ */
  function loadDetail(no){
    return $.ajax({
      url: CTX + "/api/invtdetail",
      type: "GET",
      data: { no: no },
      dataType: "json"
    })
    .then(function(res){
      if (!res || res.result === "fail") throw new Error((res && res.message) || "조회 실패");
      const detail = pickPayload(res) || {};
      fillForm(detail);
    })
    .fail(function(xhr){
      console.error("[GET /api/invtdetail] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      alert("불러오지 못했습니다.");
    });
  }

  /* ============ 시작 ============ */
  $(function(){
    if (editNo){
      $(".save-btn").text("수정하기");
      addDeleteButtonIfEdit();
    }
    // 기념일 먼저 로드 → 수정모드면 상세 불러와 폼 채우기
    loadAnniversaryOptions().then(function(){
      if (editNo) return loadDetail(editNo);
    });
  });
})();
</script>

</body>
</html>
