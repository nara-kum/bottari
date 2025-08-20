package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.WishlistRepository;
import com.example.vo.WishlistVO;

@Service
public class WishlistService {

	@Autowired
	private WishlistRepository wishlistRepository;
	
	//위시리스트
	public List<WishlistVO> exeWishList() {
		System.out.println("WishService.exeWishList()");
		
		List<WishlistVO> wishVO = wishlistRepository.selectList();
		
		return wishVO;
		
	}
	
	
}
