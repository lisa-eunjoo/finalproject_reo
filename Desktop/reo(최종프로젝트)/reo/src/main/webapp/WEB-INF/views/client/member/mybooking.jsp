<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<div class="container mybooking contents-wrap">
		<div class="row my_reo col-12 fulid">
			<div class="use_status col-12">
				<div class="col-12 t3">
					<ul class="col-12 nav nav-tabs">
						<c:choose>
							<c:when test="${mem_sector == '일반'}">
								<li class="col-6 nav-item"><a href="#nowBooking" data-toggle="tab"
										class="nav-link active">내 예약</a></li>
								<li class="col-6 nav-item"><a href="#lastBooking" data-toggle="tab" class="nav-link">지난
										예약</a></li>
							</c:when>
							<c:when test="${mem_sector == '기업'}">
								<li class="col-6 nav-item"><a href="#nowBooking" data-toggle="tab"
										class="nav-link active">예약 리스트</a></li>
								<li class="col-6 nav-item"><a href="#lastBooking" data-toggle="tab" class="nav-link">지난
										예약 리스트</a></li>
							</c:when>
						</c:choose>
					</ul>
				</div>
				<ul class="use_status_comment col-12">
					<li class="col-12">
						지점 방문 및 전화로 예약하셨거나 이용하신 내역은 개인정보보호를 위해 리스트에 보이지 않을 수 있습니다.
					</li>
				</ul>
				<div class="tb1 col-12 tab-content">
					<div id="nowBooking" class="container tab-pane active">
						<input name="res_no" type="hidden" value="${param.res_no}" />
						<table class="table table-hover">
							<thead>
								<tr>
									<th class="text-center d-none d-md-table-cell">번호</th>
									<th class="text-center">일정</th>
									<th class="text-center">공간</th>
									<th class="text-center d-none d-md-table-cell">인원</th>
									<th class="text-center">결제 금액</th>
									<th class="text-center">변경</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${myresList}" var="myresList">
									<input type="hidden" name="off_no" value="${myresList.off_no}">
									<fmt:parseNumber var="starttime" value="${fn:substring(myresList.res_startdatetime,11,13) }" />
									<fmt:parseNumber var="endtime" value="${fn:substring(myresList.res_enddatetime,11,13) }" />
									<tr>
										<td class="text-center d-none d-md-table-cell">
											<c:out value="${myresList.res_no}" />
										</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${myresList.off_unit eq '시간' }">
													<fmt:formatDate value="${myresList.res_startdatetime}"
														pattern="yyyy-MM-dd HH:mm" /> ~
													<fmt:formatDate value="${myresList.res_enddatetime}"
														pattern="HH:mm" /> (${endtime-starttime} 시간)
												</c:when>
												<c:when test="${myresList.off_unit eq '월' }">
													<fmt:formatDate value="${myresList.res_startdatetime}"
														pattern="yyyy-MM-dd" /> ~
													<fmt:formatDate value="${myresList.res_enddatetime}"
														pattern="yyyy-MM-dd" />
												</c:when>
											</c:choose>
										</td>
										<td class="text-center"><a class="acolor"
												href="./myreservDetail.reo?res_no=${myresList.res_no}&pageNo=${param.pageNo == null ? 1 : param.pageNo}">
												<c:out value="${myresList.off_name}" /></a></td>
										<td class="text-center d-none d-md-table-cell">
											<c:out value="${myresList.res_people}" />
										</td>
										<td class="text-center">
											<c:out value="${myresList.room_price}" />
										</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${myresList.res_state eq '예약취소'}">
													예약취소
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${myresList.res_state eq '예약신청'}">
															<button type="button" class="btn btn-outline-success"
																onclick="location.href='./kPayReady/${myresList.off_no}/${myresList.res_no}/<fmt:parseNumber type="number" value="${myresList.room_price}" />.reo'">결제</button>
															<a href="" class="btn btn-outline-danger openCancelModal"
																data-toggle="modal" data-res="${myresList.res_no}"
																data-target="#resCanmodal">예약취소</a>
														</c:when>
														<c:when test="${myresList.res_state eq '예약완료'}">
															<a href="" class="btn btn-outline-danger openDeleteModal"
																data-toggle="modal" data-id="${myresList.res_no}"
																data-target="#resdelmodal">환불</a>
														</c:when>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:choose>
							<c:when test="${empty myresList}">
								<tr>
									<td class="nolist" colspan="8">예약내용이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="8">${pagingnow}</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</div>
					<div id="lastBooking" class="container tab-pane fade">
						<input name="res_no" type="hidden" value="${param.res_no}">
						<table class="table table-hover">
							<thead>
								<tr>
									<th class="text-center d-none d-md-table-cell">번호</th>
									<th class="text-center">일정</th>
									<th class="text-center">공간</th>
									<th class="text-center d-none d-md-table-cell">인원</th>
									<th class="text-center">결제 금액</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${myPastList}" var="myPastList">
									<tr>
										<td class="text-center">
											<c:out value="${myPastList.res_no}" />
										</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${myPastList.off_unit eq '시간' }">
													<fmt:formatDate value="${myPastList.res_startdatetime}"
														pattern="yyyy-MM-dd HH:mm" /> ~
													<fmt:formatDate value="${myPastList.res_enddatetime}"
														pattern="HH:mm" /> (${endtime-starttime} 시간)
												</c:when>
												<c:when test="${myPastList.off_unit eq '월' }">
													<fmt:formatDate value="${myPastList.res_startdatetime}"
														pattern="yyyy-MM-dd" /> ~
													<fmt:formatDate value="${myPastList.res_enddatetime}"
														pattern="yyyy-MM-dd" />
												</c:when>
											</c:choose>
										</td>
										<td class="text-center">
											<c:out value="${myPastList.off_name}" />
										</td>
										<td class="text-center">
											<c:out value="${myPastList.res_people}" />
										</td>
										<td class="text-center">
											<c:out value="${myPastList.room_price}" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:choose>
							<c:when test="${empty myPastList}">
								<tr>
									<td class="nolist" colspan="8">예약내용이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="8">${pagingpast}</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="tips col-12">
					<p class="tips_title col-12">꼭 확인하세요!</p>
					<ul class="tips_list col-12">
						<li class="tips_item">회원 계정 없이 지점 방문 및 전화로 예약하거나 이용하신 내역은 리스트에 보이지 않을 수 있습니다.</li>
						<li class="tips_item">이용 중, 기간변경이나 자리이동, 환불 등은 이용 지점으로 문의해주세요.</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- modal -->
	<div class="modal fade" id="resdelmodal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="resdelmodal">환불</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<p>예약을 환불하시겠습니까?<br>환불한 예약 내역은 되돌릴 수 없습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" id="delBtn" class="btn btn-danger">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- modal -->
	<div class="modal fade" id="resCanmodal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="resCanmodal">예약 취소</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<p>예약을 취소하시겠습니까?<br>취소한 예약 내역은 되돌릴 수 없습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" id="canBtn" class="btn btn-danger">확인</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
</body>
<script type="text/javascript">
	$(function () {
		$(".openDeleteModal").click(function () {
			var value = $(this).data('id');
			$("#delBtn").attr("onclick", "location.href='./deleteReserv.reo?res_no=" + value + "&pageNo=" + ${ param.pageNo == null ? 1 : param.pageNo } + "'");
		});
	});
</script>
<c:if test="${modal != null}">
	<script type="text/javascript">
		$("#openDeleteModal").trigger("click");
	</script>
</c:if>
<script type="text/javascript">
	$(function () {
		$(".openCancelModal").click(function () {
			var value = $(this).data('res');
			$("#canBtn").attr("onclick", "location.href='./reservCancel.reo?res_no=" + value + "&pageNo=" + ${ param.pageNo == null ? 1 : param.pageNo } + "'");
		});
	});
</script>
<c:if test="${Cancelmodal != null}">
	<script type="text/javascript">
		$("#openCancelModal").trigger("click");
	</script>
</c:if>
</html>