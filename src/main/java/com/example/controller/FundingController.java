package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FundingController {

	// 펀딩리스트
	@RequestMapping(value = "funding/my", method = { RequestMethod.GET, RequestMethod.POST })
	public String myfunding() {
		System.out.println("fundingController.myfunding");

		return "funding/myFunding";
	}

	// 친펀딩리스트
	@RequestMapping(value = "funding/friend", method = { RequestMethod.GET, RequestMethod.POST })
	public String friendFunding() {
		System.out.println("fundingController.myfunding");

		return "funding/friendFunding";
	}

}
