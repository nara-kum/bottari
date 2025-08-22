package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
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
	public String join(@ModelAttribute UserVO userVO) {
		System.out.println("UserController.join()");

		try {
			userService.exeJoin(userVO);
			return "user/joinok";

		} catch (DuplicateKeyException e) {
			System.out.println(e);
			System.out.println("중복아이디");
			return "redirect:/joinform";

		} catch (Exception e) {
			System.out.println(e);
			return "redirect:/joinform";
		}

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
		
		UserVO user = userService.exeLogin(userVO);
		System.out.println(user);

		if (user == null) {
			System.out.println("로그인 실패: 사용자 정보 없음");
		} else {
			System.out.println("로그인 성공");
			System.out.println(user.name);
		}

		// 세션에 로그인 확인용 값을 넣어준다(id/pw가 들어있는 주소)-->로그인
		session.setAttribute("authUser", user);

		return "redirect:shoppingMall";
	}
	
	//로그아웃
	@RequestMapping(value="/logout", method= {RequestMethod.GET, RequestMethod.POST})
	public String logOut(HttpSession session){
		System.out.println("UserController.LogOut()");

		//전부 날림
		session.invalidate();

		return "redirect:/loginForm";
	}

	/* 8/22부터 주말 수정하기
	// --회원정보수정폼
	@RequestMapping(value = "/editform", method = { RequestMethod.GET, RequestMethod.POST })
	public String editForm(HttpSession session, Model model) {
		System.out.println("UserController.editForm");

		//세션에 값이 있는지 가져온다
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		
		if (authUser == null) { // 로그인 안했을때

			return "redirect:/user/loginform";

		} else { // 로그인 했을때

			// 세션에서 no값을 가져온다(지금접속한(로그인된) 사용자의 no값)
			int no = authUser.getUserNo();

			// no를 서비스에 넘겨서 no회원의 정보를 userVO 형태로 받는다
			UserVO userVO = userService.exeEditForm(no);

			// userVO를 모델에 담는다 -- > DispatcherServlet아!!! request의 어트리뷰트에 넣어라
			model.addAttribute("userVO", userVO);
		}

		return "user/Editform";
	}
	*/
		
	/* 8/22부터 주말 수정하기
	// 회원정보수정
	@RequestMapping(value = "/edit", method = { RequestMethod.GET, RequestMethod.POST })
	public String edit(@ModelAttribute UserVO userVO, HttpSession session) {
		System.out.println("UserController.edit");

		// 세션에서 꺼내기
		UserVO uservo = (UserVO) session.getAttribute("uservo");
		
		//로그인 여부
		if (uservo == null) {
			// 세션에 uservo가 없을 경우 예외 처리
			System.out.println("사용자가 로그인하지 않았습니다.");
		} else {
			System.out.println("로그인 완료");
		}

		// userVO에 세션에서 꺼낸 id추가
		userVO.setId(uservo.getId());
		
		// 서비스에 묶어둔 userVO를 넘긴다
		userService.exeEdit(userVO);

		//세션에서 가져온 uservo에 이름을 변경한다.
		userVO.setName(userVO.getName());

		// 로그인 폼으로 리다이렉트 시켜준다
		return "redirect:user/loginform";

	}
	*/
		
}