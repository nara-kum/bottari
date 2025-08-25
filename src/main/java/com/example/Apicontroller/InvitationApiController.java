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
	@PostMapping("api/invtreg")
	public JsonResult invtReg(@RequestBody InvitationVO invitationVO, HttpSession session) {
		System.out.println("InvitationApiController.invtReg()");
		System.out.println(invitationVO);

		// 1) 로그인 체크
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null) {
			return JsonResult.fail("로그인이 필요합니다.");
		}
		int userNo = authUser.getUserNo();
		
		invitationService.exeInvt(invitationVO);

		// 5) 응답
		return JsonResult.success(invitationVO);
		
	}


}
