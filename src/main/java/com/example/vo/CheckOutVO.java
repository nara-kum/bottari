package com.example.vo;

public class CheckOutVO {
	//field
	private int cart_no;
	private int user_no;
	private int product_no;
	private String title;
	private int price;
	private int quantity;
	private String brand;
	private int shipping_cost;
	private String itemimg;
	private int item_total;
	private int total_quantity;
	private int total_amount;
	//editor
	public CheckOutVO() {
		super();
	}
	public CheckOutVO(int cart_no, int user_no, int product_no, String title, int price, int quantity, String brand,
			int shipping_cost, String itemimg, int item_total, int total_quantity, int total_amount) {
		super();
		this.cart_no = cart_no;
		this.user_no = user_no;
		this.product_no = product_no;
		this.title = title;
		this.price = price;
		this.quantity = quantity;
		this.brand = brand;
		this.shipping_cost = shipping_cost;
		this.itemimg = itemimg;
		this.item_total = item_total;
		this.total_quantity = total_quantity;
		this.total_amount = total_amount;
	}

	//method g/s
	public int getCart_no() {
		return cart_no;
	}
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
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
	public int getShipping_cost() {
		return shipping_cost;
	}
	public void setShipping_cost(int shipping_cost) {
		this.shipping_cost = shipping_cost;
	}
	public String getItemimg() {
		return itemimg;
	}
	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getItem_total() {
		return item_total;
	}
	public void setItem_total(int item_total) {
		this.item_total = item_total;
	}
	public int getTotal_quantity() {
		return total_quantity;
	}
	public void setTotal_quantity(int total_quantity) {
		this.total_quantity = total_quantity;
	}
	public int getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}
	//method normal
	@Override
	public String toString() {
		return "CheckOutVO [cart_no=" + cart_no + ", user_no=" + user_no + ", product_no=" + product_no + ", title="
				+ title + ", price=" + price + ", quantity=" + quantity + ", brand=" + brand + ", shipping_cost="
				+ shipping_cost + ", itemimg=" + itemimg + ", item_total=" + item_total + ", total_quantity="
				+ total_quantity + ", total_amount=" + total_amount + "]";
	}
}
