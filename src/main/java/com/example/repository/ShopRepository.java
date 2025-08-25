package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.DetailedImageVO;
import com.example.vo.ProductOptionVO;
import com.example.vo.ProductVO;

@Repository
public class ShopRepository {

	@Autowired
	private SqlSession sqlSession;

	// 쇼핑몰리스트
	public List<ProductVO> selectList(ProductVO productVO) {
		System.out.println("ShopRepository.selectList");// ㅇㅋ

		List<ProductVO> productList = sqlSession.selectList("product.selectList");
		System.out.println("나는 되돌아오는 레파지토리");

		return productList;

	}

	// 상품등록
	public int productInsert(ProductVO productVO) {
		System.out.println("ShopRepository.ProductInsert");

		// 상품 등록 실행
		int count = sqlSession.insert("product.insert", productVO);

		return count;
	}

	// 상품상세이미지 등록
	public int detailImageInsert(DetailedImageVO detailedImageVO) {
		System.out.println("ShopRepository.detailImageInsert");

		int count = sqlSession.insert("product.detailImageInsert", detailedImageVO);
		return count;
	}

	// 옵션등록
	public int productOptionInsert(ProductOptionVO productOptionVO) {
		System.out.println("ShopRepository.productOptionInsert");

		System.out.println("*=======================================");
		System.out.println(productOptionVO);
		System.out.println("*=======================================");
		
		
		int count = sqlSession.insert("product.productOptionInsert", productOptionVO);
		return count;

	}

	// 디테일옵션등록
	public int detailOptionInsert(ProductOptionVO optionDetailVO) {
		System.out.println("ShopRepository.detailOptionInsert");
//
//		System.out.println("*=======================================");
//		System.out.println(optionDetailVO);
//		System.out.println("*=======================================");

		int count = sqlSession.insert("product.detailOptionInsert", optionDetailVO);
		return count;

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
