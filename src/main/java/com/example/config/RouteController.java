package com.example.config;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RouteController {

    @GetMapping("/r/go-detail")
    public String goDetail(@RequestParam("productNo") int productNo,
                           @RequestParam("fundingNo") int fundingNo,
                           @RequestParam(value = "back", required = false) String back,
                           HttpServletRequest req) {

        String ctx = req.getContextPath();

        // 로그인 여부 무관하게 상세 페이지로 이동
        StringBuilder target = new StringBuilder()
                .append(ctx).append("/shop/productPage2")
                .append("?productNo=").append(productNo)
                .append("&fundingNo=").append(fundingNo);

        // 내부 경로만 back으로 전달 (선택)
        if (back != null && back.startsWith("/")) {
            target.append("&back=").append(URLEncoder.encode(back, StandardCharsets.UTF_8));
        }

        return "redirect:" + target.toString();
    }
}
