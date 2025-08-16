package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class JoinController {
	
	@RequestMapping(value="/join", method= {RequestMethod.GET, RequestMethod.POST})
	public String Join(){
		System.out.println("JoinController");
		
		return "shop/join";	
	}
}