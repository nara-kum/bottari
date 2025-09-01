package com.example.controller;

import java.net.URLEncoder;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.service.UserService;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /* =========================== 회원가입 =========================== */
    @GetMapping("/joinform")
    public String joinForm() {
        return "user/joinform";
    }

    @PostMapping("/join")
    public String join(@ModelAttribute UserVO userVO) {
        try {
            userService.exeJoin(userVO);
            return "redirect:joinok";
        } catch (Exception e) {
            return "redirect:joinform";
        }
    }

    @GetMapping("/joinok")
    public String joinOk() {
        return "user/joinok";
    }

    /* =========================== 로그인 =========================== */

    // 로그인 폼: GET만 허용
    @GetMapping("/loginForm")
    public String loginForm(@RequestParam(value = "returnUrl", required = false) String returnUrl, Model model) {
        if (returnUrl != null && !returnUrl.isBlank()) {
            model.addAttribute("returnUrl", returnUrl);
        }
        return "user/loginform";
    }

    // GET /user/login → 폼으로 리다이렉트
    @GetMapping("/login")
    public String loginGet(@RequestParam(value = "returnUrl", required = false) String returnUrl,
                           HttpServletRequest req) {
        String ctx = req.getContextPath();
        String q = (returnUrl != null && !returnUrl.isBlank())
                ? "?returnUrl=" + URLEncoder.encode(returnUrl, StandardCharsets.UTF_8)
                : "";
        return "redirect:" + ctx + "/user/loginForm" + q;
    }

    // ✅ 실제 로그인 처리
    @PostMapping("/login")
    public String login(@RequestParam("id") String id,
                        @RequestParam("password") String password,
                        @RequestParam(value = "returnUrl", required = false) String returnUrl,
                        HttpServletRequest req,
                        HttpSession session) {

        System.out.println("[LOGIN] try id=" + id);

        UserVO param = new UserVO();
        param.setId(id);
        param.setPassword(password);

        UserVO authUser = userService.exeLogin(param);
        System.out.println("[LOGIN] result=" + (authUser == null ? "FAIL" : ("OK userNo=" + authUser.getUserNo())));

        if (authUser == null) {
            String ctx = req.getContextPath();
            String q = (returnUrl != null && !returnUrl.isBlank())
                    ? "?error=1&returnUrl=" + URLEncoder.encode(returnUrl, StandardCharsets.UTF_8)
                    : "?error=1";
            return "redirect:" + ctx + "/user/loginForm" + q;
        }

        // 세션 저장
        session.setAttribute("authUser", authUser);

        // ✅ returnUrl 정규화 (디코드 → 컨텍스트 제거 → 내부경로만 허용)
        String ctx = req.getContextPath(); // 예: "" 또는 "/bottari"
        String target = null;
        if (returnUrl != null && !returnUrl.isBlank()) {
            try {
                String decoded = URLDecoder.decode(returnUrl, StandardCharsets.UTF_8).trim();
                if (ctx != null && !ctx.isEmpty() && decoded.startsWith(ctx + "/")) {
                    decoded = decoded.substring(ctx.length());
                }
                if (decoded.startsWith("/") && !decoded.startsWith("//")) {
                    target = decoded;
                }
            } catch (Exception ignore) {}
        }

        if (target != null) {
            // 🔒 컨텍스트 포함 리다이렉트 (서버별 컨텍스트 처리 차이 방지)
            return "redirect:" + ctx + target;
        }

        // 기본 목적지 (컨텍스트 포함)
        return "redirect:" + ctx + "/funding/my";
    }

    /* =========================== 로그아웃 =========================== */
    @RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
    public String logout(HttpSession session, HttpServletRequest req) {
        session.invalidate();
        String ctx = req.getContextPath();
        return "redirect:" + ctx + "/user/loginForm";
    }

    /* =========================== 회원정보 수정 =========================== */
    @RequestMapping(value = "/editform", method = { RequestMethod.GET, RequestMethod.POST })
    public String editForm(HttpSession session, HttpServletRequest req, Model model) {
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) {
            String ctx = req.getContextPath();
            String full = req.getRequestURI() + (req.getQueryString() != null ? "?" + req.getQueryString() : "");
            String q = "?returnUrl=" + URLEncoder.encode(full, StandardCharsets.UTF_8);
            return "redirect:" + ctx + "/user/loginForm" + q;
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
