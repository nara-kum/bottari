package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.HistoryRepository;
import com.example.vo.HistoryVO;

@Service
public class HistoryService {
	//field
	@Autowired
	private HistoryRepository historyrepository;
	//editor
		
	//method g/s
		
	//method normal
	public List<HistoryVO> exeHistoryList(int user_no) {
		System.out.println("HistoryService.exeHistoryList()");
		
		List<HistoryVO> historyList = historyrepository.historyaddList(user_no);
		
		return historyList;
	}
}
