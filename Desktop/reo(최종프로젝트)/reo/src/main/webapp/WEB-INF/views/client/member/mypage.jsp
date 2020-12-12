<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>REO</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/mypage.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<jsp:include page="/resources/include/client/header.jsp" />

<body>
	<section class="mypage">
		<div class="contents col-12 contents-wrap">
			<h1 class="entry-title" style="text-align: center;"><span>내 정보</span></h1>
			<hr>
			<div>
				<table class="myinfo col-12">
					<tr>
						<th>이메일</th>
						<td>${member.mem_email}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${member.mem_name}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>(${member.mem_zipcode}) ${member.mem_roadaddress} ${member.mem_detailaddress}</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${member.mem_birth}</td>
					</tr>
					<c:if test="${member.mem_agentName ne null}">
						<tr>
							<th>기업 명</th>
							<td>${member.mem_agentName}</td>
						</tr>
					</c:if>
				</table>
				<hr>
				<div class="info text-center">
					<button type="button" class="btn btn-primary" onclick="location.href='./myinfo.reo'">정보수정</button>
					<button type="button" class="btn btn-danger"
						onclick="location.href='./mydeleteMember.reo'">회원탈퇴</button>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
</body>

</html>