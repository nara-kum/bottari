package com.example.vo;

public class PaymentVO {
	//field
	private int payment_no;				//결제 내역 번호
	private int user_no;				//회원 번호
	private int funding_no;				//펀딩 상품 번호
	private int product_no;				//상품 번호
	private int order_no;				//주문번호
	private String zipcode;				//배송지 우편번호
	private String address;				//주소
	private String detail_address;		//상세주소
	private String payment_date;		//결제일
	private String payment_method;		//결제수단
	private String payment_status;		//결제상태
	private String delivery_status;		//배송상태
	private int payment_amount;			//결제금액
	private String service_type;		//서비스종류(일반, 펀딩)
	private int payment_goods_no;
	private int quantity;
	private int detailoption_no;
	//editor
	public PaymentVO(int payment_no, int user_no, int funding_no, int product_no, int order_no, String zipcode,
			String address, String detail_address, String payment_date, String payment_method, String payment_status,
			String delivery_status, int payment_amount, String service_type, int payment_goods_no, int quantity, int detailoption_no) {
		super();
		this.payment_no = payment_no;
		this.user_no = user_no;
		this.funding_no = funding_no;
		this.product_no = product_no;
		this.order_no = order_no;
		this.zipcode = zipcode;
		this.address = address;
		this.detail_address = detail_address;
		this.payment_date = payment_date;
		this.payment_method = payment_method;
		this.payment_status = payment_status;
		this.delivery_status = delivery_status;
		this.payment_amount = payment_amount;
		this.service_type = service_type;
		this.payment_goods_no = payment_goods_no;
		this.quantity = quantity;
		this.detailoption_no = detailoption_no;
	}
	public PaymentVO() {
		super();
	}
	//method g/s
	public int getPayment_no() {
		return payment_no;
	}
	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getFunding_no() {
		return funding_no;
	}
	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
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
	public String getService_type() {
		return service_type;
	}
	public void setService_type(String service_type) {
		this.service_type = service_type;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getDetailoption_no() {
		return detailoption_no;
	}
	public void setDetailoption_no(int detailoption_no) {
		this.detailoption_no = detailoption_no;
	}
	public int getPayment_goods_no() {
		return payment_goods_no;
	}
	public void setPayment_goods_no(int payment_goods_no) {
		this.payment_goods_no = payment_goods_no;
	}
	//method normal
	@Override
	public String toString() {
		return "PaymentVO [payment_no=" + payment_no + ", user_no=" + user_no + ", funding_no="
				+ funding_no + ", product_no=" + product_no + ", order_no=" + order_no + ", zipcode=" + zipcode
				+ ", address=" + address + ", detail_address=" + detail_address + ", payment_date=" + payment_date
				+ ", payment_method=" + payment_method + ", payment_status=" + payment_status + ", delivery_status="
				+ delivery_status + ", payment_amount=" + payment_amount + ", service_type=" + service_type + "]";
	}
}
