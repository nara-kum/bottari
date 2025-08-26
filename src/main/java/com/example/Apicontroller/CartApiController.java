package com.example.Apicontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.CartService;
import com.example.vo.CartListVO;
import com.example.vo.CartOptionVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("api/cart")
public class CartApiController {
	//field
	@Autowired
	private CartService cartservice;
	//editor
	
	//method g/s
	
	//method normal
	@RequestMapping(value = "/selectOption", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Map<String, Object>> selectOption(
			HttpSession session,
			@RequestParam("product_no") int product_no) {
		System.out.println("CartApiController.selectOption()");
		
		Map<String, Object> result = new HashMap<>();
		
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		int user_no = authUser.getUserNo();
		
		try {
			List<CartOptionVO> optionList = cartservice.execartOptionList(product_no);
			List<CartListVO> cartDetailList = cartservice.execartDetailOptionList(product_no, user_no);
			
			result.put("success", true);
			result.put("optionList", optionList);
			result.put("cartDetailList", cartDetailList);
			
			System.out.println("optionList Count:" + optionList.size());
			System.out.println("cartDetailList Count:" + cartDetailList.size());
			
			return ResponseEntity.ok(result);
			
		} catch (Exception e) {
			System.err.println("상품 옵션 정보 불러오기 중 에러 발생:" + e.getMessage());
			e.printStackTrace();
			
			result.put("success", false);
			result.put("error", e.getMessage());
			
			return ResponseEntity.status(500).body(result);
		}
	}
}
