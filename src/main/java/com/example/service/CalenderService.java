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
	public List<CalenderVO> exeCalenderList() {
		System.out.println("CalenderService.exeCalenderList()");
		
		List<CalenderVO> calenderList = calenderrepository.calenderAddList();
		
		return calenderList;
	}
}
