package com.example.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.HistoryRepository;
import com.example.vo.HistoryFundingDetailVO;
import com.example.vo.HistoryListVO;
import com.example.vo.HistoryProductDetailVO;

@Service
public class HistoryService {
	// field
	@Autowired
	private HistoryRepository historyrepository;
	// editor

	// method g/s

	// method normal
	public List<HistoryListVO> exeHistoryList(int user_no) {
		System.out.println("HistoryService.exeHistoryList()");

		List<HistoryListVO> historyPaymentList = historyrepository.historyaddList(user_no);
		System.out.println("repository에서 리스트 받아오기 성공");
		System.out.println("historyPaymentList: " + historyPaymentList);

		if (historyPaymentList.isEmpty()) {
			return historyPaymentList;
		} else {
			// 일반 결제 데이터 처리
			List<Integer> paymentNoList = historyPaymentList.stream().map(HistoryListVO::getPayment_no)
					.collect(Collectors.toList());

			List<HistoryProductDetailVO> productDetailList = historyrepository.selectDetailList(paymentNoList);
			System.out.println("repository에서 리스트 받아오기 성공");
			System.out.println("productDetailList: " + productDetailList);

			// 펀딩 결제 데이터 처리
			List<Integer> fundingNoList = historyPaymentList.stream().map(HistoryListVO::getFunding_no)
					.filter(Objects::nonNull).collect(Collectors.toList());
			List<HistoryFundingDetailVO> fundingDetailList = new ArrayList<>();

			if (!fundingNoList.isEmpty()) {
				fundingDetailList = historyrepository.selectFundingList(fundingNoList);
				System.out.println("repository에서 리스트 받아오기 성공");
				System.out.println("fundingDetailList: " + fundingDetailList);
			}

			// payment_no 기준 옵션 매핑
			Map<Integer, List<HistoryProductDetailVO>> productMap = productDetailList.stream()
					.collect(Collectors.groupingBy(HistoryProductDetailVO::getPayment_no));
			// funding_no 기준으로 fundingDetail 매핑
			Map<Integer, List<HistoryFundingDetailVO>> fundingMap = fundingDetailList.stream()
					.collect(Collectors.groupingBy(HistoryFundingDetailVO::getFunding_no));

			// HistoryListVO에 세부 리스트 세팅
			for (HistoryListVO history : historyPaymentList) {
				// 일반상품 세팅
				history.setProductDetailList(productMap.getOrDefault(history.getPayment_no(), new ArrayList<>()));

				// 펀딩상품 세팅 (funding_no가 있는 경우만)
				if (history.getFunding_no() != null) {
					history.setFundingDetailList(fundingMap.getOrDefault(history.getFunding_no(), new ArrayList<>()));
				} else {
					history.setFundingDetailList(new ArrayList<>());
				}
			}

		}

		return historyPaymentList;
	}
}
