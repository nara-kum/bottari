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
		final String ctx = req.getContextPath(); // e.g. /bottari
		final String path = req.getServletPath(); // e.g. /api/friendfunding
		final String qs = req.getQueryString();
		final String full = path + (qs != null ? "?" + qs : "");

		HttpSession session = req.getSession(false);
		Object auth = (session != null) ? session.getAttribute("authUser") : null;

		// 디버그(세션 ID까지 찍어서 쿠키 문제 분리)
		System.out.println("[INTC] path=" + path + " auth=" + (auth != null) + " jsid="
				+ (session != null ? session.getId() : "null") + " qs=" + qs);

		// 0) /user/** 는 항상 통과
		if (path.startsWith("/user/")) {
			System.out.println("[INTC] /user/* bypass");
			return true;
		}

		// 1) 상품상세 특례: fundingNo 있을 때만 보호
		if ("/shop/productPage2".equals(path)) {
			String fundingNo = req.getParameter("fundingNo");
			if (fundingNo == null || fundingNo.isBlank()) {
				System.out.println("[INTC] productPage2(no funding) → PASS");
				return true;
			}
			if (auth != null) {
				System.out.println("[INTC] productPage2(with funding) + logged-in → PASS");
				return true;
			}
			String loginUrl = ctx + "/user/loginForm?reason=auth&returnUrl="
					+ URLEncoder.encode(full, StandardCharsets.UTF_8);
			System.out.println("[INTC] productPage2(with funding) + not logged-in → REDIRECT " + loginUrl);
			res.sendRedirect(loginUrl);
			return false;
		}

		// 2) ★ 로그인된 경우는 어떤 경로든 우선 PASS (API 포함!)
		if (auth != null) {
			System.out.println("[INTC] logged-in → PASS");
			return true;
		}

		// 3) ★ 여기부터 '미로그인'인 경우 처리
		// API면 401 JSON으로, 페이지면 로그인폼으로 리다이렉트
		if (path.startsWith("/api/")) {
			res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			res.setContentType("application/json; charset=UTF-8");
			res.setHeader("X-Auth-Required", "1");
			res.getWriter().write("{\"result\":\"fail\",\"message\":\"로그인이 필요합니다.\"}");
			System.out.println("[INTC] API unauthorized → 401 JSON");
			return false;
		}

		String loginUrl = ctx + "/user/loginForm?reason=auth&returnUrl="
				+ URLEncoder.encode(full, StandardCharsets.UTF_8);
		System.out.println("[INTC] protected path + not logged-in → REDIRECT " + loginUrl);
		res.sendRedirect(loginUrl);
		return false;
	}
}
