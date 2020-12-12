<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<c:choose>
		<c:when test="${mem_sector eq '관리자'}">
			<header>
				<jsp:include page="/resources/include/admin/nav.jsp"><jsp:param name="office" value=" " /></jsp:include>
			</header>
		</c:when>
		<c:otherwise>
			<header>
				<jsp:include page="/resources/include/client/header.jsp" />
			</header>
		</c:otherwise>
	</c:choose>
	<section>
		<c:if test="${mem_sector eq '관리자'}">
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
						<c:when test="${mem_sector eq '관리자'}">
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
									<c:when test="${option.offopt_name eq '인터넷/WIFI'}"><i class="fas fa-wifi"></i></c:when>
									<c:when test="${option.offopt_name eq '의자/테이블'}"><i class="fas fa-chair"></i></c:when>
									<c:when test="${option.offopt_name eq 'TV/프로젝터'}"><i class="fas fa-tv"></i></c:when>
									<c:when test="${option.offopt_name eq '음향/마이크'}"><i class="fas fa-microphone"></i></c:when>
									<c:when test="${option.offopt_name eq '복사/인쇄기'}"><i class="fas fa-print"></i></c:when>
									<c:when test="${option.offopt_name eq '화이트보드'}"><i class="fas fa-chalkboard"></i></c:when>
									<c:when test="${option.offopt_name eq 'PC/노트북'}"><i class="fas fa-laptop"></i></c:when>
									<c:when test="${option.offopt_name eq '개별콘센트'}"><i class="fas fa-plug"></i></c:when>
									<c:when test="${option.offopt_name eq '개인사물함'}"><i class="fas fa-suitcase"></i></c:when>
									<c:when test="${option.offopt_name eq '공기청정기'}"><i class="fas fa-fan"></i></c:when>
									<c:when test="${option.offopt_name eq '보안시스템'}"><i class="fas fa-shield-alt"></i></c:when>
									<c:when test="${option.offopt_name eq '커피/다과'}"><i class="fas fa-coffee"></i></c:when>
									<c:when test="${option.offopt_name eq '취사시설'}"><i class="fas fa-sink"></i></c:when>
									<c:when test="${option.offopt_name eq '자판기'}"><i class="fas fa-tint"></i></c:when>
									<c:when test="${option.offopt_name eq '우편물/택배물 관리'}"><i class="fas fa-mail-bulk"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '내부화장실'}"><i class="fas fa-toilet"></i></c:when>
									<c:when test="${option.offopt_name eq '전담컨시어지 서비스'}"><i class="far fa-handshake"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '클리닝 서비스'}"><i class="fas fa-broom"></i></c:when>
									<c:when test="${option.offopt_name eq '법무사/세무사 무료컨설팅'}"><i class="fas fa-user-tie"></i>
									</c:when>
									<c:when test="${option.offopt_name eq '금연'}"><i class="fas fa-smoking-ban"></i></c:when>
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
								<c:set var="rpcFeature" value="${fn:replace(feature, newLineChar, '<br>')}" />${rpcFeature}
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
				<input type="button" class="btn btn-default detailbtn" value="찜" onclick="wishFunc()" />
				<c:choose>
					<c:when test="${mem_sector eq '관리자'}">
						<input type="button" class="btn btn-success detailbtn" value="수정"
							onclick="location.href='./getOffice.reo?off_no=${office.off_no}&pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:when>
					<c:otherwise>
						<input type="button" class="btn btn-success detailbtn" value="수정"
							onclick="location.href='./getMyOffice.reo?off_no=${office.off_no}&pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:otherwise>
				</c:choose>
				<input type="button" class="btn btn-danger detailbtn" value="삭제" data-toggle="modal"
					data-target="#exampleModal" />
				<c:choose>
					<c:when test="${mem_sector eq '관리자'}">
						<input type="button" class="btn btn-secondary detailbtn" value="목록"
							onclick="location.href='./getOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:when>
					<c:otherwise>
						<input type="button" class="btn btn-secondary detailbtn" value="목록"
							onclick="location.href='./myOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" />
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<c:if test="${mem_sector eq '관리자'}">
			</div>
		</c:if>
	</section>
	<c:choose>
		<c:when test="${mem_sector ne '관리자'}">
			<footer>
				<jsp:include page="/resources/include/client/footer.jsp" />
			</footer>
		</c:when>
	</c:choose>
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">상품 삭제</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">${office.off_no}번 상품을 삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						onclick="location.href='./deleteOffice.reo?delOff_no=${office.off_no}&pageNo=<%=request.getParameter("pageNo")%>'">삭제하기</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function () {
		if ('${mem_sector}' != '관리자') {
			$('section').addClass("container");
		}
	});

	// 위시리스트
	function wishFunc() {
		$.ajax({
			type: 'GET',
			url: './searchWish.reo?off_no=${office.off_no}',
			dataType: "text",
			success: function (data) {
				// 찜 삭제
				if (data == 'del0') {
					alert("위시 삭제 에러");
				} else if (data == 'del1') {
					alert("위시 삭제 완료");
				}
				// 찜 추가
				if (data == 'add0') {
					alert("위시 추가 에러");
				} else if (data == 'add1') {
					alert("위시 추가 완료");
				}
			},
			error: function () {
				console.log('위시 ajax 실패');
			}
		});
	}
</script>

</html>