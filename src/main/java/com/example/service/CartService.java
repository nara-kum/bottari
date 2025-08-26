package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.CartRepository;
import com.example.vo.CartListVO;

@Service
public class CartService {
	//field
	@Autowired
	private CartRepository cartrepository;
	//editor
	
	//method g/s
	
	//method normal
	public List<CartListVO> execartList(int user_no) {
		System.out.println("CartService.execartList()");
		
		List<CartListVO> cartList = cartrepository.cartList(user_no);
		
		return cartList;
	}
}
