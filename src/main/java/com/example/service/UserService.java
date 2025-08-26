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
		
		int count = userRepository.insert(userVO);
		
		return count;
	}
	
	/*
	//--아이디사용유무체크(회원가입)
	public boolean exeIdcheck(String id) {
		System.out.println("UserService.exeIdcheck()");
		
		UserVO userVO = userRepository.userSelectById(id);
		
		System.out.println(userVO);
	
		if(userVO == null) {
			//사용할 수 있는 아이디
			return true;
		} else {
			//사용중인 아이디
			return false;
		}
	}
	*/
	
	
	//회원정보 수정폼
	public UserVO exeEditForm(int no) {
		System.out.println("UserService.exeEditForm()");		
		UserVO userVO = userRepository.userSelectByNo(no);
		return userVO;
	}
	

	//회원정보 수정
	public int exeEdit(UserVO userVO) {
		System.out.println("UserService.exeEdit()");
		
		int count = userRepository.userUpdate(userVO);

		return count;
	}		

	
	//로그인
	public UserVO exeLogin(UserVO userVO) {
		System.out.println("UserService.exeLogin()");
		
		UserVO authUser = userRepository.selectUser(userVO);
		
		return authUser;
	}	

}
