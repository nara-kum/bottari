package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CheckOutVO;

@Repository
public class PaymentRepository {
	// field
	@Autowired
	private SqlSession sqlsession;
	// editor

	// method g/s

	// method normal
	public List<CheckOutVO> checkoutList(int cart_no) {
		System.out.println("PaymentRepository.checkoutList()");
		System.out.println("repository.cart_no= " + cart_no);
		
		List<CheckOutVO> checkoutList = sqlsession.selectList("checkout.selectList", cart_no);
		
		System.out.println(checkoutList);
		
		return checkoutList;
	}
}
