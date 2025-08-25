package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HistoryController {
	//field
	
	//editor
	
	//method g/s
	
	//method normal
	@RequestMapping(value="/history", method= {RequestMethod.GET, RequestMethod.POST})
	public String history() {
		System.out.println("HistoryController.history()");
		
		return "history/history_mine";
	}
}
