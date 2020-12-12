<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-로그인</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/member/adminLogin.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<div class="container">
			<div class="logo">
				<a href="${pageContext.request.contextPath}/index.reo">
					<img src="${pageContext.request.contextPath}/resources/img/REO.png" alt="REO 로고" title="REO 로고"/>
				</a>
			</div>
			<div class="col-sm-8 offset-sm-2">
				<form action="${pageContext.request.contextPath}/login" method="POST" id="login-form">
					<div class="input-group">
						<div class="input-group-prepend">
							<label for="mem_email" class="input-group-text"><i class="fas fa-user"></i></label>
						</div>
						<input type="text" id="mem_email" name="mem_email" class="form-control" placeholder="Admin Id" autofocus="autofocus"/>
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<label for="mem_pw" class="input-group-text"><i class="fas fa-lock"></i></label>
						</div>
						<input type="password" id="mem_pw" name="mem_pw" class="form-control" placeholder="Password"/>
					</div>
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
					<span class="adminLoginCheck">${error != null ? '아이디나 비밀번호가 일치하지 않습니다.' : '' }</span>
					<input type="submit" class="form-control btn btn-primary" value="로그인"/>
				</form>
			</div>
		</div>
	</body>
</html>