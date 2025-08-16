package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WishlistController {

	@RequestMapping(value="/wishlist", method= {RequestMethod.GET, RequestMethod.POST})
	public String Wishlist(){
		System.out.println("WishlistController.wishlist");
		
		return "wishlist/wishlist";	
	}	
}
