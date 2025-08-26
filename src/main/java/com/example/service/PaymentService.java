package com.example.service;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.PaymentRepository;
import com.example.vo.CheckOutVO;
import com.example.vo.CheckoutFundingVO;
import com.example.vo.PaymentVO;

@Service
public class PaymentService {
	// field
	@Autowired
	private PaymentRepository paymentrepository;
	private static final Random random =new Random();
	// editor

	// method g/s

	// method normal
	public List<CheckOutVO> execheckoutList(int cart_no) {
		System.out.println("PaymentService.execheckoutList()");
//		System.out.println("service.cart_no= " + cart_no);

		List<CheckOutVO> checkoutList = paymentrepository.checkoutList(cart_no);

		return checkoutList;
	}

	public List<CheckoutFundingVO> execheckoutFundingList(int funding_no) {
		System.out.println("PaymentService.execheckoutFundingList()");
		
		List<CheckoutFundingVO> checkoutFundingList = paymentrepository.checkoutFundingList(funding_no);
		
		return checkoutFundingList;
	}
	
	
	public int exepayment(Map<String, Object> paymentMap) {
		System.out.println("PaymentService.exepayment()");
		
		List<PaymentVO> paymentList = (List<PaymentVO>) paymentMap.get("paymentList");
		
		// order_no 생성하기
		long timestamp = Instant.now().getEpochSecond();
		String timestampStr = String.valueOf(timestamp);
		
		String shortTimestamp = timestampStr.substring(timestampStr.length() - 7);
		int randomSuffix = random.nextInt(900) + 100;
		
		System.out.println("randomSuffix= " + randomSuffix + ", shortTimestamp= " + shortTimestamp);
		int order_no = Integer.parseInt(shortTimestamp + randomSuffix);
		System.out.println("order_no= " + order_no);
		
		for(PaymentVO paymentvo : paymentList) {
			paymentvo.setOrder_no(order_no);
			
			int product_no = paymentvo.getProduct_no();
			
			// product_no를 repository로 보내서 주소를 가져오게 하기
			PaymentVO addr = paymentrepository.getAddress(product_no);
			
			paymentvo.setZipcode(addr.getZipcode());
			paymentvo.setAddress(addr.getAddress());
			paymentvo.setDetail_address(addr.getDetail_address());
			
		}
		System.out.println(paymentList);
		
		
		
		
		int cart_no = (int) paymentMap.get("cart_no");
		int quantity = (int) paymentMap.get("quantity");
		
		
		
		// 카트넘버를 통해서 해당 장바구니의 옵션들을 가져오게 한다
		paymentrepository.selectCart(cart_no);
		// quantity를 결제상품에 저장한다.
		
		
		return 0;
	}
}
