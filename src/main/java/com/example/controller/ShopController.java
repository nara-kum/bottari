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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.service.ShopService;
import com.example.vo.CartVO;
import com.example.vo.ProductOptionDetailVO;
import com.example.vo.ProductVO;
import com.example.vo.ProductViewVO;

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
	
	
	
	
	
	//상품등록폼x 
	@RequestMapping(value="/shopform", method= {RequestMethod.GET, RequestMethod.POST})
	public String shopform() {	
		System.out.println("ShopController.shopform");
		
		return "shop/shopform";	
	}
	


	//상품등록
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String insert(@ModelAttribute ProductVO productVO, Model model) {

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
        
        // 상품 등록 완료 후 상품명을 모델에 추가
        model.addAttribute("productTitle", productVO.getTitle());
        model.addAttribute("productVO", productVO);
        
        
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
        

  
        */
        
        
        return "shop/shopSuccess";
   
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
	
    
    

	// 상세페이지
	@RequestMapping(value = "/productPage", method = { RequestMethod.GET, RequestMethod.POST })
	public String productDetail(@RequestParam(required = false) Integer productNo, Model model) {
		System.out.println("ShopController.productDetail");
		System.out.println("상품번호: " + productNo);

		if (productNo == null) {
			System.out.println("상품번호가 없습니다!");
			return "shop/shoppingMall";
		}

		ProductViewVO productViewVO= shopService.exeProductDetail(productNo);
		model.addAttribute("productViewVO", productViewVO);
		
		System.out.println("---------------------------------");
		System.out.println(productViewVO);
		System.out.println("---------------------------------");
		
		return "shop/productPage";
	}
    
    // 옵션상세(아이템) 리스트
	
	
	@ResponseBody
	@RequestMapping(value = "/api/optiondetail", method = { RequestMethod.GET, RequestMethod.POST })
	public List<ProductOptionDetailVO> optionDetail(@RequestParam(value="optionNo") int optionNo) {
		System.out.println("ShopController.optionDetail");
		System.out.println(optionNo);
		
		List<ProductOptionDetailVO> productOptionDetailList = shopService.exeOptionDetail(optionNo);
		System.out.println(productOptionDetailList);
		return productOptionDetailList;
	}
	
    
	
/*	
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
    
    */
	
	//상세페이지_펀딩
	@RequestMapping(value="/productPage2", method= {RequestMethod.GET, RequestMethod.POST})
	public String selectOne2() {	
		System.out.println("ShopController.selectOne");
		
		return "shop/productPage_funding";
	}
	
	
	//장바구니등록
	@RequestMapping(value="/cartadd", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String insertCart(@RequestParam(value="productNo", required=false) Integer productNo,
	                        @RequestParam(value="quantity", required=false) Integer quantity, // 기본값 제거
	                        HttpSession session) {
	    
	    System.out.println("받은 productNo: " + productNo);
	    System.out.println("받은 quantity: " + quantity);
	    
	    // quantity가 null이거나 0 이하면 1로 설정
	    if (quantity == null || quantity <= 0) {
	        quantity = 1;
	    }
	    
	    if (productNo != null && productNo > 0) {
	        CartVO cartVO = new CartVO();
	        cartVO.setUser_no(1);  
	        cartVO.setProduct_no(productNo);  
	        cartVO.setCategory_no(2);  
	        cartVO.setQuantity(quantity); // 실제 선택한 수량이 들어감
	        
	        System.out.println("설정한 CartVO: " + cartVO);
	        
	        shopService.exeCartAdd(cartVO);
	    }
	    
	    return "success";
	}

}