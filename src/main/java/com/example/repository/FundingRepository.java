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
	public List<WishlistVO> selectMyFundingList(int no){
		System.out.println("FundingRepository.selectMyFundingList()");
		List<WishlistVO> sList = sqlSession.selectList("funding.selectMyFundingList", no);
		System.out.println("sList" +sList);
		
		return sList;
	}
	
}
