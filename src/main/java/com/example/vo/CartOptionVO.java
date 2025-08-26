package com.example.vo;

public class CartOptionVO {
	//field
	
	//product section
	private int product_no;
	
	//product_option section
	private int option_no;
	private String option_name;
	
	//option_detail section
	private int detailoption_no;
	private String detailoption_name;
	//editor
	public CartOptionVO(int product_no, int option_no, String option_name, int detailoption_no,
			String detailoption_name) {
		super();
		this.product_no = product_no;
		this.option_no = option_no;
		this.option_name = option_name;
		this.detailoption_no = detailoption_no;
		this.detailoption_name = detailoption_name;
	}
	public CartOptionVO() {
		super();
	}
	//method g/s
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
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
		return "CartOptionVO [product_no=" + product_no + ", option_no=" + option_no + ", option_name=" + option_name
				+ ", detailoption_no=" + detailoption_no + ", detailoption_name=" + detailoption_name + "]";
	}
}
