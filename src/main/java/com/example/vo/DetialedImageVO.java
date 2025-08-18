package com.example.vo;

public class DetialedImageVO {

	//필드
	private int detailedImage_no;
	private int product_no;
	private String image_URL;
	private int turn;

	
	
	//생성자
	public DetialedImageVO() {
		super();
	}


	public DetialedImageVO(int detailedImage_no, int product_no, String image_URL, int turn) {
		super();
		this.detailedImage_no = detailedImage_no;
		this.product_no = product_no;
		this.image_URL = image_URL;
		this.turn = turn;
	}


	//메소드gs
	public int getDetailedImage_no() {
		return detailedImage_no;
	}


	public void setDetailedImage_no(int detailedImage_no) {
		this.detailedImage_no = detailedImage_no;
	}


	public int getProduct_no() {
		return product_no;
	}


	public void setProduct_no(int product_no) {
		this.product_no = product_no;
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


	//메소드일반
	@Override
	public String toString() {
		return "detialedImageVO [detailedImage_no=" + detailedImage_no + ", product_no=" + product_no + ", image_URL="
				+ image_URL + ", turn=" + turn + "]";
	}
	
	
	
	
}
