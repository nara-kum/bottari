package com.example.repository;

import java.util.List;

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
		
		
	    // 상품 상세 조회
	    public List<ProductVO> ProductSelectOne(int productNo) {
	        System.out.println("ShopRepository.ProductSelectOne");
	        
	        List<ProductVO> productList = sqlSession.selectList("product.selectOne", productNo);
	        return productList;
	    }
}
