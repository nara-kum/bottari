package com.example.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.repository.ShopRepository;
import com.example.vo.DetailedImageVO;
import com.example.vo.ProductOptionDetailVO;
import com.example.vo.ProductOptionVO;
import com.example.vo.ProductVO;
import com.example.vo.ProductViewVO;

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
	
	
	// 옵션디테일(아이템)
	public List<ProductOptionDetailVO> exeOptionDetail(int optionNo) {
		System.out.println("ShopRepository.exeOptionDetail");

		List<ProductOptionDetailVO> productOptionDetailList = shopRepository.optionDetailSelectList(optionNo);

		return productOptionDetailList;

	}

}