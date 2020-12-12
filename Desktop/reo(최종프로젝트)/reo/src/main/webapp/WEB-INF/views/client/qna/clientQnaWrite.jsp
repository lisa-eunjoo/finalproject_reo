<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>QNA 상세</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<section>
		<div class="container">
			<h1>글쓰기 화면</h1>
			<form action="insertQna.reo" method="post" class="col-12">
				<input type="hidden" name="qna_email" value="${mem_email}">
				<input type="hidden" name="qna_name" value="${mem_name}">
				<div class="form-group">
					<label for="qna_title">제목</label>&nbsp;
					<input class="form-control" type="text" name="qna_title" size="50" maxlength="100"
						autofocus="autofocus" required="required" placeholder="제목을 입력하세요." />
				</div>
				<div class="form-group">
					<label for="qna_content">내용</label>
					<textarea class="form-control" name="qna_content" cols="67" rows="15" maxlength="1500"
						required="required" placeholder="내용을 입력하세요."></textarea>
				</div>
				<div class="form-group">
					<label for="qna_secret">비밀글</label>&nbsp;
					<input type="radio" name="qna_secret" value="0" checked="checked">아니오
					<input type="radio" name="qna_secret" value="1">네
					<input type="password" name="qna_password" size=4 maxlength=4>
				</div>
				<div class="text-center">
					<button class="btn btn-primary" type="submit">등록</button>
					<a href="javascript:history.go(-1)" class="btn btn-primary">뒤로</a>
				</div>
			</form>
		</div>
	</section>
</body>
</html>