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
		System.out.println("WishRepository.selectWishList()");
		
		List<WishlistVO> wList = sqlSession.selectList("wishlist.selectList",no);
		
		return wList;
	}
	
	//기념일리스트
	public List<CalenderVO> selectEventList(int no){
		System.out.println("WishRepository.selectEventList()");
		
		List<CalenderVO> eList = sqlSession.selectList("wishlist.selectEventList",no);
		
		return eList;
	}
	
	//펀딩등록
	public int insertFunding(List<WishlistVO> wishlistVO) {
		System.out.println("WishRepository.insertFunding()");
		
		int count = sqlSession.insert("wishlist.insertFunding",wishlistVO);
		
		return count;
	}
	
	//위시삭제
	public int deleteWishlist(int eventNum) {
		System.out.println("WishRepository.deleteWishlist()");
		
		int count = sqlSession.delete("wishlist.deleteWish",eventNum);
		
		return count;
	}
	
}
