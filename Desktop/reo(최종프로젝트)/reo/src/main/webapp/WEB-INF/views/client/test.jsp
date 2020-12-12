<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>내 결제 상세</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<%-- <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/pay/payInfo.css"> --%>
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<h2>Hello World!</h2>
		<div id="chartdata"></div>
		<br/><br/>
		<input type="text" id="message" placeholder="메세지를 입력하세요.">
		<input type="button" id="sendBtn" value="Send">
	</body>
	<script type="text/javascript">
		var sock = new SockJS("http://localhost:8090/reo/ws/");
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		
		$(function() {
			$("#sendBtn").click(function() {
				sendMessage();
			});
		});
		
		function sendMessage() {
			sock.send($("#message").val());
		}
		
		function onMessage(msg) {
			var data = msg.data;
			var sessionid = null;
			var message = null;
			
			var strArray = data.split("|");
			
			var currentuser_session = $("#sessionuserid").val();
			sessionid = strArray[0];
			message = strArray[1];
			
			if(sessionid == currentuser_session) {
				var printHTML = "<div class='well'>";
				printHTML += "<div class='alert alert-info'>";
				printHTML += "<strong>[" + sessionid + "] : " + message + "</strong>";
				printHTML += "</div></div>";
				
				$("#chartdata").append(printHTML);
			} else {
				var printHTML = "<div class='well'>";
				printHTML += "<div class='alert alert-warning'>";
				printHTML += "<strong>[" + sessionid + "] : " + message + "</strong>";
				printHTML += "</div></div>";
				
				$("#chartdata").append(printHTML);
			}
		}
		
		function onClose(msg) {
			$("#data").append("연결 끊김");
		}
	</script>
</html>