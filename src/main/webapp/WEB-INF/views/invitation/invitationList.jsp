<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>bottari 초대장 관리</title>

  <!-- 공통 스타일 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/invitation/invitationList.css">
  <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
</head>
<body class="family">

  <!-- Header -->
  <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

  <content class="controller">
    <div id="sec-content" class="sector">
      <div class="sec-sub-title">
        <h2 class="header-sub">나의 초대장</h2>
      </div>

      <div class="sec-content-main">
        <div class="content">
          <div class="list-stack">

            <!-- 우측 상단 버튼 -->
            <div class="section-header">
              <button class="create-button" type="button">초대장 만들기</button>
            </div>

            <!-- 카드 그리드 -->
            <div class="card-container">
              <div class="inv-card-grid"><!-- 동적 렌더링 --></div>
            </div>

            <!-- 더보기 자리 (필요 시) -->
            <div class="inv-more" style="display:none;">
              <button class="inv-btn inv-btn--ghost" type="button">더보기</button>
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
  var CTX = "${pageContext.request.contextPath}";

  /* ===== 유틸 ===== */
  function esc(s){
    if (s == null) return "";
    return String(s).replace(/&/g,"&amp;")
                    .replace(/</g,"&lt;")
                    .replace(/>/g,"&gt;")
                    .replace(/"/g,"&quot;");
  }
  function absUrl(u){
    if (!u) return "";
    if (/^https?:\/\//i.test(u)) return u;     // 이미 절대 URL
    if (u.startsWith("/")) return CTX + u;     // 루트 경로 → 컨텍스트 접두
    return CTX + (u.startsWith("/") ? u : ("/" + u));
  }
  function fmtDate(s){
    if (!s) return "";
    return String(s).substring(0,10).replace(/-/g, ".");
  }
  // 마이펀딩과 동일한 리스트 추출 로직
  function pluckList(json){
    if (Array.isArray(json)) return json;
    if (!json || typeof json !== "object") return [];
    if (Array.isArray(json.data)) return json.data;
    if (Array.isArray(json.apiData)) return json.apiData;
    if (json.data && Array.isArray(json.data.list)) return json.data.list;
    if (Array.isArray(json.list)) return json.list;
    return [];
  }

  /* ===== 데이터 매핑(케이스 혼용 안전 처리) ===== */
  function mapRow(row){
    var id    = row.invitationNo ?? row.invitation_no ?? row.id ?? 0;
    var date  = row.celebrateDate ?? row.celebrate_date ?? row.date ?? "";
    var title = row.eventName ?? row.event_name ?? row.title ?? "";
    var photo = row.photoUrl ?? row.photo_url ?? row.photo ?? "";

    return {
      id: Number(id) || 0,
      title: title,
      date: fmtDate(date),
      photo: absUrl(photo)
    };
  }

  /* ===== 카드 템플릿: 반드시 ?no= 붙여서 이동 ===== */
  function cardTpl(row) {
    var viewHref = CTX + "/invitation/invitation" + (row.id ? ("?no=" + row.id) : "");
    var html = '';
    html += '<div class="inv-card" data-id="' + (row.id || '') + '">';

    // 이미지 자체를 링크로
    html += '<a class="inv-link" href="' + esc(viewHref) + '">';
    html += '  <div class="inv-thumbbox">';
    if (row.photo) html += '    <img class="inv-thumb" src="' + esc(row.photo) + '" alt="">';
    else html += '    <div class="inv-thumb inv-thumb--ph"></div>';
    html += '  </div>';
    html += '</a>';

    html += ' <div class="inv-info">';
    html += '   <div class="inv-title"><a class="inv-link" href="' + esc(viewHref) + '">'
         +       esc(row.title || "") + '</a></div>';
    html += '   <div class="inv-date">' + esc(row.date || "") + '</div>';
    html += '   <div class="inv-actions">';
    html += '     <button class="inv-btn btn-edit" type="button">수정하기</button>';
    html += '   </div>';
    html += ' </div>';
    html += '</div>';
    return html;
  }

  function renderList(rows) {
    var $wrap = $(".card-container");
    if ($wrap.length === 0) {
      $("#sec-content .sec-content-main").append('<div class="card-container"></div>');
      $wrap = $(".card-container");
    }
    if ($wrap.find(".inv-card-grid").length === 0) {
      $wrap.html('<div class="inv-card-grid"></div>');
    }
    var $grid = $wrap.find(".inv-card-grid").empty();

    if (!rows || !rows.length) {
      $grid.append('<div class="inv-empty">등록된 초대장이 없습니다.</div>');
      $(".inv-more").hide();
      return;
    }

    for (var i = 0; i < rows.length; i++) $grid.append(cardTpl(rows[i]));
    $(".inv-more").toggle(rows.length >= 16);
  }

  /* ===== 목록 로드 ===== */
  function loadList(){
    $.ajax({
      url: CTX + "/api/invtlist",
      type: "GET",
      dataType: "json",
      cache: false
    })
    .done(function(res){
      if (!res || res.result === "fail") {
        var msg = (res && res.message) || "로그인이 필요합니다.";
        alert(msg);
        var returnUrl = location.pathname + location.search;
        location.replace(CTX + "/user/loginForm?reason=auth&returnUrl=" + encodeURIComponent(returnUrl));
        return;
      }
      var rows = pluckList(res);
      var vms  = rows.map(mapRow);
      renderList(vms);
    })
    .fail(function(xhr){
      if (xhr.status === 401) {
        alert("로그인이 필요합니다.");
        var returnUrl = location.pathname + location.search;
        location.replace(CTX + "/user/loginForm?reason=auth&returnUrl=" + encodeURIComponent(returnUrl));
        return;
      }
      console.error("[GET /api/invtlist] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      renderList([]);
    });
  }

  /* ===== 라우팅 ===== */
  $(document)
    .on("click", ".create-button", function(){
      location.href = CTX + "/invitation/form";
    })
    .on("click", ".inv-card .btn-edit", function(e){
      e.stopPropagation();
      var id = $(this).closest(".inv-card").data("id") || "";
      location.href = CTX + "/invitation/form" + (id ? ("?no=" + id) : "");
    })
    // 카드 전체 클릭도 상세로(내부 a/버튼 클릭은 무시)
    .on("click", ".inv-card", function(e){
      if ($(e.target).closest(".btn-edit, a").length) return;
      var id = $(this).data("id") || "";
      if (id) location.href = CTX + "/invitation/invitation?no=" + id;
    });

  // 시작!
  $(function(){ loadList(); });
})();
</script>

</body>
</html>
