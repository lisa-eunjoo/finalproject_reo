<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>잘못된 접근</title>
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
				<i class="fas fa-exclamation-triangle"></i>
				<h3>잘못된 접근입니다.</h3>
				<p>웹 사이트에서 이 웹 페이지 표시를 거부했습니다.</p>
				<p>웹 사이트에 연결할 수 있지만, 해당 페이지를 접근할 수 있는 권한이 없습니다.</p>
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