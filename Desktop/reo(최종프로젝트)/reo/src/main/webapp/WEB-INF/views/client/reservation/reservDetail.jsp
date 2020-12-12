<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>상세 예약</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/reservation/reservation.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<body>
	<div class="modal fade" id="resdelmodal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">예약 취소</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<p>예약을 취소하시겠습니까?<br>취소한 예약 내역은 되돌릴 수 없습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" id="delBtn" class="btn btn-danger">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/resources/include/client/header.jsp" />
	<section class="wrapper container">
		<div class="container contents-wrap">
			<div class="row my_reo col-12">
				<div class="use_status col-12">
					<div class="col-12 default_tabs t3">
						<ul class="col-12">
							<li class="col-12"><a href="mybooking.reo" style="border: 1px solid lightgray;">예약 정보</a></li>
						</ul>
					</div>
					<fmt:parseNumber var="starttime" value="${fn:substring(rescheck.res_startdatetime,11,13) }" />
					<fmt:parseNumber var="endtime" value="${fn:substring(rescheck.res_enddatetime,11,13) }" />
					<div class="myinfo col-12 row">
						<div id="resimg"
							class="carousel slide swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal col-lg-6"
							data-ride="carousel">
							<div class="carousel-inner">
								<c:forEach items="${off_images}" var="image">
									<div class="carousel-item">
										<img src="${pageContext.request.contextPath}/resources/upload/${image.offimg_name}"
											alt="사무실 이미지" />
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="list_wrap col-lg-6">
							<dl class="flex_box refund">
								<dt class="flex tit"><i class="fas fa-check"></i> 예약 번호</dt>
								<dd class="flex">${rescheck.res_no} 
								<c:choose>
									<c:when test="${rescheck.res_state == '예약신청'}"><span class="resApply">(${rescheck.res_state})</span></c:when>
									<c:when test="${rescheck.res_state == '예약완료'}"><span class="resSuccess">(${rescheck.res_state})</span></c:when>
									<c:otherwise><span class="resCancel">(${rescheck.res_state})</span></c:otherwise>
								</c:choose>
								</dd>
							</dl>
							<dl class="flex_box refund">
								<dt class="flex tit"><i class="far fa-building"></i> 예약 공간 </dt>
								<dd class="flex">${rescheck.off_name} <br> <a id="reslink"
										href="./getOffice.reo?off_no=${rescheck.off_no}">[공간 소개로 이동]</a></dd>
							</dl>
							<dl class="flex_box refund">
								<dt class="flex tit"><i class="fas fa-map-marker-alt"></i> 상세 주소</dt>
								<dd class="flex">${rescheck.off_stdAddr}</dd>
							</dl>
							<dl class="flex_box refund">
								<dt class="flex tit"><i class="far fa-calendar-alt"></i> 예약 일정</dt>
								<dd class="flex">
									<c:choose>
										<c:when test="${rescheck.off_unit eq '시간' }">
											<td class="text">
												<fmt:formatDate value="${rescheck.res_startdatetime}"
													pattern="yyyy-MM-dd HH:mm" /> ~
												<fmt:formatDate value="${rescheck.res_enddatetime}" pattern="HH:mm" />
												(${endtime-starttime} 시간)</td>
										</c:when>
										<c:when test="${rescheck.off_unit eq '월' }">
											<td class="text">
												<fmt:formatDate value="${rescheck.res_startdatetime}"
													pattern="yyyy-MM-dd" /> ~
												<fmt:formatDate value="${rescheck.res_enddatetime}"
													pattern="yyyy-MM-dd" />
											</td>
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
						</div>
					</div>
					<div>
						<div class="text-center">
							<br><br>
							<c:if test="${rescheck.res_state != '예약신청' && rescheck.pay_no != null}">
								<a href="myPayInfo.reo?payNo=${rescheck.pay_no}" class="btn btn-outline-success">결제정보</a>
							</c:if>
							<c:choose>
							<c:when test="${rescheck.res_state eq '예약취소'}">
							</c:when>
							<c:otherwise>
								<c:choose>
								<c:when test="${rescheck.res_state eq '예약신청'}">
									<button type="button" class="btn btn-outline-success" onclick="location.href='./kPayReady/${rescheck.off_no}/${rescheck.res_no}/<fmt:parseNumber type="number" value="${rescheck.room_price}" />.reo'">결제</button>
										<a href="" class="btn btn-outline-danger openCancelModal" data-toggle="modal" 
										data-res="${rescheck.res_no}" data-target="#resCanmodal">예약취소</a>
								</c:when>
								<c:when test="${rescheck.res_state eq '예약완료'}">
										<a href="" class="btn btn-outline-danger openDeleteModal"
										data-toggle="modal" data-id="${rescheck.res_no}"
										data-target="#resdelmodal">환불</a>
								</c:when>
								</c:choose>
							</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-outline-primary" onclick="location.href='./mybooking.reo'">목록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
	<script type="text/javascript">
		$(document).ready(function () {
			$(".carousel-indicators").children().first().addClass('active');
			$(".carousel-inner").children().first().addClass('active');
		});
	</script>
</body>

</html>