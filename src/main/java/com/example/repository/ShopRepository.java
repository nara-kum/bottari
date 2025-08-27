package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CartDetailOptionVO;
import com.example.vo.CartVO;
import com.example.vo.DetailedImageVO;
import com.example.vo.ProductOptionDetailVO;
import com.example.vo.ProductOptionVO;
import com.example.vo.ProductVO;
import com.example.vo.ProductViewVO;

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
	public ProductViewVO ProductSelectOne(int productNo) {
		System.out.println("ShopRepository.ProductSelectOne");
		System.out.println("조회할 상품번호: " + productNo);

	
		ProductViewVO productViewVO = sqlSession.selectOne("product.selectOne", productNo);
		return productViewVO;
	}
	
	
	// 상품상세 이미지
	public List<DetailedImageVO> ImageselectList(int productNo) {
		System.out.println("ShopRepository.selectimageList");

		List<DetailedImageVO> detailedImageList = sqlSession.selectList("product.selectImageList", productNo);

		return detailedImageList;

	}
	
	// 옵션제목
	public List<ProductOptionVO> OptionselectList(int productNo) {
		System.out.println("ShopRepository.selectimageList");

		List<ProductOptionVO> productOptionList = sqlSession.selectList("product.selectOptionList", productNo);

		return productOptionList;

	}
	
	// 옵션디테일(아이템)
	public List<ProductOptionDetailVO> optionDetailSelectList(int optionNo) {
		System.out.println("ShopRepository.OptionDetailSelectList");

		List<ProductOptionDetailVO> productOptionDetailList = sqlSession.selectList("product.selectOptionDetailList", optionNo);

		return productOptionDetailList;

	}
		
	//장바구니등록
	public int cartInsert(CartVO cartVO) {
	    System.out.println("ShopRepository.cartInsert");
	    System.out.println("DB 저장 전 데이터: " + cartVO);
	    
	    int count = sqlSession.insert("product.cartInsert", cartVO);
	    
	    System.out.println("DB 저장 완료! 영향받은 행 수: " + count);
	    System.out.println("실제 저장된 cart_no: " + cartVO.getCart_no()); // auto_increment 값
	    
	    return count;
	}
	
	
	//장바구니 옵션 저장 메소드 (CartDetailOption 사용)
	public int cartDetailOptionInsert(CartDetailOptionVO cartDetailOptionVO) {
	    System.out.println("ShopRepository.cartDetailOptionInsert");
	    System.out.println("저장할 옵션 데이터: " + cartDetailOptionVO);
	    
	    int count = sqlSession.insert("product.cartDetailOptionInsert", cartDetailOptionVO);
	    
	    System.out.println("옵션 저장 완료! 영향받은 행 수: " + count);
	    return count;
	}
	
	
}