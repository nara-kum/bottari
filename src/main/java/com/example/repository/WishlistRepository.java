package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CalenderVO;
import com.example.vo.WishlistVO;

@Repository
public class WishlistRepository {

	@Autowired
	private SqlSession sqlSession;	
	
	//위시리스트
	public List<WishlistVO> selectWishList(int no){
		System.out.println("WishRepository.selectList()");
		
		List<WishlistVO> wList = sqlSession.selectList("wishlist.selectList",no);
		System.out.println(wList);
		
		return wList;
	}
	
	//기념일리스트
	public List<CalenderVO> selectEventList(int no){
		System.out.println("WishRepository.selectList()");
		
		List<CalenderVO> eList = sqlSession.selectList("wishlist.selectEventList",no);
		System.out.println(eList);
		
		return eList;
	}
	
	//펀딩등록
	public int insertFunding(WishlistVO wishlistVO) {
		System.out.println("WishRepository.insertFunding()");
		
		
		return 0;
	}
	
}
