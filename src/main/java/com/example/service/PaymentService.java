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
import com.example.vo.FundingOptionViewVO;
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

	// 펀딩일 때 리스트 조회
	public List<CheckoutFundingVO> execheckoutFundingList(int funding_no) {
		System.out.println("PaymentService.execheckoutFundingList()");

		List<CheckoutFundingVO> checkoutFundingList = paymentrepository.checkoutFundingList(funding_no);

		return checkoutFundingList;
	}

	// 펀딩 결제 결제버튼 클릭했을 때
	public PaymentVO exeprocessFundingPayment(PaymentVO request) {
		System.out.println("PaymentService.exeprocessFundingPayment()");

		int product_no = request.getProduct_no();

		List<Integer> productNoList = new ArrayList<>();
		productNoList.add(product_no);

		System.out.println(productNoList);
		List<PaymentVO> paymentList = new ArrayList<>();

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
		
		// 주소 가져오기
		List<CheckAddressVO> addressList = paymentrepository.selectProductAddress(productNoList);
		System.out.println("addressList: " + addressList);
		String address = addressList.get(0).getAddress();
		String detailAddress = addressList.get(0).getDetail_address();
		String zipcode = addressList.get(0).getZipcode();
		request.setPayment_status("완료");
		
		// 펀딩 옵션 가져오기
		List<FundingOptionViewVO> fundingOptionList = paymentrepository.selectDetailList(request.getFunding_no());
		int detailOption = fundingOptionList.get(0).getDetailoption_no();
		
		paymentList.get(0).setFunding_no(request.getFunding_no());
		paymentList.get(0).setUser_no(request.getUser_no());
		paymentList.get(0).setFunding_no(request.getFunding_no());
		paymentList.get(0).setProduct_no(request.getProduct_no());
		paymentList.get(0).setOrder_no(order_no);
		paymentList.get(0).setAddress(address);
		paymentList.get(0).setDetail_address(detailAddress);
		paymentList.get(0).setZipcode(zipcode);
		paymentList.get(0).setPayment_method(request.getPayment_method());
		paymentList.get(0).setPayment_status(request.getPayment_status());
		paymentList.get(0).setPayment_amount(request.getPayment_amount());
		paymentList.get(0).setService_type(request.getService_type());
		paymentList.get(0).setQuantity(request.getQuantity());
		paymentList.get(0).setDetailoption_no(detailOption);
		
		System.out.println(paymentList);
		
		PaymentVO vo =paymentList.get(0);
		paymentrepository.insertPaymentTable(vo);
		System.out.println(vo.getPayment_no());
		paymentrepository.insertPaymentgoodsTable(vo);
		System.out.println(vo.getPayment_goods_no());
		paymentrepository.insertPaymentGoodsOptionTable(vo);
		System.out.println(vo);

		return request;
	}

	// 일반결제 결제버튼 클릭했을 때
	public int exepayment(List<PaymentVO> paymentList) {
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

		System.out.println("Before: " + paymentList);

		for (int i = 0; i < paymentList.size(); i++) {
			paymentList.get(i).setOrder_no(order_no);
		}

		System.out.println("order_no 대입 완료");

		// ===============================================================================================

		List<Integer> productIdList = new ArrayList<>();

		System.out.println("product_no 추출 시작...");

		for (int i = 0; i < paymentList.size(); i++) {
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

		for (int i = 0; i < paymentList.size(); i++) {
			int main = paymentList.get(i).getProduct_no();
			for (int j = 0; j < addressList.size(); j++) {
				int sub = addressList.get(j).getProduct_no();
				if (main == sub) {
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

		for (int i = 0; i < paymentList.size(); i++) {
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
