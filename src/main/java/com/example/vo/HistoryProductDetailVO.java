package com.example.vo;

public class HistoryProductDetailVO {
	//field
	// payment section
	private int payment_no;
	private int order_no;
	private int product_no;
	private int funding_no;
	private String payment_date;
	private String delivery_status;
	private int payment_amount;
	private int final_amount;
	private String service_type;
	// payment_goods section
	private int quantity;
	// product_section
	private String brand;
	private String title;
	private int price;
	private String itemimg;
	private int shipping_cost;
	//editor
	public HistoryProductDetailVO(int payment_no, int order_no, int product_no, int funding_no, String payment_date,
			String delivery_status, int payment_amount, int final_amount, String service_type, int quantity, String brand,
			String title, int price, String itemimg, int shipping_cost) {
		super();
		this.payment_no = payment_no;
		this.order_no = order_no;
		this.product_no = product_no;
		this.funding_no = funding_no;
		this.payment_date = payment_date;
		this.delivery_status = delivery_status;
		this.payment_amount = payment_amount;
		this.final_amount = final_amount;
		this.service_type = service_type;
		this.quantity = quantity;
		this.brand = brand;
		this.title = title;
		this.price = price;
		this.itemimg = itemimg;
		this.shipping_cost = shipping_cost;
	}
	public HistoryProductDetailVO() {
		super();
	}
	//method g/s
	public int getPayment_no() {
		return payment_no;
	}
	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}
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
	public int getFunding_no() {
		return funding_no;
	}
	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String detlivery_status) {
		this.delivery_status = detlivery_status;
	}
	public int getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(int payment_amount) {
		this.payment_amount = payment_amount;
	}
	public int getFinal_amount() {
		return final_amount;
	}
	public void setFinal_amount(int final_amount) {
		this.final_amount = final_amount;
	}
	public String getService_type() {
		return service_type;
	}
	public void setService_type(String service_type) {
		this.service_type = service_type;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
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
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	//method normal
	@Override
	public String toString() {
		return "HistoryProductDetailVO [payment_no=" + payment_no + ", order_no=" + order_no + ", product_no="
				+ product_no + ", funding_no=" + funding_no + ", payment_date=" + payment_date + ", delivery_status="
				+ delivery_status + ", payment_amount=" + payment_amount + ", final_amount=" + final_amount
				+ ", service_type=" + service_type + ", brand=" + brand + ", title=" + title + ", price=" + price
				+ ", itemimg=" + itemimg + ", shipping_cost=" + shipping_cost + "]";
	}
}
