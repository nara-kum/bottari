package com.example.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.ProductVO;

@Repository
public class ShopRepository {

	@Autowired
	private SqlSession sqlSession;
	
	//상품등록
	public int ProductInsert(ProductVO productVO) {
		System.out.println("ShopRepository.ProductInsert"); //ㅇㅋ
		
		int count = sqlSession.insert("product.insert", productVO);
		
		return count;
		
	}
	
	
	public void ProductSelect() {
		
		System.out.println("ShopRepository.ProductSelect");//ㅇㅋ
		
	}
}
