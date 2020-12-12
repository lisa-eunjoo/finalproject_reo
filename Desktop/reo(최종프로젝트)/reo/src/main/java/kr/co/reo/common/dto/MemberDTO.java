package kr.co.reo.common.dto;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.annotations.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class MemberDTO {
	private int mem_no;
	@NotBlank(message = "이메일을 입력해 주세요.")
	@Email(message = "이메일 형식을 맞춰주세요.")
	private String mem_email;
	@NotBlank(message = "이름을 입력해 주세요.")
	private String mem_name;
	@NotBlank(message = "비밀번호를 입력해주세요.")
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,20}", message = "비밀번호는 영문 대,소문자와 숫자, 특수기호가 적어도 1개 이상씩 포함된 8 ~ 20의 비밀번호여야 합니다.")
	private String mem_pw;
	@NotEmpty(message = "전화번호를 입력해주세요.")
	private String mem_tel;
	private String mem_role;
	@NotNull(message = "우편번호를 검색해주세요.")
	private String mem_zipcode;
	@NotNull(message = "주소를 입력해주세요.")
	private String mem_roadaddress;
	@NotNull(message = "주소를 입력해주세요.")
	private String mem_detailaddress;
	@NotNull
	private Date mem_birth;
	private Date mem_regDate;
	private String mem_sector;
	private String mem_agentName;
	private String mem_buisnessNo;

	private String searchCondition;
	private String searchKeyword;
	private String log_ip;

	public String getMem_sector() {
		return mem_sector;
	}

	public void setMem_sector(String mem_sector) {
		this.mem_sector = mem_sector;
	}

	public String getMem_agentName() {
		return mem_agentName;
	}

	public void setMem_agentName(String mem_agentName) {
		this.mem_agentName = mem_agentName;
	}

	public String getMem_zipcode() {
		return mem_zipcode;
	}

	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}

	public String getMem_buisnessNo() {
		return mem_buisnessNo;
	}

	public void setMem_buisnessNo(String mem_buisnessNo) {
		this.mem_buisnessNo = mem_buisnessNo;
	}

	@JsonIgnore
	public String getSearchCondition() {
		return searchCondition;
	}

	@JsonIgnore
	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

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

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_tel() {
		return mem_tel;
	}

	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}

	public String getMem_role() {
		return mem_role;
	}

	public void setMem_role(String mem_role) {
		this.mem_role = mem_role;
	}

	public Date getMem_regDate() {
		return mem_regDate;
	}

	public void setMem_regDate(Date mem_regDate) {
		this.mem_regDate = mem_regDate;
	}

	public String getMem_roadaddress() {
		return mem_roadaddress;
	}

	public void setMem_roadaddress(String mem_roadaddress) {
		this.mem_roadaddress = mem_roadaddress;
	}

	public String getMem_detailaddress() {
		return mem_detailaddress;
	}

	public void setMem_detailaddress(String mem_detailaddress) {
		this.mem_detailaddress = mem_detailaddress;
	}

	public Date getMem_birth() {
		return mem_birth;
	}

	public void setMem_birth(Date mem_birth) {
		this.mem_birth = mem_birth;
	}

	public String getLog_ip() {
		return log_ip;
	}

	public void setLog_ip(String log_ip) {
		this.log_ip = log_ip;
	}
}