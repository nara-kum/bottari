package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.service.ShopService;
import com.example.vo.DetailedImageVO;
import com.example.vo.ProductVO;

import jakarta.servlet.http.HttpSession;




@Controller
public class ShopController {
 
	// 파일 업로드 경로 설정
	private static final String UPLOAD_PATH = "C:\\upload\\products\\"; // 실제 경로로 변경 필요
	private static final String WEB_PATH = "/upload/products/"; // 웹에서 접근할 경로

	@Autowired
	private ShopService shopService;
	
	
	
	//쇼핑몰리스트
	@RequestMapping(value="/bottarimall", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(ProductVO productVO,Model model) {	
		System.out.println("ShopController.list");
		
		

		List<ProductVO> productList = shopService.exeProductList(productVO);
		model.addAttribute("productList", productList);

		
		return "shop/shoppingMall";	
	}
	
	
	
	
	
	//상품등록폼
	@RequestMapping(value="/shopform", method= {RequestMethod.GET, RequestMethod.POST})
	public String shopform() {	
		System.out.println("ShopController.shopform");
		
		return "shop/shopform";	
	}
	


	//상품등록
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String insert(@ModelAttribute ProductVO productVO) {

        System.out.println("ShopController.register");
//        
//       System.out.println("받은 데이터: " + productVO);
//      System.out.println("받은 파일: " + productVO.getProductImage().getOriginalFilename());
//
//        for(int i=0; i<productVO.getDetailImages().length; i++) {
//        	 System.out.println("상품상세이미지: " + productVO.getDetailImages()[i].getOriginalFilename());
//        }
//                
//        for(int i=0; i<productVO.getOptionItems().length; i++) {
//        	 System.out.println(productVO.getOptionItems()[i]);
//        }
        
        
        shopService.exeProductadd(productVO);
        
        
        
        /*
        // 필수 필드 검증
        if (productVO.getTitle() == null || productVO.getTitle().trim().isEmpty()) {
            System.out.println("상품명이 비어있습니다!");
            model.addAttribute("errorMessage", "상품명을 입력해주세요.");
            return "shop/shopform";
        }
        
        if (productVO.getPrice() <= 0) {
            System.out.println("가격이 올바르지 않습니다!");
            model.addAttribute("errorMessage", "올바른 가격을 입력해주세요.");
            return "shop/shopform";
        }
        
        // 파일 업로드 처리
        if (!file.isEmpty()) {
            try {
                String savedImagePath = saveUploadedFile(file);
                productVO.setItemimg(savedImagePath);
                System.out.println("이미지 저장 완료: " + savedImagePath);
            } catch (IOException e) {
                System.out.println("파일 업로드 실패: " + e.getMessage());
                model.addAttribute("errorMessage", "이미지 업로드에 실패했습니다.");
                return "shop/shopform";
            }
        } else {
            System.out.println("업로드된 파일이 없습니다.");
            // 기본 이미지 설정 (선택사항)
            productVO.setItemimg("/assets/images/default-product.jpg");
        }
        

        
        if (result > 0) {
            System.out.println("상품 등록 성공! 생성된 상품번호: " + productVO.getProduct_no());
            model.addAttribute("productVO", productVO);
            return "shop/shopSuccess";
        } else {
            System.out.println("상품 등록 실패!");
            model.addAttribute("errorMessage", "상품 등록에 실패했습니다.");
            return "shop/shopform";
        }
        */
        
        return "";
    }
    
    
    

    /**
     * 업로드된 파일을 저장하고 웹 경로를 반환
     */
    private String saveUploadedFile(MultipartFile file) throws IOException {
        // 업로드 디렉토리 생성
        File uploadDir = new File(UPLOAD_PATH);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // 원본 파일명
        String originalFilename = file.getOriginalFilename();
        
        // 파일 확장자 추출
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        
        // UUID를 사용하여 고유한 파일명 생성
        String savedFilename = UUID.randomUUID().toString() + extension;
        
        // 파일 저장
        File savedFile = new File(uploadDir, savedFilename);
        file.transferTo(savedFile);
        
        // 웹에서 접근 가능한 경로 반환
        return WEB_PATH + savedFilename;
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
	

}
