package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.HistoryFundingDetailVO;
import com.example.vo.HistoryListVO;
import com.example.vo.HistoryProductDetailVO;
import com.example.vo.HistoryVO;

@Repository
public class HistoryRepository {
	//field
	@Autowired
	private SqlSession sqlsession;
	//editor
	
	//method g/s
	
	//method normal
	public List<HistoryListVO> historyaddList(int user_no) {
		System.out.println("HistoryRepository.historyaddList()");
		
		List<HistoryListVO> historyPaymentList = sqlsession.selectList("history.searchPaymentList", user_no);
		System.out.println("mybatis(searchPaymentList) 조회 완료");
		System.out.println(historyPaymentList);
		
		return historyPaymentList;
	}
	
	public List<HistoryProductDetailVO> selectDetailList(List<Integer> paymentNoList) {
		System.out.println("HistoryRepository.selectDetailList()");
		
		List<HistoryProductDetailVO> productDetailList = sqlsession.selectList("history.searchDetailList", paymentNoList);
		System.out.println("mybatis(searchDetailList) 조회 완료");
		
		return productDetailList;
	}
	
	public List<HistoryFundingDetailVO> selectFundingList(List<Integer> fundingNoList) {
		System.out.println("HistoryRepository.selectFundingList()");
		
		List<HistoryFundingDetailVO> fundingDetailList = sqlsession.selectList("history.searchFundingDetail", fundingNoList);
		System.out.println("mybatis(searchFundingDetail) 조회 완료");
		
		return fundingDetailList;
	}
	
	public List<HistoryVO> historyDetailAdd(int order_no) {
		System.out.println("HistoryRepository.historyDetailAdd()");
		
		List<HistoryVO> historyDetailList = sqlsession.selectList("history.selectHistoryDetail", order_no);
		System.out.println("HistoryRepository.historyDetailAdd()");
		System.out.println("Mybatis에서 데이터 조회 성공)");
		
		return historyDetailList;
	}
}
