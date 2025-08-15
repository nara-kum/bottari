package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class CalenderController {
	//field
	
	//editor
	
	//method g/s
	
	//method normal
	@RequestMapping(value="/calender", method= {RequestMethod.GET, RequestMethod.POST})
	public String Calender() {
		System.out.println("CalenderController.Calender()");
		
		return "calender/calender";
	}
}
