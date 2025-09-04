<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <title>bottari 초대장 전체보기</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Global.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/invitation/invitation.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/funding/myfunding.css">
      <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
      <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js" crossorigin="anonymous"></script>
      <style>
        /* #giftPreview .mf-meter .bar::before,
        #giftPreview .mf-meter .bar::after {
          display: none !important;
        }

        #giftPreview .mf-meter .bar .fill {
          flex: 0 0 auto !important;
          min-width: 0 !important;
        } */
      </style>

      <title>보따리몰</title>
    </head>

    <body class="family">

      <c:import url="/WEB-INF/views/include/Header.jsp"></c:import>

      <div class="screen-wrapper">
        <content class="controller">
          <div id="sec-content" class="sector">
            <div class="sec-sub-title">
              <h2 class="header-sub">초대장 전체보기</h2>
            </div>

            <div class="sec-content-main">
              <div class="inv-wrap">
                <div class="inv-card">

                  <!-- 대표 이미지 -->
                  <div class="inv-hero" id="hero">
                    <div class="ph" aria-hidden="true"></div>
                  </div>

                  <!-- 본문 -->
                  <div class="inv-body">
                    <div class="sep">초대합니다</div>
                    <div class="inv-names" id="v-names"></div>
                    <div class="inv-dateplace" id="v-dateplace"></div>
                    <div class="inv-greeting" id="v-greeting"></div>
                  </div>

                  <!-- 선물 보내기 -->
                  <div class="gift-panel" id="gift-panel">
                    <div class="gift-title">축하 선물 보내기</div>
                    <div id="giftPreview" class="gift-preview"></div>
                    <div class="gift-note">부담 없는 금액으로 마음을 전할 수 있는 보따리의 ‘펀딩’ 서비스예요.</div>
                  </div>

                  <!-- 공유 -->
                  <div class="share">
                    <button type="button" class="sbtn" id="btn-kakao">카카오톡 공유하기</button>
                    <button type="button" class="sbtn" id="btn-copy">링크 복사하기</button>
                  </div>

                </div>
              </div>
            </div>
          </div>
        </content>

        <c:import url="/WEB-INF/views/include/Footer.jsp"></c:import>
      </div>

      <script>
        $(document).ajaxError(function (e, xhr, settings, err) {
          console.error('[INV][AJAX ERROR]', settings.url, xhr.status, err, (xhr.responseText || '').slice(0, 200));
        });

        /* Kakao 공유 (그대로) */
        (function () {
          const KAKAO_JS_KEY = '098b00475c9ea44ee38fafb6b5f39880';
          const CTX = "${pageContext.request.contextPath}".replace(/\/+$/, "");
          if (window.Kakao && !Kakao.isInitialized()) Kakao.init(KAKAO_JS_KEY);
          function absUrl(u) { if (!u) return ""; if (/^https?:\/\//i.test(u)) return u; if (u.startsWith("/")) return location.origin + u; return location.origin + CTX + "/" + u.replace(/^\/+/, ""); }
          $('#btn-kakao').off('click').on('click', function () {
            if (!(window.Kakao && Kakao.isInitialized())) { alert('Kakao SDK 초기화 실패'); return; }
            const shareUrl = location.href;
            const title = ($('#v-names').text().trim() || '초대합니다');
            const desc = ($('#v-dateplace').text().trim() || '초대장 보기');
            var imgEl = document.querySelector('#hero img');
            var heroImg = (imgEl && imgEl.src) ? imgEl.src : (CTX + '/assets/icon/Logo_colored.svg');
            Kakao.Share.sendDefault({
              objectType: 'feed',
              content: { title, description: desc, imageUrl: absUrl(heroImg), link: { mobileWebUrl: shareUrl, webUrl: shareUrl } },
              buttons: [{ title: '초대장 보기', link: { mobileWebUrl: shareUrl, webUrl: shareUrl } }]
            });
          });
        })();

        /* 초대장 + 펀딩 그래프 */
        (function () {
          const CTX = "${pageContext.request.contextPath}".replace(/\/+$/, "");
          const FALLBACK_IMG = CTX + "/assets/icon/Logo_colored.svg";

          function getQuery(k) { return new URLSearchParams(location.search).get(k); }
          function pickPayload(res) { if (!res) return null; return res.apiData || res.data || res; }
          function esc(s) { return String(s == null ? "" : s).replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;").replaceAll("'", "&#039;"); }
          function fmtKRW(n) { return (Number(n) || 0).toLocaleString("ko-KR") + "원"; }
          function numLike(v) { if (v == null) return 0; const n = Number(String(v).replace(/[^\d.-]/g, '')); return Number.isFinite(n) ? n : 0; }
          function resolveImage(vo) {
            let raw = vo && (vo.image || vo.imageUrl || vo.image_url || vo.itemimg || vo.itemImg || vo.saveName || vo.save_name || vo.thumbnail || vo.thumb) || "";
            raw = String(raw).trim();
            if (!raw) return FALLBACK_IMG;
            if (/^https?:\/\//i.test(raw)) return raw;
            if (raw.startsWith(CTX + "/")) return raw;
            if (raw.startsWith("/")) return CTX + raw;
            return CTX + "/upload/" + raw;
          }

          function extractPrice(vo) {
            // price, productPrice → 없으면(0) targetAmount/amount로 보완
            const numLike = v => Number(String(v ?? '').replace(/[^\d.-]/g, '')) || 0;
            const price = numLike(vo.price ?? vo.productPrice);
            if (price > 0) return price;
            const backup = numLike(vo.targetAmount ?? vo.amount);
            return backup; // 없으면 0
          }

          function extractPaid(vo) {
            const numLike = v => Number(String(v ?? '').replace(/[^\d.-]/g, '')) || 0;
            // paidAmount → (호환필드) totalPaid/total_paid/collectedAmount/currentAmount
            return numLike(
              vo.paidAmount ?? vo.totalPaid ?? vo.total_paid ?? vo.collectedAmount ?? vo.currentAmount
            );
          }

          // ↓↓↓ 새로 추가 (중복 행을 펀딩번호 단위로 1장으로 합침) ↓↓↓
          function groupByFunding(rows) {
            if (!Array.isArray(rows)) return [];
            const map = new Map();  // fundingNo -> agg

            rows.forEach(row => {
              const fundingNo = Number(row.fundingNo ?? row.funding_no ?? 0);
              if (!fundingNo) return;

              if (!map.has(fundingNo)) {
                // 베이스 복사
                const base = { ...row };
                base._optSet = new Set();
                base._detailOptSet = new Set();
                // 기초 옵션 입력
                const on = (row.optionName ?? row.option_name ?? '').trim();
                const dn = (row.detailoptionName ?? row.detailoption_name ?? '').trim();
                if (on) base._optSet.add(on);
                if (dn) base._detailOptSet.add(dn);
                // 분자/분모 숫자 보정
                base.paidAmount = numLike(row.paidAmount ?? row.totalPaid ?? 0);
                base.targetAmount = numLike(row.targetAmount ?? row.amount ?? 0);
                map.set(fundingNo, base);
              } else {
                const agg = map.get(fundingNo);
                const on = (row.optionName ?? row.option_name ?? '').trim();
                const dn = (row.detailoptionName ?? row.detailoption_name ?? '').trim();
                if (on) agg._optSet.add(on);
                if (dn) agg._detailOptSet.add(dn);

                // 혹시 누적/목표 값이 비어있던 경우 채우기
                if (!agg.paidAmount) agg.paidAmount = numLike(row.paidAmount ?? row.totalPaid ?? 0);
                if (!agg.targetAmount) agg.targetAmount = numLike(row.targetAmount ?? row.amount ?? 0);
              }
            });

            // 옵션 세트 → 문자열로 정리
            const out = Array.from(map.values()).map(v => {
              return {
                ...v,
                optionName: Array.from(v._optSet).filter(Boolean).join(' / '),
                detailoptionName: Array.from(v._detailOptSet).filter(Boolean).join(' / '),
              };
            });

            // 원래 쿼리 정렬 맞춰 대충 최신순
            out.sort((a, b) => (new Date(b.fundingDate) - new Date(a.fundingDate)) || (b.fundingNo - a.fundingNo));
            return out;
          }


          /* 카드 */
          function renderGiftCard(vo) {
            const brand = esc(vo.brand || '');
            const title = esc(vo.title || '');
            const optionName = esc(vo.optionName ?? vo.option_name ?? '');
            const detailOptionName = esc(vo.detailoptionName ?? vo.detail_option_name ?? '');

            // 분모/분자: "상품가격(price)"와 "결제합계(paidAmount)"
            const price = extractPrice(vo);          // ← 분모 (상품가격)
            const paid = extractPaid(vo);           // ← 분자 (누적 결제합계)
            const pct = price > 0 ? Math.min(100, Math.round(paid / price * 100)) : 0;

            const imgUrl = resolveImage(vo);
            const productNo = (vo.productNo ?? vo.product_no ?? vo.prodNo ?? vo.itemNo ?? '');
            const fundingNo = (vo.fundingNo ?? vo.funding_no ?? vo.fundNo ?? '');

            return [
              '<div class="mf-mini" data-price="', price, '" data-paid="', paid, '" data-pct="', pct, '" data-paid-source="api-or-fallback">',
              '<div class="summary"><div class="left">',
              '<a href="#" class="go-detail" data-product-no="', productNo, '" data-funding-no="', fundingNo, '">',
              '<div class="thumbbox"><img src="', imgUrl, '" alt="" onerror="this.src=\'', CTX, '/assets/images/eki.jpg\'"></div>',
              '</a>',
              '<div class="info">',
              '<div class="brand">', brand, '</div>',
              '<div class="row"><span class="name">', title, '</span>',
              (optionName ? '<span class="opt-sep"> / </span><span class="opt">' + optionName + '</span>' : ''),
              (detailOptionName ? '<span class="opt-sep"> / </span><span class="opt">' + detailOptionName + '</span>' : ''),
              '</div>',
              // 상품명 아래는 "상품 가격" 표시
              '<div class="price">', fmtKRW(price), '</div>',
              '</div>',
              '</div></div>',
              // ✅ 그래프: (결제합계 / 상품가격)
              '<div class="mf-meter with-goal">',
              '<div class="bar"><div class="fill" style="width:', pct, '% !important; flex:0 0 auto !important; min-width:0 !important;"></div></div>',
              '<div class="goal"><span class="curr">', fmtKRW(paid), '</span><span class="sep"> / </span><span class="total">', fmtKRW(price), '</span></div>',
              '<div class="achv"><span class="pct">', pct, '% 달성</span></div>',
              '</div>',
              '</div>'
            ].join('');
          }



          function updateMiniMeter($mini, price, paid) {
            const pct = price > 0 ? Math.round(paid / price * 100) : 0;
            $mini.attr('data-paid', paid).attr('data-pct', pct).attr('data-paid-source', 'fallback-total');
            $mini.find('.mf-meter .fill').css('width', pct + '%');
            $mini.find('.mf-meter .goal .curr').text(fmtKRW(paid));
            $mini.find('.mf-meter .achv .pct').text(pct + '% 달성');
          }

          function renderGiftList(list) {
            const $host = $('#giftPreview');
            const grouped = groupByFunding(list || []);   // ← 여기!
            if (!Array.isArray(grouped) || grouped.length === 0) {
              $host.html('<div class="gift-empty">연결된 펀딩이 없습니다.</div>');
              return;
            }
            $host.html(grouped.map(v => renderGiftCard(v || {})).join(''));
            refreshMiniMeters();
          }

          function refreshMiniMeters() {
            $('#giftPreview .mf-mini').each(function () {
              const $mini = $(this);
              const a = $mini.find('.go-detail');
              const fundingNo = Number(a.data('fundingNo')) || 0;
              const price = Number($mini.data('price')) || 0;
              const paidSource = String($mini.attr('data-paid-source') || 'unknown');
              if (!fundingNo || !price || paidSource === 'api-total') return;
              $.getJSON(CTX + '/api/funding/total', { fundingNo })
                .done(r => { const newPaid = Number(r?.data?.totalPaid ?? r?.apiData?.totalPaid ?? 0); updateMiniMeter($mini, price, newPaid); })
                .fail(xhr => console.warn('[INV] total fallback fail', fundingNo, xhr.status));
            });
          }

          /* 데이터 fetch: 앵커 → 초대장id → (없으면 빈 화면) */
          function fetchByAnchor(fundingNo) {
            return $.getJSON(CTX + '/api/inv/funding/cards-by-anchor', { fundingNo })
              .done(res => {
                const payload = pickPayload(res);   // <-- 통일
                console.log('[INV][anchor] payload:', payload);
                renderGiftList(payload || []);
              })
              .fail(xhr => { console.error('[INV] /cards-by-anchor FAIL', xhr.status); renderGiftList([]); });
          }
          function fetchByInvitationNo(invNo) {
            return $.getJSON(CTX + '/api/inv/funding/cards-by-inv', { no: invNo })
              .done(res => {
                const payload = pickPayload(res);   // <-- 통일
                console.log('[INV][by-inv]', { invNo, payload });
                renderGiftList(payload || []);
              })
              .fail(xhr => { console.error('[INV] /cards-by-inv FAIL', xhr.status); renderGiftList([]); });
          }

          /* 초대장 본문만 채우는 부분 (invtview) */
          function renderDetail(detail) {
            detail = detail || {};
            const $hero = $("#hero").empty();
            const photoUrl = (detail.photoUrl || "").trim();
            if (photoUrl && photoUrl.startsWith("/upload/")) {
              $hero.append($('<img>', { src: CTX + photoUrl, alt: "대표 이미지" }).on("error", function () { this.src = FALLBACK_IMG; }));
            } else {
              $hero.append('<div class="ph" aria-hidden="true"></div>');
            }
            const groom = (detail.groomName || '').trim(), bride = (detail.brideName || '').trim(), baby = (detail.babyName || '').trim();
            const eventName = (detail.eventName || detail.event_name || ("이벤트 #" + (detail.eventNo || ""))).trim();
            const $names = $("#v-names").removeClass("inv-names--duo inv-names--single");
            const namesText = groom && bride ? (groom + "  &  " + bride) : (baby ? baby : (groom || bride || eventName || "초대합니다"));
            $names.text(namesText).addClass((groom && bride) ? "inv-names--duo" : "inv-names--single");
            const dateTxt = detail.celebrateDate ? String(detail.celebrateDate).slice(0, 10).replaceAll("-", " . ") : "";
            const timeTxt = detail.celebrateTime ? String(detail.celebrateTime).slice(0, 5) : "";
            const place = (detail.place || "").trim();
            $("#v-dateplace").text([[dateTxt, timeTxt].filter(Boolean).join(" "), place].filter(Boolean).join(" · "));
            $("#v-greeting").text((detail.greeting || "").trim());
          }
          function loadDetail(no) {
            if (!no) return $.Deferred().resolve().promise();
            return $.getJSON(CTX + '/api/invtview', { no })
              .done(res => { const payload = pickPayload(res); const detail = (payload && payload.detail) || payload || {}; renderDetail(detail); })
              .fail(xhr => console.error('[INV] /api/invtview FAIL', xhr.status));
          }

          /* 초기 구동 */
          $(function () {
            const anchorFundingNo = Number(getQuery('fundingNo')) || 0;
            const invNo = Number(getQuery('no')) || 0;

            // 본문은 invNo로 채움(있을 때)
            if (invNo) loadDetail(invNo);

            // 리스트 우선순위: fundingNo → invNo
            if (anchorFundingNo) {
              fetchByAnchor(anchorFundingNo);
            } else if (invNo) {
              fetchByInvitationNo(invNo);
            } else {
              renderGiftList([]); // 둘 다 없으면 비움
            }
          });

          // 상세 이동
          $(document).off('click.invGo', '.go-detail').on('click.invGo', '.go-detail', function (e) {
            e.preventDefault();
            const productNo = $(this).data('productNo') || $(this).data('product-no');
            const fundingNo = $(this).data('fundingNo') || $(this).data('funding-no');
            if (!productNo || !fundingNo) return;
            const back = location.pathname + location.search;
            const qs = $.param({ productNo, fundingNo, back });
            location.href = CTX + "/r/go-detail?" + qs;
          });

          $("#btn-copy").on("click", function () {
            var url = location.href;
            (navigator.clipboard?.writeText(url) || Promise.reject())
              .then(() => alert("링크가 복사되었습니다."))
              .catch(() => alert("클립보드 복사에 실패했습니다."));
          });
        })();
      </script>

    </body>

    </html>