package com.example.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class FundingRepository {

	private final SqlSession sqlSession;

	public FundingRepository(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/** 마이펀딩 리스트 조회 */
	public List<Map<String, Object>> selectMyFundingList(Long userNo) {
		System.out.println("FundingRepository.selectMyFundingList(userNo=" + userNo + ")");
		return sqlSession.selectList("funding.selectMyFundingList", userNo);
	}

	// com.example.repository.FundingRepository
	public List<Map<String, Object>> selectFriendFundingList(Long userNo) {
		System.out.println("FundingRepository.selectFriendFundingList(userNo=" + userNo + ")");
		return sqlSession.selectList("funding.selectFriendFundingList", userNo);
	}

}
