package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {
	
	@RequestMapping(value="/join", method= {RequestMethod.GET, RequestMethod.POST})
	public String Join(){
		System.out.println("UserController.Join()");
		
		return "user/join";	
	}
	
	@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
	public String Login(){
		System.out.println("UserController.Login()");
		
		return "user/login";	
	}
}