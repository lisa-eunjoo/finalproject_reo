<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-결제 목록</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/pay/payList.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/pay/payList.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<jsp:include page="/resources/include/admin/nav.jsp"><jsp:param name="pay" value=" "/></jsp:include>
		<section>
			<div id="main" class="col-12 col-md-12 col-lg-10 offset-lg-2 comFont">
				<h2 class="title">결제 목록</h2>
				<jsp:useBean id="todate" class="java.util.Date"/>
				<fmt:formatDate var="today" value='${todate}' pattern='yyyy-MM-dd'/>
				<form action="payList.reo" id="searchForm">
					<input type="hidden" id="pageNo" name="pageNo" value="${param.pageNo == null || param.pageNo < 1 ? 1 : param.pageNo}"/>
					<input type="date" id="fromDate" name="fromDate" min="2010-01-01" value="${param.fromDate != null ? param.fromDate : '2010-01-01'}" max="${today}" pattern="\d{4}-\d{2}-\d{2}"/>
					<span> ~ </span>
					<input type="date" id="toDate" name="toDate" min="${param.fromDate != null ? param.fromDate : '2010-01-01'}" value="${param.toDate != null ? param.toDate : today}" max="${today}" pattern="\d{4}-\d{2}-\d{2}"/>
					<select id="searchType" name="searchType">
						<option value="off_name">상품</option>
						<option value="mem_email" ${param.searchType == 'mem_email' ? 'selected="selected"' : ''}>회원</option>
					</select>
					<input type="text" id="search" name="search" size="20" maxlength="20" placeholder="내용" value="${param.search}"/>
					<input type="submit" class="btn btn-info btn-sm comFont" value="조회"/>
				</form>
				<div class="table-responsive-lg">
					<table class="table table-hover comFont">
						<thead>
							<tr class="row">
								<th class="col-xl-2 col-3">결제 번호</th>
								<th class="col-xl-2 col-3">회원 이메일</th>
								<th class="col-xl-3 col-3">상품 이름</th>
								<th class="d-none d-xl-table-cell col-xl-2">상품 가격</th>
								<th class="d-none d-xl-table-cell col-xl-1">결제 상태</th>
								<th class="col-xl-2 col-3">결제 날짜</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${payList}" var="payDTO">
							<tr class="row" data-payno="${payDTO.pay_no}">
								<td class="col-xl-2 col-3">${payDTO.pay_no}</td>
								<td class="col-xl-2 col-3">${payDTO.mem_email}</td>
								<td class="col-xl-3 col-3">${payDTO.off_name == null ? "삭제된 매물" : payDTO.off_name}</td>
								<td class="d-none d-xl-table-cell col-xl-2"><fmt:formatNumber value="${payDTO.pay_price}" type="number"/></td>
								<td class="d-none d-xl-table-cell col-xl-1">${payDTO.pay_remark == null ? payDTO.pay_state : payDTO.pay_remark}</td>
								<td class="col-xl-2 col-3"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${payDTO.pay_date}"/></td>
							</tr>
						</c:forEach>
						</tbody>
						<tfoot>
							<tr class="row">
							<c:choose>
							<c:when test="${empty payList}">
								<td class="col-xl-12 col-12">결제내역이 없습니다.</td>
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