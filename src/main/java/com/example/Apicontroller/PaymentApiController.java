package com.example.Apicontroller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.PaymentService;
import com.example.vo.PaymentVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("payment/checkout/api")
@ResponseBody
public class PaymentApiController {
	//field
	@Autowired
	private PaymentService paymentservice;
	//editor
	
	//method g/s
	
	//method normal
	
	// 펀딩결제 프로세스
	@RequestMapping(value = "/funding", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> proccessFundingPayment(@RequestBody PaymentVO request, HttpSession session) {
		System.out.println("PaymentController.proccessFundingPayment()");
		
		int funding_no = request.getFunding_no();
		
		Map<String, Object> response = new HashMap<>();
		
		try {
			// 로그인 체크
			UserVO authuser = (UserVO) session.getAttribute("authUser");
			if (authuser == null) {
				response.put("success", false);
				response.put("message", "로그인이 필요합니다.");
				return response;
			}
			
			// 입력값 검증
			if (request.getFunding_no() <= 0) {
				response.put("success", false);
				response.put("message", "유효하지 않은 펀딩 번호입니다.");
				return response;
			}
			
			if (request.getPayment_amount() <= 0) {
				response.put("success", false);
				response.put("message", "결제 금액이 올바르지 않습니다.");
				return response;
			}
			
			int user_no = authuser.getUserNo();
			request.setUser_no(user_no);
			
			String outcome = paymentservice.exegetPercent(funding_no);
			if("error".equals(outcome)) {
				response.put("success", false);
				response.put("message", "이미 완료된 펀딩입니다.");
				return response;
			}
			
			
			System.out.println("request: " + request);
			
	        // 결제 처리 로직
			PaymentVO result = paymentservice.exeprocessFundingPayment(request);
			
			paymentservice.exeChangeFundingStatus(funding_no);
	        
	        response.put("success", true);
	        response.put("message", "결제 완료");
	        response.put("payment_no", result.getPayment_no());
	        
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "결제 실패: " + e.getMessage());
	    }
	    
	    return response;
	}
	
	// 일반 결제 프로세스
	@RequestMapping(value = "/processing", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> processingNormalPayment(@RequestBody Map<String, Object> paymentData, HttpSession session){
		System.out.println("PaymentApicontroller.processiongNormalPayment()");
		
		
		UserVO authuser = (UserVO) session.getAttribute("authUser");
		
		Map<String, Object> response = new HashMap<>();
		
		if(authuser == null) {
			response.put("success", false);
			response.put("message", "로그인오류");
			
			return response;
		}
		
		int user_no = authuser.getUserNo();
		
		System.out.println("request: " + paymentData);
		
		try {
			PaymentVO result = paymentservice.exeprocessNormalPayment(paymentData, user_no);
			
			response.put("success", true);
			response.put("message", "결제완료");
			response.put("payment_no", result.getPayment_no());
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "결제실패" + e.getMessage());
		}
		
		return response;
		
	}
}
