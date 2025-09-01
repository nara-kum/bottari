package com.example.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.FundingRepository;

@Service
public class FundingService {

	@Autowired
	private FundingRepository fundingRepository;

	// 일반 리스트
	public List<?> getMyFundingList(int userNo) {
		System.out.println("FundingService.getMyFundingList(userNo=" + userNo + ")");
		return fundingRepository.selectMyFundingList(userNo);
	}

    // 내가 결제한 펀딩 리스트 (그래프 기준: 총 결제합) 친구펀딩
    public List<Map<String,Object>> getFriendFundingList(int userNo){
        return fundingRepository.selectFriendFundingList(userNo);
    }

    // ✅ NEW
    public List<Map<String,Object>> getFundingCardsByFundingAnchor(long fundingNo){
        return fundingRepository.selectFundingCardsByFundingAnchor(fundingNo);
    }
    public List<Map<String,Object>> getFundingCardsByInvitationNo(long invNo){
        return fundingRepository.selectFundingCardsByInvitationNo(invNo);
    }
	// 총합
	public long getTotalPaidByFundingNo(long fundingNo) {
		Long v = fundingRepository.selectTotalPayByFundingNo(fundingNo);
		return (v == null ? 0L : v);
	}
}
