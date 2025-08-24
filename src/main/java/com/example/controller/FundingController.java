package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FundingController {

	// 펀딩리스트
	@RequestMapping(value = "/fundinglist", method = { RequestMethod.GET, RequestMethod.POST })
	public String myfunding() {
		System.out.println("fundingController.myfunding");

		return "funding/fundingList";
	}

	// 펀딩등록
	@RequestMapping(value = "/fundingcreation", method = { RequestMethod.GET, RequestMethod.POST })
	public String fundingCreation() {
		System.out.println("fundingController.fundingcreation()");

		return "funding/myfunding";
	}

	// 친펀딩리스트
	@RequestMapping(value = "/friendfundinglist", method = { RequestMethod.GET, RequestMethod.POST })
	public String friendFunding() {
		System.out.println("fundingController.myfunding");

		return "funding/friendfundingList";
	}

}
