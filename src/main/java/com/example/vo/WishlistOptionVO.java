package com.example.vo;

public class WishlistOptionVO {

	// 필드
	private int wishlistoptionNo;
	private int wishlistNo;
	private int detailoptionNo;
	
	
	//생성자
	public WishlistOptionVO() {
		super();
	}


	public WishlistOptionVO(int wishlistoptionNo, int wishlistNo, int detailoptionNo) {
		super();
		this.wishlistoptionNo = wishlistoptionNo;
		this.wishlistNo = wishlistNo;
		this.detailoptionNo = detailoptionNo;
	}


	//메소드gs
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



	public int getDetailoptionNo() {
		return detailoptionNo;
	}



	public void setDetailoptionNo(int detailoptionNo) {
		this.detailoptionNo = detailoptionNo;
	}


	//메소드일반
	@Override
	public String toString() {
		return "WishlistOptionVO [wishlistoptionNo=" + wishlistoptionNo + ", wishlistNo=" + wishlistNo
				+ ", detailoptionNo=" + detailoptionNo + "]";
	}

	
}
