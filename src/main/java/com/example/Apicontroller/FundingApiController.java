package com.example.Apicontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.FundingService;
import com.example.vo.UserVO;
import com.example.vo.WishlistVO;
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
		int no = authUser.getUserNo();

		List<WishlistVO> fList = fundingService.exeMyFundingList(no);
		
		return (fList != null) ? JsonResult.success(fList) : JsonResult.fail("알 수 없는 오류");
	}

}
