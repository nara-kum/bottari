package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.UserService;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	//회원가입폼
	@RequestMapping(value="/joinForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String joinForm(){
		System.out.println("UserController.joinForm()");
				
		return "user/joinform";	
	}
	
	//회원가입
	@RequestMapping(value="/join", method= {RequestMethod.GET, RequestMethod.POST})
	public String join(@ModelAttribute UserVO userVO){
		System.out.println("UserController.Join()");
		System.out.println(userVO);
		
		int count = userService.exeJoin(userVO);

		return "redirect:/loginForm";	
	}

	//로그인폼
	@RequestMapping(value="/loginForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String login(){
		System.out.println("UserController.Login()");
				
		return "user/loginform";	
	}
	
	//로그인
	@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
	public String login(@ModelAttribute UserVO userVO, HttpSession session){
		System.out.println("UserController.Login()");

		UserVO authUser = userService.exeLogin(userVO);
		
		//세션에 로그인 확인용 값을 넣어준다.
		session.setAttribute("authUser", authUser);
		System.out.println(authUser);
		
		return "shop/shoppingMall";	
	}
	
	//로그아웃
	@RequestMapping(value="/logout", method= {RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpSession session){
		System.out.println("UserController.Logout()");

		//전부 날림
		session.invalidate();

		return "redirect:/loginForm";
	}
}