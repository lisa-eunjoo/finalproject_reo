<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>로그인</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript" src="https://apis.google.com/js/platform.js" async defer></script>
	<script type="text/javascript" src="https://www.google.com/recaptcha/api.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="resources/css/client/member/login.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<%
String clientId = "pMi1P5sDCZgxpAjtQudO";//애플리케이션 클라이언트 아이디값";
String redirectURI = URLEncoder.encode("/index.reo", "UTF-8");
SecureRandom random = new SecureRandom();
String state = new BigInteger(130, random).toString();
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
apiURL += "&client_id=" + clientId;
apiURL += "&redirect_uri=" + redirectURI;
apiURL += "&state=" + state;
session.setAttribute("state", state);
%>
<body>
	<div class="container">
		<div class="omb_login col-12">
			<div class="row omb_row-sm-offset-3">
				<div class="col-12">
					<a class="logo" href="index.reo">
						<img alt="logo" src="resources/img/REO.png">
					</a>
				</div>
				<div class="omb col-12">
					<form class="omb_loginForm" action="${pageContext.request.contextPath}/login" method="POST" id="loginForm">
						<div class="input-group">
							<span class="input-group-addon"><i class="fas fa-user"></i></span>
							<input type="text" class="form-control mem_email" name="mem_email"
								placeholder="email address" autofocus="autofocus" />
						</div>
						<p class="loginEmail"></p>
						<div class="input-group">
							<span class="input-group-addon"><i class="fas fa-lock"></i></span>
							<input type="password" class="form-control mem_pw" name="mem_pw" placeholder="Password" />
						</div>
						<p class="loginPw">
							<c:choose>
								<c:when test="${param.error == 1}">
									이메일이나 비밀번호가 일치하지 않습니다.
								</c:when>
								<c:when test="${param.error == 2}">
									이미 로그인중인 이메일입니다.
								</c:when>
							</c:choose>
							
						</p>

						<input type="submit" class="btn btn-lg btn-primary btn-block" id="submitBtn" value="로그인"/>
						<div class="row omb_row-sm-offset-12">
							<div class="col-12 col-sm-12">
								<p class="pw">비밀번호를 잊으셨나요? <a href="passchange.reo"> 비밀번호 찾기</a></p>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="omb row omb_row-sm-offset-3 omb_loginOr">
				<div class="col-12">
					<hr class="omb_hrOr">
					<span class="omb_spanOr">or</span>
				</div>
			</div>
			<div class="omb row omb_row-sm-offset-3 omb_socialButtons">
				<button type="button" class="naver col-12 col-md-4" onclick="location.href='${url}'"><img
						src="resources/img/naver.png"></button>
				<button type="button" class="kakao col-12 col-md-4"
					onclick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=7841b869ade90040a71d6f41785b6376&redirect_uri=http://localhost:8090/reo/oauth.reo&response_type=code'"><img
						src="resources/img/kakao_login_medium.png"></button>
				<button type="button" class="google col-12 col-md-4" onclick="location.href='${google_url}'"><img
						src="resources/img/google.png"></button>
				<div class="col-12">
					<p class="omb_signup">아직 회원이 아니세요? <a href="agreement.reo"> 회원가입</a></p>
				</div>
			</div>
			<div class="col-12">
				<div class="bt_sig text-center">
					<a href="agreement.reo" class="btn btn-lg btn-primary">일반회원</a>
					<a href="agreement.reo?buisness=buisness" class="btn btn-lg btn-primary">기업회원</a>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$("#loginForm").on("submit", function() {
		var params = "mem_email=" + $('.mem_email').val() + "," + "mem_pw=" + $('.mem_pw').val();
		var email = "mem_email=" + $('.mem_email').val();
		if ($('.mem_email').val() == "" || $('.mem_email').val() == null) {
			if ($('.mem_pw').val() == "") {
				$('.loginEmail').text("이메일을 입력해 주시길 바랍니다.");
				$('.loginEmail').addClass("text-danger");
				$('.loginPw').text("비밀번호를 입력해 주시길 바랍니다.");
				$('.loginPw').addClass("text-danger");
				$('.mem_email').focus();
			} else {
				$('.loginEmail').text("이메일을 입력해 주시길 바랍니다.");
				$('.loginEmail').addClass("text-danger");
				$('.loginPw').css("display", "none");
				$('.mem_email').focus();
			}
		} else if ($('.mem_email').val() == "" || $('.mem_pw').val() == "") {
			$('.loginPw').text("비밀번호를 입력해 주시길 바랍니다.");
			$('.loginPw').addClass("text-danger");
			$('.loginEmail').css("display", "none");
			$('.mem_pw').focus();
		} else {
			return true;
			/* $.ajax({
				type: "POST",
				url: "./emailChk.reo",
				data: email,
				success: function (data) {
					console.log(data)
					if (data == 0) {
						$('.loginPw').text("email/password를 확인해 주세요.");
						$('.loginPw').css("color", "red");
					} else {
						return true;
					} else {
						$.ajax({
							type: "POST",
							url: "./pwChk.reo",
							data: params,
							success: function (data) {
								if (data == false) {
									$('.loginPw').text("email/password를 확인해 주세요.");
									$('.loginPw').css("color", "red");
								} else {
									$('.loginPw').css("display", "none");
									return true;
								}
							}
						});
					}
				},
				error: function () {
					alert('실패!');
				}
			}); */
		};
		return false;
	});

</script>

</html>