package com.example.controller;

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

@Controller
public class PaymentController {
	//field
	@Autowired
	private PaymentService paymentservice;
	//editor
	
	//method g/s
	
	//method normal
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
}
