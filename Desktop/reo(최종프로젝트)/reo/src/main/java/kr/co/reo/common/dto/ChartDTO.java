package kr.co.reo.common.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ChartDTO {
	private String age;
	private String gu;
	private int counts;
	private Date dates;
}