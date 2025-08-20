package com.example.vo;

public class WishlistVO {

	// 필드
	private int userNo;
	private int wishlistNo;
	private String brand;
	private String title;
	private int price;

	// 생성자
	public WishlistVO() {
		super();
	}
	public WishlistVO(int userNo, int wishlistNo, String brand, String title, int price) {
		super();
		this.userNo = userNo;
		this.wishlistNo = wishlistNo;
		this.brand = brand;
		this.title = title;
		this.price = price;
	}
	// 메소드gs
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
	// 메소드-일반
	@Override
	public String toString() {
		return "WishlistVO [userNo=" + userNo + ", wishlistNo=" + wishlistNo + ", brand=" + brand + ", title=" + title
				+ ", price=" + price + "]";
	}
	
}
