<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-계약서 목록</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/pay/contractList.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/pay/contractList.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<jsp:include page="/resources/include/admin/nav.jsp"><jsp:param name="contract" value=" "/></jsp:include>
		<section>
			<div id="main" class="col-12 col-md-12 col-lg-10 offset-lg-2 comFont">
				<h2 class="title">계약서 목록</h2>
				<form action="payList.reo" id="searchForm">
					<input type="text" id="search" name="search" size="20" maxlength="20" placeholder="결제 번호" value=""/>
					<input type="submit" class="btn btn-info btn-sm comFont" value="조회"/>
				</form>
				<div class="table-responsive-lg">
					<table class="table table-hover comFont">
						<thead>
							<tr class="row">
								<th class="col-xl-2 col-3">결제 번호</th>
								<th class="col-xl-2 col-3">이메일</th>
								<th class="col-xl-2 d-none d-xl-table-cell">가격</th>
								<th class="col-xl-3 col-3">계약시작일</th>
								<th class="col-xl-3 col-3">계약종료일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${contractList}" var="contractDTO">
							<tr class="row" data-token="${contractDTO.pay_no}">
								<td class="col-xl-2 col-3">${contractDTO.pay_no}</td>
								<td class="col-xl-2 col-3">${contractDTO.id}</td>
								<td class="col-xl-2 d-none d-xl-table-cell">${contractDTO.price}</td>
								<td class="col-xl-3 col-3"><fmt:formatDate pattern="yyyy-MM-dd" value="${contractDTO.startdate}"/></td>
								<td class="col-xl-3 col-3"><fmt:formatDate pattern="yyyy-MM-dd" value="${contractDTO.enddate}"/></td>
							</tr>
						</c:forEach>
						</tbody>
						<tfoot>
							<tr class="row">
							<c:choose>
							<c:when test="${empty contractList}">
								<td class="col-xl-12 col-12">계약서가 없습니다.</td>
							</c:when>
							<c:otherwise>
								<td class="col-xl-12 col-12">${paging}</td>
							</c:otherwise>
							</c:choose>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</section>
	</body>
</html>