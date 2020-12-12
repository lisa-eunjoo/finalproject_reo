<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "No-cache");
	response.addHeader("Cache-Control", "No-store");
	response.setDateHeader("Expires", 1L);
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>Home</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<header></header>
		<section>
			<h1>
				Hello world!  
			</h1>
			<p>  The time on the server is ${serverTime}. </p>
		</section>
		<footer></footer>
	</body>
</html>