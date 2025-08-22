package com.example.vo;

public class PaymentGoodsVO {
	//field
	private int payment_goods_no;
	private int payment_no;
	private int product_no;
	private int quantity;
	//editor
	public PaymentGoodsVO(int payment_goods_no, int payment_no, int product_no, int quantity) {
		super();
		this.payment_goods_no = payment_goods_no;
		this.payment_no = payment_no;
		this.product_no = product_no;
		this.quantity = quantity;
	}
	public PaymentGoodsVO() {
		super();
	}
	//method g/s
	public int getPayment_goods_no() {
		return payment_goods_no;
	}
	public void setPayment_goods_no(int payment_goods_no) {
		this.payment_goods_no = payment_goods_no;
	}
	public int getPayment_no() {
		return payment_no;
	}
	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
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
	//method normal
	@Override
	public String toString() {
		return "PaymentGoodsVO [payment_goods_no=" + payment_goods_no + ", payment_no=" + payment_no + ", product_no="
				+ product_no + ", quantity=" + quantity + "]";
	}
}
