package com.example.Apicontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
}
