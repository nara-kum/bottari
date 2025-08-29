package com.example.Apicontroller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.PaymentService;
import com.example.vo.PaymentVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@RequestMapping("checkout/api")
@ResponseBody
public class PaymentApiController {
	//field
	@Autowired
	private PaymentService paymentservice;
	//editor
	
	//method g/s
	
	//method normal
	@RequestMapping(value = "/funding", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> proccessFundingPayment(@RequestBody PaymentVO request, HttpSession session) {
		System.out.println("PaymentController.proccessFundingPayment()");
		
		UserVO authuser = (UserVO) session.getAttribute("authUser");
		Map<String, Object> response = new HashMap<>();
		
		int user_no = authuser.getUserNo();
		request.setUser_no(user_no);
		
		System.out.println("request: " + request);
		
		try {
	        // 결제 처리 로직
			PaymentVO result = paymentservice.exeprocessFundingPayment(request);
	        
	        response.put("success", true);
	        response.put("message", "결제 완료");
	        response.put("payment_no", result.getPayment_no());
	        
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "결제 실패: " + e.getMessage());
	    }
	    
	    return response;
	}
}
