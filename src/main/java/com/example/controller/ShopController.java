package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.ShopService;
import com.example.vo.ProductVO;
import com.example.vo.ProductTotalVO;

import org.springframework.ui.Model;


@Controller
public class ShopController {
 

	@Autowired
	private ShopService shopService;
	
	
	
	//상품등록폼
	@RequestMapping(value="/shopform", method= {RequestMethod.GET, RequestMethod.POST})
	public String shopform() {	
		System.out.println("ShopController.shopform");  //ㅇㅋ
		
		return "shop/shopform";	
	}
	


	//상품등록
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String insert(@ModelAttribute ProductVO productVO) {

		System.out.println("ShopController.insert"); //ㅇㅋ
		
		System.out.println("받은 데이터: " + productVO);

		int result = shopService.exeProductadd(productVO);

		if (result > 0) {
			System.out.println("상품 등록 성공!");
			return "shop/shopSuccess"; // 성공 시 등록완료 페이지
		} else {
			System.out.println("상품 등록 실패!");
			return "shop/shopform"; // 실패 시 다시 폼 페이지
		}
	}

	
	
	
	//상세페이지
    @RequestMapping(value="/productPage", method= {RequestMethod.GET, RequestMethod.POST})
    public String productDetail(@RequestParam(required = false) Integer productNo, Model model) {    
        System.out.println("ShopController.productDetail");
        System.out.println("상품번호: " + productNo);
        
        List<ProductVO> productList = shopService.exeProductDetail(productNo);
        	
        if (productList != null && !productList.isEmpty()) {
            // 첫 번째 상품 정보 (기본 정보)
        	ProductVO productVO = productList.get(0);
            model.addAttribute("product", productVO);
            
            // 전체 리스트 (옵션, 이미지 포함)
            model.addAttribute("productList", productList);
        }
        
        return "shop/productPage";
    }
	
	
	//상세페이지_펀딩
	@RequestMapping(value="/productPage2", method= {RequestMethod.GET, RequestMethod.POST})
	public String selectOne2() {	
		System.out.println("ShopController.selectOne");
		
		return "shop/productPage_funding";
	}
	
	
	//쇼핑몰리스트
	@RequestMapping(value="/bottarimall", method= {RequestMethod.GET, RequestMethod.POST})
	public String list() {	
		System.out.println("ShopController.list");
		
		return "shop/shoppingMall";	
	}
	
	
	
}
