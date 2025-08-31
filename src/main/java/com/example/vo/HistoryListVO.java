package com.example.vo;

import java.util.List;

public class HistoryListVO {
	//field
	private int payment_no;
	private int order_no;			// 주분번호
	private Integer funding_no;			// 펀딩번호
	private String payment_date;	// 결제일
	private int final_amount;		// 총 결제금액
	private String delivery_status;	// 배송 상태
	private String service_type;	// 서비스 타입
	private int count;				// 같은 주문건 수
	private List<HistoryProductDetailVO> productDetailList;	// 제품 세부 리스트
	private List<HistoryFundingDetailVO> fundingDetailList;	// 제품 펀딩 세부 리스트
	//editor
	public HistoryListVO(int payment_no, int order_no, Integer funding_no, String payment_date, int final_amount,
			String delivery_status, String service_type, int count, List<HistoryProductDetailVO> productDetailList,
			List<HistoryFundingDetailVO> fundingDetailList) {
		super();
		this.payment_no = payment_no;
		this.order_no = order_no;
		this.funding_no = funding_no;
		this.payment_date = payment_date;
		this.final_amount = final_amount;
		this.delivery_status = delivery_status;
		this.service_type = service_type;
		this.count = count;
		this.productDetailList = productDetailList;
		this.fundingDetailList = fundingDetailList;
	}
	public HistoryListVO() {
		super();
	}
	//method g/s
	public int getPayment_no() {
		return payment_no;
	}
	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
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
	public int getFinal_amount() {
		return final_amount;
	}
	public void setFinal_amount(int final_amount) {
		this.final_amount = final_amount;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}
	public String getService_type() {
		return service_type;
	}
	public void setService_type(String service_type) {
		this.service_type = service_type;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
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
		return "HistoryListVO [payment_no=" + payment_no + ", order_no=" + order_no + ", funding_no=" + funding_no
				+ ", payment_date=" + payment_date + ", final_amount=" + final_amount + ", delivery_status="
				+ delivery_status + ", service_type=" + service_type + ", count=" + count + ", productDetailList="
				+ productDetailList + ", fundingDetailList=" + fundingDetailList + "]";
	}
}
