package com.example.vo;

public class CheckOutVO {
	//field
	// cart section
	private int cart_no;
	private int user_no;
	private int product_no;
	private int quantity;
	
	// cart_option section
	private int detailoption_no;
	
	// product section
	private String title;
	private int price;
	private String brand;
	private String itemimg;
	private int shipping_cost;
	
	// product_option section
	private int option_no;
	private String option_name;
	
	// option_detail section
	private String detailoption_name;
	
	//total section
	private int total_quantity;
	private int total_price;
	private int total_amount;
	//editor
	public CheckOutVO(int cart_no, int user_no ,int product_no, int quantity, int detailoption_no, String title, int price,
			String brand, String itemimg, int shipping_cost, int option_no, String option_name, String detailoption_name,
			int total_quantity, int total_price, int total_amount) {
		super();
		this.cart_no = cart_no;
		this.user_no = user_no;
		this.product_no = product_no;
		this.quantity = quantity;
		this.detailoption_no = detailoption_no;
		this.title = title;
		this.price = price;
		this.brand = brand;
		this.itemimg = itemimg;
		this.shipping_cost = shipping_cost;
		this.option_no = option_no;
		this.option_name = option_name;
		this.detailoption_name = detailoption_name;
		this.total_quantity = total_quantity;
		this.total_price = total_price;
		this.total_amount = total_amount;
	}
	public CheckOutVO() {
		super();
	}
	//method g/s
	public int getCart_no() {
		return cart_no;
	}
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getDetailoption_no() {
		return detailoption_no;
	}
	public void setDetailoption_no(int detailoption_no) {
		this.detailoption_no = detailoption_no;
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
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getItemimg() {
		return itemimg;
	}
	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}
	public int getShipping_cost() {
		return shipping_cost;
	}
	public void setShipping_cost(int shipping_cost) {
		this.shipping_cost = shipping_cost;
	}
	public int getOption_no() {
		return option_no;
	}
	public void setOption_no(int option_no) {
		this.option_no = option_no;
	}
	public String getOption_name() {
		return option_name;
	}
	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}
	public String getDetailoption_name() {
		return detailoption_name;
	}
	public void setDetailoption_name(String detailoption_name) {
		this.detailoption_name = detailoption_name;
	}
	public int getTotal_quantity() {
		return total_quantity;
	}
	public void setTotal_quantity(int total_quantity) {
		this.total_quantity = total_quantity;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
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
		return "CheckOutVO [cart_no=" + cart_no + ", product_no=" + product_no + ", quantity=" + quantity
				+ ", detailoption_no=" + detailoption_no + ", title=" + title + ", price=" + price + ", brand=" + brand
				+ ", itemimg=" + itemimg + ", option_no=" + option_no + ", option_name=" + option_name
				+ ", detailoption_name=" + detailoption_name + ", total_quantity=" + total_quantity + ", total_price="
				+ total_price + ", total_amount=" + total_amount + "]";
	}
}
