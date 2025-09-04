package com.example.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.HistoryRepository;
import com.example.vo.HistoryFundingCheckVO;
import com.example.vo.HistoryFundingDetailVO;
import com.example.vo.HistoryListVO;
import com.example.vo.HistoryProductDetailVO;
import com.example.vo.HistoryVO;

@Service
public class HistoryService {
	// field
	@Autowired
	private HistoryRepository historyrepository;
	// editor

	// method g/s

	// method normal
	public Map<String, List<HistoryListVO>> exeHistoryList(int user_no) {
		System.out.println("HistoryService.exeHistoryList()");

		List<HistoryListVO> historyPaymentList = historyrepository.historyaddList(user_no);
		System.out.println("repository에서 리스트 받아오기 성공");
		System.out.println("historyPaymentList: " + historyPaymentList);

		if (historyPaymentList.isEmpty()) {
			System.out.println("출력할 히스토리 리스트 없음");
			return Collections.emptyMap();
		} else {
			// 일반 결제 데이터 처리
			List<Integer> paymentNoList = historyPaymentList.stream().map(HistoryListVO::getPayment_no)
					.collect(Collectors.toList());

			System.out.println(paymentNoList);
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
		Map<String, List<HistoryListVO>> groupedByDate = historyPaymentList.stream()
				.collect(Collectors.groupingBy(h -> h.getPayment_date().substring(0, 10)));

		return groupedByDate;
	}

	public List<HistoryVO> exeHistoryDetail(int order_no) {
		System.out.println("HistoryService.exeHistoryDetail()");

		List<HistoryVO> historyDetailList = historyrepository.historyDetailAdd(order_no);
		System.out.println("HistoryService.exeHistoryDetail()");
		System.out.println("repository에서 데이터 전달 받음");
		System.out.println("historyDetailList: " + historyDetailList);

		int funding_no = historyDetailList.get(0).getFunding_no();
		System.out.println("funding_no: " + funding_no);

		return historyDetailList;
	}

	// 펀딩된 상품 상세보기
	public List<HistoryFundingCheckVO> execheckFundingData(int funding_no) {
		System.out.println("HistoryService.execheckFundingData()");

		List<HistoryFundingCheckVO> percentList = historyrepository.selectFundingPercent(funding_no);
		System.out.println("HistoryService.execheckFundingData()");
		System.out.println("repository에서 데이터 받아오기 성공");
		System.out.println("percentList: " + percentList);

		String funding_status = percentList.get(0).getFunding_status();

		HistoryFundingCheckVO percentvo = new HistoryFundingCheckVO();
		List<HistoryFundingCheckVO> finalpercentList = new ArrayList<>();

		switch (funding_status) {
		
		//펀딩이 완료된 경우
		case "done":
			for (int i = 0; i < percentList.size(); i++) {
				if (percentList.get(i).getPayment_status().equals("paid")) {
					percentvo.setFunding_no(percentList.get(i).getFunding_no());
					percentvo.setFunding_status(percentList.get(i).getFunding_status());
					percentvo.setPercent(percentList.get(i).getPercent());
					percentvo.setQuantity(percentList.get(i).getQuantity());
					percentvo.setTotal_percent(percentList.get(i).getTotal_percent());
				}

				finalpercentList.add(percentvo);
			}
			System.out.println("finalpercentList에 답기 성공");
			System.out.println("finalpercentList: " + finalpercentList);

			break;
		
		// 펀딩이 중단된 경우
		case "stop":
			for (int i = 0; i < percentList.size(); i++) {
				percentvo.setFunding_no(percentList.get(i).getFunding_no());
				percentvo.setFunding_status(percentList.get(i).getFunding_status());
				percentvo.setPercent(percentList.get(i).getPercent());
				percentvo.setQuantity(percentList.get(i).getQuantity());
				percentvo.setTotal_percent(percentList.get(i).getTotal_percent());

				finalpercentList.add(percentvo);
			}

			System.out.println("finalpercentList에 답기 성공");
			System.out.println("finalpercentList: " + finalpercentList);

			break;

		// 펀딩이 진행중인 경우
		case "ing":
			for (int i = 0; i < percentList.size(); i++) {

				if (percentList.get(i).getPayment_status().equals("paid")) {
					percentvo.setFunding_no(percentList.get(i).getFunding_no());
					percentvo.setFunding_status(percentList.get(i).getFunding_status());
					percentvo.setPercent(percentList.get(i).getPercent());
					percentvo.setQuantity(percentList.get(i).getQuantity());
					percentvo.setTotal_percent(percentList.get(i).getTotal_percent());
				}

				finalpercentList.add(percentvo);
			}
			System.out.println("finalpercentList에 답기 성공");
			System.out.println("finalpercentList: " + finalpercentList);

			break;
		}

		return finalpercentList;
	}
}
