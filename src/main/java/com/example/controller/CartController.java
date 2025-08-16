package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CartController {

	
	
	//장바구니리스트(상품O)
	@RequestMapping(value="/cart", method= {RequestMethod.GET, RequestMethod.POST})
	public String list() {	
		System.out.println("CartController.list");
		
		return "shop/cart";
	}
	
	
	
	//장바구니리스트(상품X)
	@RequestMapping(value="/emptycart", method= {RequestMethod.GET, RequestMethod.POST})
	public String list2() {	
		System.out.println("CartController.list2");
		
		return "shop/emptyCart";
	}
	
	
	//장바구니등록
	
	
	
	//장바구니수정
	
	
	
	//장바구니삭제
	
	
	
}
