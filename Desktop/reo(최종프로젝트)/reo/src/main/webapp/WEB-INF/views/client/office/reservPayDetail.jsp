<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>상세 예약 확인</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/reservation/reservation.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
<body>
<section class="wrapper">
	<div class="resheading"><h3>예약 정보 확인</h3></div>
		<form name="reservform" id="makeReserv" action="makeReserv.reo" method="POST">
			<fmt:parseNumber var="starttime" value="${fn:substring(reservdto.res_startdatetime,11,13) }"/>
			<fmt:parseNumber var="endtime" value="${fn:substring(reservdto.res_enddatetime,11,13) }" />
			<input type="hidden" id="off_no" name="off_no" value="${officedto.off_no}"/>
			<input type="hidden" name="res_startdatetime" value="${reservdto.res_startdatetime }">
			<input type="hidden" name="res_enddatetime" value="${reservdto.res_enddatetime }">
			<input type="hidden" name="res_datetime" value="${reservdto.res_datetime }">
			<input type="hidden" name="room_price" value="${reservdto.room_price }">
			<input type="hidden" name="off_name" value="${officedto.off_name }">
			<div class="container">
				<table class="table table-hover">
					<tr>
						<td class="title">예약 공간</td>
						<td class="text">${officedto.off_name}</td>
					</tr>
					<tr>
						<td class="title">예약 일정</td>
						<td class="text"><c:out value="${fn:substring(reservdto.res_startdatetime,0,16)}"/> ~ <c:out value="${fn:substring(reservdto.res_enddatetime,11,16)}"/> (<c:out value="${endtime-starttime}"/>시간)</td>
					</tr>
					<tr>
						<td class="title">예약 인원</td>
						<td class="text">${reservdto.res_people}</td>
					</tr>
					<tr>
						<td class="title">결제 예정 금액</td>
						<td class="text">${reservdto.room_price}</td>
					</tr>
					<tr>
						<td class="title">요청사항</td>
						<td class="text">${reservdto.res_memo}</td>
					</tr>
					<tr>
						<td class="title">결제방법 선택</td>
						<td class="text">
						<input type="radio" name="optradio"><label for="paychoice">무통장 입금</label>
						<input type="radio" name="optradio"><label for="paychoice"><img src="${pageContext.request.contextPath}/resources/img/kakaopay.png" border="0" width="50" height="35" />&nbsp;카카오 페이</label>
						</td>
					</tr>
					<tr>
						<td class="title">주의사항</td>
						<td class="text"><i class="far fa-check-circle"></i> 결제 전 예약문의시 대관 목적과 사용인원을 반드시 말씀해주세요.<br><i class="far fa-check-circle"></i> 대관시간은 입장 후 부터 퇴장까지의 시간입니다. (준비시간 및 정리시간도 대관시간에 포함됩니다.)<br><i class="far fa-check-circle"></i> 시설물보호를 위해 보증금을 받고있으며, 대관 후 시설물 체크한 뒤 보증금을 즉시 돌려드립니다.</td>
					</tr>
					<tr>
						<td class="title">환불규정 안내</td>
						<td class="text"><i class="far fa-check-circle"></i> 결제 후 2시간 이내에는 100% 환불이 가능합니다. (단, 이용시간 전까지만 가능)<br><i class="far fa-check-circle"></i> 이용 2일 전	환불 불가<br><i class="far fa-check-circle"></i> 이용 전날 환불 불가<br><i class="far fa-check-circle"></i> 이용 당일 환불 불가</td>
					</tr>
					</table>
				<input type="submit" id="myBtn" class="btn default" value="예약하기">
			</div>
		</form>
</section>
<div id="footer">
</div>
</body>
</html>