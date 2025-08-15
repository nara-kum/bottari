package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class InvitationController {
	
	@RequestMapping(value="/invitation", method= {RequestMethod.GET, RequestMethod.POST})
	public String Invitation(){
		System.out.println("InvitationController");
		
		
		return "invitation/invitation";
		
	}

}
