package com.example.service;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.PaymentRepository;
import com.example.vo.CheckOutVO;
import com.example.vo.CheckoutFundingVO;
import com.example.vo.DetailOptionVO;
import com.example.vo.PaymentVO;

@Service
public class PaymentService {
	// field
	@Autowired
	private PaymentRepository paymentrepository;
	private static final Random random = new Random();
	// editor

	// method g/s

	// method normal
	public List<CheckOutVO> execheckoutList(List<Integer> cartNos) {
		System.out.println("PaymentService.execheckoutList() 진입");

		List<CheckOutVO> checkoutList = paymentrepository.checkoutList(cartNos);

		System.out.println("PaymentService.execheckoutList() 재진입 => detailoption_name 찾으러 출발");

		List<DetailOptionVO> detailOptionList = paymentrepository.detailList(cartNos);
		
		System.out.println("PaymentService.execheckoutList() 재진입");
		
		Map<Integer, String> detailMap = detailOptionList.stream()
				.collect(Collectors.toMap(DetailOptionVO::getDetailoption_no, DetailOptionVO::getDetailoption_name));

		for (CheckOutVO checkout : checkoutList) {
			if (detailMap.containsKey(checkout.getDetailoption_no())) {
				checkout.setDetailoption_name(detailMap.get(checkout.getDetailoption_no()));
			}
		}
		
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

		System.out.println("Before: " +paymentList);

		for(int i = 0 ; i < paymentList.size() ; i++) {
			paymentList.get(i).setOrder_no(order_no);
		}

		System.out.println("After: " +paymentList);
		
		int count = paymentrepository.savePayments(paymentMap);
		
		return count;
	}
}
