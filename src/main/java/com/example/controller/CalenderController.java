package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	public int eventInsert(@ModelAttribute CalenderVO calendervo) {
		System.out.println("CalenderController.eventInsert()");
		
//		System.out.println("CalenderController.calendervo:" + calendervo);
		
		int count = calenderservice.exeInsertCalender(calendervo);
		
		return count;
	}
	
	//이벤트 수정
	@RequestMapping(value="/update", method= {RequestMethod.GET, RequestMethod.POST})
	public int eventUpdate(@ModelAttribute CalenderVO calendervo) {
		System.out.println("CalenderController.eventUpdate()");
		
		System.out.println("CalenderController.calendervo" + calendervo);
		
		int count = calenderservice.exeUpdateCalender(calendervo);
		
		return count;
	}
	
	
	
	//이벤트 삭제
}
