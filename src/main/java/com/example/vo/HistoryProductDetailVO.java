package com.example.vo;

public class HistoryProductDetailVO {
	//field
	private int payment_no;
	private String brand;
	private String title;
	private int price;
	private int quantity;
	private String detailoption_name;
	private String option_name;
	private int total_amount;
	//editor
	public HistoryProductDetailVO(int payment_no, String brand, String title, int price, int quantity,
			String detailoption_name, String option_name, int total_amount) {
		super();
		this.payment_no = payment_no;
		this.brand = brand;
		this.title = title;
		this.price = price;
		this.quantity = quantity;
		this.detailoption_name = detailoption_name;
		this.option_name = option_name;
		this.total_amount = total_amount;
	}
	public HistoryProductDetailVO() {
		super();
	}
	//method g/s
	public int getPayment_no() {
		return payment_no;
	}
	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getDetailoption_name() {
		return detailoption_name;
	}
	public void setDetailoption_name(String detailoption_name) {
		this.detailoption_name = detailoption_name;
	}
	public String getOption_name() {
		return option_name;
	}
	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}
	public int getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}
	//method normal
	@Override
	public String toString() {
		return "HistoryProductDetailVO [payment_no=" + payment_no + ", brand=" + brand + ", title=" + title + ", price="
				+ price + ", quantity=" + quantity + ", detailoption_name=" + detailoption_name + ", option_name="
				+ option_name + ", total_amount=" + total_amount + "]";
	}
}
