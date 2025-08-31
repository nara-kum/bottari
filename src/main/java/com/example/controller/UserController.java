package com.example.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.service.UserService;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	/*
	 * =========================== 회원가입 ===========================
	 */
	@RequestMapping(value = "/joinform", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinForm() {
		return "user/joinform";
	}

	@RequestMapping(value = "/join", method = { RequestMethod.GET, RequestMethod.POST })
	public String join(@ModelAttribute UserVO userVO) {
		try {
			userService.exeJoin(userVO);
			return "redirect:joinok";
		} catch (Exception e) {
			return "redirect:joinform";
		}
	}

	@RequestMapping(value = "/joinok", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinOk() {
		return "user/joinok";
	}

	/*
	 * =========================== 로그인 ===========================
	 */

	// 로그인 폼: returnUrl 있으면 모델에 세팅하여 hidden으로 전달
	@RequestMapping(value = "/loginForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginForm(@RequestParam(value = "returnUrl", required = false) String returnUrl, Model model) {
		if (returnUrl != null && !returnUrl.isBlank()) {
			model.addAttribute("returnUrl", returnUrl);
		}
		return "user/loginform";
	}

	// ✅ GET /user/login 이 들어오면 폼으로 리다이렉트 (id 파라미터 요구 에러 방지)
	@GetMapping("/login")
	public String loginGet(@RequestParam(value = "returnUrl", required = false) String returnUrl) {
		String q = (returnUrl != null && !returnUrl.isBlank())
				? "?returnUrl=" + URLEncoder.encode(returnUrl, StandardCharsets.UTF_8)
				: "";
		return "redirect:/user/loginForm" + q;
	}

	// ✅ POST /user/login 만 실제 로그인 처리
	@PostMapping("/login")
	public String login(@RequestParam("id") String id, @RequestParam("password") String password,
			@RequestParam(value = "returnUrl", required = false) String returnUrl, HttpSession session) {

		System.out.println("[LOGIN] try id=" + id);

		UserVO param = new UserVO();
		param.setId(id);
		param.setPassword(password);

		UserVO authUser = userService.exeLogin(param);
		System.out.println("[LOGIN] result=" + (authUser == null ? "FAIL" : ("OK userNo=" + authUser.getUserNo())));

		if (authUser == null) {
			String q = (returnUrl != null && !returnUrl.isBlank())
					? "?error=1&returnUrl=" + URLEncoder.encode(returnUrl, StandardCharsets.UTF_8)
					: "?error=1";
			return "redirect:/user/loginForm" + q;
		}

		// 세션 저장
		session.setAttribute("authUser", authUser);

		// 안전한 내부 경로로만 복귀
		if (returnUrl != null && !returnUrl.isBlank() && returnUrl.startsWith("/")) {
			return "redirect:" + returnUrl;
		}
		// 기본 목적지
		return "redirect:/funding/my";
	}

	/*
	 * =========================== 로그아웃 ===========================
	 */
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/user/loginForm";
	}

	/*
	 * =========================== 회원정보 수정 ===========================
	 */
	@RequestMapping(value = "/editform", method = { RequestMethod.GET, RequestMethod.POST })
	public String editForm(HttpSession session, Model model) {
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null) {
			// 보호 페이지 → 로그인 폼으로
			return "user/loginform";
		}
		int no = authUser.getUserNo();
		UserVO userVO = userService.exeEditForm(no);
		model.addAttribute("userVO", userVO);
		return "user/Editform";
	}

	@RequestMapping(value = "/edit", method = { RequestMethod.GET, RequestMethod.POST })
	public String edit(@ModelAttribute UserVO userVO, HttpSession session) {
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		int no = authUser.getUserNo();
		userVO.setUserNo(no);
		userService.exeEdit(userVO);
		authUser.setName(userVO.getName());
		return "redirect:/user/bottarimall";
	}
}
