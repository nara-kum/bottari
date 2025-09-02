// src/main/java/com/example/repository/FundingQueryRepository.java
package com.example.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FundingQueryRepository {

	@Autowired
    private SqlSession sqlSession;
    private static final String NS = "funding.";

    // 마이펀딩 

    public List<Map<String,Object>> selectMyFundingCards(int userNo){
        return sqlSession.selectList(NS + "selectMyFundingCards", userNo);
    }

    public int updateFundingStatusStop(int userNo, int fundingNo){
        return sqlSession.update(NS + "updateFundingStatusStop",
                Map.of("userNo", userNo, "fundingNo", fundingNo));
    }

    public int updateFundingStatusDone(int userNo, int fundingNo){
        return sqlSession.update(NS + "updateFundingStatusDone",
                Map.of("userNo", userNo, "fundingNo", fundingNo));
    }
    //친구펀딩
    public List<Map<String,Object>> selectFriendFundingCards(int userNo){
        return sqlSession.selectList(NS + "selectFriendFundingCards", userNo);
    }
    
    // 펀딩(취소)
    public int updateMyPaymentsByFunding(int userNo, int fundingNo){
        return sqlSession.delete(NS + "updateMyPaymentsByFunding",
                Map.of("userNo", userNo, "fundingNo", fundingNo));
    }
    
    //초대장
    public Integer selectEventNoByInvitationNo(int invitationNo){
        return sqlSession.selectOne(NS + "selectEventNoByInvitationNo", invitationNo);
    }
    public List<Map<String,Object>> selectGiftsPublicByEvent(int eventNo){
        return sqlSession.selectList(NS + "selectGiftsPublicByEvent", eventNo);
    }
    public List<Map<String,Object>> selectGiftsPublicByFunding(int fundingNo){
        return sqlSession.selectList(NS + "selectGiftsPublicByFunding", fundingNo);
    }
    public Integer selectTotalPaidByFunding(int fundingNo){
        return sqlSession.selectOne(NS + "selectTotalPaidByFunding", fundingNo);
    }
    
	//총합
	public Long selectTotalPayByFundingNo(long fundingNo) {
		return sqlSession.selectOne("funding.selectTotalPayByFundingNo", fundingNo);
	}
	
	// 취소
	public int cancelAllPaymentsByFunding(long fundingNo){
	    return sqlSession.update(NS + "cancelAllPaymentsByFunding", fundingNo);
	}
}
