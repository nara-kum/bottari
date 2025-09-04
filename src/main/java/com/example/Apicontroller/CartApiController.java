package com.example.Apicontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.CartService;
import com.example.vo.CartListVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartApiController {
	// field
	@Autowired
	private CartService cartservice;
	// editor

	// method g/s

	// method normal
	@ResponseBody
	@RequestMapping(value = "/update", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> updateCart(@RequestParam("cart_no") int cartNo, @RequestParam("type") String type,
			@RequestParam("value") String value, HttpSession session) {
		System.out.println("CartApiController.updateCart()");
		System.out.println("cart_no: " + cartNo + ", type: " + type + ", value: " + value);

		Map<String, Object> result = new HashMap<>();

		try {
			// 유저 로그인 확인
			UserVO authuser = (UserVO) session.getAttribute("authUser");
			if (authuser == null) {
				result.put("success", false);
				result.put("message", "로그인이 필요합니다");
				
				return result;
			}

			int user_no = authuser.getUserNo();

			// type 값 변환
			int updateResult = 0;

			switch (type) {
			case "quantity":
				updateResult = cartservice.exeupdateQuantity(cartNo, Integer.parseInt(value));
				break;
			case "option":
				updateResult = cartservice.exeupdateOption(cartNo, Integer.parseInt(value));
				break;
			case "anniversary":
				updateResult = cartservice.exeupdateAnniversary(cartNo, Integer.parseInt(value));
				break;
			}

			if (updateResult > 0) {
				System.out.println("어헣 업데이트 결과가 1보타 크다");
				// 업데이트된 총액 계산
				List<CartListVO> updateCartList = cartservice.exeAllinOne(user_no);
				if (!updateCartList.isEmpty()) {
					CartListVO firstItem = updateCartList.get(0);

					result.put("success", true);
					result.put("cList", updateCartList);
					result.put("total_price", Integer.valueOf(firstItem.getTotal_price()));
					result.put("total_quantity", Integer.valueOf(firstItem.getTotal_quantity()));
					result.put("shipping_cost", Integer.valueOf(firstItem.getShipping_cost()));
				} else {
					result.put("success", false);
					result.put("message", "업데이트할 데이터를 찾을 수 없습니다.");
				}
			} else {
				// 예상치 못한 상황 (거의 발생하지 않음)
				result.put("success", false);
				result.put("message", "데이터 처리 중 오류가 발생했습니다.");
			}

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getMessage());
		}

		return result;
	}

	// 장바구니 삭제
	@ResponseBody
	@RequestMapping(value = "/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> deleteCart(@RequestParam("cart_no") int cart_no, HttpSession session) {
		System.out.println("CartApiController.deleteCart()");

		Map<String, Object> result = new HashMap<>();

		try {
			// 유저 로그인 확인
			UserVO authuser = (UserVO) session.getAttribute("authUser");
			if (authuser == null) {
				result.put("success", false);
				result.put("message", "로그인이 필요합니다");
				return result;
			}

			int user_no = authuser.getUserNo();

			int deleteResult = cartservice.exedeleteCartItem(cart_no);

			if (deleteResult > 0) {
				// 업데이트된 총액 계산
				List<CartListVO> updateCartList = cartservice.exeAllinOne(user_no);

				if (updateCartList.isEmpty()) {
					result.put("success", true);
					result.put("isEmpty", true);
					result.put("redirectUrl", "/shop/no_cart");
				} else {

					CartListVO firstItem = updateCartList.get(0);

					result.put("success", true);
					result.put("cList", updateCartList);
					result.put("total_price", firstItem.getTotal_price());
					result.put("total_quantity", firstItem.getTotal_quantity());
					result.put("shipping_cost", firstItem.getShipping_cost());
				}
			} else {
				result.put("success", false);
				result.put("message", "삭제할 아이템을 찾을 수 없습니다.");
			}

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getMessage());
		}

		return result;

	}

	@ResponseBody
	@RequestMapping(value = "/delete-bulk", method = { RequestMethod.POST })
	public Map<String, Object> deleteCartBulk(@RequestParam("cart_no") List<Integer> cartNos, HttpSession session) {

		System.out.println("CartApiController.deleteCartBulk()");
		Map<String, Object> result = new HashMap<>();

		try {
			// 로그인 확인
			UserVO authuser = (UserVO) session.getAttribute("authUser");
			if (authuser == null) {
				result.put("success", false);
				result.put("message", "로그인이 필요합니다");
				return result;
			}

			if (cartNos == null || cartNos.isEmpty()) {
				result.put("success", false);
				result.put("message", "삭제할 항목이 없습니다.");
				return result;
			}

			int user_no = authuser.getUserNo();

			int deleted = cartservice.exedeleteCartItems(cartNos); // ✅ 다건 삭제 서비스
			if (deleted <= 0) {
				result.put("success", false);
				result.put("message", "삭제할 아이템을 찾을 수 없습니다.");
				return result;
			}

			// 삭제 후 합계 갱신
			List<CartListVO> updateCartList = cartservice.exeAllinOne(user_no);
			if (updateCartList == null || updateCartList.isEmpty()) {
				result.put("success", true);
				result.put("isEmpty", true);
				result.put("redirectUrl", "/shop/no_cart");
			} else {
				CartListVO firstItem = updateCartList.get(0);
				result.put("success", true);
				result.put("cList", updateCartList);
				result.put("total_price", firstItem.getTotal_price());
				result.put("total_quantity", firstItem.getTotal_quantity());
				result.put("shipping_cost", firstItem.getShipping_cost());
			}
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getMessage());
		}
		return result;
	}

}
