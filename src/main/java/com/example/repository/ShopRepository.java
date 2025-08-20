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
        System.out.println("등록할 상품 정보: " + productVO);
        
        try {
            // 상품 등록 실행
            int count = sqlSession.insert("product.insert", productVO);
            
            if (count > 0) {
                System.out.println("DB 등록 성공! 영향받은 행 수: " + count);
                System.out.println("생성된 product_no: " + productVO.getProduct_no());
                return count; // 성공시 1 반환
            } else {
                System.out.println("DB 등록 실패! 영향받은 행 수: " + count);
                return 0;
            }
            
        } catch (Exception e) {
            System.out.println("DB 등록 중 예외 발생: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
        
    // 상품 상세 조회
    public List<ProductVO> ProductSelectOne(int productNo) {
        System.out.println("ShopRepository.ProductSelectOne");
        System.out.println("조회할 상품번호: " + productNo);
        
        try {
            List<ProductVO> productList = sqlSession.selectList("product.selectOne", productNo);
            System.out.println("조회 결과: " + productList);
            return productList;
            
        } catch (Exception e) {
            System.out.println("상품 조회 중 예외 발생: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
