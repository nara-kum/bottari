package com.example.vo;

public class CheckoutFundingVO {
	//field
	private int funding_no;
	private int product_no;
	private int percent;
	private int amount;
	private String funding_status;
	private String title;
	private String brand;
	private int price;
	//editor
	public CheckoutFundingVO(int funding_no, int product_no, int percent, int amount, String funding_status,
			String title, String brand, int price) {
		super();
		this.funding_no = funding_no;
		this.product_no = product_no;
		this.percent = percent;
		this.amount = amount;
		this.funding_status = funding_status;
		this.title = title;
		this.brand = brand;
		this.price = price;
	}
	public CheckoutFundingVO() {
		super();
	}
	//method g/s
	public int getFunding_no() {
		return funding_no;
	}
	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
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
	//method normal
	@Override
	public String toString() {
		return "CheckoutFundingVO [funding_no=" + funding_no + ", product_no=" + product_no + ", percent=" + percent
				+ ", amount=" + amount + ", funding_status=" + funding_status + ", title=" + title + ", brand=" + brand
				+ ", price=" + price + "]";
	}
}
