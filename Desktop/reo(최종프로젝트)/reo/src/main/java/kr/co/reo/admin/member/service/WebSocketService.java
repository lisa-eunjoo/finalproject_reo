package kr.co.reo.admin.member.service;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component("webSocketService")
@RequestMapping("/ws")
public class WebSocketService extends TextWebSocketHandler {

	private Map<String, WebSocketSession> users = new HashMap<>();
	private Map<String, String> auth = new HashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session.getId());
		System.out.println(session.getPrincipal().getName());
		users.put(session.getId(), session);
		session.sendMessage(new TextMessage("필요한 게 있으시면 언제든지 말씀해주세요."));
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		JSONParser parser = new JSONParser();
		JSONObject object = (JSONObject) parser.parse(message.getPayload());
		String type = (String) object.get("type");
		String to = (String) object.get("to");
		String msg = (String) object.get("message");
		WebSocketSession toSession = getMem_email(to);
		toSession.sendMessage(new TextMessage(session.getId() + "|" + message));
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session.getId());
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		super.handleTransportError(session, exception);
	}

	private WebSocketSession getMem_email(String mem_email) {
		return users.get(mem_email);
	}

	private void sendAll(String msg) throws Exception {
		for (String mem_email : users.keySet()) {
			WebSocketSession session = users.get(mem_email);
			if (session.isOpen()) {
				synchronized (session) {
					session.sendMessage(new TextMessage(msg));
				}
			}
		}
	}

}