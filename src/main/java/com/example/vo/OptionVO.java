package com.example.vo;

import java.util.ArrayList;
import java.util.List;

public class OptionVO {
	//field
	private int option_no;
	private String option_name;
	private List<DetailOptionVO> detailList = new ArrayList<>();
	//editor
	public OptionVO(int option_no, String option_name, List<DetailOptionVO> detailList) {
		super();
		this.option_no = option_no;
		this.option_name = option_name;
		this.detailList = detailList;
	}
	public OptionVO() {
		super();
	}
	//method g/s
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
	public List<DetailOptionVO> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<DetailOptionVO> detailList) {
		this.detailList = detailList;
	}
	//method normal
	@Override
	public String toString() {
		return "OptionVO [option_no=" + option_no + ", option_name=" + option_name
				+ ", detailList=" + detailList + "]";
	}
}
