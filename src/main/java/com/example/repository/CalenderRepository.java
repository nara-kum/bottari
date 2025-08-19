package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CalenderVO;

@Repository
public class CalenderRepository {
	//field
	@Autowired
	private SqlSession sqlsession;
	//editor
	
	//method g/s
	
	//method normal
	
	//캘린더 리스트
	public List<CalenderVO> calenderAddList() {
		System.out.println("CalenderRepository.addList()");
		
		List<CalenderVO> calenderList = sqlsession.selectList("calender.selectList");
		
		return calenderList;
	}
	
	//캘린더 이벤트 추가
	public int calenderInsert(CalenderVO calendervo) {
		System.out.println("CalenderRepository.calenderInsert()");
//		System.out.println("CalenderRepository.calendervo" + calendervo);
		
		int count = sqlsession.insert("calender.insert",calendervo);
		
		return count;
	}
	
	//캘린더 이벤트 수정
	public int calenderUpdate(CalenderVO calendervo) {
		System.out.println("CalenderRepository.calenderUpdate()");
		
		System.out.println("CalenderRepository.calndervo:" + calendervo);
		
		int count = sqlsession.update("calender.update",calendervo);
		
		return count;
	}
	
	//캘린더 이벤트 삭제
}
