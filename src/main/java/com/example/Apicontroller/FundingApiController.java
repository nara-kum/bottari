// src/main/java/com/example/Apicontroller/FundingApiController.java
package com.example.Apicontroller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.FundingService;
import com.example.vo.UserVO;
import com.javaex.util.JsonResult;

import jakarta.servlet.http.HttpSession;

@RestController
public class FundingApiController {

    @Autowired
    private FundingService fundingService;

    // 내 펀딩 목록
    @GetMapping("/api/myfunding")
    public JsonResult myFunding(HttpSession session) {
        System.out.println("FundingApiController.myFunding()");

        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) {
            return JsonResult.fail("로그인이 필요합니다.");
        }

        // 매퍼 parameterType=long 과 일치
        Long userNo = (long) authUser.getUserNo();

        System.out.println("FundingService.getMyFundingList(userNo=" + userNo + ")");
        List<Map<String, Object>> list = fundingService.getMyFundingList(userNo);
        System.out.println("API /api/myfunding size=" + (list == null ? 0 : list.size()));
        System.out.println(list);

        return (list != null) ? JsonResult.success(list) : JsonResult.success(Collections.emptyList());
    }

}
