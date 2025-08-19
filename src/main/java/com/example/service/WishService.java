package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.WishRepository;
import com.example.vo.WishlistVO;

@Service
public class WishService {

	@Autowired
	private WishRepository wishRepository;
	
	//위시리스트 등록
	public int exeProductadd(WishlistVO wishlistVO) {
		System.out.println("WishService.exeProductadd");
		
		int count = wishRepository.wishInsert(wishlistVO);
		return count;
	}
	
	//저장하기
	/*
	public int exeadd(WishlistVO wishlistVO) {	
		System.out.println("WishService.exeadd()");
		
		//가정
		//데이터가 여기서 생김 여기서 묶어야 됨
		//1. VO 를 만들고 묶으면 된다.
		//2. Map 으로 묶는다(이번에만 쓴다)  <--지금은 여기에 해당
				
		Map<String, String> wishMap = new HashMap<String, String>();
		wishMap.put("wishlist_no", "10");
		wishMap.put("user_no", "1");
		wishMap.put("product_no", "2");
		wishMap.put("date", "2025-03-27 09:00:00");
		wishMap.put("ea", "1");
		
		int count = wishRepository.wishInsert(wishMap);
		
		return count;
	}	
	*/
	
}
