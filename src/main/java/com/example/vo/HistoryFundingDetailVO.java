package com.example.vo;

public class HistoryFundingDetailVO {
	// field
	private int funding_no;
	private int percent;
	private int amount;
	private String funding_status;
	private int total_percent;
	// editor
	public HistoryFundingDetailVO(int funding_no, int percent, int amount, String funding_status, int total_percent) {
		super();
		this.funding_no = funding_no;
		this.percent = percent;
		this.amount = amount;
		this.funding_status = funding_status;
		this.total_percent = total_percent;
	}
	public HistoryFundingDetailVO() {
		super();
	}
	// method g/s
	public int getFunding_no() {
		return funding_no;
	}
	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}
	public int getPercent() {
		return percent;
	}
	public void setPercent(int percent) {
		this.percent = percent;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getFunding_status() {
		return funding_status;
	}
	public void setFunding_status(String funding_status) {
		this.funding_status = funding_status;
	}
	public int getTotal_percent() {
		return total_percent;
	}
	public void setTotal_percent(int total_percent) {
		this.total_percent = total_percent;
	}
	// method normal
	@Override
	public String toString() {
		return "HistoryFundingDetailVO [funding_no=" + funding_no + ", percent=" + percent + ", amount=" + amount
				+ ", funding_status=" + funding_status + ", total_percent=" + total_percent + "]";
	}
}
