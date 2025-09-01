package com.example.vo;

public class HistoryVO {
	//field
	// payment_section
	private int order_no;
	private int product_no;
	private String zip_code;
	private String address;
	private String detail_address;
	private String payment_date;
	private String payment_method;
	private String payment_status;
	private String delivery_status;
	private int payment_amount;
	// payment_goods section
	private int quantity;
	// product_section
	private String title;
	private String brand;
	private int price;
	private String itemimg;
	private int shipping_cost;
	//editor
	public HistoryVO(int order_no, int product_no, String zip_code, String address, String detail_address,
			String payment_date, String payment_method, String payment_status, String delivery_status,
			int payment_amount, int quantity, String title, String brand, int price, String itemimg, int shipping_cost) {
		super();
		this.order_no = order_no;
		this.product_no = product_no;
		this.zip_code = zip_code;
		this.address = address;
		this.detail_address = detail_address;
		this.payment_date = payment_date;
		this.payment_method = payment_method;
		this.payment_status = payment_status;
		this.delivery_status = delivery_status;
		this.payment_amount = payment_amount;
		this.quantity = quantity;
		this.title = title;
		this.brand = brand;
		this.price = price;
		this.itemimg = itemimg;
		this.shipping_cost = shipping_cost;
	}
	public HistoryVO() {
		super();
	}
	//method g/s
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
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
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	public String getPayment_status() {
		return payment_status;
	}
	public void setPayment_status(String payment_status) {
		this.payment_status = payment_status;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}
	public int getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(int payment_amount) {
		this.payment_amount = payment_amount;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getItemimg() {
		return itemimg;
	}
	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}
	public int getShipping_cost() {
		return shipping_cost;
	}
	public void setShipping_cost(int shipping_cost) {
		this.shipping_cost = shipping_cost;
	}
	//method normal
	@Override
	public String toString() {
		return "HistoryVO [order_no=" + order_no + ", product_no=" + product_no + ", zip_code=" + zip_code
				+ ", address=" + address + ", detail_address=" + detail_address + ", payment_date=" + payment_date
				+ ", payment_method=" + payment_method + ", payment_status=" + payment_status + ", delivery_status="
				+ delivery_status + ", payment_amount=" + payment_amount + ", quantity=" + quantity + ", title=" + title
				+ ", brand=" + brand + ", price=" + price + ", itemimg=" + itemimg + ", shipping_cost=" + shipping_cost
				+ "]";
	}
}
