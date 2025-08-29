package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class InvitationController {
	
	//초대장 리스트
	@RequestMapping(value="invitation/list", method= {RequestMethod.GET, RequestMethod.POST})
	public String InvitationList(){
		System.out.println("InvitationController.InvitationList()");
		
		
		return "invitation/invitationList";
		
	}
	
	//초대장 전체보기
	@RequestMapping(value="invitation/invitation", method= {RequestMethod.GET, RequestMethod.POST})
	public String Invitation(){
		System.out.println("InvitationController.Invitation()");
		
		
		return "invitation/invitation";
		
	}
	
	//초대장 등록폼
	@RequestMapping(value="invitation/form", method= {RequestMethod.GET, RequestMethod.POST})
	public String InvitationForm(){
		System.out.println("InvitationController.InvitationForm()");
		
		
		return "invitation/invitationForm";
		
	}

}
