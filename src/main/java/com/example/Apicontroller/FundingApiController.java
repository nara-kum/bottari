package com.example.Apicontroller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		System.out.println("FundingApiController.myFunding(protected, my list)");
		UserVO auth = (UserVO) session.getAttribute("authUser");
		if (auth == null)
			return JsonResult.fail("로그인이 필요합니다.");
		List<?> list = fundingService.getMyFundingList(auth.getUserNo());
		return JsonResult.success(list);
	}


	// 친구 펀딩
	@GetMapping("/api/friendfunding")
	public JsonResult friendFunding(HttpSession session) {
		System.out.println("FundingApiController.friendFunding(protected, i-paid list)");
		UserVO auth = (UserVO) session.getAttribute("authUser");
		if (auth == null)
			return JsonResult.fail("로그인이 필요합니다.");

		int userNo = auth.getUserNo();
		List<Map<String, Object>> list = fundingService.getFriendFundingList(userNo);
		return JsonResult.success(list);
	}

	// 총합
	@GetMapping("/api/funding/total")
	public JsonResult totalPaid(@RequestParam("fundingNo") long fundingNo) {
		long total = fundingService.getTotalPaidByFundingNo(fundingNo);
		return JsonResult.success(Map.of("fundingNo", fundingNo, "totalPaid", total));
	}

	// 펀딩중단-펀딩프로덕트 펀딩넘 읽어서 펀딩스테이터스 stop으로 변경,페이먼트 펀딩넘 읽어서 삭제

	// 펀딩완료-펀딩 상세 화면으로 가서 최대로 올린 후 전부 결제하면 됨

	// 펀딩취소-페이먼트에 가서 내가 낸 펀딩넘 삭제

}
