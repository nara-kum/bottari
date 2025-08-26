package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.CartService;
import com.example.vo.CartListVO;

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
	public String list() {	
		System.out.println("CartController.list()");
		
//		List<CartListVO> cartList = cartservice.execartList();
		
		return "shop/cart";
	}
	
	
	//장바구니등록
	
	
	
	//장바구니수정
	
	
	
	//장바구니삭제
	
	
	
}
