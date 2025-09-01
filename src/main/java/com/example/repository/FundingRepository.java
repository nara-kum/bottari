package com.example.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FundingRepository {

	@Autowired
	private SqlSession sqlSession;

	//일반 리스트
	public List<?> selectMyFundingList(int userNo) {
		System.out.println("FundingRepository.selectMyFundingList(userNo=" + userNo + ")");
		return sqlSession.selectList("funding.selectMyFundingList", userNo);
	}
	
	//친구펀딩
    public List<Map<String,Object>> selectFriendFundingList(int userNo){
        return sqlSession.selectList("funding.selectFriendFundingList", userNo);
    }
	//총합
	public Long selectTotalPayByFundingNo(long fundingNo) {
		return sqlSession.selectOne("funding.selectTotalPayByFundingNo", fundingNo);
	}


    // ✅ NEW: 앵커 fundingNo 기반으로 카드 리스트 조회 (동일 user+event)
    public List<Map<String,Object>> selectFundingCardsByFundingAnchor(long fundingNo){
        return sqlSession.selectList("funding.selectFundingCardsByFundingAnchor", fundingNo);
    }
    public List<Map<String,Object>> selectFundingCardsByInvitationNo(long invNo){
        return sqlSession.selectList("funding.selectFundingCardsByInvitationNo", invNo);
    }

}
