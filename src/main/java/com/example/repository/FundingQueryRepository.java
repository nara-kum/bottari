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

//    public FundingQueryRepository(SqlSession sqlSession) {
//        this.sqlSession = sqlSession;
//    }

    public Integer selectEventNoByInvitationNo(int invitationNo){
        return sqlSession.selectOne(NS + "selectEventNoByInvitationNo",
                                    Map.of("invitationNo", invitationNo));
    }
    public List<Map<String,Object>> selectGiftsPublicByEvent(int eventNo){
        return sqlSession.selectList(NS + "selectGiftsPublicByEvent",
                                     Map.of("eventNo", eventNo));
    }
    public List<Map<String,Object>> selectGiftsPublicByFunding(int fundingNo){
        return sqlSession.selectList(NS + "selectGiftsPublicByFunding",
                                     Map.of("fundingNo", fundingNo));
    }
    public Integer selectTotalPaidByFunding(int fundingNo){
        return sqlSession.selectOne(NS + "selectTotalPaidByFunding",
                                    Map.of("fundingNo", fundingNo));
    }
}
