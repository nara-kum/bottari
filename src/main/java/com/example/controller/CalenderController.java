package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.CalenderService;
import com.example.vo.CalenderVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class CalenderController {
	// field
	@Autowired
	private CalenderService calenderservice;
	// editor

	// method g/s

	// method normal

	// 캘린더 리스트
	@RequestMapping(value = "/calender", method = { RequestMethod.GET, RequestMethod.POST })
	public String calenderList(Model model, HttpSession session) {
		System.out.println("CalenderController.calenderList()");

		UserVO authuser = (UserVO) session.getAttribute("authUser");

		System.out.println("authuser in session: " + session.getAttribute("authuser"));

		if (authuser == null) {
			// 로그인 안된 상태 → 로그인 페이지로 리다이렉트
			return "redirect:/loginForm";
		}

		int user_no = authuser.getUserNo();

		System.out.println("현재 로그인 user_no: " + user_no);

		List<CalenderVO> calenderList = calenderservice.exeCalenderList(user_no);

		model.addAttribute("cList", calenderList);

		return "/calender/calendar_control";
	}
}
