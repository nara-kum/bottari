package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.InvitationService;
import com.example.vo.InvitationVO;

@Controller
public class InvitationController {
	
	@Autowired
	private InvitationService invitationService;
	
	//초대장 리스트
	@RequestMapping(value="/invitationList", method= {RequestMethod.GET, RequestMethod.POST})
	public String InvitationList(){
		System.out.println("InvitationController.InvitationList()");
		
		
		return "invitation/invitationList";
		
	}
	
	//초대장 전체보기
	@RequestMapping(value="/invitation", method= {RequestMethod.GET, RequestMethod.POST})
	public String Invitation(){
		System.out.println("InvitationControllerInvitation()");
		
		
		return "invitation/invitation";
		
	}
	
	//초대장 등록폼
	@RequestMapping(value="/invitationForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String InvitationForm(){
		System.out.println("InvitationController.InvitationForm()");
		
		
		return "invitation/invitationForm";
		
	}
	
	//초대장 등록
	@RequestMapping(value="/invtreg", method= {RequestMethod.GET, RequestMethod.POST})
	public String invtReg(@ModelAttribute InvitationVO invitationVO){
		System.out.println("InvitationController.invtReg()");
		System.out.println(invitationVO);
		
		invitationService.exeInvt(invitationVO);
		
		return "invitation/invitationForm";
		
	}

}
