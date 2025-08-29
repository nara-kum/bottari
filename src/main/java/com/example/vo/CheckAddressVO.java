package com.example.vo;

public class CheckAddressVO {
	//field
	private int product_no;
	private String shipping_yn;
	private String zipcode;
	private String address;
	private String detail_address;
	//editor
	public CheckAddressVO(int product_no, String shipping_yn, String zipcode, String address, String detail_address) {
		super();
		this.product_no = product_no;
		this.shipping_yn = shipping_yn;
		this.zipcode = zipcode;
		this.address = address;
		this.detail_address = detail_address;
	}
	public CheckAddressVO() {
		super();
	}
	//method g/s
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public String getShipping_yn() {
		return shipping_yn;
	}
	public void setShipping_yn(String shipping_yn) {
		this.shipping_yn = shipping_yn;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	//method normal
	@Override
	public String toString() {
		return "CheckAddressVO [product_no=" + product_no + ", shipping_yn=" + shipping_yn + ", zipcode=" + zipcode
				+ ", address=" + address + ", detail_address=" + detail_address + "]";
	}
}
