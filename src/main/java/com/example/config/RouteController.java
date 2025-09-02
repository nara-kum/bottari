package com.example.config;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.vo.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RouteController {

    @GetMapping("/r/go-detail")
    public String goDetail(@RequestParam("productNo") int productNo,
                           @RequestParam("fundingNo") int fundingNo,
                           @RequestParam(value = "back", required = false) String back,
                           HttpServletRequest req,
                           HttpSession session) {

        UserVO auth = (UserVO) (session == null ? null : session.getAttribute("authUser"));
        String ctx = req.getContextPath();

        if (auth != null) {
            String target = ctx + "/shop/productPage2?productNo=" + productNo + "&fundingNo=" + fundingNo;
            return "redirect:" + target;
        }

        // 내부 경로만 허용, 아니면 기본값
        String returnUrl = (back != null && back.startsWith("/")) ? back : "/invitation/list";
        String loginUrl = ctx + "/user/loginForm?returnUrl=" + URLEncoder.encode(returnUrl, StandardCharsets.UTF_8);
        return "redirect:" + loginUrl;
    }
}
