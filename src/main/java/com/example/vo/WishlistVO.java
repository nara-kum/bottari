package com.example.vo;

public class WishlistVO {

	// 필드
	// 위시
	private int userNo;
	private int wishlistNo;
	private String image;
	private String brand;
	private String title;
	private int price;
	private int quantity;
	private int wishlistoptionNo;
	private int detailoptionNo;
	private String optionName;
	private String detailoptionName;
	// 펀딩
	private int fundingNo;
	private int eventNo;
	private int productNo;
	private int percent;
	private int amount;
	private String fundingStatus;
	private String fundingDate;

	
	// 생성자
	public WishlistVO() {
		super();
	}

	public WishlistVO(int userNo, int wishlistNo, String image, String brand, String title, int price, int quantity,
			int wishlistoptionNo, int detailoptionNo, String optionName, String detailoptionName, int fundingNo, int eventNo,
			int productNo, int percent, int amount, String fundingStatus, String fundingDate) {
		super();
		this.userNo = userNo;
		this.wishlistNo = wishlistNo;
		this.brand = image;
		this.brand = brand;
		this.title = title;
		this.price = price;
		this.quantity = quantity;
		this.wishlistoptionNo = wishlistoptionNo;
		this.detailoptionNo = detailoptionNo;
		this.optionName = optionName;
		this.detailoptionName = detailoptionName;
		this.fundingNo = fundingNo;
		this.eventNo = eventNo;
		this.productNo = productNo;
		this.percent = percent;
		this.amount = amount;
		this.fundingStatus = fundingStatus;
		this.fundingDate = fundingDate;
	}

	
	
	//메소드gs
	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getWishlistNo() {
		return wishlistNo;
	}

	public void setWishlistNo(int wishlistNo) {
		this.wishlistNo = wishlistNo;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getWishlistoptionNo() {
		return wishlistoptionNo;
	}

	public void setWishlistoptionNo(int wishlistoptionNo) {
		this.wishlistoptionNo = wishlistoptionNo;
	}

	public int getDetailoptionNo() {
		return detailoptionNo;
	}

	public void setDetailoptionNo(int detailoptionNo) {
		this.detailoptionNo = detailoptionNo;
	}

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	public String getDetailoptionName() {
		return detailoptionName;
	}

	public void setDetailoptionName(String detailoptionName) {
		this.detailoptionName = detailoptionName;
	}

	public int getFundingNo() {
		return fundingNo;
	}

	public void setFundingNo(int fundingNo) {
		this.fundingNo = fundingNo;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getPercent() {
		return percent;
	}

	public void setPercent(int percent) {
		this.percent = percent;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getFundingStatus() {
		return fundingStatus;
	}

	public void setFundingStatus(String fundingStatus) {
		this.fundingStatus = fundingStatus;
	}

	public String getFundingDate() {
		return fundingDate;
	}

	public void setFundingDate(String fundingDate) {
		this.fundingDate = fundingDate;
	}

	
	//메소드일반
	@Override
	public String toString() {
		return "WishlistVO [userNo=" + userNo + ", wishlistNo=" + wishlistNo + ", image=" + image + ", brand=" + brand + ", title=" + title
				+ ", price=" + price + ", quantity=" + quantity + ", wishlistoptionNo=" + wishlistoptionNo
				+ ", detailoptionNo=" + detailoptionNo + ", optionName=" + optionName + ", detailoptionName=" + detailoptionName + ", fundingNo="
				+ fundingNo + ", eventNo=" + eventNo + ", productNo=" + productNo + ", percent=" + percent + ", amount="
				+ amount + ", fundingStatus=" + fundingStatus + ", fundingDate=" + fundingDate + "]";
	}



}
