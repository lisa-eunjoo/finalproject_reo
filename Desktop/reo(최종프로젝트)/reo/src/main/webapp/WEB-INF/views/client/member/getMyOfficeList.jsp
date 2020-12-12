<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>내 상품 목록</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/office/office.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/mypage.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	<script type="text/javascript">
		var limit = 12;
		var offset = 0;
		var isDisplay = false;

		function delSubmit() {
			delForm.submit();
		}

		$(function () {
			$(".openDeleteModal").click(function () {
				var chkValues = [];
				$.each($("input[name='delOff_no']:checked"), function () {
					chkValues.push($(this).val());
				});

				$('.modal-footer #delBtn').css("display", "inline");
				$('.modal-footer #delCancel').text("취소하기");

				if (chkValues.length > 0) {
					$(".modal-body").html(chkValues.join(", ") + "번 오피스을 삭제하시겠습니까?");
				} else {
					$(".modal-body").html("삭제할 오피스을 선택해주세요.");
					$('.modal-footer #delBtn').css("display", "none");
					$('.modal-footer #delCancel').text("확인");
				}
			});
		});

		$(function () {
			var sidx = '';
			var sord = '';

			if ('<%=request.getParameter("SIDX")%>' == 'null' && '<%=request.getParameter("SORD")%>' == 'null') {
				sidx = "off_no";
				sord = "desc";
			} else {
				sidx = '<%=request.getParameter("SIDX")%>';
				sord = '<%=request.getParameter("SORD")%>';
			}

			$('#sortSel').val(sidx);
			$('#sortSel2').val(sord);

			$("#chk_all").click(function () {
				if ($("#chk_all").is(":checked")) {
					$(".delChkbox").prop("checked", true);
				} else {
					$(".delChkbox").prop("checked", false);
				}
			});
		});

		function setList() {
			$('#noResultSpan').remove();
			//$('#pagingDiv').css("display", "block");

			var pageNo = 1;

			var sidx = $('#sortSel').val();
			var sord = $('#sortSel2').val();

			location.href = './myOfficeList.reo?pageNo=' + pageNo + '&SIDX=' + sidx + '&SORD=' + sord;
		}
	</script>
</head>

<body>
	<header>
		<jsp:include page="/resources/include/client/header.jsp" />
	</header>
	<section class="container sec">
		<div class="container contents-wrap">
			<div class="row my_reo col-12">
				<div class="use_status col-12">
					<div class="col-12 default_tabs t3">
						<ul class="col-12">
							<li class="col-12"><a href="#">내 오피스</a></li>
						</ul>
					</div>
					<form action="" method="POST" name="filterForm">
						<div class="sort_bar">
							<div class="sorting_filter">
								<select id="sortSel" class="type_color col-12 col-md-6" name="SIDX"
									onchange="setList()">
									<option selected="selected" value="off_no">등록 순</option>
									<option value="off_rent">가격 순</option>
									<option value="off_likeCount">좋아요 순</option>
									<option value="off_name">이름 순</option>
								</select>
								<select id="sortSel2" class="type_color col-12 col-md-6" name="SORD"
									onchange="setList()">
									<option selected="selected" value="desc">내림차순</option>
									<option value="asc">오름차순</option>
								</select>
							</div>
						</div>
					</form>
					<form action="./deleteOffice.reo?pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%>
						<%} else {%>1<%}%>" method="POST" name="delForm">
					<div class="table-responsive-lg">
						<table class="table table-striped table-hover comFont">
							<thead>
							<tr class="row">
								<th class="col-xl-2 col-3">상품명</th>
								<th class="col-xl-2 col-2">유형</th>
								<th class="col-xl-1 col-3">가격</th>
								<th class="d-none d-xl-table-cell col-xl-3">주소</th>
								<th class="col-xl-1 col-2">수용인원</th>
								<th class="d-none d-xl-table-cell col-xl-1">좋아요수</th>
								<th class="d-none d-xl-table-cell col-xl-1">수정</th>
								<th class="col-xl-1 col-2">삭제&nbsp;<input type="checkbox" id="chk_all" /></th>
							</tr>
							</thead>
							<tbody id="tbody">
							<c:choose>
								<c:when test="${not empty myOfficeList}">
									<c:forEach items="${myOfficeList}" var="office">
										<tr class="row deltr">
											<td class="col-xl-2 col-3"><a href="./detailOffice.reo?off_no=${office.off_no}&pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%>
											<%} else {%>1<%}%>">${office.off_name}</a></td>
											<td class="col-xl-2 col-2">${office.off_type}</td>
											<td class="col-xl-1 col-3"><fmt:formatNumber value="${office.off_rent}" pattern="#,###"/><br><span class="off_unitBr">(${office.off_unit})</span></td>
											<td class="d-none d-xl-table-cell col-xl-3">${office.off_stdAddr}</td>
											<td class="col-xl-1 col-2">${office.off_maxNum}</td>
											<td class="d-none d-xl-table-cell col-xl-1">${office.off_likeCount}</td>
											<td class="d-none d-xl-table-cell col-xl-1"><button type="button" onclick="location.href='./getMyOffice.reo?off_no=${office.off_no}&pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%>'
											<%} else {%>1'<%}%>" class="btn btn-success">수정</button></td>
											<td class="col-xl-1 col-2"><input type="checkbox" name="delOff_no" class="delChkbox" value="${office.off_no}" /></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="row"><td class="col-12" colspan="8">등록된 오피스이 없습니다.</td></tr>
								</c:otherwise>
							</c:choose>
							</tbody>
							<tfoot>
								<tr class="row">
									<td class="col-6" colspan="4"><input type="button" onclick="location.href='./insertOfficeView.reo?pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%>'
									<%} else {%>1'<%}%>" class="btn btn-success float-left" value="오피스등록"/></td>
									<td class="col-6" colspan="4"><a href="" class="openDeleteModal btn btn-danger float-right" data-toggle="modal" data-id="${office.off_no}" data-target="#deleteModal">오피스삭제</a></td>
								</tr>
								<tr class="row"><td class="col-12" colspan="8">${paging}</td></tr>
							</tfoot>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>
<footer>
	<jsp:include page="/resources/include/client/footer.jsp" />
</footer>
<!-- Modal -->
		<div class="modal fade" id="deleteModal"  role="dialog"  >
			<div class="modal-dialog" >
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">오피스 삭제</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"></div>
					<div class="modal-footer">
						<button type="button" onclick="delSubmit()" id="delBtn" class="btn btn-danger">삭제하기</button>
						<button type="button" id="delCancel" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>