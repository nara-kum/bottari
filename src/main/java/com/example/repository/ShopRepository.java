package com.example.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CartDetailOptionVO;
import com.example.vo.CartVO;
import com.example.vo.DetailedImageVO;
import com.example.vo.FundingOptionViewVO;
import com.example.vo.FundingProductVO;
import com.example.vo.ProductOptionDetailVO;
import com.example.vo.ProductOptionVO;
import com.example.vo.ProductVO;
import com.example.vo.ProductViewVO;
import com.example.vo.WishlistOptionVO;
import com.example.vo.WishlistVO;

@Repository
public class ShopRepository {

	@Autowired
	private SqlSession sqlSession;

	// 쇼핑몰 상품리스트 - 페이징 + 검색 (강의와 동일한 방식)
	public List<ProductVO> selectProductList(Map<String, Object> limitMap) {
		System.out.println("ShopRepository.selectProductList - 페이징");
		System.out.println("파라미터: " + limitMap);

		// MyBatis를 통해 페이징 쿼리 실행 (강의와 동일한 쿼리 id 사용)
		List<ProductVO> productList = sqlSession.selectList("product.selectListWithPaging", limitMap);
		System.out.println("조회된 상품 수: " + productList.size());

		return productList;
	}

	// 전체 상품 개수 조회 - 검색 조건 + 가격 조건 포함
	public int selectTotalCountByKwd(String kwd, int categoryNo, int priceRange) {
		System.out.println("ShopRepository.selectTotalCountByKwd");
		System.out.println("검색키워드: " + kwd);
		System.out.println("카테고리: " + categoryNo);
		System.out.println("가격대: " + priceRange);

		// 파라미터를 Map으로 묶어서 전달
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("kwd", kwd);
		paramMap.put("categoryNo", categoryNo);
		paramMap.put("priceRange", priceRange);
		
		// MyBatis를 통해 전체 개수 조회
		int totalCount = sqlSession.selectOne("product.selectTotalCountByKwd", paramMap);
		System.out.println("전체 상품 수: " + totalCount);

		return totalCount;
	}

	// 기존 쇼핑몰리스트 (페이징 없음) - 호환성을 위해 유지
	public List<ProductVO> selectList(ProductVO productVO) {
		System.out.println("ShopRepository.selectList - 페이징 없음");

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
	
	//펀딩번호
	public FundingProductVO FundingProductSelectOne(int fundingNo) {
		System.out.println("ShopRepository.FundingProductSelectOne");
		
		FundingProductVO fundingProductVO = sqlSession.selectOne("product.selectOneFunding", fundingNo);
		
		return fundingProductVO;	
	}
	
	//펀딩상품의 옵션 조회
	public List<FundingOptionViewVO> fundingOptionSelectList(int fundingNo){
		System.out.println("ShopRepository.fundingOptionSelectList");
		System.out.println("조회할 펀딩번호: " + fundingNo);

		List<FundingOptionViewVO> fundingOptionList = sqlSession.selectList("product.selectListFundingOption", fundingNo);
		
		System.out.println("-------------------------------------");
		System.out.println(fundingOptionList);
		System.out.println("-------------------------------------");
		return fundingOptionList;
	}
	
	//펀딩별 현재 총결제액
	public int fundingTotalPay(int fundingNo){
		System.out.println("ShopRepository.fundingTotalPay");

		int fundingTotalPay = sqlSession.selectOne("product.selectTotalPayForFundingNo", fundingNo);
		System.out.println("@@@@@@@@" + fundingTotalPay);
		return fundingTotalPay;
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
	
	//위시리스트 등록
	public int wishlistInsert(WishlistVO wishlistVO) {
	    System.out.println("ShopRepository.wishlistInsert");
	    System.out.println("DB 저장 전 데이터: " + wishlistVO);
	    
	    int count = sqlSession.insert("product.wishlistInsert", wishlistVO);
	    
	    System.out.println("위시리스트 저장 완료! 영향받은 행 수: " + count);
	    return count;
	}
	
	//위시리스트 옵션 저장
	public int wishlistOptionInsert(WishlistOptionVO wishlistOptionVO) {
	    System.out.println("ShopRepository.wishlistOptionInsert");
	    return sqlSession.insert("product.wishlistOptionInsert", wishlistOptionVO);
	}
}