package com.example.vo;

public class WishlistVO {

	//필드
	private int wishlistNo;
	private	int user_no;
	private int product_no;
	private String date;
    private int ea;

    //생성자
	public WishlistVO() {}

	public WishlistVO(int wishlistNo, int user_no, int product_no, String date, int ea) {
		super();
		this.wishlistNo = wishlistNo;
		this.user_no = user_no;
		this.product_no = product_no;
		this.date = date;
		this.ea = ea;
	}
	
    //메소드gs
	public int getWishlistNo() {
		return wishlistNo;
	}

	public void setWishlistNo(int wishlistNo) {
		this.wishlistNo = wishlistNo;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getEa() {
		return ea;
	}

	public void setEa(int ea) {
		this.ea = ea;
	}

	//메소드-일반
	@Override
	public String toString() {
		return "WishlitVO [wishlistNo=" + wishlistNo + ", user_no=" + user_no + ", product_no=" + product_no + ", date="
				+ date + ", ea=" + ea + "]";
	}


}
