<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>관리자-예약 리스트</title>
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
	<script type='text/javascript'>
		$(function () {
			$(".openDeleteModal").click(function () {
				var value = $(this).data('id');
				var page = $(this).data('page');
				$("#delBtn").attr("onclick", "location.href='./resDelete.reo?res_no=" + value + "&pageNo=" + page + "'");
			})
		});
	</script>
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
	<jsp:include page="/resources/include/admin/nav.jsp">
		<jsp:param name="reservation" value="" />
	</jsp:include>
	<section>
		<div id="main" class="col-lg-10 offset-lg-2 col-md-12 col-12 comFont">
			<h2>관리자 예약 리스트</h2>
			<div style="float:right;"><i class="far fa-calendar-check"></i> 예약 현황 : ${resCount}<br></div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>예약 번호</th>
						<th>예약자 email</th>
						<th>업체명</th>
						<th>예약 일정</th>
						<th>결제 금액</th>
						<th class="d-none d-md-table-cell">예약 인원</th>
						<th class="d-none d-md-table-cell">상세 확인</th>
						<th class="d-none d-md-table-cell">예약 변경</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${empty allreslist}">
						<tbody>
							<c:forEach items="${AllResList}" var="allreslist">
								<tr>
									<td>${allreslist.res_no}</td>
									<td>${allreslist.mem_email}</td>
									<td>${allreslist.mem_agentName}</td>
									<td>
										<c:choose>
											<c:when test="${allreslist.off_unit eq '시간' }">
												<fmt:formatDate value="${allreslist.res_startdatetime}"
													pattern="yy-MM-dd HH:mm" /> ~
												<fmt:formatDate value="${allreslist.res_enddatetime}" pattern="HH:mm" />
											</c:when>
											<c:when test="${allreslist.off_unit eq '월' }">
												<fmt:formatDate value="${allreslist.res_startdatetime}"
													pattern="yy-MM-dd" /> ~
												<fmt:formatDate value="${allreslist.res_enddatetime}"
													pattern="yy-MM-dd" />
											</c:when>
										</c:choose>

									</td>
									<td>${allreslist.room_price }원</td>
									<td class="d-none d-md-table-cell">${allreslist.res_people}</td>
									<td class="d-none d-md-table-cell"><a
											href="./resView.reo?res_no=${allreslist.res_no}&pageNo=${param.pageNo == null ? 1 : param.pageNo}">상세
											확인</a></td>
									<td class="d-none d-md-table-cell">
										<c:if test="${allreslist.res_state != '예약취소' }">
											<a href="" class="btn btn-outline-danger openDeleteModal"
												data-toggle="modal" data-id="${allreslist.res_no}"
												data-page="${param.pageNo == null ? 1 : param.pageNo}"
												data-target="#resdelmodal">취소</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="8">${paging}</td>
							</tr>
						</tfoot>
					</c:when>
					<c:otherwise>
						<tr>
							<td class="nolist" colspan="8">예약내용이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</section>
</body>

</html>