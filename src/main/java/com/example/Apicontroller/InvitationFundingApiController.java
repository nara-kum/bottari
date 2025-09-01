// src/main/java/com/example/Apicontroller/InvitationFundingApiController.java
package com.example.Apicontroller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.InvitationFundingService;
import com.example.vo.UserVO;
import com.javaex.util.JsonResult;

import jakarta.servlet.http.HttpSession;

@RestController
public class InvitationFundingApiController {

	@Autowired
	private InvitationFundingService invitationFundingService;


    /** 마이펀딩(로그인 필요) */
    @GetMapping("/api/funding/my-list")
    public JsonResult myFundingList(HttpSession session){
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");
        List<Map<String,Object>> list = invitationFundingService.getMyFundingCards(auth.getUserNo());
        return JsonResult.success(list);
    }


    /** 펀딩중단 (소유자) */
    @PostMapping("/api/funding/stop")
    public JsonResult stop(@RequestParam("fundingNo") int fundingNo, HttpSession session){
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");
        int cnt = invitationFundingService.stopFunding(auth.getUserNo(), fundingNo);
        return (cnt > 0) ? JsonResult.success(Map.of("fundingNo", fundingNo, "status","STOP"))
                         : JsonResult.fail("중단 실패 또는 권한 없음");
    }

    /** 펀딩완료 (소유자) */
    @PostMapping("/api/funding/complete")
    public JsonResult complete(@RequestParam("fundingNo") int fundingNo, HttpSession session){
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");
        int cnt = invitationFundingService.completeFunding(auth.getUserNo(), fundingNo);
        return (cnt > 0) ? JsonResult.success(Map.of("fundingNo", fundingNo, "status","DONE"))
                         : JsonResult.fail("완료 처리 실패 또는 권한 없음");
    }
    

    /** 친구펀딩(내가 친구에게 낸 내역, 로그인 필요) */
    @GetMapping("/api/funding/friend-list")
    public JsonResult friendFunding(HttpSession session){
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");
        List<Map<String,Object>> list = invitationFundingService.getFriendFundingList(auth.getUserNo());
        return JsonResult.success(list);
    }

    /** 내가 참여한 펀딩 취소: 내 payment 삭제 */
    @PostMapping("/api/funding/friend/cancel")
    public JsonResult cancelMyFunding(@RequestParam("fundingNo") int fundingNo,
                                      HttpSession session){
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");

        int deleted = invitationFundingService.cancelMyFunding(auth.getUserNo(), fundingNo);
        if (deleted > 0) return JsonResult.success(deleted);
        return JsonResult.fail("삭제할 결제내역이 없습니다.");
    }
	
	/**초대장 초대장번호 → 이벤트 펀딩 카드 목록 */
	@GetMapping("/api/inv/funding/cards-by-inv")
	public JsonResult cardsByInvitation(@RequestParam("no") int invitationNo) {
		List<Map<String, Object>> list = invitationFundingService.getCardsByInvitationPublic(invitationNo);
		System.out.println("[API] /cards-by-inv no=" + invitationNo + " -> size=" + (list == null ? 0 : list.size()));
		return JsonResult.success(list == null ? java.util.Collections.emptyList() : list);
	}

	/**초대장 이벤트번호 → 이벤트 펀딩 카드 목록 (선택) */
	@GetMapping("/api/inv/funding/cards-by-event")
	public JsonResult cardsByEvent(@RequestParam("eventNo") int eventNo) {
		return JsonResult.success(invitationFundingService.getCardsByEventPublic(eventNo));
	}

	/**초대장 특정 펀딩 한 건만 (앵커) */
	@GetMapping("/api/inv/funding/cards-by-anchor")
	public JsonResult cardsByFunding(@RequestParam("fundingNo") int fundingNo) {
		return JsonResult.success(invitationFundingService.getCardsByFundingPublic(fundingNo));
	}

}
