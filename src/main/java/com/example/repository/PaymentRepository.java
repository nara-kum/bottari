package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CheckAddressVO;
import com.example.vo.CheckOutVO;
import com.example.vo.CheckoutFundingVO;
import com.example.vo.DetailOptionVO;
import com.example.vo.FundingOptionViewVO;
import com.example.vo.PaymentVO;

@Repository
public class PaymentRepository {
	// field
	@Autowired
	private SqlSession sqlsession;
	// editor

	// method g/s

	// method normal
	public List<CheckOutVO> checkoutList(List<Integer> cartNos) {
		System.out.println("PaymentRepository.checkoutList()");
		System.out.println("repository.cartNos: " + cartNos);
		
		List<CheckOutVO> checkoutList = sqlsession.selectList("checkout.selectList", cartNos);
		
		System.out.println(checkoutList);
		
		return checkoutList;
	}
	
	public List<DetailOptionVO> detailList(List<Integer> cartNos) {
		System.out.println("PaymentRepository.detailList()");
		
		List<DetailOptionVO> detailList = sqlsession.selectList("checkout.selectDetail", cartNos);
		
		return detailList;
	}
	
	// 펀딩 결제일 때 리스트 조회 함수
	public List<CheckoutFundingVO> checkoutFundingList(int funding_no) {
		System.out.println("PaymentRepository.checkoutFundingList()");
		
		List<CheckoutFundingVO> checkoutFundingList = sqlsession.selectList("checkout.selectFundingList", funding_no);
		
		System.out.println(checkoutFundingList);
		
		return checkoutFundingList;
	}
	
	// 상품 주소 단일로 가져오기
	public List<CheckAddressVO> selectProductAddress(List<Integer> productNoList) {
		System.out.println("PaymentRepository.selectProductAddress()");
		
		List<CheckAddressVO> addressList  = sqlsession.selectList("checkout.selectAddress", productNoList);
		
		return addressList;
	}
	
	// 펀딩옵션 가져오기
	public List<FundingOptionViewVO> selectDetailList(int funding_no) {
		System.out.println("PaymentRepository.selectDetailList()");
		
		List<FundingOptionViewVO> fundingOptionList = sqlsession.selectList("checkout.selectFundingOption", funding_no);
		
		return fundingOptionList;
	}
	
	// 상품 주소정보 뭉탱이로 가져오기
	public List<CheckAddressVO> selectAddress(List<Integer> productIdList) {
		System.out.println("PaymentRepository.selectAddress()");
		
		List<CheckAddressVO> addressList = sqlsession.selectList("checkout.selectAddress", productIdList);
		
		return addressList;
	}
	
	// 데이터베이스에 저장
	public PaymentVO insertPaymentTable(PaymentVO vo) {
		System.out.println("PaymentRepository.insertPaymentTable()");
		
		System.out.println(vo);
		
		sqlsession.insert("checkout.insertpaymentList", vo);
		
		
		return vo;
	}
	
	public PaymentVO insertPaymentgoodsTable(PaymentVO vo) {
		System.out.println("PaymentRepository.insertPaymentgoodsTable()");
		
		sqlsession.insert("checkout.insertpaymentgoodsList", vo);
		
		return vo;
	}
	
	public PaymentVO insertPaymentGoodsOptionTable(PaymentVO vo) {
		System.out.println("PaymentRepository.insertPaymentGoodsOptionTable()");
		
		sqlsession.insert("checkout.insertpaymentgoodsoptionList", vo);
		
		return vo;
	}
}
