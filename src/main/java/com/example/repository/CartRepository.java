package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CartListVO;
import com.example.vo.CartOptionVO;

@Repository
public class CartRepository {
	// field
	@Autowired
	private SqlSession sqlsession;
	// editor

	// method g/s

	// method normal
	public List<CartListVO> cartList(int user_no) {
		System.out.println("CartRepository.cartList");
		
		List<CartListVO> cartList = sqlsession.selectList("cart.selectCartList",user_no);
		
		return cartList;
	}
	
	public List<CartOptionVO> cartOptionList(int product_no) {
		System.out.println("CartRepository.cartOptionList()");
		
		return null;
	}
	
	public List<CartListVO> cartDetailList(int product_no, int user_no) {
		System.out.println("CartRepository.cartDetailList()");
		
		return null;
	}
}
