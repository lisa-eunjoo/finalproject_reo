package kr.co.reo.client.member.service;

import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class SessionListener implements HttpSessionBindingListener {

	// 싱글톤 객체를 담을 변수
	private static SessionListener sessionListener = null;
	// 로그인한 접속자를 저장한 HashTable (데이터를 해시하여 테이블 내의 주소를 계산하고 데이터를 담는 것 ,
	// 해시함수 알고리즘은 나눗셈법. 자릿수 접기 등등)
	private static Hashtable<HttpSession, String> loginUsers = new Hashtable<>();

	// 싱글톤 처리
	public static synchronized SessionListener getInstance() {
		if (sessionListener == null) {
			sessionListener = new SessionListener();
		}
		return sessionListener;
	}

	// 세션이 연결시 호출 (해시테이블에 접속자 저장)
	public void valueBound(HttpSessionBindingEvent event) {
		loginUsers.put(event.getSession(), event.getSession().getAttribute("mem_email").toString());
	}

	// 세션이 끊겼을시 호출
	public void valueUnbound(HttpSessionBindingEvent event) {
		loginUsers.remove(event.getSession());
		System.out.println("mem_email : " + event.getName() + " 로그아웃");
	}

	// 해당 아이디의 동시 사용을 막기위해서 이미 사용중인 아이디인지를 확인한다.
	public boolean isUsing(String mem_email) {
		return loginUsers.containsValue(mem_email);
	}

	// 강제 로그아웃
	public void forceLogout(String mem_email) {
		for (HttpSession session : loginUsers.keySet()) {
			if (loginUsers.get(session).equals(mem_email)) {
				session.invalidate();
				break;
			}
		}
	}

	// 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
	public void setSession(HttpSession session, String mem_email) {
		// 이순간에 Session Binding이벤트가 일어나는 시점
		// name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
		session.setAttribute(mem_email, this); // login에 자기자신을 집어넣는다.
	}

	// 입력받은 세션Object로 아이디를 리턴한다.
	public String getmem_email(HttpSession session) {
		return (String) loginUsers.get(session);
	}

	// 현재 접속한 총 사용자 수
	public int getUserCount() {
		return loginUsers.size();
	}

	// 현재 접속중인 모든 사용자 아이디를 출력
	public void printloginUsers() {
		System.out.println("===========================================");
		System.out.print("접속자 목록 : ");
		int count = 0;
		for (HttpSession session : loginUsers.keySet()) {
			System.out.print(loginUsers.get(session) + ", ");
			count++;
			if (count > 10) {
				System.out.println();
				count = 0;
			}
		}
		System.out.println("===========================================");
	}

	// 현재 접속중인 모든 사용자를 리턴
	public String getUsers() {
		return loginUsers.toString();
	}
}
