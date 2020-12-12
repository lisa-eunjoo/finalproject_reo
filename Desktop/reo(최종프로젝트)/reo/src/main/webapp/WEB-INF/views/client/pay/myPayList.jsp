<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>내 결제 목록</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/client/pay/myPayList.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/pay/myPayList.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/mypage.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<body>
<jsp:include page="/resources/include/client/header.jsp" />
<section>
	<div class="container contents-wrap">
		<div class="row my_reo col-12">
			<div class="use_status col-12">
				<div class="col-12 default_tabs t3">
					<ul class="col-12">
						<li class="col-12"><a href="myPayList.reo">내 결제 내역</a></li>
					</ul>
				</div>
				<div class="col-sm-12 payList comFont">
					<jsp:useBean id="todate" class="java.util.Date"/>
					<fmt:formatDate var="today" value='${todate}' pattern='yyyy-MM-dd'/>
					<form action="myPayList.reo" id="searchForm">
						<input type="hidden" id="pageNo" name="pageNo" value="${param.pageNo == null || param.pageNo < 1 ? 1 : param.pageNo}"/>
						<input type="date" id="fromDate" name="fromDate" min="2010-01-01" value="${param.fromDate != null ? param.fromDate : '2010-01-01'}" max="${today}" pattern="\d{4}-\d{2}-\d{2}"/>
						<span> ~ </span>
						<input type="date" id="toDate" name="toDate" min="${param.fromDate != null ? param.fromDate : '2010-01-01'}" value="${param.toDate != null ? param.toDate : today}" max="${today}" pattern="\d{4}-\d{2}-\d{2}"/>
						<input type="text" id="search" name="search" size="15" maxlength="15" placeholder="상품 이름" value="${param.search}"/>
						<input type="submit" id="searchBtn" class="btn btn-info btn-sm" value="조회"/>
					</form>
				</div>
				<div class="table-responsive-lg">
					<table class="table table-hover comFont">
						<thead>
							<tr class="row">
								<th class="col-lg-2 col-4">결제 번호</th>
								<th class="col-lg-4 col-5">상품 이름</th>
								<th class="d-none d-lg-table-cell col-lg-2">상품 가격</th>
								<th class="d-none d-lg-table-cell col-lg-2">결제 상태</th>
								<th class="col-lg-2 col-3">결제 날짜</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${payList}" var="payDTO">
							<tr class="row" data-payno="${payDTO.pay_no}">
								<td class="col-lg-2 col-4">${payDTO.pay_no}</td>
								<td class="col-lg-4 col-5">${payDTO.off_name == null ? "삭제된 매물" : payDTO.off_name}</td>
								<td class="d-none d-lg-table-cell col-lg-2"><fmt:formatNumber value="${payDTO.pay_price}" type="number"/></td>
								<td class="d-none d-lg-table-cell col-lg-2">${payDTO.pay_remark == null ? payDTO.pay_state : payDTO.pay_remark}</td>
								<td class="col-lg-2 col-3"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${payDTO.pay_date}"/></td>
							</tr>
						</c:forEach>
						</tbody>
						<tfoot>
							<tr class="row">
							<c:choose>
							<c:when test="${empty payList}">
								<td class="col-lg-12 col-12">결제내역이 없습니다.</td>
							</c:when>
							<c:otherwise>
								<td class="col-lg-12 col-12">${paging}</td>
							</c:otherwise>
							</c:choose>
							</tr>
						</tfoot>
					</table>
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
	</div>
</section>
<footer>
	<jsp:include page="/resources/include/client/footer.jsp" />
</footer>
</body>
</html>