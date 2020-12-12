<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-로그인 로그</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/member/loginLogList.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/member/member.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<jsp:include page="/resources/include/admin/nav.jsp"><jsp:param name="log" value=" "/></jsp:include>
		<section>
			<div id="main" class="col-lg-10 offset-lg-2 col-md-12 col-12 comFont">
				<h2 class="title">로그인 로그</h2>
				<jsp:useBean id="todate" class="java.util.Date"/>
				<fmt:formatDate var="today" value='${todate}' pattern='yyyy-MM-dd'/>
				<form action="loginLogList.reo" id="searchForm" method="POST">
					<input type="hidden" id="pageNo" name="pageNo" value="1"/>
					<input type="date" id="fromDate" name="fromDate" min="2010-01-01" max="${today}" pattern="\d{4}-\d{2}-\d{2}"/>
					<span> ~ </span>
					<input type="date" id="toDate" name="toDate" min="2010-01-01" max="${today}" pattern="\d{4}-\d{2}-\d{2}"/>
					<select id="searchType" name="searchType">
						<option value="mem_email">이메일</option>
						<option value="log_ip">아이피</option>
					</select>
					<input type="text" id="search" name="search" size="20" maxlength="20" placeholder="내용"/>
					<input type="submit" value="검색" class="btn btn-info btn-sm comFont" id="submitBtn"/>
				</form>
				<div class="table-responsive-lg">
					<table id="logTable" class="table table-bordered comFont textCenter">
						<thead>
							<tr class="row">
								<th class="col-md-2 d-none d-lg-table-cell">로그번호</th>
								<th class="col-md-4 col-sm-4 col-4">이메일</th>
								<th class="col-md-3 col-sm-4 col-4">로그인 시간</th>
								<th class="col-md-3 col-sm-4 col-4">아이피</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${loginLogList}" var="loginLog">
							<tr class="row">
								<td class="col-md-2 d-none d-md-table-cell">${loginLog.log_no}</td>
								<td class="col-md-4 col-sm-4 col-4">${loginLog.mem_email}</td>
								<td class="col-md-3 col-sm-4 col-4"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${loginLog.log_date}"/></td>
								<td class="col-md-3 col-sm-4 col-4">${loginLog.log_ip}</td>
							</tr>
						</c:forEach>
						</tbody>
						<tfoot>
							<tr class="row">
							<c:choose>
							<c:when test="${empty loginLogList}">
								<td class="col-lg-12 col-sm-12 col-12">검색 결과가 없습니다.</td>
							</c:when>
							<c:otherwise>
								<td class="col-lg-12 col-sm-12 col-12">${paging}</td>
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