package com.example.Apicontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.InvitationService;
import com.example.vo.InvitationVO;
import com.example.vo.UserVO;
import com.javaex.util.JsonResult;

import jakarta.servlet.http.HttpSession;

@RestController	
public class InvitationApiController {
	
	@Autowired
	private InvitationService invitationService;
	
	//초대장 등록
	@PostMapping("/api/invtreg")
	public JsonResult invtReg(@RequestBody InvitationVO invitationVO, HttpSession session) {
		System.out.println("InvitationApiController.invtReg()");
		System.out.println(invitationVO);

	    UserVO authUser = (UserVO) session.getAttribute("authUser");
	    if (authUser == null) {
	        return JsonResult.fail("로그인이 필요합니다.");
	    }
	    invitationVO.setUserNo(authUser.getUserNo());

	    // 필수값 검증
	    if (invitationVO.getCategoryNo() == 0 || invitationVO.getEventNo() == 0
	        || invitationVO.getCelebrateDate() == null || invitationVO.getCelebrateDate().isBlank()) {
	        return JsonResult.fail("필수 항목을 확인해주세요.");
	    }
	
	    int cnt = invitationService.exeInvtReg(invitationVO);
	    if (cnt > 0) {
	        return JsonResult.success(invitationVO); // useGeneratedKeys면 invitationNo 채워져 돌아옴
	    }
	    return JsonResult.fail("초대장 등록에 실패했습니다.");
	}


}
