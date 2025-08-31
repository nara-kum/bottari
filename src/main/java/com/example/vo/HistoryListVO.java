package com.example.vo;

import java.util.List;

public class HistoryListVO {
	//field
	private int user_no;
	private int payment_no;
	private Integer funding_no;
	private String payment_date;	// 결제일
	private List<HistoryProductDetailVO> productDetailList;	// 제품 세부 리스트
	private List<HistoryFundingDetailVO> fundingDetailList;	// 제품 펀딩 세부 리스트
	//editor
	public HistoryListVO(int user_no, int payment_no, int funding_no, String payment_date,
			List<HistoryProductDetailVO> productDetailList, List<HistoryFundingDetailVO> fundingDetailList) {
		super();
		this.user_no = user_no;
		this.payment_no = payment_no;
		this.funding_no = funding_no;
		this.payment_date = payment_date;
		this.productDetailList = productDetailList;
		this.fundingDetailList = fundingDetailList;
	}
	public HistoryListVO() {
		super();
	}
	//method g/s
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getPayment_no() {
		return payment_no;
	}
	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}
	public Integer getFunding_no() {
		return funding_no;
	}
	public void setFunding_no(Integer funding_no) {
		this.funding_no = funding_no;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public List<HistoryProductDetailVO> getProductDetailList() {
		return productDetailList;
	}
	public void setProductDetailList(List<HistoryProductDetailVO> productDetailList) {
		this.productDetailList = productDetailList;
	}
	public List<HistoryFundingDetailVO> getFundingDetailList() {
		return fundingDetailList;
	}
	public void setFundingDetailList(List<HistoryFundingDetailVO> fundingDetailList) {
		this.fundingDetailList = fundingDetailList;
	}
	//method normal
	@Override
	public String toString() {
		return "HistoryListVO [user_no=" + user_no + ", payment_no=" + payment_no + ", funding_no=" + funding_no
				+ ", payment_date=" + payment_date + ", productDetailList=" + productDetailList + ", fundingDetailList="
				+ fundingDetailList + "]";
	}
}
