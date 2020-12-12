<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>내 결제 상세</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/client/pay/payInfo.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/pay/payInfo.css">
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
						<div class="payInfo">
							<div class="col-sm-12">
								<div class="reo textCenter">R E O</div>
								<span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${payDTO.pay_date}"/></span><br/>
								<span class="good">${payDTO.off_name == null ? "삭제된 매물" : payDTO.off_name}</span><br/>
								<span class="price"><fmt:formatNumber value="${payDTO.pay_price}" type="number"/>원</span><br/>
								<table class="infoTitle">
									<tr>
										<td>공급가금액</td>
										<c:set var="price" value="${payDTO.pay_price / 11 + (1 - (payDTO.pay_price  / 11 % 1) % 1)}"/>
										<td><fmt:formatNumber value="${payDTO.pay_price - price}" type="number"/>원</td>
									</tr>
									<tr>
										<td>부가세</td>
										<td><fmt:formatNumber value="${price}" type="number"/>원</td>
									</tr>
								</table>
								<hr/>
								<table class="infoContent">
									<tr>
										<td>구매자</td>
										<td>${payDTO.mem_email}</td>
									</tr>
									<tr>
										<td>거래방법</td>
										<td>${payDTO.pay_type}</td>
									</tr>
									<c:if test="${payDTO.pay_type == 'CARD'}">
									<tr>
										<td>거래카드</td>
										<td>${payDTO.pay_card}</td>
									</tr>
									<tr>
										<td>카드번호</td>
										<td>${payDTO.pay_bin}</td>
									</tr>
									</c:if>
									<tr>
										<td>승인일시</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${payDTO.pay_date}"/></td>
									</tr>
									<tr>
										<td>거래상태</td>
										<td id="payState">${payDTO.pay_remark == null ? payDTO.pay_state : payDTO.pay_remark}</td>
									</tr>
									<tr>
										<td>결제번호</td>
										<td id="payNo">${payDTO.pay_no}</td>
									</tr>
								</table>
								<hr/>
								<div class="infoBtn">
									<c:if test="${payDTO.off_unit == '월'}">
									<button id="contractBtn" class="btn btn-info btn-lg" onclick="contractOpen()">계약서 확인</button>
									</c:if>
									<c:if test="${payDTO.pay_state == '결제완료' and payDTO.pay_remark == null}">
									<button id="cancelBtn" class="btn btn-danger btn-lg" onclick="cancelModal()">결제취소</button>
									</c:if>
									<c:choose>
									<c:when test="${prev == null}">
									<button class="btn btn-info btn-lg" onclick="location.href='myPayList.reo?pageNo=${param.pageNo == null ? 1 : param.pageNo}&fromDate=${param.fromDate}&toDate=${param.toDate}&search=${param.search}'">목록</button>
									</c:when>
									<c:otherwise>
									<button class="btn btn-primary btn-lg" onclick="location.href='${prev}'">이전</button>
									</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<footer><jsp:include page="/resources/include/client/footer.jsp" /></footer>
		<c:if test="${payDTO.pay_state == '결제완료' and payDTO.pay_remark == null}">
		<div id="openModal"></div>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/openModal.js"></script>
		<script type="text/javascript"></script>
		</c:if>
	</body>
</html>