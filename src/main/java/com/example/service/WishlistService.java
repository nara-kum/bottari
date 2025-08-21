package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.WishlistRepository;
import com.example.vo.CalenderVO;
import com.example.vo.WishlistVO;

@Service
public class WishlistService {

	@Autowired
	private WishlistRepository wishlistRepository;
	
	//위시리스트
	public List<WishlistVO> exeWishList(int no) {
		System.out.println("WishService.exeWishList()");
		
		List<WishlistVO> wList = wishlistRepository.selectWishList(no);
		
		return wList;
		
	}
	
	//기념일리스트
	public List<CalenderVO> exeEventList(int no) {
		System.out.println("WishService.exeEventList()");
		
		List<CalenderVO> eList = wishlistRepository.selectEventList(no);
		
		return eList;
		
	}
	
	
}
