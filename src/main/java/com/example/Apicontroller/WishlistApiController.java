package com.example.Apicontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.WishlistService;
import com.example.vo.CalenderVO;
import com.example.vo.UserVO;
import com.example.vo.WishlistVO;
import com.javaex.util.JsonResult;

import jakarta.servlet.http.HttpSession;

@RestController
public class WishlistApiController {

	@Autowired
	private WishlistService wishlistService;

	// 리스트 보는 화면
	@GetMapping("/api/wishlist")
	public JsonResult Wishlist(HttpSession session) {
		System.out.println("WishlistApiController.Wishlist()");

		// 세션값 가져오기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
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
	
	//펀딩 등록하기
	@PostMapping("/api/openFunding")
	public JsonResult openFunding(@ModelAttribute WishlistVO wishlistVO) {
		System.out.println("WishlistApiController.openFunding()");
		System.out.println(wishlistVO);
		
		wishlistService.exeFunding(wishlistVO);
		
		return null;
	}
}
