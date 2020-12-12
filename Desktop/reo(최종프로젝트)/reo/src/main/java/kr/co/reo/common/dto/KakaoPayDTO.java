package kr.co.reo.common.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class KakaoPayDTO {
	private String tid; // 결제 고유 번호, 20자
	private boolean tms_result;
	private String next_redirect_app_url; // 요청한 클라이언트(Client)가 모바일 앱일 경우 카카오톡 결제 페이지 Redirect URL
	private String next_redirect_mobile_url; // 요청한 클라이언트가 모바일 웹일 경우 카카오톡 결제 페이지 Redirect URL
	private String next_redirect_pc_url; // 요청한 클라이언트가 PC 웹일 경우 카카오톡으로 결제 요청 메시지(TMS)를 보내기 위한 사용자 정보 입력 화면 Redirect URL
	private String android_app_scheme; // 카카오페이 결제 화면으로 이동하는 Android 앱 스킴(Scheme)
	private String ios_app_scheme; // 카카오페이 결제 화면으로 이동하는 iOS 앱 스킴
	private Date created_at; // 결제 준비 요청 시간
	private String partner_order_id; // 가맹점 주문번호, 최대 100자
	private String partner_user_id; // 가맹점 회원 id, 최대 100자
}