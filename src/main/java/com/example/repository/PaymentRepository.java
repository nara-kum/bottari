package com.example.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CheckOutVO;
import com.example.vo.CheckoutFundingVO;
import com.example.vo.DetailOptionVO;
import com.example.vo.PaymentGoodsOptionVO;
import com.example.vo.PaymentGoodsVO;
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
	
	public List<CheckoutFundingVO> checkoutFundingList(int funding_no) {
		System.out.println("PaymentRepository.checkoutFundingList()");
		
		List<CheckoutFundingVO> checkoutFundingList = sqlsession.selectList("checkout.selectFundingList", funding_no);
		
		System.out.println(checkoutFundingList);
		
		return checkoutFundingList;
	}
	
	public int savePayments(Map<String, Object> paymentMap) {
		
		List<PaymentVO> paymentList = (List<PaymentVO>) paymentMap.get("paymentList");
		List<PaymentGoodsVO> paymentGoodsList = (List<PaymentGoodsVO>) paymentMap.get("paymentGoodsList");
		List<PaymentGoodsOptionVO> paymentGoodsOptionList = (List<PaymentGoodsOptionVO>) paymentMap.get("paymentGoodsOptionList");
		
		
		
		return 0;
	}
}
