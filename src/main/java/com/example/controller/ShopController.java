package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
    public String insert(@ModelAttribute ProductVO productVO, Model model) {

        System.out.println("ShopController.insert");
        System.out.println("받은 데이터: " + productVO);
        
        // 필수 필드 검증
        if (productVO.getTitle() == null || productVO.getTitle().trim().isEmpty()) {
            System.out.println("상품명이 비어있습니다!");
            return "shop/shopform";
        }
        
        if (productVO.getPrice() <= 0) {
            System.out.println("가격이 올바르지 않습니다!");
            return "shop/shopform";
        }
        
        // 기본값 설정
        if (productVO.getBrand() == null) {
            productVO.setBrand("");
        }
        if (productVO.getItemimg() == null) {
            productVO.setItemimg("");
        }
        if (productVO.getAddress() == null) {
            productVO.setAddress("");
        }
        if (productVO.getDetail_address() == null) {
            productVO.setDetail_address("");
        }

        int result = shopService.exeProductadd(productVO);

        if (result > 0) {
            System.out.println("상품 등록 성공! 생성된 상품번호: " + productVO.getProduct_no());
            model.addAttribute("productVO", productVO);
            return "shop/shopSuccess";
        } else {
            System.out.println("상품 등록 실패!");
            return "shop/shopform";
        }
    }

	
    
    
    // 이미지 파일 저장 메소드
    private String saveImageFile(MultipartFile file, String folder) throws IOException {
        // 업로드 폴더 설정
        String uploadDir = System.getProperty("user.dir") + "/src/main/webapp/assets/uploads/" + folder + "/";
        
        // 폴더가 없으면 생성
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        
        // 파일명 생성 (중복 방지를 위해 UUID 사용)
        String originalFileName = file.getOriginalFilename();
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String savedFileName = UUID.randomUUID().toString() + extension;
        
        // 파일 저장
        File savedFile = new File(uploadDir + savedFileName);
        file.transferTo(savedFile);
        
        System.out.println("파일 저장 완료: " + savedFile.getAbsolutePath());
        
        return savedFileName;
    }
    
    
    
	
	
  //상세페이지
    @RequestMapping(value="/productPage", method= {RequestMethod.GET, RequestMethod.POST})
    public String productDetail(@RequestParam(required = false) Integer productNo, Model model) {    
        System.out.println("ShopController.productDetail");
        System.out.println("상품번호: " + productNo);
        
        if (productNo == null) {
            System.out.println("상품번호가 없습니다!");
            return "shop/shoppingMall";
        }
        
        List<ProductVO> productList = shopService.exeProductDetail(productNo);
            
        if (productList != null && !productList.isEmpty()) {
            // 첫 번째 상품 정보 (기본 정보)
            ProductVO productVO = productList.get(0);
            model.addAttribute("product", productVO);
            
            // 전체 리스트 (옵션, 이미지 포함)
            model.addAttribute("productList", productList);
        } else {
            System.out.println("상품 정보를 찾을 수 없습니다!");
            return "shop/shoppingMall";
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
