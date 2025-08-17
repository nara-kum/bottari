package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class InvitationController {
	
	@RequestMapping(value="/invitationList", method= {RequestMethod.GET, RequestMethod.POST})
	public String InvitationList(){
		System.out.println("InvitationController.InvitationList()");
		
		
		return "invitation/invitationList";
		
	}
	
	@RequestMapping(value="/invitation", method= {RequestMethod.GET, RequestMethod.POST})
	public String Invitation(){
		System.out.println("InvitationControllerInvitation()");
		
		
		return "invitation/invitation";
		
	}
	
	@RequestMapping(value="/invitationForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String InvitationForm(){
		System.out.println("InvitationController.InvitationForm()");
		
		
		return "invitation/invitationForm";
		
	}

}
