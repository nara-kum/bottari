package com.example.service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.PaymentRepository;
import com.example.vo.CartListVO;
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
	// 일반 결제 리스트 조회
	public List<CheckOutVO> execheckoutList(List<Integer> cartNos) {
		System.out.println("PaymentService.execheckoutList()");

		List<CheckOutVO> checkoutList = paymentrepository.checkoutList(cartNos);
		System.out.println("PaymentService.execheckoutList()");
		System.out.println("repository에서 데이터 건네받기 성공");
		
		System.out.println("checkoutList: " + checkoutList);
		
		List<CartListVO> paymentMainList = new ArrayList<>();
		
		for(int i = 0 ; i<checkoutList.size() ; i++) {
			paymentMainList.get(i).getCart_no();
		}

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

	// 일반결제 결제버튼 클릭했을 때
	public int exepayment(List<PaymentVO> paymentList) {
		System.out.println("PaymentService.exepayment()");

		// order_no 생성 (int 범위 내)
		int order_no = generatedOrderNum();
		System.out.println("order_no: " + order_no);

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
					String shipping_yn = addressList.get(j).getShipping_yn();
					String zipcode = addressList.get(j).getZipcode();
					String address = addressList.get(j).getAddress();
					String detailAddress = addressList.get(j).getDetail_address();

					if (shipping_yn.equals("n")) {
						zipcode = null;
						address = null;
						detailAddress = null;
					} else {
						paymentList.get(i).setZipcode(zipcode);
						paymentList.get(i).setAddress(address);
						paymentList.get(i).setDetail_address(detailAddress);

						break;
					}
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
