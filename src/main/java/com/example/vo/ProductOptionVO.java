package com.example.vo;

public class ProductOptionVO {
	
	//필드
	private int option_no;
	private int product_no;
	private int detailOPtion_no;
	private String option_name;
	private String detailOPtion_name;
	
	
	//생성자
	public ProductOptionVO() {
		super();
	}


	public ProductOptionVO(int option_no, int product_no, int detailOPtion_no, String option_name,
			String detailOPtion_name) {
		super();
		this.option_no = option_no;
		this.product_no = product_no;
		this.detailOPtion_no = detailOPtion_no;
		this.option_name = option_name;
		this.detailOPtion_name = detailOPtion_name;
	}


	//메소드gs
	public int getOption_no() {
		return option_no;
	}


	public void setOption_no(int option_no) {
		this.option_no = option_no;
	}


	public int getProduct_no() {
		return product_no;
	}


	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}


	public int getDetailOPtion_no() {
		return detailOPtion_no;
	}


	public void setDetailOPtion_no(int detailOPtion_no) {
		this.detailOPtion_no = detailOPtion_no;
	}


	public String getOption_name() {
		return option_name;
	}


	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}


	public String getDetailOPtion_name() {
		return detailOPtion_name;
	}


	public void setDetailOPtion_name(String detailOPtion_name) {
		this.detailOPtion_name = detailOPtion_name;
	}


	//메소드 일반
	@Override
	public String toString() {
		return "ProductOptionVO [option_no=" + option_no + ", product_no=" + product_no + ", detailOPtion_no="
				+ detailOPtion_no + ", option_name=" + option_name + ", detailOPtion_name=" + detailOPtion_name + "]";
	}
	
	

}
