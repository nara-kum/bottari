package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WishlistController {
	
	//리스트 보는 화면
	@RequestMapping(value="funding/wish", method= {RequestMethod.GET, RequestMethod.POST})
	public String Wishlist(){
		System.out.println("WishController.Wishlist()");
		
		return "wishlist/wishlist";	
	}
	
}
