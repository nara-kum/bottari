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
	public List<CalenderVO> calenderAddList() {
		System.out.println("CalenderRepository.addList()");
		
		List<CalenderVO> calenderList = sqlsession.selectList("calender.selectList");
		
		return calenderList;
	}
}
