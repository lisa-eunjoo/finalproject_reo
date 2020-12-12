package kr.co.reo.common.dto;

import lombok.Data;

@Data
public class ContractDTO {
	private long tokenId; // 결제번호 pay_no
	private String pay_no; // 결제번호 pay_no
	private String name; // 계약자 이름 mem_name
	private String id; // 계약자 아이디 mem_email
	private String location; // 소재지 off_stdAddr + " " + off_detailAddr + " " + off_extraAddr
	private long price; // 잔금 pay_price
	private long payday; // 잔금 지불날(계약일) 밀리세컨트 pay_date
	private long startdate; // 계약시작일 밀리세컨트 res_startdatetime
	private long enddate; // 계약종료일 밀리세컨트 res_enddatetime
}