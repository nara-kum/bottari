package com.example.repository;

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

	// 이미지 업로드
	public int insertInvitation(InvitationVO vo) {
		System.out.println("이미지업로드??" + vo);

		return sqlSession.insert("invitation.insertInvitation", vo);
	}

	// 초대장 리스트 셀렉트
	public List<InvitationVO> selectInvitationList(int userNo) {
		System.out.println("InvitationRepository.selectInvitationList(userNo=" + userNo + ")");

		List<InvitationVO> invitationVO = sqlSession.selectList("invitation.selectListByUser", userNo);

		System.out.println(invitationVO);

		return invitationVO;
	}

	// 초대장 수정
	public int updateInvitation(InvitationVO vo) {
		return sqlSession.update("invitation.updateInvitation", vo);
	}

	// 초대장 삭제
	public int deleteInvitation(Map<String, Object> p) {
		return sqlSession.delete("invitation.deleteInvitation", p);
	}

	// 초대장 상세조회
	public Map<String, Object> selectInvitationDetail(Map<String, Object> p) {
		return sqlSession.selectOne("invitation.selectInvitationDetail", p);
	}

	public List<Map<String, Object>> selectGiftsByEvent(Map<String, Object> p) {
		return sqlSession.selectList("invitation.selectGiftsByEvent", p);
	}

	// ✅ 소유자 제약 없이 전체 필드
	public Map<String, Object> selectInvitationFullAny(int invitationNo) {
		return sqlSession.selectOne("invitation.selectInvitationFullAny", invitationNo);
	}

	// ✅ 공개: 이벤트별 펀딩 카드 목록 (비로그인)
	public List<Map<String, Object>> selectGiftsPublicByEvent(int eventNo) {
		return sqlSession.selectList("funding.selectGiftsPublicByEvent", eventNo);
	}
}
