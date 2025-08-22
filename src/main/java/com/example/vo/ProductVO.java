package com.example.vo;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {

	// 필드
	private int product_no; // 상품번호 (자동증가로 변경해야됨)
	private int category_no; // 카테고리번호
	private String title; // 상품명
	private int price; // 가격
	private String brand; // 브랜드
	private String shipping_yn; // 배송여부
	private int shipping_cost; // 배송비
	private String zipcode; // 우편번호
	private String address; // 주소
	private String detail_address; // 상세주소
	private String itemimg; // 대표이미지경로
	private List<String> option_names; // 옵션제목
	private List<String>[] optionItems; // 상세옵션들

	private MultipartFile productImage; // 이미지경로
	private MultipartFile[] detailImages; // 상세섦영 이미지들

	// 생성자
	public ProductVO() {
	}

	public ProductVO(int product_no, int category_no, String title, int price, String brand, String shipping_yn,
			int shipping_cost, String zipcode, String address, String detail_address, String itemimg,
			List<String> option_names, List<String>[] optionItems, MultipartFile productImage,
			MultipartFile[] detailImages) {
		super();
		this.product_no = product_no;
		this.category_no = category_no;
		this.title = title;
		this.price = price;
		this.brand = brand;
		this.shipping_yn = shipping_yn;
		this.shipping_cost = shipping_cost;
		this.zipcode = zipcode;
		this.address = address;
		this.detail_address = detail_address;
		this.itemimg = itemimg;
		this.option_names = option_names;
		this.optionItems = optionItems;
		this.productImage = productImage;
		this.detailImages = detailImages;
	}

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

	public String getShipping_yn() {
		return shipping_yn;
	}

	public void setShipping_yn(String shipping_yn) {
		this.shipping_yn = shipping_yn;
	}

	public int getShipping_cost() {
		return shipping_cost;
	}

	public void setShipping_cost(int shipping_cost) {
		this.shipping_cost = shipping_cost;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
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

	public String getItemimg() {
		return itemimg;
	}

	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}

	public List<String> getOption_names() {
		return option_names;
	}

	public void setOption_names(List<String> option_names) {
		this.option_names = option_names;
	}

	public List<String>[] getOptionItems() {
		return optionItems;
	}

	public void setOptionItems(List<String>[] optionItems) {
		this.optionItems = optionItems;
	}

	public MultipartFile getProductImage() {
		return productImage;
	}

	public void setProductImage(MultipartFile productImage) {
		this.productImage = productImage;
	}

	public MultipartFile[] getDetailImages() {
		return detailImages;
	}

	public void setDetailImages(MultipartFile[] detailImages) {
		this.detailImages = detailImages;
	}

	@Override
	public String toString() {
		return "ProductVO [product_no=" + product_no + ", category_no=" + category_no + ", title=" + title + ", price="
				+ price + ", brand=" + brand + ", shipping_yn=" + shipping_yn + ", shipping_cost=" + shipping_cost
				+ ", zipcode=" + zipcode + ", address=" + address + ", detail_address=" + detail_address + ", itemimg="
				+ itemimg + ", option_names=" + option_names + ", optionItems=" + Arrays.toString(optionItems)
				+ ", productImage=" + productImage + ", detailImages=" + Arrays.toString(detailImages) + "]";
	}

}
