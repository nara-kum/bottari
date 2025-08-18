package com.example.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.UserVO;

@Repository
public class UserRepository {
	
	@Autowired
	private SqlSession sqlSession;
	
	//회원가입
	public int insertUser(UserVO userVO) {
		
		System.out.println("UserRepository.selectUser()");
		System.out.println(userVO);
		
		int count = sqlSession.insert("user.insertUser",userVO);
		
		return count;
	}
	
	//로그인
	public UserVO selectUser(UserVO userVO) {
		
		System.out.println("UserRepository.selectUser()");
		System.out.println(userVO);
		
		UserVO authUser = sqlSession.selectOne("user.selectIdPw",userVO);
		
		System.out.println(authUser);
		
		return authUser;
	}
	
	//아이디사용유무체크(회원가입)
	public UserVO userSelectById(String id) {
		System.out.println("UserRepository.userSelectById()");
		System.out.println(id);
		
		UserVO userVO = sqlSession.selectOne("user.selectOneById",id);
		return userVO;
	}

}
