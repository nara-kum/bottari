package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.HistoryService;
import com.example.vo.HistoryVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class HistoryController {
	//field
	@Autowired
	private HistoryService historyservice;
	//editor
	
	//method g/s
	
	//method normal
	@RequestMapping(value="/history", method= {RequestMethod.GET, RequestMethod.POST})
	public String history(HttpSession session, Model model) {
		System.out.println("HistoryController.history()");
		
		UserVO authuser = (UserVO) session.getAttribute("authUser");
		
		int user_no = authuser.getUserNo();
		
		List<HistoryVO> historyList = historyservice.exeHistoryList(user_no);
		
		return "history/history_mine";
	}
}
