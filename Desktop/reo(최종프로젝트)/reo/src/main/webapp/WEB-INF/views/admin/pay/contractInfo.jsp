<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-계약서</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/pay/contractInfo.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/pay/contractInfo.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<div class="windowMenu">
			<i class="fas fa-times" title="닫기"></i>
			<i class="fas fa-file-image" title="PDF로 저장"></i>
			<i class="fas fa-print" title="프린트 하기"></i>
		</div>
		<div>
			<!-- <iframe id="contractIframe" name="contractIframe" src="" width="773" height="795" title="계약서"></iframe> -->
			<iframe id="contractIframe" name="contractIframe" src="" width="1185" height="850" title="계약서"></iframe>
		</div>
		<form action="contractIframe.reo" method="POST" id="contractForm" target="contractIframe">
			<input type="hidden" name="pay_no" value="${pay_no}"/>
		</form>
	</body>
</html>
