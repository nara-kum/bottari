package com.example.vo;

public class UserVO {
	//필드
	private int userNo;
	private String id;
	private String name;
	private String password;
	private String email;
	private String phone;
	private int birth;
	private String JoinDate;
	
	//생성자
	public UserVO() {
		super();
	}
	public UserVO(int userNo, String id, String name, String password, String email, String phone, int birth,
			String joinDate) {
		super();
		this.userNo = userNo;
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.birth = birth;
		this.JoinDate = joinDate;
	}
	
	//메소드-sg
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getBirth() {
		return birth;
	}
	public void setBirth(int birth) {
		this.birth = birth;
	}
	public String getJoinDate() {
		return JoinDate;
	}
	public void setJoinDate(String joinDate) {
		this.JoinDate = joinDate;
	}
	
	//메소드 일반
	@Override
	public String toString() {
		return "UserVO [userNo=" + userNo + ", id=" + id + ", name=" + name + ", password=" + password + ", email="
				+ email + ", phone=" + phone + ", birth=" + birth + ", JoinDate=" + JoinDate + "]";
	}
}
