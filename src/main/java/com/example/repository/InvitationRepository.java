package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.InvitationVO;

@Repository
public class InvitationRepository {

	@Autowired
	private SqlSession sqlSession;

	// 초대장 등록
	public int insertInvi(InvitationVO invitationVO) {
		System.out.println("InvitationRepository.insertInvi()");
		System.out.println(invitationVO);

		int count = sqlSession.insert("invitation.insertInvitation", invitationVO);

		return count;
	}

	// 초대장 리스트 셀렉트
	public List<InvitationVO> selectInvitationList(int userNo) {
		System.out.println("InvitationRepository.selectInvitationList(userNo=" + userNo + ")");
		List<InvitationVO> invitationVO = sqlSession.selectList("invitation.selectListByUser", userNo);
		
		System.out.println(invitationVO);
		
		return invitationVO;
	}

}
