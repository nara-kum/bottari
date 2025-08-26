package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.CartRepository;
import com.example.vo.CartListVO;
import com.example.vo.CartOptionVO;

@Service
public class CartService {
	// field
	@Autowired
	private CartRepository cartrepository;
	// editor

	// method g/s

	// method normal
	public List<CartListVO> execartList(int user_no) {
		System.out.println("CartService.execartList()");

		List<CartListVO> cartList = cartrepository.cartList(user_no);

		return cartList;
	}

	public List<CartOptionVO> execartOptionList(int product_no) {
		System.out.println("CartService.execartOptionList()");

		List<CartOptionVO> optionList = cartrepository.cartOptionList(product_no);

		return optionList;
	}

	public List<CartListVO> execartDetailOptionList(int product_no, int user_no) {
		System.out.println("CartService.execartDetailOptionList()");
		
		List<CartListVO> cartDetailList = cartrepository.cartDetailList(product_no, user_no);
		
		return cartDetailList;
	}
}
