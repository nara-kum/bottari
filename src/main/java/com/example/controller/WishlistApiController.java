package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.WishlistService;
import com.example.vo.WishlistVO;
import com.javaex.util.JsonResult;

@RestController
public class WishlistApiController {
	
	@Autowired
	private WishlistService wishlistService;
	
	//리스트 보는 화면		
	@GetMapping("/api/wishlist")
	public JsonResult Wishlist(){
		System.out.println("WishController.Wishlist()");
		
		List<WishlistVO> wishVO = wishlistService.exeWishList();
		
		return JsonResult.success(wishVO);
		
	}
	
}
