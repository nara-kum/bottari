package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.repository.ShopRepository;
import com.example.vo.ProductVO;


@Service
public class ShopService {


	
	@Autowired
	private ShopRepository shopRepository;

	
	//쇼핑몰 리스트
    public List<ProductVO> exeProductList(ProductVO productVO) {
    	
    	System.out.println("ShopService.exeProductList");//ㅇㅋ
    	List<ProductVO> productList = shopRepository.selectList(productVO);
    	System.out.println("나눈 서비수");
    	
    	return productList; 
    	
    	
    }
	
	
	//상품등록
	public int exeProductadd(ProductVO productVO) {
		System.out.println("ShopService.exeProductadd"); // ㅇㅋ

		
		//대표이미지 처리 
		// *대표이미지 경로
		// 대표이미지 복사
		
		
		//기본정보 입력
		productVO.setItemimg("대표이미지 경로");
        int count = shopRepository.ProductInsert(productVO);

        
        //상세이미지 처리
        
        
        
        //상품옵션구분(반복문)
        	//상품디테일옵션(반복문)
        
        
        return count;

	}
	
	
	   // 상품 상세페이지
    public List<ProductVO> exeProductDetail(int productNo) {
        System.out.println("ShopService.exeProductDetail");
        
        List<ProductVO> productList = shopRepository.ProductSelectOne(productNo);
        return productList;
    }


    



}
