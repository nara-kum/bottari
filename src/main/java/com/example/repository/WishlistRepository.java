package com.example.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CalenderVO;
import com.example.vo.WishlistVO;

@Repository
public class WishlistRepository {

	@Autowired
	private SqlSession sqlSession;	
	
	//위시리스트
	public List<WishlistVO> selectWishList(int no){
		System.out.println("WishRepository.selectWishList()");
		List<WishlistVO> wList = sqlSession.selectList("wishlist.selectList", no);
		return wList;
	}
	
	//기념일리스트
	public List<CalenderVO> selectEventList(int no){
		System.out.println("WishRepository.selectEventList()");
		List<CalenderVO> eList = sqlSession.selectList("wishlist.selectEventList", no);
		return eList;
	}
	
	//펀딩등록(단건) — 서비스에서 loop 호출
	public int insertFundingOne(WishlistVO vo) {
		System.out.println("WishRepository.insertFundingOne() vo=" + vo);
		return sqlSession.insert("wishlist.insertFundingOne", vo);
	}

	//펀딩옵션 등록
	public int insertFundingOption(int fundingNo, int detailoptionNo) {
		System.out.println("WishRepository.insertFundingOption() fundingNo=" + fundingNo + ", detailoptionNo=" + detailoptionNo);
		Map<String, Object> p = new HashMap<>();
		p.put("fundingNo", fundingNo);
		p.put("detailoptionNo", detailoptionNo);
		return sqlSession.insert("wishlist.insertFundingOption", p);
	}
	
	//위시삭제 (eventNo 기준)
	public int deleteWishlist(int eventNum) {
		System.out.println("WishRepository.deleteWishlist() eventNo=" + eventNum);
		Map<String, Object> p = new HashMap<>();
		p.put("eventNo", eventNum);
		int count = sqlSession.delete("wishlist.deleteWish", p);
		return count;
	}
}
