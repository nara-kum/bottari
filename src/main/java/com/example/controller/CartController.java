package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.CartService;
import com.example.vo.CartListVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
	//field
	@Autowired
	private CartService cartservice;
	//editor
	
	//method g/s
	
	//method normal
	
	
	//장바구니리스트
	@RequestMapping(value="/cart", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(HttpSession session) {	
		System.out.println("CartController.list()");
		
		UserVO authuser = (UserVO) session.getAttribute("authUser");
		
		if(authuser == null) {
			// 로그인 안된 상태 → 로그인 페이지로 리다이렉트
			return "redirect:/loginForm";
		} else {
			
			int user_no = authuser.getUserNo();
			
			List<CartListVO> cartList = cartservice.execartList(user_no);
			
			System.out.println(cartList);
			
			return "shop/cart";
		}
		
	}
	
	
	//장바구니등록
	
	
	
	//장바구니수정
	
	
	
	//장바구니삭제
	
	
	
}
