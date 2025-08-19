package com.example.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.WishlistVO;

@Repository
public class WishRepository {

	@Autowired
	private SqlSession sqlSession;	
	
	//위시리스트 등록
	public int wishInsert(WishlistVO wishlistVO) {
		System.out.println("WishRepository.wishInsert");
		
		int count = sqlSession.insert("wish.insert",wishlistVO);
		
		return count;
	}
	
	//--1명저장 Map
	/*
	public int wishInsert(Map<String, String> wishMap) {
		System.out.println("WishRepository.wishInsert");
		
		System.out.println(wishMap);
		int count = sqlSession.insert("wishlist.insert",wishMap);
		
		return count;
	}
	*/
	
}
