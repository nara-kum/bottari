package com.example.vo;

public class FundingProductVO {

	//필드
	private int funding_no;
	private int user_no;
	private int event_no;
	private int wishlist_no;
	private int product_no;
	private int percent;
	private int amount;
	private String funding_status;
	private String funding_date;
	
	
	//생성자
	public FundingProductVO() {
		super();
	}
	
	
	public FundingProductVO(int funding_no, int user_no, int event_no, int wishlist_no, int product_no, int percent,
			int amount, String funding_status, String funding_date) {
		super();
		this.funding_no = funding_no;
		this.user_no = user_no;
		this.event_no = event_no;
		this.wishlist_no = wishlist_no;
		this.product_no = product_no;
		this.percent = percent;
		this.amount = amount;
		this.funding_status = funding_status;
		this.funding_date = funding_date;
	}
	
	
	//메소드gs
	public int getFunding_no() {
		return funding_no;
	}
	
	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}
	
	public int getUser_no() {
		return user_no;
	}
	
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	
	public int getEvent_no() {
		return event_no;
	}
	
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	
	public int getWishlist_no() {
		return wishlist_no;
	}
	
	public void setWishlist_no(int wishlist_no) {
		this.wishlist_no = wishlist_no;
	}
	
	public int getProduct_no() {
		return product_no;
	}
	
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
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
	
	public String getFunding_status() {
		return funding_status;
	}
	
	public void setFunding_status(String funding_status) {
		this.funding_status = funding_status;
	}
	
	public String getFunding_date() {
		return funding_date;
	}
	
	public void setFunding_date(String funding_date) {
		this.funding_date = funding_date;
	}
	
	
	//메소드일반
	@Override
	public String toString() {
		return "fundingProductVO [funding_no=" + funding_no + ", user_no=" + user_no + ", event_no=" + event_no
				+ ", wishlist_no=" + wishlist_no + ", product_no=" + product_no + ", percent=" + percent + ", amount="
				+ amount + ", funding_status=" + funding_status + ", funding_date=" + funding_date + "]";
	}

	
}
