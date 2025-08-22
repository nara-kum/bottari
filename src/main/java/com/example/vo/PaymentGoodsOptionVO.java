package com.example.vo;

public class PaymentGoodsOptionVO {
	//field
	private int payment_goods_option_no;
	private int payment_goods_no;
	private int detailoprion_no;
	//editor
	public PaymentGoodsOptionVO(int payment_goods_option_no, int payment_goods_no, int detailoprion_no) {
		super();
		this.payment_goods_option_no = payment_goods_option_no;
		this.payment_goods_no = payment_goods_no;
		this.detailoprion_no = detailoprion_no;
	}
	public PaymentGoodsOptionVO() {
		super();
	}
	//method g/s
	public int getPayment_goods_option_no() {
		return payment_goods_option_no;
	}
	public void setPayment_goods_option_no(int payment_goods_option_no) {
		this.payment_goods_option_no = payment_goods_option_no;
	}
	public int getPayment_goods_no() {
		return payment_goods_no;
	}
	public void setPayment_goods_no(int payment_goods_no) {
		this.payment_goods_no = payment_goods_no;
	}
	public int getDetailoprion_no() {
		return detailoprion_no;
	}
	public void setDetailoprion_no(int detailoprion_no) {
		this.detailoprion_no = detailoprion_no;
	}
	//method normal
	@Override
	public String toString() {
		return "PaymentGoodsOptionVO [payment_goods_option_no=" + payment_goods_option_no + ", payment_goods_no="
				+ payment_goods_no + ", detailoprion_no=" + detailoprion_no + "]";
	}
}
