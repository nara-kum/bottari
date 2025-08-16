package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ShopController {
 

	
	
	
	//상세등록폼
	@RequestMapping(value="/shopform", method= {RequestMethod.GET, RequestMethod.POST})
	public String insert() {	
		System.out.println("ShopController.insert");
		
		return "shop/shopform";	
	}
	
	
	//상세페이지
	@RequestMapping(value="/productPage", method= {RequestMethod.GET, RequestMethod.POST})
	public String selectOne() {	
		System.out.println("ShopController.selectOne");
		
		return "shop/productPage";
	
	}
	
	//상세페이지_펀딩
	@RequestMapping(value="/productPage2", method= {RequestMethod.GET, RequestMethod.POST})
	public String selectOne2() {	
		System.out.println("ShopController.selectOne");
		
		return "shop/productPage_funding";
	}
	
	
	//쇼핑몰리스트
	@RequestMapping(value="/bottarimall", method= {RequestMethod.GET, RequestMethod.POST})
	public String list() {	
		System.out.println("ShopController.list");
		
		return "shop/shoppingMall";	
	}
	
	
	
}
