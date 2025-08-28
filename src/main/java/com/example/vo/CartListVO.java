package com.example.vo;

import java.util.List;

public class CartListVO {
	//field
	
	//cart section
	private int cart_no;
	private int user_no;
	private int product_no;
	private int quantity;
	
	//product section
	private String title;
	private String brand;
	private String itemimg;
	private int price;
	private String shipping_cost;
	
	//cart_option section
	private int detailoption_no;
	
	//nestedOptions section
	private List<OptionVO> options;
	
	//total section
	private int total_quantity;
	private int total_price;
	
	//editor
	public CartListVO(int cart_no, int user_no, int product_no, int quantity, String title, String brand,
			String itemimg, int price, String shipping_cost, int detailoption_no, List<OptionVO> options,
			int total_quantity, int total_price) {
		super();
		this.cart_no = cart_no;
		this.user_no = user_no;
		this.product_no = product_no;
		this.quantity = quantity;
		this.title = title;
		this.brand = brand;
		this.itemimg = itemimg;
		this.price = price;
		this.shipping_cost = shipping_cost;
		this.detailoption_no = detailoption_no;
		this.options = options;
		this.total_quantity = total_quantity;
		this.total_price = total_price;
	}

	public CartListVO() {
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

	public String getItemimg() {
		return itemimg;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public int getPrice() {
		return price;
	}

	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}

	public String getShipping_cost() {
		return shipping_cost;
	}

	public void setShipping_cost(String shipping_cost) {
		this.shipping_cost = shipping_cost;
	}

	public int getDetailoption_no() {
		return detailoption_no;
	}

	public void setDetailoption_no(int detailoption_no) {
		this.detailoption_no = detailoption_no;
	}

	public List<OptionVO> getOptions() {
		return options;
	}

	public void setOptions(List<OptionVO> options) {
		this.options = options;
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
	//method normal
	@Override
	public String toString() {
		return "CartListVO [cart_no=" + cart_no + ", user_no=" + user_no + ", product_no=" + product_no + ", quantity="
				+ quantity + ", title=" + title + ", brand=" + brand + ", itemimg=" + itemimg + ", price=" + price
				+ ", shipping_cost=" + shipping_cost + ", detailoption_no=" + detailoption_no + ", options=" + options
				+ ", total_quantity=" + total_quantity + ", total_price=" + total_price + "]";
	}
}
