package com.example.vo;

public class ProductTotalVO {
	

	//필드
	private int product_no;           // 상품번호 (자동증가로 변경해야됨)
    private int category_no;          // 카테고리번호
    private String category_title;    
    private String title;            // 상품명
    private int price;               // 가격
    private String brand;            // 브랜드
    private String itemimg;          // 이미지경로
    private int shipping_yn;         // 배송여부
    private int shipping_cost;       // 배송비
    private int zipcode;             // 우편번호
    private String address;          // 주소
    private String detail_address;   // 상세주소
    
   //상품옵션
	private int option_no;
	private int detailOPtion_no;
	private String option_name;
	private String detailOPtion_name;
    
	//상세이미지
	private int detailedImage_no;
	private String image_URL;
	private int turn;
	
	
	//생성자
	public ProductTotalVO() {
		super();
	}


	public ProductTotalVO(int product_no, int category_no, String category_title, String title, int price, String brand,
			String itemimg, int shipping_yn, int shipping_cost, int zipcode, String address, String detail_address,
			int option_no, int detailOPtion_no, String option_name, String detailOPtion_name, int detailedImage_no,
			String image_URL, int turn) {
		super();
		this.product_no = product_no;
		this.category_no = category_no;
		this.category_title = category_title;
		this.title = title;
		this.price = price;
		this.brand = brand;
		this.itemimg = itemimg;
		this.shipping_yn = shipping_yn;
		this.shipping_cost = shipping_cost;
		this.zipcode = zipcode;
		this.address = address;
		this.detail_address = detail_address;
		this.option_no = option_no;
		this.detailOPtion_no = detailOPtion_no;
		this.option_name = option_name;
		this.detailOPtion_name = detailOPtion_name;
		this.detailedImage_no = detailedImage_no;
		this.image_URL = image_URL;
		this.turn = turn;
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


	public String getCategory_title() {
		return category_title;
	}


	public void setCategory_title(String category_title) {
		this.category_title = category_title;
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


	public int getOption_no() {
		return option_no;
	}


	public void setOption_no(int option_no) {
		this.option_no = option_no;
	}


	public int getDetailOPtion_no() {
		return detailOPtion_no;
	}


	public void setDetailOPtion_no(int detailOPtion_no) {
		this.detailOPtion_no = detailOPtion_no;
	}


	public String getOption_name() {
		return option_name;
	}


	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}


	public String getDetailOPtion_name() {
		return detailOPtion_name;
	}


	public void setDetailOPtion_name(String detailOPtion_name) {
		this.detailOPtion_name = detailOPtion_name;
	}


	public int getDetailedImage_no() {
		return detailedImage_no;
	}


	public void setDetailedImage_no(int detailedImage_no) {
		this.detailedImage_no = detailedImage_no;
	}


	public String getImage_URL() {
		return image_URL;
	}


	public void setImage_URL(String image_URL) {
		this.image_URL = image_URL;
	}


	public int getTurn() {
		return turn;
	}


	public void setTurn(int turn) {
		this.turn = turn;
	}


	//
	@Override
	public String toString() {
		return "ProductTotal [product_no=" + product_no + ", category_no=" + category_no + ", category_title="
				+ category_title + ", title=" + title + ", price=" + price + ", brand=" + brand + ", itemimg=" + itemimg
				+ ", shipping_yn=" + shipping_yn + ", shipping_cost=" + shipping_cost + ", zipcode=" + zipcode
				+ ", address=" + address + ", detail_address=" + detail_address + ", option_no=" + option_no
				+ ", detailOPtion_no=" + detailOPtion_no + ", option_name=" + option_name + ", detailOPtion_name="
				+ detailOPtion_name + ", detailedImage_no=" + detailedImage_no + ", image_URL=" + image_URL + ", turn="
				+ turn + "]";
	}
	
	

}
