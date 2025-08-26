package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.PaymentService;
import com.example.vo.CheckOutVO;
import com.example.vo.CheckoutFundingVO;
import com.example.vo.PaymentVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {
	//field
	@Autowired
	private PaymentService paymentservice;
	//editor
	
	//method g/s
	
	//method normal
	
	//일반 구매일 때
	@RequestMapping(value = "/checkout", method = { RequestMethod.GET, RequestMethod.POST })
	public String checkoutList(@RequestParam(value="cart_no", required=false, defaultValue="1") int cart_no, Model model) {
		System.out.println("PayController.checkoutList()");
//		System.out.println("cart_no= " + cart_no);
		
		List<CheckOutVO> checkoutList = paymentservice.execheckoutList(cart_no);
		
		model.addAttribute("pList", checkoutList);
		
		if (!checkoutList.isEmpty()) {
	        CheckOutVO firstItem = checkoutList.get(0);
	        model.addAttribute("total_quantity", firstItem.getTotal_quantity());
	        model.addAttribute("total_amount", firstItem.getTotal_amount());
	        model.addAttribute("shipping_cost", firstItem.getShipping_cost());
	        model.addAttribute("final_amount", firstItem.getTotal_amount() + firstItem.getShipping_cost());
	    }
		
		
		return "/shop/checkout";
	}
	
	//펀딩일 때 
	@RequestMapping(value = "/checkout_funding", method = {RequestMethod.GET,RequestMethod.POST})
	public String checkoutFundingList(@RequestParam(value="funding_no", required=false, defaultValue="0") int funding_no,
									  @RequestParam(value="count", required=false, defaultValue="1") int count, 
									  Model model) {
		System.out.println("PaymentController.checkoutFundingList()");
		
		if(funding_no != 0 && count >= 1) {
			List<CheckoutFundingVO> checkoutFundingList = paymentservice.execheckoutFundingList(funding_no);
			
			model.addAttribute("fList", checkoutFundingList);
			model.addAttribute("amount", checkoutFundingList.get(0).getAmount());
			model.addAttribute("percent", checkoutFundingList.get(0).getPercent());
			
			return "/shop/checkout_funding";
		} else {
			
			return "/shop/error";
		}
		
	}
	
	// 결제버튼을 클릭했을 때
	@RequestMapping(value = "/checkout/payment", method = {RequestMethod.GET,RequestMethod.POST})
	public String checkoutPayment(
			@RequestParam("cart_no") int cart_no,
			@RequestParam String paymentMethod,
			@RequestParam String cashReceiptRequested,
			@RequestParam int totalAmount,
			@RequestParam int totalQuantity,
			@RequestParam int shippingCost,
			@RequestParam("productId") int[] product_no,
			@RequestParam("quantity") int[] quantity,
			@RequestParam("itemTotal") int[] item_total,
			HttpSession session)	{
		System.out.println("PaymentController.checkoutPayment()");
		System.out.println(cart_no);
		
		// 파라미터 확인용 로그(디버깅)
        System.out.println("결제 방식: " + paymentMethod);
        System.out.println("현금영수증 신청: " + cashReceiptRequested);
        System.out.println("총 금액: " + totalAmount);
        
        // 상품 정보 처리
        for(int i = 0; i < product_no.length; i++) {
            System.out.println("상품ID: " + product_no[i] + 
                              ", 수량: " + quantity[i] + 
                              ", 금액: " + item_total[i]);
        }
        
        UserVO authuser = (UserVO) session.getAttribute("authUser");
        
        int user_no = authuser.getUserNo();
        
        List<PaymentVO> paymentList = new ArrayList<>();
        
        for(int i = 0 ; i < product_no.length ; i++) {
        	PaymentVO paymentvo = new PaymentVO();
        	
        	paymentvo.setUser_no(user_no);
        	paymentvo.setProduct_no(product_no[i]);
        	paymentvo.setPayment_method(paymentMethod);
        	paymentvo.setPayment_status("완료");
        	paymentvo.setDelivery_status("준비중");
        	paymentvo.setPayment_amount(item_total[i]);
        	paymentvo.setService_type("normal(cashreceipt:" + cashReceiptRequested + ")");
        	
        	paymentList.add(paymentvo);
        }
        
        for(int i = 0 ; i<quantity.length ; i++) {
        	
        }
        System.out.println(paymentList);
        
        Map<String, Object> paymentMap = new HashMap<>();
        
        paymentMap.put("cart_no", cart_no);
        paymentMap.put("quantity", quantity);
        paymentMap.put("paymentList", paymentList);
        
        paymentservice.exepayment(paymentMap);
		
		return "checkout/success";
	}
	
	
	
}
