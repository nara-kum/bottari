package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.FundingRepository;
import com.example.vo.WishlistVO;

@Service
public class FundingService {
	
	@Autowired
	private FundingRepository fundingRepository;
	
	// 캘린더 리스트
	public List<WishlistVO> exeMyFundingList(int no) {
	System.out.println("FundingService.exeMyFundingList()");
	
	return fundingRepository.selectMyFundingList(no);
}

}
