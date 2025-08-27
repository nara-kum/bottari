package com.example.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	//이미지 업로드
    public int insertInvitation(InvitationVO vo) {
        return sqlSession.insert("invitation.insertInvitation", vo);
    }

	// 초대장 리스트 셀렉트
	public List<InvitationVO> selectInvitationList(int userNo) {
		System.out.println("InvitationRepository.selectInvitationList(userNo=" + userNo + ")");
		List<InvitationVO> invitationVO = sqlSession.selectList("invitation.selectListByUser", userNo);
		
		System.out.println(invitationVO);
		
		return invitationVO;
	}
	
	//
    public InvitationVO selectOne(int userNo, int invitationNo){
        Map<String, Object> p = new HashMap<>();
        p.put("userNo", userNo);
        p.put("invitationNo", invitationNo);
        return sqlSession.selectOne("invitation.selectOne", p);
    }

}
