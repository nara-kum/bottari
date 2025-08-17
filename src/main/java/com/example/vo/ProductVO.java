package com.example.vo;

public class ProductVO {

	
	//필드
	private int productNo;           // 상품번호 (자동증가로 변경해야됨)
    private int categoryNo;          // 카테고리번호
    private String name;             // 상품명
    private int price;               // 가격
    private String brand;            // 브랜드
    private String itemimage;        // 이미지경로
    private int shippingYN;          // 배송여부
    private int shippingCost;        // 배송비
    private int zipCode;             // 우편번호
    private String address;          // 주소
    private String detailAddress;    // 상세주소
    
    
    
	//생성자
    public ProductVO() {
		super();
	}
    
    
	public ProductVO(int productNo, int categoryNo, String name, int price, String brand, String itemimage,
			int shippingYN, int shippingCost, int zipCode, String address, String detailAddress) {
		super();
		this.productNo = productNo;
		this.categoryNo = categoryNo;
		this.name = name;
		this.price = price;
		this.brand = brand;
		this.itemimage = itemimage;
		this.shippingYN = shippingYN;
		this.shippingCost = shippingCost;
		this.zipCode = zipCode;
		this.address = address;
		this.detailAddress = detailAddress;
	}

	

    //메소드gs
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getItemimage() {
		return itemimage;
	}
	public void setItemimage(String itemimage) {
		this.itemimage = itemimage;
	}
	public int getShippingYN() {
		return shippingYN;
	}
	public void setShippingYN(int shippingYN) {
		this.shippingYN = shippingYN;
	}
	public int getShippingCost() {
		return shippingCost;
	}
	public void setShippingCost(int shippingCost) {
		this.shippingCost = shippingCost;
	}
	public int getZipCode() {
		return zipCode;
	}
	public void setZipCode(int zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	

	//메소드일반
	@Override
	public String toString() {
		return "ProductVO [productNo=" + productNo + ", categoryNo=" + categoryNo + ", name=" + name + ", price="
				+ price + ", brand=" + brand + ", itemimage=" + itemimage + ", shippingYN=" + shippingYN
				+ ", shippingCost=" + shippingCost + ", zipCode=" + zipCode + ", address=" + address
				+ ", detailAddress=" + detailAddress + "]";
	}
    	
	
}
