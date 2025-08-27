package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CartListVO;
import com.example.vo.ProductOptionListVO;

@Repository
public class CartRepository {
	// field
	@Autowired
	private SqlSession sqlsession;
	// editor

	// method g/s

	// method normal
	public List<CartListVO> selectCartList(int user_no) {
		System.out.println("CartRepository.selectCartList()");
		
		List<CartListVO> cartList = sqlsession.selectList("cart.selectCartList", user_no);
		
		return cartList;
	}
	
	public List<ProductOptionListVO> selectByProductNoList(List<Integer>productNoList) {
		
		List<ProductOptionListVO> productOptionList = sqlsession.selectList("cart.selectByProductNoList", productNoList);
		
		return productOptionList;
	}
}
