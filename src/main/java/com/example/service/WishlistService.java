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
	
	//펀딩 생성시 펀딩테이블에 인서트 하고, 위시리스트 삭제
	public void exeFunding(List<WishlistVO> wishlistVO) {
		System.out.println("WishService.exeFunding()");
		
		//펀딩테이블에 먼저 인서트
		wishlistRepository.insertFunding(wishlistVO);
		
		//위시리스트 삭제
		int eventNum = wishlistVO.get(0).getEventNo();
		wishlistRepository.deleteWishlist(eventNum);
		
	}
	
	
}
