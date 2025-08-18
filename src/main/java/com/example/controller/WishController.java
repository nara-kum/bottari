package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WishController {

	@RequestMapping(value="/wishlist", method= {RequestMethod.GET, RequestMethod.POST})
	public String Wishlist(){
		System.out.println("WishlistController.Wishlist()");
		
		return "wishlist/wishlist";	
	}

	@RequestMapping(value="/nonewish", method= {RequestMethod.GET, RequestMethod.POST})
	public String Nonewish(){
		System.out.println("WishController.Nonewish()");
		
		return "wishlist/nonewish";	
	}		
}
