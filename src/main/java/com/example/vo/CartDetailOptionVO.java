package com.example.vo;

public class CartDetailOptionVO {
	
	
	//필드
	private int cartoption_no;
	private int cart_no;
	private int detailoption_no;
	
	//생성자
	public CartDetailOptionVO() {
		super();
	}


	public CartDetailOptionVO(int cartoption_no, int cart_no, int detailoption_no) {
		super();
		this.cartoption_no = cartoption_no;
		this.cart_no = cart_no;
		this.detailoption_no = detailoption_no;
	}


	//메소드gs
	public int getCartoption_no() {
		return cartoption_no;
	}


	public void setCartoption_no(int cartoption_no) {
		this.cartoption_no = cartoption_no;
	}


	public int getCart_no() {
		return cart_no;
	}


	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}


	public int getDetailoption_no() {
		return detailoption_no;
	}


	public void setDetailoption_no(int detailoption_no) {
		this.detailoption_no = detailoption_no;
	}


	//메소드일반
	@Override
	public String toString() {
		return "CartDetailOption [cartoption_no=" + cartoption_no + ", cart_no=" + cart_no + ", detailoption_no="
				+ detailoption_no + "]";
	}
	
	
	

}
