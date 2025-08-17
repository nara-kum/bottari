package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.ShopRepository;



@Service
public class ShopService {
	
	
	@Autowired
	private ShopRepository shopRepository;
	
	
	public void exeProductadd() {
		System.out.println("ShopService.exeProductadd"); //ㅇㅋ
		
		shopRepository.ProductInsert();
		
		
	}
	
	
	

}
