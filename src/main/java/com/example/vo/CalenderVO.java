package com.example.vo;

public class CalenderVO {
	//field
	private int event_no;
	private int user_no;
	private String event_date;
	private String event_name;
	private String event_memo;
	private String icon_id;
	
	//editor
	public CalenderVO(int event_no, int user_no, String event_date, String event_name, String event_memo,
			String icon_id) {
		super();
		this.event_no = event_no;
		this.user_no = user_no;
		this.event_date = event_date;
		this.event_name = event_name;
		this.event_memo = event_memo;
		this.icon_id = icon_id;
	}
	public CalenderVO() {
		super();
	}
	//method g/s
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getEvent_date() {
		return event_date;
	}
	public void setEvent_date(String event_date) {
		this.event_date = event_date;
	}
	public String getEvent_name() {
		return event_name;
	}
	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}
	public String getEvent_memo() {
		return event_memo;
	}
	public void setEvent_memo(String event_memo) {
		this.event_memo = event_memo;
	}
	public String getIcon_id() {
		return icon_id;
	}
	public void setIcon_id(String icon_id) {
		this.icon_id = icon_id;
	}
	//method normal
	@Override
	public String toString() {
		return "CalenderVO [event_no=" + event_no + ", user_no=" + user_no + ", event_date=" + event_date
				+ ", event_name=" + event_name + ", event_memo=" + event_memo + ", icon_id=" + icon_id + "]";
	}
}
