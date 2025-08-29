package com.example.service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.PaymentRepository;
import com.example.vo.CheckAddressVO;
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
	
	
	// 펀딩 결제일 때 리스트 조회 함수
	public List<CheckoutFundingVO> execheckoutFundingList(int funding_no) {
		System.out.println("PaymentService.execheckoutFundingList()");

		List<CheckoutFundingVO> checkoutFundingList = paymentrepository.checkoutFundingList(funding_no);

		return checkoutFundingList;
	}

	public int exepayment(List<PaymentVO>paymentList) {
		System.out.println("PaymentService.exepayment()");

		// order_no 생성 (int 범위 내)
		System.out.println("order_no 생성 시작");
		long timestamp = Instant.now().getEpochSecond();
		String timestampStr = String.valueOf(timestamp);

		// timestamp 6자리만 사용
		String shortTimestamp = timestampStr.substring(timestampStr.length() - 6);

		// randomSuffix 3자리
		int randomSuffix = random.nextInt(900) + 100;

		int order_no = Integer.parseInt(shortTimestamp + randomSuffix);
		System.out.println("order_no 생성완료");
		System.out.println("order_no= " + order_no);

		System.out.println("============================================");
		System.out.println("order_no 대입 시작");
		
		System.out.println("Before: " +paymentList);

		for(int i = 0 ; i < paymentList.size() ; i++) {
			paymentList.get(i).setOrder_no(order_no);
		}
		
		System.out.println("order_no 대입 완료");
		
		// ===============================================================================================
		
		List<Integer> productIdList = new ArrayList<>();
		
		System.out.println("product_no 추출 시작...");
		
		for(int i = 0 ; i < paymentList.size() ; i++) {
			int product_no = paymentList.get(i).getProduct_no();
			
			productIdList.add(product_no);
		}
		
		
		System.out.println("product_no 추출 완료");
		System.out.println("productIdList: " + productIdList);
		
		// ===============================================================================================
		
		System.out.println("주소 추출 준비 repository로 이동...");
		List<CheckAddressVO> addressList = paymentrepository.selectAddress(productIdList);
		
		System.out.println("주소 추출 완료");
		System.out.println("주소 대입 시작...");
		
		for(int i = 0 ; i < paymentList.size() ; i++) {
			int main = paymentList.get(i).getProduct_no();
			for(int j = 0 ; j < addressList.size() ; j++) {
				int sub = addressList.get(j).getProduct_no();
				if(main == sub) {
					String zipcode = addressList.get(j).getZipcode();
					String address = addressList.get(j).getAddress();
					String detailAddress = addressList.get(j).getDetail_address();
					
					paymentList.get(i).setZipcode(zipcode);
					paymentList.get(i).setAddress(address);
					paymentList.get(i).setDetail_address(detailAddress);
					
					break;
				}
			}
		}
		
		System.out.println("주소대입 완료");
		System.out.println("paymentList: " + paymentList);
		
		for(int i = 0 ; i <paymentList.size() ; i++) {
			PaymentVO vo = paymentList.get(i);
			paymentrepository.insertPaymentTable(vo);
			System.out.println(vo);
			paymentrepository.insertPaymentgoodsTable(vo);
			System.out.println(vo.getPayment_goods_no());
			paymentrepository.insertPaymentGoodsOptionTable(vo);
			System.out.println(vo);
		}
		
		
		return 0;
	}
}
