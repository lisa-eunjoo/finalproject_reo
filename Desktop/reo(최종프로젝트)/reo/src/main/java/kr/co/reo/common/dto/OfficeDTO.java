package kr.co.reo.common.dto;

import java.util.List;

public class OfficeDTO {
	private int off_no;
	private String off_type;
	private String off_unit;
	private String off_name;
	private String mem_email;
	private String mem_agentName;
	private String mem_agentTel;
	private int off_rent;
	private String off_stdAddr;
	private String off_detailAddr;
	private String off_extraAddr;
	private int off_maxNum;
	private String off_feature;
	private int off_likeCount;
	private String off_image;
	private int pageNo;
	private int LIMIT;
	private int OFFSET;
	private List<String> off_imgs;

	private String keyword;
	private String map_gu;
	private String map_dong;
	private double map_la;
	private double map_ln;

	public int getOff_no() {
		return off_no;
	}

	public void setOff_no(int off_no) {
		this.off_no = off_no;
	}

	public String getOff_type() {
		return off_type;
	}

	public void setOff_type(String off_type) {
		this.off_type = off_type;
	}

	public String getOff_unit() {
		return off_unit;
	}

	public void setOff_unit(String off_unit) {
		this.off_unit = off_unit;
	}

	public String getOff_name() {
		return off_name;
	}

	public void setOff_name(String off_name) {
		this.off_name = off_name;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_agentName() {
		return mem_agentName;
	}

	public void setMem_agentName(String mem_agentName) {
		this.mem_agentName = mem_agentName;
	}

	public String getMem_agentTel() {
		return mem_agentTel;
	}

	public void setMem_agentTel(String mem_agentTel) {
		this.mem_agentTel = mem_agentTel;
	}

	public int getOff_rent() {
		return off_rent;
	}

	public void setOff_rent(int off_rent) {
		this.off_rent = off_rent;
	}

	public String getOff_stdAddr() {
		return off_stdAddr;
	}

	public void setOff_stdAddr(String off_stdAddr) {
		this.off_stdAddr = off_stdAddr;
	}

	public String getOff_detailAddr() {
		return off_detailAddr;
	}

	public void setOff_detailAddr(String off_detailAddr) {
		this.off_detailAddr = off_detailAddr;
	}

	public String getOff_extraAddr() {
		return off_extraAddr;
	}

	public void setOff_extraAddr(String off_extraAddr) {
		this.off_extraAddr = off_extraAddr;
	}

	public int getOff_maxNum() {
		return off_maxNum;
	}

	public void setOff_maxNum(int off_maxNum) {
		this.off_maxNum = off_maxNum;
	}

	public String getOff_feature() {
		return off_feature;
	}

	public void setOff_feature(String off_feature) {
		this.off_feature = off_feature;
	}

	public int getOff_likeCount() {
		return off_likeCount;
	}

	public void setOff_likeCount(int off_likeCount) {
		this.off_likeCount = off_likeCount;
	}

	public String getOff_image() {
		return off_image;
	}

	public void setOff_image(String off_image) {
		this.off_image = off_image;
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

	///
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getMap_gu() {
		return map_gu;
	}

	public void setMap_gu(String map_gu) {
		this.map_gu = map_gu;
	}

	public String getMap_dong() {
		return map_dong;
	}

	public void setMap_dong(String map_dong) {
		this.map_dong = map_dong;
	}

	public double getMap_la() {
		return map_la;
	}

	public void setMap_la(double map_la) {
		this.map_la = map_la;
	}

	public double getMap_ln() {
		return map_ln;
	}

	public void setMap_ln(double map_ln) {
		this.map_ln = map_ln;
	}

	public List<String> getOff_imgs() {
		return off_imgs;
	}

	public void setOff_imgs(List<String> off_imgs) {
		this.off_imgs = off_imgs;
	}
}