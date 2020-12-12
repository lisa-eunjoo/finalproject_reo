<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-회원 정보</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/member/member.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<jsp:include page="/resources/include/admin/nav.jsp"><jsp:param name="member" value=" "/></jsp:include>
		<section>
			<div id="main" class="col-lg-10 offset-lg-2 col-md-12 col-12">
				<div class="container">
					<h2 class="title">회원 상세</h2>
					<form action="insertMember.reo" method="POST" id="memberForm">
						<input type="hidden" name="mem_no" id="mem_no" value="${member.mem_no == null ? 0 : member.mem_no}"/>
						<div class="form-group row">
							<label for="mem_email" class="col-sm-2 col-form-label">Email</label>
							<div class="col-sm-10">
								<input type="email" id="mem_email" name="mem_email" class="form-control form-control-lg" value="${member.mem_email}" placeholder="E-Mail" required="required"/>
								<div id="emailCheck" class="check"></div>
							</div>
						</div>
						<c:if test="${member.mem_no == null || member.mem_no == 0}">
						<div class="form-group row mem_pwBox">
							<label for="mem_pw" class="col-sm-2 col-form-label">비밀번호</label>
							<div class="col-sm-10">
								<input type="password" id="mem_pw" name="mem_pw" class="form-control form-control-lg" placeholder="Password" required="required"/>
								<div id="passwordCheck" class="check"></div>
							</div>
						</div>
						<div class="form-group row mem_pwBox">
							<label for="mem_pwCheck" class="col-sm-2 col-form-label">비밀번호 확인</label>
							<div class="col-sm-10">
								<input type="password" id="mem_pwCheck" class="form-control form-control-lg" placeholder="Password Check" required="required"/>
							</div>
						</div>
						</c:if>
						<div class="form-group row">
							<label for="mem_name" class="col-sm-2 col-form-label">이름</label>
							<div class="col-sm-10">
								<input type="text" id="mem_name" name="mem_name" class="form-control form-control-lg" value="${member.mem_name}" placeholder="Name" required="required"/>
							</div>
						</div>
						<div class="form-group row">
							<label for="mem_name" class="col-sm-2 col-form-label">전화번호</label>
							<div class="col-sm-10">
								<input type="tel" id="mem_tel" name="mem_tel" class="form-control form-control-lg" value="${member.mem_tel}" placeholder="Tel" required="required"/>
							</div>
						</div>
						<div class="form-group row">
							<label for="daumPostcodeBtn" class="col-sm-2 col-form-label">주소</label>
							<div class="col-sm-10">
								<div class="form-group flex">
									<input type="text" name="mem_zipcode" id="mem_zipcode" class="form-control form-control-lg col-sm-6" value="${member.mem_zipcode}" placeholder="우편번호" required="required"/>
									<input type="button" id="daumPostcodeBtn" class="col-sm-3 offset-sm-1 btn btn-info" onclick="daumPostcode()" value="우편번호 찾기">
								</div>
								<div class="form-group flex">
									<input type="text" name="mem_roadaddress" id="mem_roadaddress" class="form-control form-control-lg" value="${member.mem_roadaddress}" placeholder="도로명주소" required="required"/>
								</div>
								<div class="form-group flex">
									<input type="text" name="mem_detailaddress" id="mem_detailaddress" class="form-control form-control-lg" value="${member.mem_detailaddress}" placeholder="상세주소" required="required"/>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="mem_birth" class="col-sm-2 col-form-label">생년월일</label>
							<div class="col-sm-10">
								<jsp:useBean id="today" class="java.util.Date"/>
								<input type="date" id="mem_birth" name="mem_birth" class="form-control form-control-lg" value="${member.mem_birth}" min="1900-01-01" max="<fmt:formatDate value='${today}' pattern='yyyy-MM-dd'/>"/>
							</div>
						</div>
						<c:if test="${mem_sector == null}">
						<div class="form-group row">
							<label for="ordinary" class="col-sm-2 col-form-label">사업자 구분</label>
							<div class="col-sm-10 textLeft">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="mem_sector" id="ordinary" value="일반" checked="checked">
									<label class="form-check-label" for="ordinary">일반</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="mem_sector" id="business" value="사업자">
									<label class="form-check-label" for="business">사업자</label>
								</div>
							</div>
						</div>
						</c:if>
						<div id="biz">
							<!-- 사업자 번호 -->
							<div class="form-group row">
								<label for="mem_buisnessNo" class="col-sm-2 col-form-label">사업자 번호</label>
								<div class="flex col-sm-10">
									<input type="number" class="form-control form-control-lg col-sm-6 email" id="mem_buisnessNo" name="mem_buisnessNo" placeholder="ex)1234567890" min="0"/>
									<button type="button" class="col-sm-3 offset-sm-1 btn btn-info" id="biusnessbtn" onclick="buisnessno()">조회</button>
								</div>
							</div>
							<!-- 기업 이름 -->
							<div class="form-group row">
								<label for="mem_agentName" class="col-sm-2 col-form-label">기업 이름</label>
								<div class="col-sm-10">
									<input type="text" name="mem_agentName" id="mem_agentName" class="form-control form-control-lg" placeholder="이름"/>
								</div>
							</div>
						</div>
						<input type="hidden" value="aaaa" name="aaaa"/>
					</form>
					<div class="btnList">
						<button id="modifyBtn" class="btn btn-success">회원 수정</button>&nbsp;&nbsp;&nbsp;
						<button id="deleteBtn" class="btn btn-danger" data-memno="${member.mem_no}">회원 삭제</button>&nbsp;&nbsp;&nbsp; 
						<a href="memberList.reo?${query}" class="btn btn-info">회원 목록</a>
					</div>
				</div>
			</div>
		</section>
	</body>
	<script src="${pageContext.request.contextPath}/resources/js/admin/member/memberInfo.js"></script>
</html>