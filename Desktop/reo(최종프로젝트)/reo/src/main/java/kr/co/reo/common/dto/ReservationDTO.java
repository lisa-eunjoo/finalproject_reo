package kr.co.reo.common.dto;

import java.sql.Timestamp;

public class ReservationDTO {
	private int res_no;
	private String mem_email;
	private String mem_name;
	private String mem_agentName;
	private String mem_tel;
	private String mem_sector;
	private Timestamp res_datetime;
	private Timestamp res_startdatetime;
	private Timestamp res_enddatetime;
	private String room_price;
	private String res_state;
	private String res_memo;
	private int res_people;
	private String pay_no;
	private int off_no;
	private String off_name;
	private String off_unit;
	private String off_stdAddr;
	private int pageNo;
	private int LIMIT;
	private int OFFSET;
	private String device;

	public int getRes_no() {
		return res_no;
	}

	public void setRes_no(int res_no) {
		this.res_no = res_no;
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

	public String getMem_agentName() {
		return mem_agentName;
	}

	public void setMem_agentName(String mem_agentName) {
		this.mem_agentName = mem_agentName;
	}

	public String getMem_tel() {
		return mem_tel;
	}

	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}

	public String getMem_sector() {
		return mem_sector;
	}

	public void setMem_sector(String mem_sector) {
		this.mem_sector = mem_sector;
	}

	public Timestamp getRes_datetime() {
		return res_datetime;
	}

	public void setRes_datetime(Timestamp res_datetime) {
		this.res_datetime = res_datetime;
	}

	public Timestamp getRes_startdatetime() {
		return res_startdatetime;
	}

	public void setRes_startdatetime(Timestamp res_startdatetime) {
		this.res_startdatetime = res_startdatetime;
	}

	public Timestamp getRes_enddatetime() {
		return res_enddatetime;
	}

	public void setRes_enddatetime(Timestamp res_enddatetime) {
		this.res_enddatetime = res_enddatetime;
	}

	public String getRoom_price() {
		return room_price;
	}

	public void setRoom_price(String room_price) {
		this.room_price = room_price;
	}

	public String getRes_state() {
		return res_state;
	}

	public void setRes_state(String res_state) {
		this.res_state = res_state;
	}

	public String getRes_memo() {
		return res_memo;
	}

	public void setRes_memo(String res_memo) {
		this.res_memo = res_memo;
	}

	public int getRes_people() {
		return res_people;
	}

	public void setRes_people(int res_people) {
		this.res_people = res_people;
	}

	public String getPay_no() {
		return pay_no;
	}

	public void setPay_no(String pay_no) {
		this.pay_no = pay_no;
	}

	public int getOff_no() {
		return off_no;
	}

	public void setOff_no(int off_no) {
		this.off_no = off_no;
	}

	public String getOff_name() {
		return off_name;
	}

	public void setOff_name(String off_name) {
		this.off_name = off_name;
	}

	public String getOff_unit() {
		return off_unit;
	}

	public void setOff_unit(String off_unit) {
		this.off_unit = off_unit;
	}

	public String getOff_stdAddr() {
		return off_stdAddr;
	}

	public void setOff_stdAddr(String off_stdAddr) {
		this.off_stdAddr = off_stdAddr;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getLIMIT() {
		return LIMIT;
	}

	public void setLIMIT(int lIMIT) {
		LIMIT = lIMIT;
	}

	public int getOFFSET() {
		return OFFSET;
	}

	public void setOFFSET(int oFFSET) {
		OFFSET = oFFSET;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

}
