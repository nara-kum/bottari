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
		System.out.println("ShopRepository.ProductInsert");
		
		// 상품 등록 후 생성된 product_no를 productVO에 설정
		int count = sqlSession.insert("product.insert", productVO);
		
		if (count > 0) {
			// 등록된 상품의 번호 반환
			return productVO.getProduct_no();
		}
		
		return 0;
	}
		
		
	    // 상품 상세 조회
	    public List<ProductVO> ProductSelectOne(int productNo) {
	        System.out.println("ShopRepository.ProductSelectOne");
	        
	        List<ProductVO> productList = sqlSession.selectList("product.selectOne", productNo);
	        return productList;
	    }
}
