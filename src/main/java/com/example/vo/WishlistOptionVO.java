package com.example.vo;

public class WishlistOptionVO {

	// 필드
	private int wishlistoptionNo;
	private int wishlistNo;
	private String detailoptionName;

	
	//생성자
	public WishlistOptionVO() {
		super();
	}


	public WishlistOptionVO(int wishlistoptionNo, int wishlistNo, String detailoptionName) {
		super();
		this.wishlistoptionNo = wishlistoptionNo;
		this.wishlistNo = wishlistNo;
		this.detailoptionName = detailoptionName;
	}

	//메소
	public int getWishlistoptionNo() {
		return wishlistoptionNo;
	}


	public void setWishlistoptionNo(int wishlistoptionNo) {
		this.wishlistoptionNo = wishlistoptionNo;
	}


	public int getWishlistNo() {
		return wishlistNo;
	}


	public void setWishlistNo(int wishlistNo) {
		this.wishlistNo = wishlistNo;
	}


	public String getDetailoptionName() {
		return detailoptionName;
	}


	public void setDetailoptionName(String detailoptionName) {
		this.detailoptionName = detailoptionName;
	}


	@Override
	public String toString() {
		return "WishlistVO [wishlistoptionNo=" + wishlistoptionNo + ", wishlistNo=" + wishlistNo + ", detailoptionName="
				+ detailoptionName + "]";
	}
	
	

}
