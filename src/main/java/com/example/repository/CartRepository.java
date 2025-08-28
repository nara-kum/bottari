package com.example.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	// 수량 업데이트
	public int updateCartQuantity(int cart_no, int newQuantityValue) {
		System.out.println("CartRepository.updateCartQuantity()");
		
		Map<String, Object> quantiMap = new HashMap<>();
		quantiMap.put("cart_no", cart_no);
		quantiMap.put("newQuantityValue", newQuantityValue);
		
		int count = sqlsession.update("cart.updateCartQuantity", quantiMap);
		
		return count;
	}
	
	// 옵션 변경
	public int updateCartOptions(int cart_no, int option_no) {
		System.out.println("CartRepository.updateCartOptions()");
		System.out.println("cart_no: " + cart_no + ", option_no: " + option_no);
		
		Map<String, Object> optionMap = new HashMap<>();
		optionMap.put("cart_no", cart_no);
		optionMap.put("option_no", option_no);
		
		int count = sqlsession.update("cart.updateCartOptions", optionMap);
		
		System.out.println("어엏 나 나와따");
		
		return count;
	}
	
	// 기념일 변경
	public int updateCartAnniversary(int cart_no, int event_no) {
		System.out.println("CartRepository.updateCartAnniversary()");
		
		Map<String, Object> anniMap = new HashMap<>();
		anniMap.put("cart_no", cart_no);
		anniMap.put("event_no", event_no);
		
		int count = sqlsession.update("cart.updateCartAnniversary", anniMap);
		
		return count;
	}
	
	// 장바구니 삭제
	public int deleteCartItem(int cart_no) {
		System.out.println("CartRepository.deleteCartItem()");
		
		int count = sqlsession.delete("cart.deleteCartItem", cart_no);
		
		return count;
	}
}
