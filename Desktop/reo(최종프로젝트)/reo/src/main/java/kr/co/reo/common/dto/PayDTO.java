package kr.co.reo.common.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PayDTO {
	private String pay_no;
	private int res_no;
	private String mem_email;
	private int off_no;
	private int pay_price;
	private Timestamp pay_beforedate;
	private Timestamp pay_date;
	private String pay_type;
	private String pay_card;
	private String pay_bin;
	private String pay_state;
	private String pay_tid;
	private String pay_remark;

	private String off_name;
	private String off_unit;
	private Timestamp res_startdatetime;
	private String fromDate;
	private String toDate;
	private String searchType;
	private String search;
	private int LIMIT;
	private int OFFSET;
	private int pageNo;
	
}