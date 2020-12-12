package kr.co.reo.common.dto;

import java.sql.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;

@Data
@Document
public class SearchTitleDTO {
	@Id
	private String seq;
	private String title;
	private String mem_email;
	private Date date;
}