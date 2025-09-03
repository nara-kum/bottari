package com.example.service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.PaymentRepository;
import com.example.vo.CheckAddressVO;
import com.example.vo.CheckOutVO;
import com.example.vo.CheckoutFundingVO;
import com.example.vo.FundingOptionViewVO;
import com.example.vo.HistoryFundingDetailVO;
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
	// 일반 결제 리스트 조회(리뉴얼)
	public List<CheckOutVO> exeNormalCheckOutList(List<Integer> cartNos) {
		System.out.println("PaymentService.exeNormalCheckOutList()");
		
		List<CheckOutVO> checkoutList = paymentrepository.checkoutList(cartNos);
		System.out.println("PaymentService.exeNormalCheckOutList()");
		System.out.println("repository에서 데이터 받아오기 성공");
		System.out.println("checkoutList: " + checkoutList);
		
		if(checkoutList.isEmpty()) {
			return checkoutList;
		} else {
			
		}
		
		return checkoutList;
	}
	
	// 일반 결제 리스트 조회
	public List<CheckOutVO> execheckoutList(List<Integer> cartNos) {
		System.out.println("PaymentService.execheckoutList()");

		List<CheckOutVO> checkoutList = paymentrepository.checkoutList(cartNos);
		System.out.println("PaymentService.execheckoutList()");
		System.out.println("repository에서 데이터 건네받기 성공");
		
		System.out.println("checkoutList: " + checkoutList);

		return checkoutList;
	}

	// 펀딩일 때 리스트 조회
	public List<CheckoutFundingVO> execheckoutFundingList(int funding_no) {
		System.out.println("PaymentService.execheckoutFundingList()");

		List<CheckoutFundingVO> checkoutFundingList = paymentrepository.checkoutFundingList(funding_no);
		System.out.println("PaymentService.execheckoutFundingList()");
		System.out.println("repository에서 데이터 건네받기 성공");

		return checkoutFundingList;
	}

	// 펀딩 결제 결제버튼 클릭했을 때
	public PaymentVO exeprocessFundingPayment(PaymentVO request) {
		System.out.println("PaymentService.exeprocessFundingPayment()");
		
		int funding_no = request.getFunding_no();
		System.out.println("funding_no: " + funding_no);

		List<CheckoutFundingVO> fundingList = paymentrepository.checkoutFundingList(funding_no);
		System.out.println("PaymentService.exeprocessFundingPayment()");
		System.out.println("repository에서 데이터 건네받기 성공");

		int product_no = fundingList.get(0).getProduct_no();

		List<Integer> productNoList = new ArrayList<>();
		productNoList.add(product_no);

		System.out.println(productNoList);
		List<PaymentVO> paymentList = new ArrayList<>();
		
		if (paymentList.isEmpty()) {
			paymentList.add(new PaymentVO());
		}

		// order_no 생성하기
		int order_no = generatedOrderNum();
		
		// 주소 가져오기
		List<CheckAddressVO> addressList = paymentrepository.selectProductAddress(productNoList);

		System.out.println("addressList: " + addressList);
		String address = addressList.get(0).getAddress();
		String detailAddress = addressList.get(0).getDetail_address();
		String zipcode = addressList.get(0).getZipcode();
		String shipping_yn = addressList.get(0).getShipping_yn();
		request.setPayment_status("paid");

		if (shipping_yn.equals("n")) {
			System.out.println("shipping_yn == n");
			zipcode = null;
			address = null;
			detailAddress = null;
			System.out.println("zipcode: " + zipcode + ", address: " + address + ", detailAddress: " + detailAddress);

			// 펀딩 옵션 가져오기
			List<FundingOptionViewVO> fundingOptionList = paymentrepository.selectDetailList(request.getFunding_no());
			int detailOption = fundingOptionList.get(0).getDetailoption_no();
			System.out.println("detailOption: " + detailOption);

			// 첫 번째 객체 가져오기
			PaymentVO payment = paymentList.get(0);

			// 값 세팅
			payment.setFunding_no(request.getFunding_no());
			payment.setUser_no(request.getUser_no());
			payment.setProduct_no(product_no);
			payment.setOrder_no(order_no);
			payment.setAddress(address);
			payment.setDetail_address(detailAddress);
			payment.setZipcode(zipcode);
			payment.setPayment_method(request.getPayment_method());
			payment.setPayment_status(request.getPayment_status());
			payment.setPayment_amount(request.getPayment_amount());
			payment.setService_type(request.getService_type());
			payment.setQuantity(request.getQuantity());
			payment.setDetailoption_no(detailOption);

			System.out.println(paymentList);

			PaymentVO vo = paymentList.get(0);
			paymentrepository.insertPaymentTable(vo);
			System.out.println(vo.getPayment_no());
			paymentrepository.insertPaymentgoodsTable(vo);
			System.out.println(vo.getPayment_goods_no());
			paymentrepository.insertPaymentGoodsOptionTable(vo);
			System.out.println(vo);

			return request;
		} else {
			// 펀딩 옵션 가져오기
			List<FundingOptionViewVO> fundingOptionList = paymentrepository.selectDetailList(request.getFunding_no());
			int detailOption = fundingOptionList.get(0).getDetailoption_no();

			// 첫 번째 객체 가져오기
			PaymentVO payment = paymentList.get(0);

			// 값 세팅
			payment.setFunding_no(request.getFunding_no());
			payment.setUser_no(request.getUser_no());
			payment.setProduct_no(product_no);
			payment.setOrder_no(order_no);
			payment.setAddress(address);
			payment.setDetail_address(detailAddress);
			payment.setZipcode(zipcode);
			payment.setPayment_method(request.getPayment_method());
			payment.setPayment_status(request.getPayment_status());
			payment.setPayment_amount(request.getPayment_amount());
			payment.setService_type(request.getService_type());
			payment.setQuantity(request.getQuantity());
			payment.setDetailoption_no(detailOption);

			System.out.println(paymentList);

			PaymentVO vo = paymentList.get(0);
			paymentrepository.insertPaymentTable(vo);
			System.out.println(vo.getPayment_no());
			paymentrepository.insertPaymentgoodsTable(vo);
			System.out.println(vo.getPayment_goods_no());
			paymentrepository.insertPaymentGoodsOptionTable(vo);
			System.out.println(vo);

			return request;
		}

	}
	
	// 일반 결제 프로세스 (리뉴얼)
	public PaymentVO exeprocessNormalPayment(Map<String, Object> paymentData, int user_no) {
		System.out.println("PaymentService.exeprocessNormalPayment()");
		
		// user_no 확인
		System.out.println("user_no: " + user_no);
		
		// order_no 생성
		int order_no = generatedOrderNum();
		System.out.println("order_no: " + order_no);
		
		// Map에서 공통 데이터 추출
		String payment_method = (String) paymentData.get("payment_method");
		String service_type = (String) paymentData.get("service_type");
		String zipcode = (String) paymentData.get("zipcode");
		String address = (String) paymentData.get("address");
		String detailAddress = (String) paymentData.get("detail_address");
		String payment_status = "paid";
		String delivery_status = "준비중";
		int funding_no = 0;
		
		
		// Map에서 배열 데이터 추출
		List<Map<String, Object>> items = (List<Map<String, Object>>) paymentData.get("productItems");
		
		// PaymentVO 리스트 생성
		List<PaymentVO> paymentList = new ArrayList<>();
		
		for(Map<String, Object> item : items) {
			PaymentVO paymentvo = new PaymentVO();
			
			// 단일 데이터 대입
			paymentvo.setUser_no(user_no);
			paymentvo.setFunding_no(funding_no);
			paymentvo.setOrder_no(order_no);
			paymentvo.setPayment_method(payment_method);
			paymentvo.setService_type(service_type);
			paymentvo.setZipcode(zipcode);
			paymentvo.setAddress(address);
			paymentvo.setDetail_address(detailAddress);
			paymentvo.setPayment_status(payment_status);
			paymentvo.setDelivery_status(delivery_status);
			// 배열 데이터 대입
			paymentvo.setProduct_no((Integer) item.get("product_no"));
			paymentvo.setPayment_amount((Integer) item.get("item_total"));
			paymentvo.setQuantity((Integer) item.get("quantity"));
			paymentvo.setDetailoption_no((Integer) item.get("detailoption_no"));
			
			paymentList.add(paymentvo);
		}
		
		// repository로 전달
		for(int i = 0 ; i<paymentList.size() ; i++) {
			PaymentVO vo =  paymentList.get(i);
			paymentrepository.insertPaymentTable(vo);
			System.out.println(vo);
			paymentrepository.insertPaymentgoodsTable(vo);
			System.out.println(vo.getPayment_goods_no());
			paymentrepository.insertPaymentGoodsOptionTable(vo);
			System.out.println(vo);
		}
		
		System.out.println("PaymentService.exeprocessNormalPayment()");
		System.out.println("결제프로세스 완료 / 장바구니 삭제 시작");
		
		List<Integer> cartNos = new ArrayList<>();
		
		for(Map<String, Object> item : items) {
			int cartNo = (Integer) item.get("cart_no");
			
			cartNos.add(cartNo);
		}
		
		System.out.println("cartNos: " + cartNos);
		
		int count = paymentrepository.deleteCart(cartNos);
		
		if(count == 1) {
			paymentrepository.deleteCartDetail(cartNos);
		}
		
		return (PaymentVO) paymentData;
	}

	// 결제 완료 후 결제된 상품의 장바구니 테이블 삭헤
	public int exeDeleteCart(List<Integer> cartNos) {
		System.out.println("PaymentService.exeDeleteCart()");

		int count = paymentrepository.deleteCart(cartNos);

		if (count == 1) {
			System.out.println("장바구니 삭제 완료");
			paymentrepository.deleteCartDetail(cartNos);
		}

		return 0;
	}
	
	// total_percent 가져오는 함수
	public String exegetPercent(int funding_no) {
		System.out.println("PaymentService.exegetPercent()");
		
		System.out.println("funding_no: " + funding_no);
		
		List<HistoryFundingDetailVO> checkPercentList = paymentrepository.getPercent(funding_no);
		
		int total_percent = checkPercentList.get(0).getTotal_percent();
		
		if(total_percent == 100) {
			return "error";
		} else {
			return "normal";
		}
	}
	
	// 펀딩 상태 변경하는 함수
	public int exeChangeFundingStatus(int funding_no) {
		System.out.println("PaymentService.exeChangeFundingStatus()");
		
		List<HistoryFundingDetailVO> percentList = paymentrepository.getPercent(funding_no);
		int total_percent = percentList.get(0).getTotal_percent();
		
		if(total_percent == 100) {
			int count = paymentrepository.changeFundingStatus(funding_no);
			
			return count;
		}
		
		return 0;
	}

	private int generatedOrderNum() {
		System.out.println("PaymentService.generatedOrderNum()");

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

		return order_no;
	}
}
