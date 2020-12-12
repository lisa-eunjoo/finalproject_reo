<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-회원 목록</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/member/memberList.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/member/member.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<jsp:include page="/resources/include/admin/nav.jsp"><jsp:param name="member" value=" "/></jsp:include>
		<section>
			<div id="main" class="col-lg-10 offset-lg-2 col-md-12 col-12">
				<h2 class="title">회원 목록</h2>
				<form action="memberList.reo" id="searchForm">
					<select name="searchType">
						<option value="mem_email" ${searchType == 'mem_email' ? 'selected=selected' : ''}>이메일</option>
						<option value="mem_name" ${searchType == 'mem_name' ? 'selected=selected' : ''}>이름</option>
						<option value="mem_sector" ${searchType == 'mem_sector' ? 'selected=selected' : ''}>사업자구분</option>
					</select>
					<input type="text" name="searchKeyword" value="${searchKeyword}"/> 
					<input type="submit" value="검색" class="btn btn-info btn-sm comFont" id="submitBtn"/>
				</form>
				<form action="memberMultiDelete.reo" method="POST" name="deleteForm">
					<div class="table-responsive-lg">
						<table class="table table-bordered comFont textCenter">
							<thead>
								<tr class="row">
									<th class="col-lg-1 col-sm-2 col-2"><label for="allCheck">선택</label> <input id="allCheck" type="checkbox"/></th>
									<th class="col-lg-2 d-none d-lg-table-cell">회원번호</th>
									<th class="col-lg-3 col-sm-5 col-5">이메일</th>
									<th class="col-lg-2 col-sm-3 col-3">이름</th>
									<th class="col-lg-2 d-none d-lg-table-cell">가입날짜</th>
									<th class="col-lg-2 col-sm-2 col-2">사업자구분</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${memberList}" var="member">
								<tr class="row">
									<td class="col-lg-1 col-sm-2 col-2">
										<input type="checkbox" name="rowCheck" class="rowCheck" value="${member.mem_no}"/>
									</td>
									<td class="col-lg-2 d-none d-lg-table-cell">${member.mem_no}</td>
									<td class="col-lg-3 col-sm-5 col-5 infoLink">
										<span>
										<c:choose>
										<c:when test="${memberMap[member.mem_no]}"><i class="fas fa-circle green" data-toggle="tooltip" data-placement="top" title="로그인 상태" alt="로그인 상태"></i></c:when>
										<c:otherwise><i class="fas fa-circle red" data-toggle="tooltip" data-placement="top" title="로그아웃 상태" alt="로그아웃 상태"></i></c:otherwise>
										</c:choose>
										<a href="memberInfo.reo?memNo=${member.mem_no}&${query}">${member.mem_email}</a></span>
									</td>
									<td class="col-lg-2 col-sm-3 col-3">${member.mem_name}</td>
									<td class="col-lg-2 d-none d-lg-table-cell">${member.mem_regDate}</td>
									<td class="col-lg-2 col-sm-2 col-2">${member.mem_sector}</td>
								</tr>
							</c:forEach>
							</tbody>
							<tfoot>
								<c:if test="${empty memberList}">
									<tr class="row"><td class="col-lg-12 col-sm-12 col-12">검색 결과가 없습니다.</td></tr>
								</c:if>
								<tr class="row">
									<td class="col-lg-12 col-sm-12 col-12">
										<div class="floatLeft">
											<input type="button" id="delete" class="btn btn-danger" value="선택 삭제">
										</div>
										<div class="floatRight">
											<a href="insertMember.reo" class="btn btn-primary">회원 등록</a>
										</div>
									</td>
								</tr>
								<c:if test="${not empty memberList}">
								<tr class="row"><td class="col-lg-12 col-sm-12 col-12">${paging}</td></tr>
								</c:if>
							</tfoot>
						</table>
					</div>
				</form>
			</div>
		</section>
	</body>
</html>