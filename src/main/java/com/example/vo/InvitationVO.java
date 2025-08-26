package com.example.vo;

public class InvitationVO {

	// 필드
	private int invitationNo;
	private int categoryNo;
	private int userNo;
	private int eventNo;
	private int themeNo;
	private String photoUrl;
	private String celebrateDate;
	private String celebrateTime;
	private String greeting;
	private String place;
	private String address1;
	private String address2;
	private String groomName;
	private String groomContect;
	private String groomFatherName;
	private String groomFatherContect;
	private String groomMotherName;
	private String groomMotherContect;
	private String brideName;
	private String brideContect;
	private String brideFatherName;
	private String brideFatherContect;
	private String brideMotherName;
	private String brideMotherContect;
	private String babyName;
	private String babyFatherName;
	private String babyFatherContect;
	private String babyMotherName;
	private String babyMotherContect;
	private String createdAt;
	private int hasFunding;
	private String eventName;

	// 생성자

	public InvitationVO() {
		super();
	}

	public InvitationVO(int invitationNo, int categoryNo, int userNo, int eventNo, int themeNo, String photoUrl,
			String celebrateDate, String celebrateTime, String greeting, String place, String address1, String address2,
			String groomName, String groomContect, String groomFatherName, String groomFatherContect,
			String groomMotherName, String groomMotherContect, String brideName, String brideContect,
			String brideFatherName, String brideFatherContect, String brideMotherName, String brideMotherContect,
			String babyName, String babyFatherName, String babyFatherContect, String babyMotherName,
			String babyMotherContect, String createdAt, int hasFunding, String eventName) {
		super();
		this.invitationNo = invitationNo;
		this.categoryNo = categoryNo;
		this.userNo = userNo;
		this.eventNo = eventNo;
		this.themeNo = themeNo;
		this.photoUrl = photoUrl;
		this.celebrateDate = celebrateDate;
		this.celebrateTime = celebrateTime;
		this.greeting = greeting;
		this.place = place;
		this.address1 = address1;
		this.address2 = address2;
		this.groomName = groomName;
		this.groomContect = groomContect;
		this.groomFatherName = groomFatherName;
		this.groomFatherContect = groomFatherContect;
		this.groomMotherName = groomMotherName;
		this.groomMotherContect = groomMotherContect;
		this.brideName = brideName;
		this.brideContect = brideContect;
		this.brideFatherName = brideFatherName;
		this.brideFatherContect = brideFatherContect;
		this.brideMotherName = brideMotherName;
		this.brideMotherContect = brideMotherContect;
		this.babyName = babyName;
		this.babyFatherName = babyFatherName;
		this.babyFatherContect = babyFatherContect;
		this.babyMotherName = babyMotherName;
		this.babyMotherContect = babyMotherContect;
		this.createdAt = createdAt;
		this.hasFunding = hasFunding;
		this.eventName = eventName;
	}

	//메소드-gs
	public int getInvitationNo() {
		return invitationNo;
	}

