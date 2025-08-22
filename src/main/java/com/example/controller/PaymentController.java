package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PaymentController {
	//field
	
	//editor
	
	//method g/s
	
	//method normal
	@RequestMapping(value = "/checkout", method = { RequestMethod.GET, RequestMethod.POST })
	public String checkoutList() {
		System.out.println("PayController.checkoutList()");
		
		return "/shop/checkout";
	}
}
