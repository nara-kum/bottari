package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.UserService;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/user")
public class UserController {


	@Autowired
	private UserService userService;

	// 회원가입폼
	@RequestMapping(value = "/joinform", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinForm() {
		System.out.println("UserController.joinForm()");

		return "user/joinform";
	}

	// 회원가입
	@RequestMapping(value = "/join", method = { RequestMethod.GET, RequestMethod.POST })
	public String join(@ModelAttribute UserVO userVO) {
		System.out.println("UserController.Join()");
		System.out.println(userVO);
		
		try {
			userService.exeJoin(userVO);
			return "redirect:joinok";  //성공되면 회원가입 완료된 화면 보여줌
			
		} catch (Exception e) {
			return "redirect:joinform";
		}

	}

	//회원가입성공 화면
	@RequestMapping(value = "/joinok", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinOk() {
		System.out.println("UserController.joinok()");

		return "user/joinok";

	}	
	
	
	// 로그인폼
	@RequestMapping(value = "/loginForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginForm() {
		System.out.println("UserController.loginForm()");

		return "user/loginform";
	}

	// 로그인
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(@ModelAttribute UserVO userVO, HttpSession session) {
		System.out.println("UserController.Login()");

		UserVO authUser = userService.exeLogin(userVO);

		// 세션에 로그인 확인용 값을 넣어준다.
		session.setAttribute("authUser", authUser);
		System.out.println(authUser);

		return "redirect:/bottarimall";
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) {
		System.out.println("UserController.Logout()");

		// 전부 날림
		session.invalidate();

		return "redirect:/user/loginForm";
	}

	// 회원정보 수정폼 2025-08-26 오후 3:36 확인 했을때는 화면 잘 보임 
	@RequestMapping(value = "/editform", method = { RequestMethod.GET, RequestMethod.POST })
	public String editForm(HttpSession session, Model model) {
		System.out.println("UserController.editForm()");

		// 세션값 가져오기
		UserVO authUser = (UserVO) session.getAttribute("authUser");

		// 로그인 여부 체크
		if (authUser == null) {
			return "user/loginform";

		} else { // 로그인 했을때

			// no값 꺼내기
			int no = authUser.getUserNo();

			// 수정
			UserVO userVO = userService.exeEditForm(no);

			model.addAttribute("userVO", userVO);
		}

		return "user/Editform";
	}
	

	// 회원정보 수정   
	@RequestMapping(value = "/edit", method = { RequestMethod.GET, RequestMethod.POST })
	public String edit(@ModelAttribute UserVO userVO, HttpSession session) {
		System.out.println("UserController.edit()");
		
		//세션에서 꺼내기
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		int no = authUser.getUserNo();
		
		//userVO에 세션에서 꺼낸 no추가
		userVO.setUserNo(no);
		userService.exeEdit(userVO);

		authUser.setName(userVO.getName());
		
		return "redirect:/bottarimall"; //보따리 몰로 이동
	    
	}
	


}