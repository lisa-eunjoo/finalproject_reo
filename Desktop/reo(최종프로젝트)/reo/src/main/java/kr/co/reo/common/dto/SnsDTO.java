package kr.co.reo.common.dto;

import java.sql.Date;

public class SnsDTO {
	private int mem_no;
	private String mem_email;
	private String mem_name;
	private String mem_role;
	private String mem_buisnessNo;
	private String mem_sector;
	private Date mem_regDate;

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_role() {
		return mem_role;
	}

	public void setMem_role(String mem_role) {
		this.mem_role = mem_role;
	}

	public String getMem_buisnessNo() {
		return mem_buisnessNo;
	}

	public void setMem_buisnessNo(String mem_buisnessNo) {
		this.mem_buisnessNo = mem_buisnessNo;
	}

	public String getMem_sector() {
		return mem_sector;
	}

	public void setMem_sector(String mem_sector) {
		this.mem_sector = mem_sector;
	}

	public Date getMem_regDate() {
		return mem_regDate;
	}

	public void setMem_regDate(Date mem_regDate) {
		this.mem_regDate = mem_regDate;
	}

}
