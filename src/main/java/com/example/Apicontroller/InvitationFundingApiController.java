// src/main/java/com/example/Apicontroller/InvitationFundingApiController.java
package com.example.Apicontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.InvitationFundingService;
import com.javaex.util.JsonResult;

@RestController
public class InvitationFundingApiController {

	@Autowired
    private InvitationFundingService invitationFundingService;

//    public InvitationFundingApiController(InvitationFundingService invitationFundingService) {
//        this.invitationFundingService = invitationFundingService;
//    }

    /** 초대장번호 → 이벤트 펀딩 카드 목록 */
    @GetMapping("/api/inv/funding/cards-by-inv")
    public JsonResult cardsByInvitation(@RequestParam("no") int invitationNo){
        List<Map<String,Object>> list = invitationFundingService.getCardsByInvitationPublic(invitationNo);
        return JsonResult.success(list);
    }

    /** 이벤트번호 → 이벤트 펀딩 카드 목록 (선택) */
    @GetMapping("/api/inv/funding/cards-by-event")
    public JsonResult cardsByEvent(@RequestParam("eventNo") int eventNo){
        return JsonResult.success(invitationFundingService.getCardsByEventPublic(eventNo));
    }

    /** 특정 펀딩 한 건만 (앵커) */
    @GetMapping("/api/inv/funding/cards-by-anchor")
    public JsonResult cardsByFunding(@RequestParam("fundingNo") int fundingNo){
        return JsonResult.success(invitationFundingService.getCardsByFundingPublic(fundingNo));
    }

    /** 진행바 총합(해당 펀딩의 결제 누적) */
//    @GetMapping("/api/funding/total")
//    public JsonResult totalByFunding(@RequestParam("fundingNo") int fundingNo){
//        int total = invitationFundingService.getTotalPaid(fundingNo);
//        Map<String,Object> data = new HashMap<>();
//        data.put("fundingNo", fundingNo);
//        data.put("totalPaid", total);
//        return JsonResult.success(data);
//    }
}
