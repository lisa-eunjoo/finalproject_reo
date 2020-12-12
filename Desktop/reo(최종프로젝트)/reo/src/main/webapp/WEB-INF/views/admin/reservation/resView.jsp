<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>관리자-상세 예약 확인</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/reservation/reservation.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/nav.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>

<body>
	<jsp:include page="/resources/include/admin/nav.jsp">
		<jsp:param name="reservation" value="" />
	</jsp:include>
	<section>
		<div id="main" class="col-lg-10 offset-lg-2 col-md-12 col-12 comFont">
			<fmt:parseNumber var="starttime" value="${fn:substring(rescheck.res_startdatetime,11,13) }" />
			<fmt:parseNumber var="endtime" value="${fn:substring(rescheck.res_enddatetime,11,13) }" />
			<div class="text-center">
				<h5>관리자 예약 상세 확인</h5><br>
			</div>
			<div class="myinfo col-md-12">
				<div class="list_wrap">
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="fas fa-check"></i> 예약 번호</dt>
						<dd class="flex">${rescheck.res_no}</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="far fa-envelope"></i> 예약자 email</dt>
						<dd class="flex">${rescheck.mem_email}</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="fas fa-user"></i> 예약자 이름</dt>
						<dd class="flex">${rescheck.mem_name}</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="fas fa-mobile-alt"></i> 예약자 전화번호</dt>
						<dd class="flex">${rescheck.mem_tel}</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="far fa-building"></i> 예약 공간</dt>
						<dd class="flex">${rescheck.off_name}</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="fas fa-map-marker-alt"></i> 상세 주소</dt>
						<dd class="flex">${rescheck.off_stdAddr}</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="far fa-clock"></i> 예약 단위</dt>
						<dd class="flex">${rescheck.off_unit}</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="far fa-calendar-alt"></i> 예약 일정</dt>
						<dd class="flex">
							<c:choose>
								<c:when test="${rescheck.off_unit eq '시간' }">
									<fmt:formatDate value="${rescheck.res_startdatetime}" pattern="yyyy-MM-dd HH:mm" />
									~
									<fmt:formatDate value="${rescheck.res_enddatetime}" pattern="HH:mm" />
									(${endtime-starttime} 시간)
								</c:when>
								<c:when test="${rescheck.off_unit eq '월' }">
									<fmt:formatDate value="${rescheck.res_startdatetime}" pattern="yyyy-MM-dd" /> ~
									<fmt:formatDate value="${rescheck.res_enddatetime}" pattern="yyyy-MM-dd" />
								</c:when>
							</c:choose>
						</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="fas fa-user-friends"></i> 예약 인원</dt>
						<dd class="flex">${rescheck.res_people} 명</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="fas fa-won-sign"></i> 결제 금액</dt>
						<dd class="flex">${rescheck.room_price}원</dd>
					</dl>
					<dl class="flex_box refund">
						<dt class="flex tit"><i class="far fa-sticky-note"></i> 요청사항</dt>
						<dd class="flex">${rescheck.res_memo}</dd>
					</dl>
				</div><br>
				<div class="text-center">
					<c:if test="${rescheck.res_state != '예약신청' && rescheck.pay_no != null}">
					<button onclick="location.href='payInfo.reo?payNo=${rescheck.pay_no}'" class="btn btn-success">결제정보</button>
					</c:if>
					<button type="button" onclick="location.href='./resList.reo'" class="btn btn-primary">목록</button>
				</div>
			</div>
		</div>
	</section>
</body>

</html>