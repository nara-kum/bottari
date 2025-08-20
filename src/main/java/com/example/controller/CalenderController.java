package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.CalenderService;
import com.example.vo.CalenderVO;
import com.example.vo.InvitationVO;
import com.example.vo.ProductVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;



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

	    return "/calender/calender";
	}
	
	//이벤트 연결 펀딩 리스트, 초대장 호출
	@RequestMapping(value="/response", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> ResponseEntity(@RequestParam("event_id") int event_id) {
		System.out.println("CalenderController.ResponseEntitiy()");
		
		Map<String, Object> result = new HashMap<>();		
		
		System.out.println(event_id);
		
		//DB에서 가져오기
		List<InvitationVO> invitationList = calenderservice.exegetInvitationList(event_id);
		List<ProductVO> productList = calenderservice.exegetProductList(event_id);
		
		result.put("fundingList", productList);
	    result.put("invitationList", invitationList);
		
		return result;
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
		
//		System.out.println("CalenderController.calendervo" + calendervo);
		
		int count = calenderservice.exeUpdateCalender(calendervo);
		
		return count;
	}
	
	//이벤트 삭제
	@RequestMapping(value="/delte", method= {RequestMethod.GET, RequestMethod.POST})
	public int eventDelete(@ModelAttribute CalenderVO calendervo) {
		System.out.println("CalenderController.eventDelete()");
		
		int count = calenderservice.exeDeleteCalender(calendervo);
		
		return 0;
	}
}
