package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.CalenderRepository;
import com.example.vo.CalenderVO;

@Service
public class CalenderService {
	//field
	@Autowired
	private CalenderRepository calenderrepository;
	//editor
	
	//method g/s
	
	//method normal
	
	//캘린더 리스트
	public List<CalenderVO> exeCalenderList() {
		System.out.println("CalenderService.exeCalenderList()");
		
		List<CalenderVO> calenderList = calenderrepository.calenderAddList();
		
		return calenderList;
	}
	
	//캘린더 이벤트 등록
	public int exeInsertCalender(CalenderVO calendervo) {
		System.out.println("CalenderService.exeCalenderInsert()");
//		System.out.println("CalenderService.calendervo:" + calendervo);
		
		int count = calenderrepository.calenderInsert(calendervo);
		
		return count;
	}
	
	//캘린더 이벤트 수정
	public int exeUpdateCalender(CalenderVO calendervo) {
		System.out.println("CalenderService.exeUpdateCalender()");
		System.out.println("CalenderService.calendervo:" + calendervo);
		
		int count = calenderrepository.calenderUpdate(calendervo);
		
		return count;
	}
	
	//캘린더 이벤트 삭제
	
}
