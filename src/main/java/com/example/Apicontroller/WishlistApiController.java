package com.example.Apicontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.ShopService;
import com.example.service.WishlistService;
import com.example.vo.CalenderVO;
import com.example.vo.CartDetailOptionVO;
import com.example.vo.CartVO;
import com.example.vo.UserVO;
import com.example.vo.WishlistVO;
import com.javaex.util.JsonResult;

import jakarta.servlet.http.HttpSession;

@RestController
public class WishlistApiController {

	@Autowired
	private WishlistService wishlistService;
	@Autowired
	private ShopService shopService;

	// 리스트 보는 화면
	@GetMapping("/api/wishlist")
	public JsonResult Wishlist(HttpSession session) {
		System.out.println("WishlistApiController.Wishlist()");

		// 세션값 가져오기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null) {
			return JsonResult.fail("로그인이 필요합니다.");
		}
		int no = authUser.getUserNo();

		List<WishlistVO> wList = wishlistService.exeWishList(no);
		System.out.println(wList);

		if (wList != null) {
			return JsonResult.success(wList);
		} else {
			return JsonResult.fail("알 수 없는 오류");
		}

	}

	// 기념일 리스트
	@GetMapping("/api/eventlist")
	public JsonResult eventList(HttpSession session) {
		System.out.println("WishlistApiController.eventList()");

		// 세션값 가져오기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null) {
			return JsonResult.fail("로그인이 필요합니다.");
		}
		int no = authUser.getUserNo();

		List<CalenderVO> eList = wishlistService.exeEventList(no);
		System.out.println(eList);

		System.out.println(eList);

		if (eList != null) {
			return JsonResult.success(eList);
		} else {
			return JsonResult.fail("알 수 없는 오류");
		}

	}

	// 펀딩 등록하기
	@PostMapping("/api/openfunding")
	public JsonResult openFunding(@RequestBody List<WishlistVO> wishlistVO, HttpSession session) {
		System.out.println("WishlistApiController.openFunding()");

		// 1) 로그인 체크
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null) {
			return JsonResult.fail("로그인이 필요합니다.");
		}
		int userNo = authUser.getUserNo();

		// 2) 요청 검증
		if (wishlistVO == null || wishlistVO.isEmpty()) {
			return JsonResult.fail("요청 본문이 비었습니다.");
		}

		// 3) 세션 userNo를 모든 항목에 주입
		for (WishlistVO vo : wishlistVO) {
			if (vo != null) {
				vo.setUserNo(userNo);
			}
		}

		wishlistService.exeFunding(wishlistVO);

		// 5) 응답
		return JsonResult.success(wishlistVO);
	}
	
	//장바구니 등록
	@PostMapping("/api/cart/addFromWishlist")
	public JsonResult addCartFromWishlist(@RequestBody List<WishlistVO> items, HttpSession session) {
	    System.out.println("WishlistApiController.addCartFromWishlist()");

	    // 로그인 체크
	    UserVO auth = (UserVO) session.getAttribute("authUser");
	    if (auth == null) return JsonResult.fail("로그인이 필요합니다.");
	    final int userNo = auth.getUserNo();

	    // 요청 검증 (분리해서 명확하게)
	    if (items == null) return JsonResult.fail("요청 본문이 비었습니다.");
	    if (items.isEmpty()) return JsonResult.fail("요청 본문이 비었습니다.");
	    if (items.size() > 200) return JsonResult.fail("한 번에 너무 많은 항목입니다(최대 200).");

	    int addCount = 0;
	    List<Integer> createdCartNos = new java.util.ArrayList<>();
	    List<Integer> toDeleteWishlistNos = new java.util.ArrayList<>();

	    for (int i = 0; i < items.size(); i++) {
	        WishlistVO w = items.get(i);
	        if (w == null) return JsonResult.fail((i+1) + "번째 항목이 비어 있습니다.");

	        // 지역변수로 빼서 null 먼저 체크
	        Integer productNo  = w.getProductNo();
	        Integer wishlistNo = w.getWishlistNo();
	        Integer quantity   = w.getQuantity();
	        Integer categoryNo = w.getCategoryNo();
	        Integer detailOpt  = w.getDetailoptionNo();

	        if (productNo == null || productNo <= 0)
	            return JsonResult.fail((i+1) + "번째 항목: productNo 누락");
	        if (wishlistNo == null || wishlistNo <= 0)
	            return JsonResult.fail((i+1) + "번째 항목: wishlistNo 누락");

	        if (quantity == null || quantity <= 0) quantity = 1;
	        if (categoryNo == null) categoryNo = 0;

	        // 장바구니 기본 insert
	        CartVO cart = new CartVO();
	        cart.setUser_no(userNo);
	        cart.setProduct_no(productNo);
	        cart.setCategory_no(categoryNo);
	        cart.setQuantity(quantity);
	        shopService.exeCartAdd(cart); // useGeneratedKeys로 cart_no 세팅됨

	        int cartNo = cart.getCart_no();
	        createdCartNos.add(cartNo);

	        // 옵션 있으면 cart_option insert
	        if (detailOpt != null && detailOpt > 0) {
	            CartDetailOptionVO opt = new CartDetailOptionVO();
	            opt.setCart_no(cartNo);
	            opt.setDetailoption_no(detailOpt);
	            shopService.exeCartDetailOptionAdd(opt);
	        }

	        toDeleteWishlistNos.add(wishlistNo);
	        addCount++;
	    }

	    // 위시리스트 일괄 삭제
	    int delCount = 0;
	    if (!toDeleteWishlistNos.isEmpty()) {
	        delCount = wishlistService.deleteWishlistByIds(userNo, toDeleteWishlistNos);
	    }

	    java.util.Map<String, Object> data = new java.util.HashMap<>();
	    data.put("addedCount", addCount);
	    data.put("deletedCount", delCount);
	    data.put("cartNos", createdCartNos);
	    return JsonResult.success(data);
	}


	//위시리스트 제거 
	@PostMapping("/api/wishlist/remove")
	public JsonResult removeWishlist(@RequestBody List<WishlistVO> items, HttpSession session) {
	    System.out.println("WishlistApiController.removeWishlist()");

	    UserVO auth = (UserVO) session.getAttribute("authUser");
	    if (auth == null) return JsonResult.fail("로그인이 필요합니다.");
	    final int userNo = auth.getUserNo();

	    if (items == null || items.isEmpty()) return JsonResult.fail("요청 본문이 비었습니다.");

	    java.util.List<Integer> ids = new java.util.ArrayList<>();
	    for (int i = 0; i < items.size(); i++) {
	        WishlistVO w = items.get(i);
	        if (w == null || w.getWishlistNo() <= 0) {
	            return JsonResult.fail((i+1) + "번째 항목: wishlistNo 누락");
	        }
	        ids.add(w.getWishlistNo());
	    }

	    int delCount = wishlistService.deleteWishlistByIds(userNo, ids);
	    return (delCount > 0) ? JsonResult.success(delCount) : JsonResult.fail("삭제된 항목이 없습니다.");
	}
}
