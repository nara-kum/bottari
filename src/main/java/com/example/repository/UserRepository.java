package com.example.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.UserVO;

@Repository
public class UserRepository {
	
	@Autowired
	private SqlSession sqlSession;
	
	//--user저장(회원가입)
	public int insert(UserVO userVO) {
		
		System.out.println("UserRepository.insert()");
		
		int count = sqlSession.insert("user.insert",userVO);
		
		return count;
	}

	//--user정보가져오기(id password) -->세션저장용
	public UserVO userSelectOneByIdPw(UserVO userVO) {
		System.out.println("UserRepository.userSelectOneByIdPw()");
		System.out.println(userVO);
		UserVO authUser = sqlSession.selectOne("user.selectOneByIdPw",userVO);
		
		System.out.println("유저 레파지토리 로그인 성공?");
		
		//return null;
		return authUser;
	}	

	// /////////////////////////////////////  8/22부터 주말 수정하기 ////////////////////////////////////////////////////		
	/* 
	//--user정보가져오기(no) -->회원수정폼
	public UserVO userSelectByNo(int no) {
		System.out.println("UserRepository.userSelectByNo()");
		
		System.out.println(no);
		UserVO userVO = sqlSession.selectOne("user.selectByNo", no);
		System.out.println(userVO);
		
		return userVO;	
	}	
	*/
	
	// /////////////////////////////////////  8/22부터 주말 수정하기 ////////////////////////////////////////////////////		
	/*
	//회원정보 수정
	public int userUpdate(UserVO userVO) {
		System.out.println("UserRepository.userUpdate()");

		int count = sqlSession.update("user.update",userVO);
		
		return count;
	}	
	*/
	
	//아이디사용유무체크(회원가입)
	public UserVO userSelectById(String id) {
		System.out.println("UserRepository.userSelectById()");
		
		UserVO userVO = sqlSession.selectOne("user.selectOneById",id);
		System.out.println(id);
		return userVO;
	}	
	
	//로그인
	public UserVO selectUser(UserVO userVO) {
		
		System.out.println("UserRepository.selectUser()");
		System.out.println(userVO);
		
		UserVO authUser = sqlSession.selectOne("user.selectIdPw",userVO);
		
		System.out.println(authUser);
		
		return authUser;
	}

}
