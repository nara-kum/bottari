package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.CalenderService;
import com.example.vo.CalenderVO;



@Controller
public class CalenderController {
	//field
	@Autowired
	private CalenderService calenderservice;
	//editor
	
	//method g/s
	
	//method normal
	
	//캘린더 리스트
	@RequestMapping(value="/calender", method= {RequestMethod.GET, RequestMethod.POST})
	public String calenderList(Model model) {
		System.out.println("CalenderController.calenderList()");
		
		List<CalenderVO> calenderList = calenderservice.exeCalenderList();
		
		model.addAttribute("cList", calenderList);
		
		return "/calender/calender";
	}
	
	//이벤트 등록
	@RequestMapping(value="/insert", method= {RequestMethod.GET, RequestMethod.POST})
	public String eventInsert() {
		System.out.println("CalenderController.eventInsert()");
		
		
		
		return "";
	}
}
