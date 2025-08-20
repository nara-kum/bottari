package com.example.vo;

public class FundingProductVO {
	//field
	private int funding_no;
	private int event_no;
	private int product_no;
	private String funding_option;
	private String funding_status;
	private String funding_date;
	//editor
	public FundingProductVO(int funding_no, int event_no, int product_no, String funding_option, String funding_status,
			String funding_date) {
		super();
		this.funding_no = funding_no;
		this.event_no = event_no;
		this.product_no = product_no;
		this.funding_option = funding_option;
		this.funding_status = funding_status;
		this.funding_date = funding_date;
	}
	public FundingProductVO() {
		super();
	}
	//method g/s
	public int getFunding_no() {
		return funding_no;
	}
	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public String getFunding_option() {
		return funding_option;
	}
	public void setFunding_option(String funding_option) {
		this.funding_option = funding_option;
	}
	public String getFunding_status() {
		return funding_status;
	}
	public void setFunding_status(String funding_status) {
		this.funding_status = funding_status;
	}
	public String getFunding_date() {
		return funding_date;
	}
	public void setFunding_date(String funding_date) {
		this.funding_date = funding_date;
	}
	//method normal
	@Override
	public String toString() {
		return "FundingProductVO [funding_no=" + funding_no + ", event_no=" + event_no + ", product_no=" + product_no
				+ ", funding_option=" + funding_option + ", funding_status=" + funding_status + ", funding_date="
				+ funding_date + "]";
	}
}
