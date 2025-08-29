<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>bottari 초대장 관리</title>
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

          <!-- 더보기 자리 -->
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

  // 안전 이스케이프
  function esc(s){
    if (s == null) return "";
    return String(s).replace(/&/g,"&amp;")
                    .replace(/</g,"&lt;")
                    .replace(/>/g,"&gt;")
                    .replace(/"/g,"&quot;");
  }

  function resolveUrl(u){
    if (!u) return "";
    if (u.startsWith("/")) return CTX + u;
    return u;
  }

  function fmtDate(s){
    if (!s) return "";
    return String(s).substring(0,10).replace(/-/g, ".");
  }

  function mapRow(row){
    var id    = row.invitationNo;
    var date  = row.celebrateDate;
    var title = row.eventName;
    return {
      id: id,
      title: title,
      date: fmtDate(date),
      photo: resolveUrl(row.photoUrl || ""),
      hasFunding: Boolean(Number(row.hasFunding || 0))
    };
  }

  // 카드 템플릿
  function cardTpl(row) {
  var html = '';
  html += '<div class="inv-card" data-id="' + (row.id || '') + '">';
  if (row.hasFunding) {
    html += '<div class="inv-badge">🎁 펀딩</div>';
  }
  html += '<div class="inv-thumbbox">';
  if (row.photo) {
    html += '<img class="inv-thumb" src="' + esc(row.photo) + '" alt="">';
  } else {
    html += '<div class="inv-thumb inv-thumb--ph"></div>';
  }
  html += '</div>';
  html += ' <div class="inv-info">';
  html += '   <div class="inv-title">' + esc(row.title || "") + '</div>';
  html += '   <div class="inv-date">' + esc(row.date || "") + '</div>';
  html += '   <div class="inv-actions">';
  html += '   <button class="inv-btn btn-edit" type="button">수정하기</button>';
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

  for (var i = 0; i < rows.length; i++) {
    $grid.append(cardTpl(rows[i]));
  }

  $(".inv-more").toggle(rows.length >= 16);
}


  function loadList(){
    $.ajax({
      url: CTX + "/api/invtlist",
      type: "GET",
      dataType: "json",
      cache: false
    })
    .done(function(res){
      console.log("[GET /api/invtlist] raw:", res);
      if (!res || res.result === "fail"){
        alert(res && res.message ? res.message : "목록을 불러오지 못했습니다.");
        renderList([]);
        return;
      }
      var rows = Array.isArray(res.apiData) ? res.apiData : [];
      var vms = rows.map(mapRow);
      renderList(vms);
    })
    .fail(function(xhr){
      console.error("[GET /api/invtlist] fail:", xhr.status, (xhr.responseText||"").slice(0,200));
      renderList([]);
    });
  }

  // 라우팅
  $(document)
    .on("click", ".create-button", function(){
      location.href = CTX + "invitation/form";
    })
    .on("click", ".inv-card .btn-edit", function(){
      var id = $(this).closest(".inv-card").data("id") || "";
      location.href = CTX + "/invitation/form" + (id ? ("?no=" + id) : "");
    })
    .on("click", ".inv-card .inv-thumb", function(){
      var id = $(this).closest(".inv-card").data("id") || "";
      location.href = CTX + "invitation/invitation" + (id ? ("?no=" + id) : "");
    });

  // 시작!
  $(function(){ loadList(); });
})();
</script>

</body>
</html>
