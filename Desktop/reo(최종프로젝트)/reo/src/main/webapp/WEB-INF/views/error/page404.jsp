<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>페이지를 찾을 수 없습니다.</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<main class="container">
			<h1 class="reo textCenter">
				<img alt="로고" src="${pageContext.request.contextPath}/resources/img/REO.png"/>
				<a href="${pageContext.request.contextPath}/index.reo">R E O</a>
			</h1>
			<div class="errorBox">
				<i class="fas fa-times-circle"></i>
				<h3>요청하신 페이지를 찾을 수 없습니다.</h3>
				<p>입력하신 주소가 잘못되었거나, 페이지의 주소의 변경 혹은 삭제로 인해 현재 사용하실 수 없습니다.</p>
				<p>입력하신 페이지의 주소가 정확한지 다시 한번 확인해 주시길 부탁드립니다.</p>
				<p>서비스에 이용에 불편을 드려 죄송합니다.</p>
				<br/>
				<p>관련하여 문의가 있으시면 언제든지, Q&amp;A로 문의하여 주십시오.</p>
				<br/>
				<button type="button" class="btn btn-secondary" onclick="history.back()">이전 페이지로</button>&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/index.reo'">홈페이지로</button>
			</div>
		</main>
		<footer></footer>
	</body>
</html>