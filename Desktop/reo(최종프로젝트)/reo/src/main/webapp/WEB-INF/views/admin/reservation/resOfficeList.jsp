<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>관리자-상품 리스트</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/office/office.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>

	<script type="text/javascript">
		var limit = 12;
		var offset = 0;
		var isDisplay = false;

		$(function () {
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

			var off_type = $('#typeVal').val();
			var off_unit = $('#unitVal').val();
			var min_price = $('input[name=min_price]').val();
			var max_price = $('input[name=max_price]').val();
			var off_maxNum = $('input[name=off_maxNum]').val();
			var off_options = [];
			var off_options_str = "";
			var pageNo = 1;

			$("input[name=offopt_name]:checked").each(function (i) {
				off_options.push($(this).val());
			});

			if (min_price == '') {
				min_price = 0;
			}
			if (max_price == '') {
				max_price = 0;
			}
			if (off_maxNum == '') {
				off_maxNum = 0;
			}
			if (off_options.length == 0) {
				off_options_str = "null";
			} else {
				for (var i = 0; i < off_options.length; i++) {
					if (i == off_options.length - 1) {
						off_options_str += off_options[i];
					} else {
						off_options_str += off_options[i] + ",";
					}
				}
			}

			var sidx = $('#sortSel').val();
			var sord = $('#sortSel2').val();

			location.href = './getOfficeList.reo?pageNo=' + pageNo + '&off_type=' + off_type + '&off_unit=' + off_unit + '&min_price=' + min_price +
				'&max_price=' + max_price + '&off_maxNum=' + off_maxNum + '&offopt_name=' + off_options_str +
				'&SIDX=' + sidx + '&SORD=' + sord;
	</script>
</head>

<body>
	<section class="container sec">
		<form action="" method="POST" name="filterForm">
			<div id="filterArea">
				<div class="row col-12">
					<div id="typeArea" class="col-12 col-sm-3">
						<span>공간 유형을 선택해주세요.</span>
						<select id="typeVal" class="form-control" name="off_type">
							<option value="전체" selected="selected">전체
							<option value="공유오피스">공유오피스
							<option value="회의실">회의실
							<option value="세미나실">세미나실
							<option value="다목적홀">다목적홀
							<option value="스터디룸">스터디룸
						</select>
					</div>
					<div id="unitArea" class="col-12 col-sm-3">
						<span>예약 단위를 선택해주세요.</span>
						<select id="unitVal" class="form-control" name="off_unit">
							<option value="전체" selected="selected">전체
							<option value="시간">시간단위
							<option value="월">월단위
						</select>
					</div>
					<div class="col-12 col-sm-3">
						<span>가격 범위를 선택해주세요.</span>
						<div class="input-group">
							<input type="number" name="min_price" min="0" value="0" class="form-control"
								onkeypress="return event.charCode >= 48">
							<span id="priceRange">~</span>
							<input type="number" onkeypress="return event.charCode >= 48" name="max_price" min="0"
								class="form-control">
						</div>
					</div>
					<div id="maxnumArea" class="col-12 col-sm-3">
						<span>인원을 선택해주세요.</span>
						<input type="number" name="off_maxNum" min="1" class="form-control"
							onkeypress="return event.charCode >= 48"><br>
					</div>
				</div>
				<div id="optionArea" class="col-12">
					<span>편의시설을 선택해주세요.</span>
					<input type="checkbox" id="opt1" name="offopt_name" value="냉난방" /><label for="opt1">냉난방</label>
					<input type="checkbox" id="opt2" name="offopt_name" value="인터넷/WIFI" /><label
						for="opt2">인터넷/WIFI</label>
					<input type="checkbox" id="opt3" name="offopt_name" value="의자/테이블" /><label
						for="opt3">의자/테이블</label>
					<input type="checkbox" id="opt4" name="offopt_name" value="TV/프로젝터" /><label
						for="opt4">TV/프로젝터</label>
					<input type="checkbox" id="opt5" name="offopt_name" value="음향/마이크" /><label
						for="opt5">음향/마이크</label>
					<input type="checkbox" id="opt6" name="offopt_name" value="복사/인쇄기" /><label
						for="opt6">복사/인쇄기</label>
					<input type="checkbox" id="opt7" name="offopt_name" value="화이트보드" /><label for="opt7">화이트보드</label>
					<input type="checkbox" id="opt8" name="offopt_name" value="PC/노트북" /><label
						for="opt8">PC/노트북</label>
					<input type="checkbox" id="opt9" name="offopt_name" value="개별콘센트" /><label for="opt9">개별콘센트</label>
					<input type="checkbox" id="opt10" name="offopt_name" value="개인사물함" /><label
						for="opt10">개인사물함</label>
					<input type="checkbox" id="opt11" name="offopt_name" value="공기청정기" /><label
						for="opt11">공기청정기</label>
					<input type="checkbox" id="opt12" name="offopt_name" value="보안시스템" /><label
						for="opt12">보안시스템</label>
					<input type="checkbox" id="opt13" name="offopt_name" value="커피/다과" /><label
						for="opt13">커피/다과</label>
					<input type="checkbox" id="opt14" name="offopt_name" value="취사시설" /><label for="opt14">취사시설</label>
					<input type="checkbox" id="opt15" name="offopt_name" value="자판기" /><label for="opt15">자판기</label>
					<input type="checkbox" id="opt16" name="offopt_name" value="우편물/택배물 관리" /><label for="opt16">우편물/택배물
						관리</label>
					<input type="checkbox" id="opt20" name="offopt_name" value="내부화장실" /><label
						for="opt20">내부화장실</label>
					<input type="checkbox" id="opt18" name="offopt_name" value="전담컨시어지 서비스" /><label for="opt18">전담컨시어지
						서비스</label>
					<input type="checkbox" id="opt19" name="offopt_name" value="클리닝 서비스" /><label for="opt19">클리닝
						서비스</label>
					<input type="checkbox" id="opt17" name="offopt_name" value="법무사/세무사 무료컨설팅" /><label
						for="opt17">법무사/세무사 무료컨설팅</label>
					<input type="checkbox" id="opt21" name="offopt_name" value="금연" /><label for="opt21">금연</label>
				</div>
				<div id="btnArea" class="col-12">
					<button type="button" onclick="setList()">적용</button>
					<button type="button" onclick="location.href='./getOfficeList.reo'">초기화</button>
				</div>
			</div>
			<div class="inner_width row">
				<div class="sorting_filter type_border col-12">
					<select id="sortSel" name="SIDX">
						<option selected="selected" value="off_no">등록 순</option>
						<option value="off_rent">가격 순</option>
						<option value="off_likeCount">좋아요 순</option>
						<option value="off_name">이름 순</option>
					</select>
					<select id="sortSel2" name="SORD">
						<option selected="selected" value="desc">내림차순</option>
						<option value="asc">오름차순</option>
					</select>
				</div>
			</div>
		</form>
		<form action="./deleteOffice.reo?pageNo=<%=request.getParameter("pageNo")%>" method="POST" name="delForm">
			<!-- 에러땜에 위치 바꿈 -->
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>상품명</th>
						<th>유형</th>
						<th>상호명</th>
						<th>사업자번호</th>
						<th>좋아요수</th>
						<th>수정</th>
						<th>삭제&nbsp;<input type="checkbox" id="chk_all" /></th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:choose>
						<c:when test="${not empty officeList}">
							<c:forEach items="${officeList}" var="office">
								<tr class="deltr">
									<td><a href="./resdetailOffice.reo?off_no=${office.off_no}">${office.off_name}</a>
									</td>
									<td>${office.off_type}</td>
									<td>${office.mem_agentName}</td>
									<td>${office.mem_agentTel}</td>
									<td>${office.off_likeCount}</td>
									<td><button type="button" onclick="location.href='./getOffice.reo?off_no=${office.off_no}&pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%>'
							<%} else {%>1'<%}%>" class="btn btn-success">수정</button></td>
							<td><input type="checkbox" name="delOff_no" class="delChkbox" value="${office.off_no}" /></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr><td colspan="7">등록된 매물이 없습니다.</td></tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
		<div class="text-center">
			<div>${paging}</div>
		</div>
	</form>
</section>
</body>
</html>