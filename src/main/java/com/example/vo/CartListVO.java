package com.example.vo;

public class CartListVO {
	//field
	
	// cart section
	private int cart_no;
	private int category_no;
	private String Registration_date;
	private int quantity;
	
	//product section
	private int product_no;
	private String title;
	private String brand;
	private int price;
	private int shipping_cost;
	private String itemimg;
	
	//product option section
	private int option_no;
	private String option_name;
	
	//cart_option section
	private int cartoption_no;
	private int detailoption_no;
	
	//option_detail section
	private String detailoption_name;
	//editor
	public CartListVO() {
		super();
	}
	public CartListVO(int cart_no, int category_no, String registration_date, int quantity, int product_no, String title,
			String brand, int price, int shipping_cost, String itemimg, int option_no, String option_name,
			int cartoption_no, int detailoption_no, String detailoption_name) {
		super();
		this.cart_no = cart_no;
		this.category_no = category_no;
		Registration_date = registration_date;
		this.quantity = quantity;
		this.product_no = product_no;
		this.title = title;
		this.brand = brand;
		this.price = price;
		this.shipping_cost = shipping_cost;
		this.itemimg = itemimg;
		this.option_no = option_no;
		this.option_name = option_name;
		this.cartoption_no = cartoption_no;
		this.detailoption_no = detailoption_no;
		this.detailoption_name = detailoption_name;
	}
	//method g/s
	public int getCart_no() {
		return cart_no;
	}
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}
	public int getCategory_no() {
		return category_no;
	}
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	public String getRegistration_date() {
		return Registration_date;
	}
	public void setRegistration_date(String registration_date) {
		Registration_date = registration_date;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
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
	public int getShipping_cost() {
		return shipping_cost;
	}
	public void setShipping_cost(int shipping_cost) {
		this.shipping_cost = shipping_cost;
	}
	public String getItemimg() {
		return itemimg;
	}
	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
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
	public int getCartoption_no() {
		return cartoption_no;
	}
	public void setCartoption_no(int cartoption_no) {
		this.cartoption_no = cartoption_no;
	}
	public int getDetailoption_no() {
		return detailoption_no;
	}
	public void setDetailoption_no(int detailoption_no) {
		this.detailoption_no = detailoption_no;
	}
	public String getDetailoption_name() {
		return detailoption_name;
	}
	public void setDetailoption_name(String detailoption_name) {
		this.detailoption_name = detailoption_name;
	}
	//method normal
	@Override
	public String toString() {
		return "CartListVO [cart_no=" + cart_no + ", category_no=" + category_no + ", Registration_date="
				+ Registration_date + ", quantity=" + quantity + ", product_no=" + product_no + ", title=" + title
				+ ", brand=" + brand + ", itemimg=" + itemimg + ", option_no=" + option_no + ", option_name="
				+ option_name + ", cartoption_no=" + cartoption_no + ", detailoption_no=" + detailoption_no
				+ ", detailoption_name=" + detailoption_name + "]";
	}
}
