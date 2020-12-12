package kr.co.reo.common.dto;

public class QnaDTO {
	private int qna_no;
	private String qna_email;
	private String qna_name;
	private String qna_title;
	private String qna_content;
	private int qna_hits;
	private String qna_date;
	private int qna_secret;
	private String qna_password;
	private int qna_report;

	private int answer_exist;
	private String answer_email;
	private String answer_name;
	private String answer_title;
	private String answer_content;
	private String answer_date;
	private int answer_report;

	private int report_no;
	private String report_email;
	private int report_qnanum;
	private int report_type;

	public int getqna_no() {
		return qna_no;
	}

	public void setqna_no(int qna_no) {
		this.qna_no = qna_no;
	}

	public String getQna_email() {
		return qna_email;
	}

	public void setQna_email(String qna_email) {
		this.qna_email = qna_email;
	}

	public String getQna_name() {
		return qna_name;
	}

	public void setQna_name(String qna_name) {
		this.qna_name = qna_name;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public int getQna_hits() {
		return qna_hits;
	}

	public void setQna_hits(int qna_hits) {
		this.qna_hits = qna_hits;
	}

	public String getQna_date() {
		return qna_date;
	}

	public void setQna_date(String qna_date) {
		this.qna_date = qna_date;
	}

	public int getQna_secret() {
		return qna_secret;
	}

	public void setQna_secret(int qna_secret) {
		this.qna_secret = qna_secret;
	}

	public String getQna_password() {
		return qna_password;
	}

	public void setQna_password(String qna_password) {
		this.qna_password = qna_password;
	}

	public int getQna_report() {
		return qna_report;
	}

	public void setQna_report(int qna_report) {
		this.qna_report = qna_report;
	}

	public int getAnswer_exist() {
		return answer_exist;
	}

	public void setAnswer_exist(int answer_exist) {
		this.answer_exist = answer_exist;
	}

	public String getAnswer_email() {
		return answer_email;
	}

	public void setAnswer_email(String answer_email) {
		this.answer_email = answer_email;
	}

	public String getAnswer_name() {
		return answer_name;
	}

	public void setAnswer_name(String answer_name) {
		this.answer_name = answer_name;
	}

	public String getAnswer_title() {
		return answer_title;
	}

	public void setAnswer_title(String answer_title) {
		this.answer_title = answer_title;
	}

	public String getAnswer_content() {
		return answer_content;
	}

	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}

	public String getAnswer_date() {
		return answer_date;
	}

	public void setAnswer_date(String answer_date) {
		this.answer_date = answer_date;
	}

	public int getAnswer_report() {
		return answer_report;
	}

	public void setAnswer_report(int answer_report) {
		this.answer_report = answer_report;
	}

	public int getreport_no() {
		return report_no;
	}

	public void setreport_no(int report_no) {
		this.report_no = report_no;
	}

	public String getReport_email() {
		return report_email;
	}

	public void setReport_email(String report_email) {
		this.report_email = report_email;
	}

	public int getReport_qnanum() {
		return report_qnanum;
	}

	public void setReport_qnanum(int report_qnanum) {
		this.report_qnanum = report_qnanum;
	}

	public int getReport_type() {
		return report_type;
	}

	public void setReport_type(int report_type) {
		this.report_type = report_type;
	}

}
