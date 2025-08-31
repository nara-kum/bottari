package com.example.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.repository.FundingRepository;

@Service
public class FundingService {

	private final FundingRepository fundingRepository;

	public FundingService(FundingRepository fundingRepository) {
		this.fundingRepository = fundingRepository;
	}

	//마이펀딩 리스
	public List<Map<String, Object>> getMyFundingList(Long userNo) {
		System.out.println("FundingService.getMyFundingList(userNo=" + userNo + ")");
		return fundingRepository.selectMyFundingList(userNo);
	}
	
	//친구펀딩 리스트
	public List<Map<String, Object>> getFriendFundingList(Long userNo) {
		System.out.println("FundingService.getFriendFundingList(userNo=" + userNo + ")");
		return fundingRepository.selectFriendFundingList(userNo);
	}

}
