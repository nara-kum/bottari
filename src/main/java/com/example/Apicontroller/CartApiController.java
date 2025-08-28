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
	//field
	@Autowired
	private CartService cartservice;
	//editor
	
	//method g/s
	
	//method normal
	@ResponseBody
	@RequestMapping(value = "/update", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> updateCart(
			@RequestParam("cart_no") int cartNo,
			@RequestParam("type") String type,
			@RequestParam("value") String value,
			HttpSession session) {
		System.out.println("CartApiController.updateCart()");
		System.out.println("cart_no: " + cartNo + ", type: " + type + ", value: " + value);
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			// 유저 로그인 확인
			UserVO authuser = (UserVO) session.getAttribute("authUser");
			if(authuser == null) {
				result.put("success", false);
				result.put("message", "로그인이 필요합니다");
			}
			
			int user_no = authuser.getUserNo();
			
			// type 값 변환
			int updateResult = 0;
			
            switch(type) {
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
            
            if(updateResult > 0) {
            	// 업데이트된 총액 계산
            	List<CartListVO> updateCartList = cartservice.exeAllinOne(user_no);
            	
            	CartListVO firstItem = updateCartList.get(0);
            	
            	result.put("success", true);
            	result.put("cList", updateCartList);
            	result.put("newTotal", Integer.valueOf(firstItem.getTotal_price()));
            	result.put("total_quantity", Integer.valueOf(firstItem.getTotal_quantity()));
            	result.put("shipping_cost", Integer.valueOf(firstItem.getShipping_cost()));
            } else {
            	result.put("success", false);
                result.put("message", "업데이트할 데이터를 찾을 수 없습니다.");
            }
            
        } catch(Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
	}
	
	// 장바구니 삭제
	@ResponseBody
	@RequestMapping(value = "/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> deleteCart(
			@RequestParam("cart_no") int cart_no,
			HttpSession session) {
		 System.out.println("CartApiController.deleteCart()");
		 
		 Map<String, Object> result = new HashMap<>();
		 
		 try {
			// 유저 로그인 확인
			UserVO authuser = (UserVO) session.getAttribute("authUser");
			if(authuser == null) {
				result.put("success", false);
				result.put("message", "로그인이 필요합니다");
			}
			
			int user_no = authuser.getUserNo();
			
			int deleteResult = cartservice.exedeleteCartItem(cart_no);
			
			if(deleteResult > 0) {
            	// 업데이트된 총액 계산
            	List<CartListVO> updateCartList = cartservice.exeAllinOne(user_no);
            	
            	CartListVO firstItem = updateCartList.get(0);
            	
            	result.put("success", true);
            	result.put("cList", updateCartList);
            	result.put("newTotal", firstItem.getTotal_price());
            	result.put("total_quantity", firstItem.getTotal_quantity());
            	result.put("shipping_cost", firstItem.getShipping_cost());
            } else {
            	result.put("success", false);
                result.put("message", "삭제할 아이템을 찾을 수 없습니다.");
            }
			
		 } catch(Exception e) {
			 result.put("success", false);
			 result.put("message", e.getMessage());
		 }
		 
		 return result;
		
	}
}