	public void setInvitationNo(int invitationNo) {
		this.invitationNo = invitationNo;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public int getThemeNo() {
		return themeNo;
	}

	public void setThemeNo(int themeNo) {
		this.themeNo = themeNo;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public String getCelebrateDate() {
		return celebrateDate;
	}

	public void setCelebrateDate(String celebrateDate) {
		this.celebrateDate = celebrateDate;
	}

	public String getCelebrateTime() {
		return celebrateTime;
	}

	public void setCelebrateTime(String celebrateTime) {
		this.celebrateTime = celebrateTime;
	}

	public String getGreeting() {
		return greeting;
	}

	public void setGreeting(String greeting) {
		this.greeting = greeting;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getGroomName() {
		return groomName;
	}

	public void setGroomName(String groomName) {
		this.groomName = groomName;
	}

	public String getGroomContect() {
		return groomContect;
	}

	public void setGroomContect(String groomContect) {
		this.groomContect = groomContect;
	}

	public String getGroomFatherName() {
		return groomFatherName;
	}

	public void setGroomFatherName(String groomFatherName) {
		this.groomFatherName = groomFatherName;
	}

	public String getGroomFatherContect() {
		return groomFatherContect;
	}

	public void setGroomFatherContect(String groomFatherContect) {
		this.groomFatherContect = groomFatherContect;
	}

	public String getGroomMotherName() {
		return groomMotherName;
	}

	public void setGroomMotherName(String groomMotherName) {
		this.groomMotherName = groomMotherName;
	}

	public String getGroomMotherContect() {
		return groomMotherContect;
	}

	public void setGroomMotherContect(String groomMotherContect) {
		this.groomMotherContect = groomMotherContect;
	}

	public String getBrideName() {
		return brideName;
	}

	public void setBrideName(String brideName) {
		this.brideName = brideName;
	}

	public String getBrideContect() {
		return brideContect;
	}

	public void setBrideContect(String brideContect) {
		this.brideContect = brideContect;
	}

	public String getBrideFatherName() {
		return brideFatherName;
	}

	public void setBrideFatherName(String brideFatherName) {
		this.brideFatherName = brideFatherName;
	}

	public String getBrideFatherContect() {
		return brideFatherContect;
	}

	public void setBrideFatherContect(String brideFatherContect) {
		this.brideFatherContect = brideFatherContect;
	}

	public String getBrideMotherName() {
		return brideMotherName;
	}

	public void setBrideMotherName(String brideMotherName) {
		this.brideMotherName = brideMotherName;
	}

	public String getBrideMotherContect() {
		return brideMotherContect;
	}

	public void setBrideMotherContect(String brideMotherContect) {
		this.brideMotherContect = brideMotherContect;
	}

	public String getBabyName() {
		return babyName;
	}

	public void setBabyName(String babyName) {
		this.babyName = babyName;
	}

	public String getBabyFatherName() {
		return babyFatherName;
	}

	public void setBabyFatherName(String babyFatherName) {
		this.babyFatherName = babyFatherName;
	}

	public String getBabyFatherContect() {
		return babyFatherContect;
	}

	public void setBabyFatherContect(String babyFatherContect) {
		this.babyFatherContect = babyFatherContect;
	}

	public String getBabyMotherName() {
		return babyMotherName;
	}

	public void setBabyMotherName(String babyMotherName) {
		this.babyMotherName = babyMotherName;
	}

	public String getBabyMotherContect() {
		return babyMotherContect;
	}

	public void setBabyMotherContect(String babyMotherContect) {
		this.babyMotherContect = babyMotherContect;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public int getHasFunding() {
		return hasFunding;
	}

	public void setHasFunding(int hasFunding) {
		this.hasFunding = hasFunding;
	}

	public String getEventName() {
		return eventName;
	}

	public void getEventName(String eventName) {
		this.eventName = eventName;
	}
	//메소드-일반
	@Override
	public String toString() {
		return "InvitationVO [invitationNo=" + invitationNo + ", categoryNo=" + categoryNo + ", userNo=" + userNo
				+ ", eventNo=" + eventNo + ", themeNo=" + themeNo + ", photoUrl=" + photoUrl + ", celebrateDate="
				+ celebrateDate + ", celebrateTime=" + celebrateTime + ", greeting=" + greeting + ", place=" + place
				+ ", address1=" + address1 + ", address2=" + address2 + ", groomName=" + groomName + ", groomContect="
				+ groomContect + ", groomFatherName=" + groomFatherName + ", groomFatherContect=" + groomFatherContect
				+ ", groomMotherName=" + groomMotherName + ", groomMotherContect=" + groomMotherContect + ", brideName="
				+ brideName + ", brideContect=" + brideContect + ", brideFatherName=" + brideFatherName
				+ ", brideFatherContect=" + brideFatherContect + ", brideMotherName=" + brideMotherName
				+ ", brideMotherContect=" + brideMotherContect + ", babyName=" + babyName + ", babyFatherName="
				+ babyFatherName + ", babyFatherContect=" + babyFatherContect + ", babyMotherName=" + babyMotherName
				+ ", babyMotherContect=" + babyMotherContect + ", createdAt=" + createdAt + ", hasFunding=" + hasFunding
				+ ", eventName=" + eventName+ "]";
	}


}
