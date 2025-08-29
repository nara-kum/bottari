package com.example.vo;

public class CheckoutFundingVO {
	//field
	
	// funding section
	private int funding_no;
	private int product_no;
	private int percent;
	private int amount;
	private String funding_status;
	
	// funding_option section
	private int detailoption_no;
	
	// option_detail section
	private String detailpotion_name;
	
	// product section
	private String title;
	private String brand;
	private int price;
	private String itemimg;
	//editor
	public CheckoutFundingVO() {
		super();
	}
	public CheckoutFundingVO(int funding_no, int product_no, int percent, int amount, String funding_status,
			int detailoption_no, String detailpotion_name, String title, String brand, int price, String itemimg) {
		super();
		this.funding_no = funding_no;
		this.product_no = product_no;
		this.percent = percent;
		this.amount = amount;
		this.funding_status = funding_status;
		this.detailoption_no = detailoption_no;
		this.detailpotion_name = detailpotion_name;
		this.title = title;
		this.brand = brand;
		this.price = price;
		this.itemimg = itemimg;
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
	public int getDetailoption_no() {
		return detailoption_no;
	}
	public void setDetailoption_no(int detailoption_no) {
		this.detailoption_no = detailoption_no;
	}
	public String getDetailpotion_name() {
		return detailpotion_name;
	}
	public void setDetailpotion_name(String detailpotion_name) {
		this.detailpotion_name = detailpotion_name;
	}
	public String getItemimg() {
		return itemimg;
	}
	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}
	//method normal
	@Override
	public String toString() {
		return "CheckoutFundingVO [funding_no=" + funding_no + ", product_no=" + product_no + ", percent=" + percent
				+ ", amount=" + amount + ", funding_status=" + funding_status + ", detailoption_no=" + detailoption_no
				+ ", detailpotion_name=" + detailpotion_name + ", title=" + title + ", brand=" + brand + ", price="
				+ price + ", itemimg=" + itemimg + "]";
	}
	
}
