// src/main/java/com/example/Apicontroller/FundingApiController.java
package com.example.Apicontroller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.FundingService;
import com.example.service.InvitationService;
import com.example.vo.UserVO;
import com.javaex.util.JsonResult;

import jakarta.servlet.http.HttpSession;

@RestController
public class FundingApiController {

	@Autowired
	private FundingService fundingService;

	@Autowired
	private InvitationService invitationService;

	// 내 펀딩 목록
	@GetMapping("/api/myfunding")
	public JsonResult myFunding(@RequestParam(value = "eventNo", required = false) Integer eventNo,
			HttpSession session) {

		// ✅ 공개 케이스: 초대장 공유 화면에서 호출 (/api/myfunding?eventNo=###)
		if (eventNo != null) {
			System.out.println("FundingApiController.myFunding(public, eventNo=" + eventNo + ")");
			// InvitationService에 이미 추가한 공개 메서드 사용
			List<Map<String, Object>> list = invitationService.getGiftsPublicByEvent(eventNo);
			return JsonResult.success(list != null ? list : Collections.emptyList());
		}

		// 🔒 보호 케이스: '내 펀딩' (기존 동작 유지)
		System.out.println("FundingApiController.myFunding(protected, my list)");
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null) {
			return JsonResult.fail("로그인이 필요합니다.");
		}

		Long userNo = (long) authUser.getUserNo(); // 매퍼 parameterType=long 이라고 되어 있음
		System.out.println("FundingService.getMyFundingList(userNo=" + userNo + ")");
		List<Map<String, Object>> list = fundingService.getMyFundingList(userNo);
		System.out.println("API /api/myfunding size=" + (list == null ? 0 : list.size()));
		return JsonResult.success(list != null ? list : Collections.emptyList());
	}

}
