package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.PaymentRepository;
import com.example.vo.CheckOutVO;

@Service
public class PaymentService {
	//field
	@Autowired
	private PaymentRepository paymentrepository;
	//editor
	
	//method g/s
	
	//method normal
	public List<CheckOutVO> execheckoutList(int cart_no) {
		System.out.println("PaymentService.execheckoutList()");
		System.out.println("service.cart_no= " + cart_no);
		
		List<CheckOutVO> checkoutList = paymentrepository.checkoutList(cart_no);
		
		return checkoutList;
	}
}
