package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.repository.WishlistRepository;
import com.example.vo.CalenderVO;
import com.example.vo.WishlistVO;

@Service
public class WishlistService {

	@Autowired
	private WishlistRepository wishlistRepository;
	
	//위시리스트
	public List<WishlistVO> exeWishList(int no) {
		System.out.println("WishService.exeWishList()");
		List<WishlistVO> wList = wishlistRepository.selectWishList(no);
		return wList;
	}
	
	//기념일리스트
	public List<CalenderVO> exeEventList(int no) {
		System.out.println("WishService.exeEventList()");
		List<CalenderVO> eList = wishlistRepository.selectEventList(no);
		return eList;
	}
	
	//펀딩 생성시 펀딩테이블에 인서트 하고, 위시리스트 삭제
	@Transactional
	public int exeFunding(List<WishlistVO> wishlistVO) {
		System.out.println("WishService.exeFunding()");
		if (wishlistVO == null || wishlistVO.isEmpty()) return 0;

		// 동일 이벤트로 묶여 온다는 전제
		int eventNum = wishlistVO.get(0).getEventNo();

		for (WishlistVO vo : wishlistVO) {
			if (vo == null) continue;

			// 1) funding_product 단건 insert → vo.fundingNo 채워짐 (useGeneratedKeys)
			wishlistRepository.insertFundingOne(vo);

			// 2) funding_option insert (funding_no, detailoption_no)
			int detailOptionNo = vo.getDetailoptionNo();
			if (vo.getFundingNo() > 0 && detailOptionNo > 0) {
				wishlistRepository.insertFundingOption(vo.getFundingNo(), detailOptionNo);
			}
		}

		// 3) 위시리스트 삭제 (eventNo 기준)
		int count = wishlistRepository.deleteWishlist(eventNum);
		return count;
	}
}
