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
		System.out.println("cart_no= " + cart_no);
		
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
}
