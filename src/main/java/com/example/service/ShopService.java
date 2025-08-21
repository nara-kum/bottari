package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.controller.UserController;
import com.example.repository.ShopRepository;
import com.example.vo.ProductVO;


@Service
public class ShopService {

    private final UserController userController;
	
	
	@Autowired
	private ShopRepository shopRepository;


    ShopService(UserController userController) {
        this.userController = userController;
    }
	
	
	
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

		int count = shopRepository.ProductInsert(productVO);
		return count;

	}
	
	
	   // 상품 상세페이지
    public List<ProductVO> exeProductDetail(int productNo) {
        System.out.println("ShopService.exeProductDetail");
        
        List<ProductVO> productList = shopRepository.ProductSelectOne(productNo);
        return productList;
    }


    



}
