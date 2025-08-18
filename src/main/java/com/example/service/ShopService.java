package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.ShopRepository;
import com.example.vo.ProductVO;


@Service
public class ShopService {
	
	
	@Autowired
	private ShopRepository shopRepository;
	
	

	public int exeProductadd(ProductVO productVO) {
		System.out.println("ShopService.exeProductadd"); // ㅇㅋ

		int count = shopRepository.ProductInsert(productVO);
		return count;

	}
	

}
