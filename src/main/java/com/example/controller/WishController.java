package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.WishService;



@Controller
@RequestMapping("wishlist")
public class WishController {
	
	@Autowired
	private WishService wishService;

	
	//비어있는 위시리스트 보는 화면
	@RequestMapping(value="/", method= {RequestMethod.GET, RequestMethod.POST})
	public String Nonewish(){
		System.out.println("WishController.Nonewish()"); //ok
		
		return "wishlist/nonewish";	
	}	
	
	//리스트 보는 화면
	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
	public String Wishlist(){
		System.out.println("WishController.Wishlist()"); //ok
		
		return "wishlist/wishlist";	
	}
	
	//위시리스트 등록
	/*
	@RequestMapping(value="/wishadd", method={RequestMethod.GET, RequestMethod.POST})
	public String add(@ModelAttribute WishlistVO wishlistVO) {
		System.out.println("WishController.add");
		
		wishService.exeadd(wishlistVO); //위시리스트 등록하러 가는 곳은 쇼핑몰
		
		return "redirect:/bottarimall"; //쇼핑몰로 리다이렉트
	}
	*/
	
}
