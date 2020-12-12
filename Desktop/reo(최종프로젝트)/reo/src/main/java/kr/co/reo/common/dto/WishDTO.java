package kr.co.reo.common.dto;

public class WishDTO {
	private int wish_no;
	private int off_no;
	private String mem_email;

	public int getWish_no() {
		return wish_no;
	}

	public void setWish_no(int wish_no) {
		this.wish_no = wish_no;
	}

	public int getOff_no() {
		return off_no;
	}

	public void setOff_no(int off_no) {
		this.off_no = off_no;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
}
