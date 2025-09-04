package com.example.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.HistoryService;
import com.example.vo.HistoryFundingCheckVO;
import com.example.vo.HistoryListVO;
import com.example.vo.HistoryVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class HistoryController {
	//field
	@Autowired
	private HistoryService historyservice;
	//editor
	
	//method g/s
	
	//method normal
	@RequestMapping(value="/history/list", method= {RequestMethod.GET, RequestMethod.POST})
	public String history(HttpSession session, Model model) {
		System.out.println("HistoryController.history()");
		
		UserVO authuser = (UserVO) session.getAttribute("authUser");
		
		
		if (authuser == null) {
			return "redirect:/loginForm";
		} else {	
			int user_no = authuser.getUserNo();
			System.out.println("user_no: " + user_no);
			
			Map<String, List<HistoryListVO>> historyGroupedMap = historyservice.exeHistoryList(user_no);
			System.out.println("HistoryController.history()");
			System.out.println("service에서 Map 받아오기 성공");
			
			if(historyGroupedMap.isEmpty()) {
				System.out.println("map 비어있음!");
				return "history/history_empty";
			} else {
				System.out.println("map 정보 있음");
				model.addAttribute("hMap", historyGroupedMap);
				
				return "history/history_mine";
			}		
		}	
	}
	
	@RequestMapping(value="/history/detail", method= {RequestMethod.GET, RequestMethod.POST})
	public String historyDetail(HttpSession session, Model model,
			@RequestParam("order_no")int order_no) {
		System.out.println("HistoryController.historyDetail()");
		System.out.println("조회된 order_no: " + order_no);
		
		UserVO authuser = (UserVO) session.getAttribute("authUser");
		
		if(authuser == null) {
			return "user/loginForm" ;
		}
		
		List<HistoryVO> historyDetailList = historyservice.exeHistoryDetail(order_no);
		System.out.println("HistoryController.historyDetail()");
		System.out.println("service에서 데이터 받아오기 성공");
		
		int totalPrice = 0;
		int totalQuantity = 0;
		int totalAmount = 0;
		
		for(int i = 0 ; i<historyDetailList.size() ; i++) {
			int quantity = historyDetailList.get(i).getQuantity();
			int amount = historyDetailList.get(i).getPayment_amount();
			int price = historyDetailList.get(i).getPrice();
			
			totalQuantity += quantity;
			totalAmount += amount;
			totalPrice += price;
		}
		
		String shippingStatus = historyDetailList.get(0).getDelivery_status();
		
		System.out.println("totalQuantity: " + totalQuantity + ", totalAmount: " + totalAmount + ", totalPrice: " + totalPrice);
		
		int funding_no = historyDetailList.get(0).getFunding_no();
		
		if(funding_no != 0) {
			return checkFundingData(historyDetailList, funding_no, model);
		} 
		
		model.addAttribute("hList", historyDetailList);
		model.addAttribute("total_quantity", totalQuantity);
		model.addAttribute("total_amount", totalAmount);
		model.addAttribute("shipping_cost", historyDetailList.get(0).getShipping_cost());
		model.addAttribute("delivery_status", shippingStatus);
		model.addAttribute("total_price", totalPrice);
		model.addAttribute("zipcode", historyDetailList.get(0).getZipcode());
		model.addAttribute("address", historyDetailList.get(0).getAddress());
		model.addAttribute("detail_address", historyDetailList.get(0).getDetail_address());
		
		
		return "history/history_detail";
	}
	
	@RequestMapping(value="/history/detail/funding", method= {RequestMethod.GET, RequestMethod.POST})
	public String checkFundingData(List<HistoryVO> historyDetailList, int funding_no,
			Model model) {
		System.out.println("HistoryController.checkFundingData()");
		
		List<HistoryFundingCheckVO> finalpercentList = historyservice.execheckFundingData(funding_no);
		System.out.println("HistoryController.checkFundingData()");
		System.out.println("service에서 데이터 받아오기 성공");
		System.out.println("percentList: " + finalpercentList);
		
		
		int paid_percent = historyDetailList.get(0).getQuantity()*finalpercentList.get(0).getPercent();
		int total_percent = finalpercentList.get(0).getTotal_percent();
		int total_price = historyDetailList.get(0).getPayment_amount();
		String funding_status = finalpercentList.get(0).getFunding_status();
		
		System.out.println("total_price: " + total_price);
		
		System.out.println(historyDetailList);
		System.out.println(finalpercentList);
		
		model.addAttribute("hList", historyDetailList);
		model.addAttribute("pList", finalpercentList);
		model.addAttribute("total_price", total_price);
		model.addAttribute("total_percent", total_percent);
		model.addAttribute("paid_percent", paid_percent);
		model.addAttribute("funding_status", funding_status);
		
		return "history/history_detail_funding";
	}
}
