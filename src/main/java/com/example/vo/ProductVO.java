package com.example.vo;

public class ProductVO {

	
	//필드
	private int product_no;           // 상품번호 (자동증가로 변경해야됨)
    private int category_no;          // 카테고리번호
    private String title;             // 상품명
    private int price;               // 가격
    private String brand;            // 브랜드
    private String itemimg;        // 이미지경로
    private int shipping_yn;          // 배송여부
    private int shipping_cost;        // 배송비
    private int zipcode;             // 우편번호
    private String address;          // 주소
    private String detail_address;    // 상세주소
    
    
    
	//생성자
    public ProductVO() {
		super();
	}



	public ProductVO(int product_no, int category_no, String title, int price, String brand, String itemimg,
			int shipping_yn, int shipping_cost, int zipcode, String address, String detail_address) {
		super();
		this.product_no = product_no;
		this.category_no = category_no;
		this.title = title;
		this.price = price;
		this.brand = brand;
		this.itemimg = itemimg;
		this.shipping_yn = shipping_yn;
		this.shipping_cost = shipping_cost;
		this.zipcode = zipcode;
		this.address = address;
		this.detail_address = detail_address;
	}


	//메소드gs
	public int getProduct_no() {
		return product_no;
	}



	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}



	public int getCategory_no() {
		return category_no;
	}



	public void setCategory_no(int category_no) {
		this.category_no = category_no;
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



	public String getBrand() {
		return brand;
	}



	public void setBrand(String brand) {
		this.brand = brand;
	}



	public String getItemimg() {
		return itemimg;
	}



	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}



	public int getShipping_yn() {
		return shipping_yn;
	}



	public void setShipping_yn(int shipping_yn) {
		this.shipping_yn = shipping_yn;
	}



	public int getShipping_cost() {
		return shipping_cost;
	}



	public void setShipping_cost(int shipping_cost) {
		this.shipping_cost = shipping_cost;
	}



	public int getZipcode() {
		return zipcode;
	}



	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getDetail_address() {
		return detail_address;
	}



	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}



	//메소드일반
	@Override
	public String toString() {
		return "ProductVO [product_no=" + product_no + ", category_no=" + category_no + ", title=" + title + ", price="
				+ price + ", brand=" + brand + ", itemimg=" + itemimg + ", shipping_yn=" + shipping_yn
				+ ", shipping_cost=" + shipping_cost + ", zipcode=" + zipcode + ", address=" + address
				+ ", detail_address=" + detail_address + "]";
	}
    
	
	
	
}
