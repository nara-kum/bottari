package com.example.vo;

public class DetailOptionVO {
	//field
	private int detailoption_no;
	private String detailoption_name;
	//editor
	public DetailOptionVO(int detailoption_no, String detailoption_name) {
		super();
		this.detailoption_no = detailoption_no;
		this.detailoption_name = detailoption_name;
	}
	public DetailOptionVO() {
		super();
	}
	//method g/s
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
		return "DetailOptionVO [detailoption_no=" + detailoption_no + ", detailoption_name=" + detailoption_name + "]";
	}
}
