<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>상품 상세</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/office/office.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>

<body>
	<%-- <c:choose>
	<c:when test="${mem_email eq 'admin'}">
		<header><jsp:include page="/resources/include/admin/nav.jsp" /></header>
	</c:when>
	<c:otherwise>
		<header><jsp:include page="/resources/include/client/header.jsp" /></header>
	</c:otherwise>
</c:choose> --%>
	<section>
		<c:if test="${mem_email eq 'admin'}">
			<div id="main" class="col-12 col-md-12 col-lg-10 offset-lg-2">
		</c:if>
		<div class="row">
			<div class="col-12 col-md-8">
				<table class="table table-striped table-hover">
					<tr>
						<th>공간명</th>
						<td>${office.off_name}</td>
					</tr>
					<tr>
						<th>공간유형</th>
						<td>${office.off_type}</td>
					</tr>
					<c:choose>
						<c:when test="${mem_email eq 'admin'}">
							<tr>
								<th>사업자 이메일</th>
								<td>${office.mem_email}</td>
							</tr>
							<tr>
								<th>상호명</th>
								<td>${office.mem_agentName}</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>${office.mem_agentTel}</td>
							</tr>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<tr>
						<th>가격</th>
						<td>${office.off_rent}원 / ${office.off_unit}</td>
					</tr>
					<tr>
						<th>수용인원</th>
						<td>최대 ${office.off_maxNum}인</td>
					</tr>
					<tr>
						<th>편의시설</th>
						<td>
							<c:forEach items="${off_options}" var="option" varStatus="status">
								<c:choose>
									<c:when test="${option.offopt_name eq '냉난방'}"><i class="fas fa-wind"></i></c:when>
									<c:when test="${option.offopt_name eq '인터넷/WIFI'}"><i class="fas fa-wifi"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '의자/테이블'}"><i class="fas fa-chair"></i>
									</c:when>
									<c:when test="${option.offopt_name eq 'TV/프로젝터'}"><i class="fas fa-tv"></i></c:when>
									<c:when test="${option.offopt_name eq '음향/마이크'}"><i class="fas fa-microphone"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '복사/인쇄기'}"><i class="fas fa-print"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '화이트보드'}"><i class="fas fa-chalkboard"></i>
									</c:when>
									<c:when test="${option.offopt_name eq 'PC/노트북'}"><i class="fas fa-laptop"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '개별콘센트'}"><i class="fas fa-plug"></i></c:when>
									<c:when test="${option.offopt_name eq '개인사물함'}"><i class="fas fa-suitcase"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '공기청정기'}"><i class="fas fa-fan"></i></c:when>
									<c:when test="${option.offopt_name eq '보안시스템'}"><i class="fas fa-shield-alt"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '커피/다과'}"><i class="fas fa-coffee"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '취사시설'}"><i class="fas fa-sink"></i></c:when>
									<c:when test="${option.offopt_name eq '자판기'}"><i class="fas fa-tint"></i></c:when>
									<c:when test="${option.offopt_name eq '우편물/택배물 관리'}"><i
											class="fas fa-mail-bulk"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '내부화장실'}"><i class="fas fa-toilet"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '전담컨시어지 서비스'}"><i
											class="far fa-handshake"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '클리닝 서비스'}"><i class="fas fa-broom"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '법무사/세무사 무료컨설팅'}"><i
											class="fas fa-user-tie"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '금연'}"><i class="fas fa-smoking-ban"></i>
									</c:when>
									<c:otherwise><i class="fas fa-grip-horizontal"></i></c:otherwise>
								</c:choose>
								<span class="txt_name">
									<c:choose>
										<c:when test="${status.count % 3 == 0}">
											<span class="offopt_name">${option.offopt_name}</span><br />
										</c:when>
										<c:otherwise>
											<span class="offopt_name">${option.offopt_name}</span>
										</c:otherwise>
									</c:choose>
								</span>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${office.off_stdAddr}</td>
					</tr>
					<tr>
						<th>소개말</th>
						<td>
							<c:set var="feature" value="${office.off_feature}" />
							<% pageContext.setAttribute("newLineChar", "\r\n"); %><c:if test="${not empty feature}">
								<c:set var="rpcFeature" value="${fn:replace(feature, newLineChar, '<br>')}" />
								${rpcFeature}
							</c:if>
						</td>
					</tr>
					<tr>
						<th>이미지</th>
						<td>
							<c:forEach items="${off_images}" var="image">
								${image.offimg_name}<br>
							</c:forEach>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-12 col-md-4">
				<h3>예약자리</h3>
			</div>
		</div>
		<div class="fixed_bar text-center col-12">
			<div class="btn_wrap">
				<c:choose>
					<c:when test="${mem_email eq 'admin'}">
						<input type="button" class="btn btn-success detailbtn" value="예약"
							onclick="location.href='./getOffice.reo?off_no=${office.off_no}&pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:when>
					<c:otherwise>
						<input type="button" class="btn btn-success detailbtn" value="예약"
							onclick="location.href='./getMyOffice.reo?off_no=${office.off_no}&pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${mem_email eq 'admin'}">
						<input type="button" class="btn btn-secondary detailbtn" value="목록"
							onclick="location.href='./resOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:when>
					<c:otherwise>
						<input type="button" class="btn btn-secondary detailbtn" value="목록"
							onclick="location.href='./myOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<c:if test="${mem_email eq 'admin'}">

		</c:if>
		</div>
	</section>
	<c:choose>
		<c:when test="${mem_email ne 'admin'}">
			<%-- <footer>
			<jsp:include page="/resources/include/client/footer.jsp" />
		</footer> --%>
		</c:when>
	</c:choose>

	<script type="text/javascript">

	</script>

</html>