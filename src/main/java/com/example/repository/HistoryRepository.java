package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.HistoryVO;

@Repository
public class HistoryRepository {
	//field
	@Autowired
	private SqlSession sqlsession;
	//editor
	
	//method g/s
	
	//method normal
	public List<HistoryVO> historyaddList(int user_no) {
		System.out.println("HistoryRepository.historyaddList()");
		
		List<HistoryVO> historyList = sqlsession.selectList("history.addList", user_no);
		
		return historyList;
	}
}
