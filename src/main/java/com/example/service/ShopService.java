package com.example.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.repository.ShopRepository;
import com.example.vo.CartDetailOptionVO;
import com.example.vo.CartVO;
import com.example.vo.DetailedImageVO;
import com.example.vo.FundingOptionViewVO;
import com.example.vo.ProductOptionDetailVO;
import com.example.vo.ProductOptionVO;
import com.example.vo.ProductVO;
import com.example.vo.ProductViewVO;
import com.example.vo.WishlistOptionVO;
import com.example.vo.WishlistVO;

@Service
public class ShopService {

	@Autowired
	private ShopRepository shopRepository;
	private DetailedImageVO detailedImageVO;

	// 쇼핑몰 리스트
	public List<ProductVO> exeProductList(ProductVO productVO) {

		System.out.println("ShopService.exeProductList");// ㅇㅋ
		List<ProductVO> productList = shopRepository.selectList(productVO);

		System.out.println("나눈 서비수");

		
		return productList;

	}

	// 상품등록
	public int exeProductadd(ProductVO productVO) {
		System.out.println("ShopService.exeProductadd"); // ㅇㅋ
		System.out.println(productVO);
		System.out.println(productVO.getOptionItems().toString());
		System.out.println("-------------------------------------------------------");

		// 파일저장경로
		String saveDir = "C:\\javaStudy\\upload\\";

		///////////////////////////////////////////////////////////////
		//상품상세 정보 등록
		///////////////////////////////////////////////////////////////
		// 1)대표이미지 처리
		// 원본 파일명
		String orgName = productVO.getProductImage().getOriginalFilename();
		System.out.println(orgName);

		// 확장자
		String exName = orgName.substring(orgName.lastIndexOf(".") + 1);
		System.out.println(exName);

		// 저장파일명(겹치지 않는 파일명 - 덮어쓰기방지용)
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + "." + exName;
		System.out.println(saveName);

		// 파일경로
		String filePath = saveDir + saveName;
		System.out.println(filePath);

		// productVO에 대표이미지경로 추가
		productVO.setItemimg(saveName);

		// product 테이블에 정보저장
		int count = shopRepository.productInsert(productVO);
		System.out.println(productVO);

		// 대표이미지 복사
		try {
			byte[] fileData = productVO.getProductImage().getBytes();

			OutputStream os = new FileOutputStream(filePath);
			BufferedOutputStream bos = new BufferedOutputStream(os);

			bos.write(fileData);
			bos.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		///////////////////////////////////////////////////////////////
		//상품상세이미지 정보 등록
		///////////////////////////////////////////////////////////////
		
		MultipartFile[] detailImages = productVO.getDetailImages();
		
		for(int i=0; i<detailImages.length; i++) {
			
			MultipartFile file = detailImages[i];
			
			// 상세 이미지 처리
			// 원본 파일명
			String detailOrgName = file.getOriginalFilename();
			System.out.println(detailOrgName);

			// 확장자
			String detailExName = detailOrgName.substring(detailOrgName.lastIndexOf(".") + 1);
			System.out.println(detailExName);

			// 저장파일명(겹치지 않는 파일명 - 덮어쓰기방지용)
			String detailSaveName = System.currentTimeMillis() + UUID.randomUUID().toString() + "." + detailExName;
			System.out.println(detailSaveName);

			// 파일경로
			String detailFilePath = saveDir + detailSaveName;
			System.out.println(detailFilePath);

			//저장할VO
			DetailedImageVO detailedImageVO = new DetailedImageVO(productVO.getProduct_no(), detailSaveName, i);
			
			
			//레파지토리 vo넘겨서 저장
			shopRepository.detailImageInsert(detailedImageVO);
			
			// 상세이미지 복사
			try {
				byte[] fileData = file.getBytes();

				OutputStream os = new FileOutputStream(detailFilePath);
				BufferedOutputStream bos = new BufferedOutputStream(os);

				bos.write(fileData);
				bos.close();

			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		
		///////////////////////////////////////////////////////////////
		//옵션저장
		///////////////////////////////////////////////////////////////
		List<String> optionNameList = productVO.getOption_names();
		
		for(int i=0; i<optionNameList.size(); i++) {
			
			ProductOptionVO productOptionVO = new ProductOptionVO();
			productOptionVO.setProduct_no(productVO.getProduct_no());
			productOptionVO.setOption_name(optionNameList.get(i));
			
			//상품옵션구분 저장
		    shopRepository.productOptionInsert(productOptionVO);
			
			
			//디테일리스트 반복
			for(int j=0; j<productVO.getOptionItems()[i].size(); j++) {
				
				ProductOptionVO optionDetailVO = new ProductOptionVO();
				optionDetailVO.setOption_no(productOptionVO.getOption_no());
				
				optionDetailVO.setDetailOPtion_name(productVO.getOptionItems()[i].get(j).toString());
				
			    //디테일 옵션구분 저장
			    shopRepository.detailOptionInsert(optionDetailVO);
				
			}
			
			
			
		}
		
		// 기본정보 입력
		// productVO.setItemimg("대표이미지 경로");
		// int count = shopRepository.ProductInsert(productVO);

		// 상세이미지 처리

		// 상품옵션구분(반복문)
		// 상품디테일옵션(반복문)

		return 1;

	}

	// 상품 상세페이지
	public ProductViewVO exeProductDetail(int productNo) {
		System.out.println("ShopService.exeProductDetail");
		
		
		//상품기본정보
		ProductViewVO productViewVO = shopRepository.ProductSelectOne(productNo);
		
		//상품상세이미지 리스트
		List<DetailedImageVO> detailedImageList = shopRepository.ImageselectList(productViewVO.getProduct_no());
		
		//상품옵션리스트 -- 옵션들
		List<ProductOptionVO> productOptionList = shopRepository.OptionselectList(productViewVO.getProduct_no());

		productViewVO.setDetailedImageList(detailedImageList);
		productViewVO.setProductOptionList(productOptionList);

		return productViewVO;
	}
	
	
	

	
	// 펀딩상세페이지
	public Map<String, Object> exefungdingProductDetail(int productNo, int fundingNo) {
		System.out.println("ShopService.exefungdingProductDetail");

		// 상품기본정보
		ProductViewVO productViewVO = shopRepository.ProductSelectOne(productNo);

		// 상품상세이미지 리스트
		List<DetailedImageVO> detailedImageList = shopRepository.ImageselectList(productViewVO.getProduct_no());

		
		// 상품기본정보+이미지리스트
		productViewVO.setDetailedImageList(detailedImageList);
		
		
		//펀딩번호를 알고있다 fundingNo
		//펀딩프로덕트VO 가져오기
		
		
		//펀딩번호(상품) 오션명들(옵션)
		// 사이즈-데   용량-2G   칼라-빨강

		List<FundingOptionViewVO> fundingOptionList = shopRepository.fundingOptionSelectList(fundingNo);
		System.out.println("******여기확인:" + fundingOptionList);
		
		//지금까지 결재액
		int fundingTotalPay = shopRepository.fundingTotalPay(fundingNo);
		System.out.println("fundingTotalPay-->" + fundingTotalPay );
		
		
	
		//모두묶어서 화면으로 보낸다
		Map<String, Object> fundingProductDetailMap = new HashMap<String, Object>();
		
		fundingProductDetailMap.put("productViewVO", productViewVO);
		fundingProductDetailMap.put("fundingOptionList", fundingOptionList);
		fundingProductDetailMap.put("fundingTotalPay", fundingTotalPay);
		
		
		return fundingProductDetailMap;
	}
		
	
	

	
	
	// 옵션디테일(아이템)
	public List<ProductOptionDetailVO> exeOptionDetail(int optionNo) {
		System.out.println("ShopRepository.exeOptionDetail");

		List<ProductOptionDetailVO> productOptionDetailList = shopRepository.optionDetailSelectList(optionNo);

		return productOptionDetailList;

	}

	
	//장바구니 등록(데이터넘기기)
	public void exeCartAdd(CartVO cartVO) {
	    System.out.println("ShopService.exeCartAdd");
	    System.out.println("Service에서 받은 CartVO: " + cartVO);
	    
	    shopRepository.cartInsert(cartVO);
	}
	
	
	//장바구니 옵션 등록 (CartDetailOption 사용)
	public void exeCartDetailOptionAdd(CartDetailOptionVO cartDetailOptionVO) {
	    System.out.println("ShopService.exeCartDetailOptionAdd");
	    System.out.println("Service에서 받은 CartDetailOption: " + cartDetailOptionVO);
	    
	    shopRepository.cartDetailOptionInsert(cartDetailOptionVO);
	    System.out.println("장바구니 옵션 저장 완료");
	}
	
	
	
	//위시리스트 등록
	public void exeWishlistAdd(WishlistVO wishlistVO) {
	    System.out.println("ShopService.exeWishlistAdd");
	    System.out.println("Service에서 받은 WishlistVO: " + wishlistVO);
	    
	    shopRepository.wishlistInsert(wishlistVO);
	}
	
	
	//위시리스트 옵션 등록
	public void exeWishlistOptionAdd(WishlistOptionVO wishlistOptionVO) {
	    System.out.println("ShopService.exeWishlistOptionAdd");
	    System.out.println("Service에서 받은 WishlistOption: " + wishlistOptionVO);
	    
	    shopRepository.wishlistOptionInsert(wishlistOptionVO);
	    System.out.println("위시리스트 옵션 저장 완료");
	}
}