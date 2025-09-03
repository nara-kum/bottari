package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.CalenderRepository;
import com.example.vo.CalenderVO;
import com.example.vo.InvitationVO;
import com.example.vo.WishlistVO;

@Service
public class CalenderService {
	// field
	@Autowired
	private CalenderRepository calenderrepository;
	// editor

	// method g/s

	// method normal

	// 캘린더 리스트
	public List<CalenderVO> exeCalenderList(int user_no) {
		System.out.println("CalenderService.exeCalenderList()");

		List<CalenderVO> calenderList = calenderrepository.calenderAddList(user_no);

		return calenderList;
	}

	// 초대장 정보 가져오기
	public List<InvitationVO> exegetInvitationList(int event_id) {
		System.out.println("CalenderService.exegetInvitationList()");
		
		List<InvitationVO> invitationList = calenderrepository.getInvitationList(event_id);

		return invitationList;
	}

	// 펀딩리스트 가져오기
	public List<WishlistVO> exegetProductList(int event_id) {
		System.out.println("CalenderService.exeProductList()");
		
		List<WishlistVO> productList = calenderrepository.getProductList(event_id);
		
		return productList;
	}

	// 캘린더 이벤트 등록
	public int exeInsertCalender(CalenderVO calendervo) {
		System.out.println("CalenderService.exeCalenderInsert()");
//		System.out.println("CalenderService.calendervo:" + calendervo);

		int count = calenderrepository.calenderInsert(calendervo);

		return count;
	}

	// 캘린더 이벤트 수정
	public int exeUpdateCalender(CalenderVO calendervo) {
		System.out.println("CalenderService.exeUpdateCalender()");
		System.out.println("CalenderService.calendervo:" + calendervo);

		int count = calenderrepository.calenderUpdate(calendervo);

		return count;
	}

	// 캘린더 이벤트 삭제
	public int exeDeleteCalender(CalenderVO calendervo) {
		System.out.println("CalenderService.exeDeleteCalender()");
		
		int count = calenderrepository.calenderDelete(calendervo);
		
		return count;
	}

}
