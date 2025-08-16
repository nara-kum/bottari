package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ShopController {
 
	@RequestMapping(value="/shopform", method= {RequestMethod.GET, RequestMethod.POST})
	public String insert() {	
		System.out.println("ShopController.insert");
		
		return "shop/shopform";	
	}
}
