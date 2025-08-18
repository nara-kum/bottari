package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.UserRepository;
import com.example.vo.UserVO;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	//회원가입
	public int exeJoin(UserVO userVO) {
		System.out.println("UserService.exeJoin()");
		
		int count = userRepository.insertUser(userVO);
		
		return count;
	}

	//로그인
	public UserVO exeLogin(UserVO userVO) {
		System.out.println("UserService.exeLogin()");
		
		UserVO authUser = userRepository.selectUser(userVO);
		
		return authUser;
	}

}
