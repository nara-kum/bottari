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
import com.example.vo.CartDetailOptionVO;
import com.example.vo.CartVO;
import com.example.vo.ProductOptionDetailVO;
import com.example.vo.ProductVO;
import com.example.vo.ProductViewVO;
import com.example.vo.UserVO;
import com.example.vo.WishlistOptionVO;
import com.example.vo.WishlistVO;

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
	
	
	
	
	
	//펀딩상세페이지
	@RequestMapping(value = "/productPage2", method = { RequestMethod.GET, RequestMethod.POST })
	public String fundingproductDetail(@RequestParam(required = false) Integer productNo, Model model) {
		System.out.println("ShopController.productDetail");
		System.out.println("상품번호: " + productNo);

		if (productNo == null) {
			System.out.println("상품번호가 없습니다!");
			return "shop/shoppingMall";
		}

		ProductViewVO productViewVO= shopService.exefungdingProductDetail(productNo);
		model.addAttribute("productViewVO", productViewVO);
		
		System.out.println("---------------------------------");
		System.out.println(productViewVO);
		System.out.println("---------------------------------");
		
		return "shop/productPage_funding";
	}
	
	
	
	


	//장바구니등록 
	@RequestMapping(value="/cartadd", method= {RequestMethod.GET, RequestMethod.POST})
	public String insertCart(@RequestParam(value="productNo", required=false) Integer productNo,
			 				 @RequestParam(value="categoryNo", required=false) Integer categoryNo,
	                         @RequestParam(value="quantity", required=false) Integer quantity,
	                         @RequestParam(value="selectedOptions", required=false) String selectedOptionsJson, // 옵션 정보 추가
	                         HttpSession session) {
	    
	    System.out.println("===== 장바구니 등록 시작 =====");
	    System.out.println("받은 productNo: " + productNo);
	    System.out.println("받은 quantity: " + quantity);
	    System.out.println("받은 selectedOptions: " + selectedOptionsJson);
	    
	    // 로그인 사용자 정보 확인
	    UserVO authUser = (UserVO) session.getAttribute("authUser");
	    if (authUser == null) {
	        return "user/loginform";
	    }
	    
	    int userNo = authUser.getUserNo();
	    
	    // 기본값 설정
	    if (quantity == null || quantity <= 0) {
	        quantity = 1;
	    }
	    
	    if (productNo == null || productNo <= 0) {
	        return "잘못된 상품 정보입니다";
	    }
	    
	    try {
	        // 1단계: 장바구니 기본 정보 등록
	        CartVO cartVO = new CartVO();
	        cartVO.setUser_no(userNo);
	        cartVO.setProduct_no(productNo);
	        cartVO.setCategory_no(categoryNo);
	        cartVO.setQuantity(quantity);
	        
	        System.out.println("장바구니 기본 정보: " + cartVO);
	        
	        // 장바구니에 상품 등록하고 생성된 cart_no 받아오기
	        shopService.exeCartAdd(cartVO);
	        int cartNo = cartVO.getCart_no(); // 생성된 장바구니 번호
	        
	        System.out.println("생성된 cart_no: " + cartNo);
	        
	        // 2단계: 선택된 옵션들이 있으면 장바구니 옵션 테이블에도 등록
	        if (selectedOptionsJson != null && !selectedOptionsJson.trim().isEmpty() 
	            && !selectedOptionsJson.equals("[]")) {
	            
	            System.out.println("옵션 정보 처리 시작");
	            
	            // JSON 형태의 옵션 정보를 파싱 (간단하게 처리)
	            // 예: "[1,2,3]" -> ["1","2","3"]
	            String[] optionIds = selectedOptionsJson
	                .replace("[", "")
	                .replace("]", "")
	                .replace("\"", "")
	                .split(",");
	            
	            // 각 옵션별로 CartOptionVO 생성하여 저장
	            for (String optionIdStr : optionIds) {
	                optionIdStr = optionIdStr.trim();
	                if (!optionIdStr.isEmpty()) {
	                    try {
	                        int detailOptionNo = Integer.parseInt(optionIdStr);
	                        
	                        CartDetailOptionVO cartDetailOptionVO = new CartDetailOptionVO();
	                        cartDetailOptionVO.setCart_no(cartNo);  // 위에서 생성된 장바구니 번호
	                        cartDetailOptionVO.setDetailoption_no(detailOptionNo);  // 선택된 옵션 번호
	                        
	                        System.out.println("저장할 옵션 정보: " + cartDetailOptionVO);
	                        
	                        // 장바구니 옵션 저장
	                        shopService.exeCartDetailOptionAdd(cartDetailOptionVO);
	                        
	                    } catch (NumberFormatException e) {
	                        System.out.println("잘못된 옵션 번호: " + optionIdStr);
	                    }
	                }
	            }
	            System.out.println("모든 옵션 저장 완료");
	            
	        } else {
	            System.out.println("선택된 옵션이 없음 (단일 상품)");
	        }
	        
	        System.out.println("===== 장바구니 등록 완료 =====");
	        return "redirect:/cart";
	        
	    } catch (Exception e) {
	        System.out.println("장바구니 등록 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        return "오류가 발생했습니다";
	    }
	}

	
	
	//위시리스트 등록 - 수정된 버전
	@RequestMapping(value="/wishlistadd", method= {RequestMethod.GET, RequestMethod.POST})
	public String insertWishlist(@RequestParam(value="productNo", required=false) Integer productNo,
	                            @RequestParam(value="quantity", required=false) Integer quantity,
	                            @RequestParam(value="selectedOptions", required=false) String selectedOptionsJson, // 옵션 정보 추가
	                            HttpSession session) {
	    
	    System.out.println("===== 위시리스트 등록 시작 =====");
	    System.out.println("받은 productNo: " + productNo);
	    System.out.println("받은 quantity: " + quantity);
	    System.out.println("받은 selectedOptions: " + selectedOptionsJson);
	    
	    // 로그인 체크 - 디버깅 추가
	    System.out.println("세션 확인 중...");
	    UserVO authUser = (UserVO) session.getAttribute("authUser");
	    System.out.println("세션에서 가져온 authUser: " + authUser);
	    
	    if (authUser == null) {
	        System.out.println("로그인되지 않은 사용자 - 로그인 페이지로 이동");
	        return "user/loginform";
	    }
	    
	    System.out.println("로그인된 사용자 확인: userNo = " + authUser.getUserNo());
	    
	    int userNo = authUser.getUserNo();
	    
	    // 기본값 설정
	    if (quantity == null || quantity <= 0) {
	        quantity = 1;
	    }
	    
	    if (productNo == null || productNo <= 0) {
	        return "잘못된 상품 정보입니다";
	    }
	    
	    try {
	        // 1단계: 위시리스트 기본 정보 등록
	        WishlistVO wishlistVO = new WishlistVO();
	        wishlistVO.setUserNo(userNo);
	        wishlistVO.setProductNo(productNo);
	        wishlistVO.setQuantity(quantity);
	        
	        System.out.println("위시리스트 기본 정보: " + wishlistVO);
	        
	        // 위시리스트에 상품 등록하고 생성된 wishlist_no 받아오기
	        shopService.exeWishlistAdd(wishlistVO);
	        int wishlistNo = wishlistVO.getWishlistNo(); // 생성된 위시리스트 번호
	        
	        System.out.println("생성된 wishlist_no: " + wishlistNo);
	        
	        // 2단계: 선택된 옵션들이 있으면 위시리스트 옵션 테이블에도 등록
	        System.out.println("selectedOptionsJson 원본: '" + selectedOptionsJson + "'");
	        System.out.println("selectedOptionsJson이 null인가? " + (selectedOptionsJson == null));
	        System.out.println("selectedOptionsJson이 비어있나? " + (selectedOptionsJson != null && selectedOptionsJson.trim().isEmpty()));
	        System.out.println("selectedOptionsJson이 []인가? " + (selectedOptionsJson != null && selectedOptionsJson.equals("[]")));
	        
	        if (selectedOptionsJson != null && !selectedOptionsJson.trim().isEmpty() 
	            && !selectedOptionsJson.equals("[]")) {
	            
	            System.out.println("위시리스트 옵션 정보 처리 시작");
	            
	            // JSON 형태의 옵션 정보를 파싱
	            String[] optionIds = selectedOptionsJson
	                .replace("[", "")
	                .replace("]", "")
	                .replace("\"", "")
	                .split(",");
	            
	            // 각 옵션별로 WishlistOptionVO 생성하여 저장
	            for (String optionIdStr : optionIds) {
	                optionIdStr = optionIdStr.trim();
	                if (!optionIdStr.isEmpty()) {
	                    try {
	                        int detailOptionNo = Integer.parseInt(optionIdStr);
	                        
	                        WishlistOptionVO wishlistOptionVO = new WishlistOptionVO();
	                        wishlistOptionVO.setWishlistNo(wishlistNo);  // 위에서 생성된 위시리스트 번호
	                        wishlistOptionVO.setDetailoptionNo(detailOptionNo);  // 선택된 옵션 번호
	                        
	                        System.out.println("저장할 위시리스트 옵션 정보: " + wishlistOptionVO);
	                        
	                        // 위시리스트 옵션 저장
	                        shopService.exeWishlistOptionAdd(wishlistOptionVO);
	                        
	                    } catch (NumberFormatException e) {
	                        System.out.println("잘못된 옵션 번호: " + optionIdStr);
	                    }
	                }
	            }
	            System.out.println("모든 위시리스트 옵션 저장 완료");
	            
	        } else {
	            System.out.println("선택된 옵션이 없음 (단일 상품)");
	        }
	        
	        System.out.println("===== 위시리스트 등록 완료 =====");
	        return "redirect:/wishlist";
	        
	    } catch (Exception e) {
	        System.out.println("위시리스트 등록 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        return "오류가 발생했습니다";
	    }
	}
	
}