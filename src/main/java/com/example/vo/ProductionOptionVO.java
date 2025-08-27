package com.example.vo;

import java.util.ArrayList;
import java.util.List;

public class ProductionOptionVO {
	//field
	private int product_no;
	private List<OptionVO> options = new ArrayList<>();
	//editor
	public ProductionOptionVO(int product_no, List<OptionVO> options) {
		super();
		this.product_no = product_no;
		this.options = options;
	}
	public ProductionOptionVO() {
		super();
	}
	//method g/s
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public List<OptionVO> getOptions() {
		return options;
	}
	public void setOptions(List<OptionVO> options) {
		this.options = options;
	}
	//method normal
	@Override
	public String toString() {
		return "ProductionOptionVO [product_no=" + product_no + ", options=" + options + "]";
	}
}
