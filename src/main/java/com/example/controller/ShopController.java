package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.service.ShopService;
import com.example.vo.ProductVO;




@Controller
public class ShopController {
 

	@Autowired
	private ShopService shopService;
	
	
	
	//상품등록폼
	@RequestMapping(value="/shopform", method= {RequestMethod.GET, RequestMethod.POST})
	public String shopform() {	
		System.out.println("ShopController.shopform");  //ㅇㅋ
		
		return "shop/shopform";	
	}
	

	
	//상품등록
		@RequestMapping(value="/register", method=RequestMethod.POST)
		public String insert(@ModelAttribute ProductVO productVO) {
		
			System.out.println("ShopController.insert");
			System.out.println("받은 데이터: " + productVO);
			
			int result = shopService.exeProductadd(productVO);
			
			if(result > 0) {
				System.out.println("상품 등록 성공!");
				return "redirect:/shopform"; // 성공 시 폼으로 리다이렉트
			} else {
				System.out.println("상품 등록 실패!");
				return "shop/shopform"; // 실패 시 다시 폼 페이지
			}
		}

	
	
	/*
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
	
	*/
	
}
