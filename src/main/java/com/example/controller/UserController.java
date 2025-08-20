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
	public String join(){
		System.out.println("UserController.Join()");
		
		return "user/join";	
	}

	
	//회원가입 완료시 보이는 화면
	@RequestMapping(value="/joinok", method = {RequestMethod.GET, RequestMethod.POST})
	public String joinok() {
		System.out.println("UserController.joinok");
		
		return "user/joinok";
	}
	
	//로그인폼
	@RequestMapping(value="/loginForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String login(){
		System.out.println("UserController.LoginForm()");
				
		return "user/loginform";	
	}
	
	//로그인
	@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
	public String login(@ModelAttribute UserVO userVO, HttpSession session){
		System.out.println("UserController.Login()");
		
		UserVO authUser = userService.exeLogin(userVO);
		
		//세션에 로그인 확인용 값을 넣어준다.
		session.setAttribute("authUser", authUser);
		
		return "redirect:/loginAfter";	
	}
	
	//로그아웃
	@RequestMapping(value="/logout", method= {RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpSession session){
		System.out.println("UserController.Logout()");

		//전부 날림
		session.invalidate();

		return "redirect:/loginForm";
	}
	
	//로그인 이후에 화면 --> 위시리스트
	@RequestMapping(value="/loginAfter", method= {RequestMethod.GET, RequestMethod.POST})
	public String loginAfter(){
		System.out.println("UserController.loginAfter");
		
		return "redirect:api/wishlist";
	}	
	

	// 회원정보수정폼
	@RequestMapping(value = "/editform", method = { RequestMethod.GET, RequestMethod.POST })
	public String editForm(HttpSession session, Model model) {
		System.out.println("UserController.editform()");

		//세션값 가져오기
		UserVO authUser = (UserVO)session.getAttribute("authUser");

		//로그인 여부 체크
		if(authUser==null) {
			return "redirect:loginForm";
		}else {
			//no값 꺼내기
			int no = authUser.getUserNo();
			System.out.println(no);
			
			//수정
			UserVO userVO = userService.exeEditData(no);

			model.addAttribute("userVO", userVO);

			return "user/Editform";
		}	
	}
		
	// 회원정보수정
	@RequestMapping(value = "/edit", method = { RequestMethod.GET, RequestMethod.POST })
	public String edit(@ModelAttribute UserVO userVO, HttpSession session) {
		System.out.println("UserController.edit()");
			
		//1.세션에서 no값을 꺼내온다
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		String no = authUser.getId();
			
		//2.DS가 묶어준 userVO에 세션에서 꺼낸 no를 추가한다
		userVO.setId(no);

		//3.서비스에 묶어둔 userVO를 넘긴다
		userService.exeEdit(userVO);
		
		//-----
		
		//4.해더의 이름 변경  --> 세션의 이름변경
		// 위에 1번에서 가져온 authUSer에 이름을 변경한다
		authUser.setName(userVO.getName());
			
		//5.로그인 폼으로 리다이렉트 시켜준다
		return "redirect:user/loginform";
		//return "redirect:shop/shoppingMall";
		
	}
		
}