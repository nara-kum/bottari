package com.example.vo;

public class HistoryVO {
	//field
	private String payment_date;
	private int product_no;
	private int fundingproduct_no;
	private int order_no;
	private int payment_amount;
	private int quantity;
	private String title;
	private String brand;
	private int price;
	private int percent;
	private int amount;
	//editor
	public HistoryVO(String payment_date, int product_no, int fundingproduct_no, int order_no, int payment_amount,
			int quantity, String title, String brand, int price, int percent, int amount) {
		super();
		this.payment_date = payment_date;
		this.product_no = product_no;
		this.fundingproduct_no = fundingproduct_no;
		this.order_no = order_no;
		this.payment_amount = payment_amount;
		this.quantity = quantity;
		this.title = title;
		this.brand = brand;
		this.price = price;
		this.percent = percent;
		this.amount = amount;
	}
	public HistoryVO() {
		super();
	}
	//method g/s
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getFundingproduct_no() {
		return fundingproduct_no;
	}
	public void setFundingproduct_no(int fundingproduct_no) {
		this.fundingproduct_no = fundingproduct_no;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public int getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(int payment_amount) {
		this.payment_amount = payment_amount;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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
	//method normal
	@Override
	public String toString() {
		return "HistoryVO [payment_date=" + payment_date + ", product_no=" + product_no + ", fundingproduct_no="
				+ fundingproduct_no + ", order_no=" + order_no + ", payment_amount=" + payment_amount + ", quantity="
				+ quantity + ", title=" + title + ", brand=" + brand + ", price=" + price + ", percent=" + percent
				+ ", amount=" + amount + "]";
	}
}
