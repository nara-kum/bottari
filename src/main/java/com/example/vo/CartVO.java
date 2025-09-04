package com.example.vo;

public class CartVO {

	//필드
	private int cart_no;
	private int user_no;
	private int product_no;
	private int category_no;
	private String registration_date;
	private int quantity;

	
	//생성자
	public CartVO() {
		super();
	}


	public CartVO(int cart_no, int user_no, int product_no, int category_no, String registration_date, int quantity) {
		super();
		this.cart_no = cart_no;
		this.user_no = user_no;
		this.product_no = product_no;
		this.category_no = category_no;
		this.registration_date = registration_date;
		this.quantity = quantity;
	}


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


	public int getCategotry_no() {
		return category_no;
	}


	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}


	public String getRegistration_date() {
		return registration_date;
	}


	public void setRegistration_date(String registration_date) {
		this.registration_date = registration_date;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	@Override
	public String toString() {
		return "CartVO [cart_no=" + cart_no + ", user_no=" + user_no + ", product_no=" + product_no + ", category_no="
				+ category_no + ", registration_date=" + registration_date + ", quantity=" + quantity + "]";
	}
	
	
	
}
