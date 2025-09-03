package com.example.controller;

import java.util.ArrayList;
import java.util.List;

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
	@RequestMapping(value = "/payment/checkout", method = { RequestMethod.GET, RequestMethod.POST })
	public String checkOutList(@RequestParam("cart_no") List<Integer> cartNos,
								Model model, HttpSession session) {
		System.out.println("PaymentController.checkOutList() 진입");
		
		System.out.println("cartNos: " + cartNos);
		
		UserVO authuser = (UserVO) session.getAttribute("authUser");
        
        
        if(authuser == null)
			return "/user/loginForm";
		else {
			int user_no = authuser.getUserNo();
			
        	List<CheckOutVO> checkoutList = paymentservice.execheckoutList(cartNos);
        	System.out.println("PaymentController.checkOutList() 재진입");
        	
        	model.addAttribute("cList", checkoutList);
        	
        	if(!checkoutList.isEmpty()) {
        		CheckOutVO firstItem = checkoutList.get(0);
        		if(firstItem.getUser_no() != user_no) {
        			return "/shop/error";
        		} else {
        			model.addAttribute("total_quantity", firstItem.getTotal_quantity());
        			model.addAttribute("total_price",firstItem.getTotal_price());
        			model.addAttribute("total_amount",firstItem.getTotal_amount()); 
        			model.addAttribute("shipping_cost", firstItem.getShipping_cost());
        		}
        		
        		return "/shop/checkout";
        	} else {
        		return "/shop/error";
        	}
        }
	}
	
	
	
	// 펀딩 결제일 때 리스트 조회 함수
	@RequestMapping(value = "/payment/checkout_funding", method = {RequestMethod.GET,RequestMethod.POST})
	public String checkoutFundingList(@RequestParam("funding_no") int funding_no,
									  @RequestParam("count") int count, 
									  Model model) {
		System.out.println("PaymentController.checkoutFundingList()");
		
		if(funding_no != 0 && count >= 1) {
			
			List<CheckoutFundingVO> checkoutFundingList = paymentservice.execheckoutFundingList(funding_no);
			int percent = checkoutFundingList.get(0).getPercent();
			int total_percent = percent*count;
			
			model.addAttribute("fList", checkoutFundingList);
			model.addAttribute("amount", checkoutFundingList.get(0).getAmount());
			model.addAttribute("percent", checkoutFundingList.get(0).getPercent());
			model.addAttribute("total_percent", total_percent);
			model.addAttribute("total_amount", count*checkoutFundingList.get(0).getAmount());
			
			return "/shop/checkout_funding";
		} else {
			
			return "/shop/error";
		}
		
	}
	
	// ajax로 보내면 이것도 만들어야 되네;;
	@RequestMapping(value = "/shop/success", method = {RequestMethod.GET,RequestMethod.POST})
	public String success() {
		return "shop/success";
	}
	
	@RequestMapping(value = "/shop/error", method = {RequestMethod.GET,RequestMethod.POST})
	public String error() {
		return "shop/error";
	}
	
}
