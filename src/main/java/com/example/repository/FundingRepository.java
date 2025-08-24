package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.WishlistVO;

@Repository
public class FundingRepository {

	@Autowired
	private SqlSession sqlSession;	
	
	//위시리스트
	public List<WishlistVO> selectFundingList(int userNo){
		System.out.println("WishRepository.selectWishList()");
		
		List<WishlistVO> pdlist = sqlSession.selectList("funding.selectMyFunding",userNo);
		
		return pdlist;
	}
	
}
