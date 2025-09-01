package com.example.vo;

public class HistoryFundingCheckVO {
	//field
	private int funding_no;
	private int percent;
	private int quantity;
	private int total_percent;
	//editor
	public HistoryFundingCheckVO(int funding_no, int percent, int quantity, int total_percent) {
		super();
		this.funding_no = funding_no;
		this.percent = percent;
		this.quantity = quantity;
		this.total_percent = total_percent;
	}
	public HistoryFundingCheckVO() {
		super();
	}
	//method g/s
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
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotal_percent() {
		return total_percent;
	}
	public void setTotal_percent(int total_percent) {
		this.total_percent = total_percent;
	}
	//method normal
	@Override
	public String toString() {
		return "HistoryFundingCheckVO [funding_no=" + funding_no + ", percent=" + percent + ", quantity=" + quantity
				+ ", total_percent=" + total_percent + "]";
	}
}
