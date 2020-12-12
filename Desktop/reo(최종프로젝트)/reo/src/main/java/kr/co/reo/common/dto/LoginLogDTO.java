package kr.co.reo.common.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class LoginLogDTO {
	private int log_no;
	private String mem_email;
	private Date log_date;
	private String log_ip;
	private String fromDate;
	private String toDate;
	private String searchType;
	private String search;
	private int LIMIT;
	private int OFFSET;
	private int pageNo;
}