package com.example.vo;

public class ProductOptionDetailVO {

	// 필드
	private int detailoption_no;
	private int option_no;
	private String detailoption_name;

	public ProductOptionDetailVO() {
	}

	public ProductOptionDetailVO(int detailoption_no, int option_no, String detailoption_name) {
		this.detailoption_no = detailoption_no;
		this.option_no = option_no;
		this.detailoption_name = detailoption_name;
	}

	public int getDetailoption_no() {
		return detailoption_no;
	}

	public void setDetailoption_no(int detailoption_no) {
		this.detailoption_no = detailoption_no;
	}

	public int getOption_no() {
		return option_no;
	}

	public void setOption_no(int option_no) {
		this.option_no = option_no;
	}

	public String getDetailoption_name() {
		return detailoption_name;
	}

	public void setDetailoption_name(String detailoption_name) {
		this.detailoption_name = detailoption_name;
	}

	@Override
	public String toString() {
		return "ProductOptionDetailVO [detailoption_no=" + detailoption_no + ", option_no=" + option_no
				+ ", detailoption_name=" + detailoption_name + "]";
	}

}
