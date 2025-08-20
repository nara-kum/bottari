package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.WishlistVO;

@Repository
public class WishlistRepository {

	@Autowired
	private SqlSession sqlSession;	
	
	//위시리스트
	public List<WishlistVO> selectList(){
		System.out.println("WishRepository.selectList()");
		
		List<WishlistVO> wishVO = sqlSession.selectList("wishlist.selectList");
		System.out.println(wishVO);
		
		return wishVO;
	}
	
}
