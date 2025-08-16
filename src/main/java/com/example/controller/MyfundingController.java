package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MyfundingController {

	@RequestMapping(value="/myfunding", method= {RequestMethod.GET, RequestMethod.POST})
	public String myfunding(){
		System.out.println("MyfundingController.myfunding");
		
		return "funding/myfunding";	
	}	
}
