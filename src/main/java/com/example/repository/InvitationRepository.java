package com.example.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.InvitationVO;

@Repository
public class InvitationRepository {
	
	@Autowired
	private SqlSession sqlSession;

	public int insertInvi(InvitationVO invitationVO) {
		System.out.println("InvitationRepository.insertInvi()");
		System.out.println(invitationVO);
		
		int count = sqlSession.insert("invitation.insertInvi",invitationVO);
		
		return count;
	}

}
