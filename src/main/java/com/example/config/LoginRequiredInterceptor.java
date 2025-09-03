package com.example.config;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class LoginRequiredInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		final String ctx = req.getContextPath(); // e.g. "" or "/bottari"
		final String uri = req.getRequestURI(); // e.g. /bottari/invitation/invitation
		String path = uri;
		if (ctx != null && !ctx.isEmpty() && uri.startsWith(ctx)) {
			path = uri.substring(ctx.length()); // e.g. /invitation/invitation
		}
		final String qs = req.getQueryString();
		final String full = path + (qs != null ? "?" + qs : "");

		HttpSession session = req.getSession(false);
		Object auth = (session != null) ? session.getAttribute("authUser") : null;

		System.out.println("[INTC] uri=" + uri + " path=" + path + " auth=" + (auth != null) + " jsid="
				+ (session != null ? session.getId() : "null") + " qs=" + qs);

		/* 장바구니 전용 가드: 공개우회보다 먼저 처리 (비로그인 → 로그인폼로) */
		if ("/shop/cart".equals(path)) {
			if (auth == null) {
				String loginUrl = ctx + "/user/loginForm?reason=auth&returnUrl="
						+ URLEncoder.encode(full, StandardCharsets.UTF_8);
				System.out.println("[INTC] cart not logged-in → REDIRECT " + loginUrl);
				res.sendRedirect(loginUrl);
				return false;
			}
			System.out.println("[INTC] cart logged-in → PASS");
			return true;
		}

		// 0) 완전 공개 라우트 (페이지 뷰)
		if (path.startsWith("/user/") || path.startsWith("/assets/") || path.startsWith("/upload/")
				|| "/favicon.ico".equals(path) || path.startsWith("/error") || path.equals("/invitation/invitation")
				|| path.startsWith("/invitation/invitation/") // ✅ 공유 초대장 뷰
				|| path.startsWith("/r/") || path.startsWith("/i/") || path.startsWith("/share/")
				|| path.startsWith("/kakao/") || path.startsWith("/shop/")) {
			System.out.println("[INTC] public path bypass → " + path);
			return true;
		}

		// 로그인 상태면 전부 통과
		if (auth != null)
			return true;

		// === 미로그인 허용 API ===//
		// src/main/java/com/example/config/LoginRequiredInterceptor.java

		if ("GET".equalsIgnoreCase(req.getMethod())) {
			// 공유/보기 데이터: 항상 공개
			if ("/api/invtview".equals(path)) {
				System.out.println("[INTC] public GET /api/invtview → PASS");
				return true;
			}

			// 초대장 펀딩 카드(그래프) 공개 허용 (신규 엔드포인트들)
			if (path.equals("/api/inv/funding/cards-by-inv") || path.equals("/api/inv/funding/cards-by-event")
					|| path.equals("/api/inv/funding/cards-by-anchor")) {
				System.out.println("[INTC] public GET " + path + " → PASS");
				return true;
			}

			// (선택) 진행바 보조 합계 API도 공개 허용
			if ("/api/funding/total".equals(path)) {
				System.out.println("[INTC] public GET /api/funding/total → PASS");
				return true;
			}

			// 기존 특례 유지
			if ("/api/myfunding".equals(path)) {
				String ev = req.getParameter("eventNo");
				if (ev != null && !ev.isBlank()) {
					System.out.println("[INTC] public GET /api/myfunding?eventNo=" + ev + " → PASS");
					return true;
				}
			}
		}

		// 헤더가 호출하는 내 초대장 목록은, 공유 뷰에서만 조용히 200 빈 목록
		if ("/api/invtlist".equals(path)) {
			String referer = req.getHeader("Referer");
			if (referer != null && referer.contains("/invitation/invitation")) {
				System.out.println("[INTC] silent 200 for /api/invtlist on public invitation view");
				res.setStatus(HttpServletResponse.SC_OK);
				res.setContentType("application/json; charset=UTF-8");
				res.getWriter().write("{\"result\":\"success\",\"list\":[]}");
				return false;
			}
		}

		// 나머지 API는 401
		if (path.startsWith("/api/")) {
			res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			res.setContentType("application/json; charset=UTF-8");
			res.setHeader("X-Auth-Required", "1");
			res.getWriter().write("{\"result\":\"fail\",\"message\":\"로그인이 필요합니다.\"}");
			return false;
		}

		// 페이지는 로그인 폼으로
		String loginUrl = ctx + "/user/loginForm?reason=auth&returnUrl="
				+ URLEncoder.encode(full, StandardCharsets.UTF_8);
		res.sendRedirect(loginUrl);
		return false;
	}
}
