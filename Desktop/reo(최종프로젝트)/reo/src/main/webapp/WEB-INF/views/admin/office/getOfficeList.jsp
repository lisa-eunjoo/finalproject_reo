<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>관리자-상품 목록</title>
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

		function delSubmit() {
			delForm.submit();
		}

		function filterReset() {
			filterForm.reset();
			$('input:checkbox[name=offopt_name]').nextAll('.fa-check').css("color", "gray");
		}

		function displayFilter() {
			if (!isDisplay) {
				$('#filterArea').css("display", "block");
				isDisplay = true;
			} else {
				$('#filterArea').css("display", "none");
				isDisplay = false;
			}
		}
		$(function () {
			$('input:checkbox[name=offopt_name]').click(function () {
				if ($('input:checkbox[id=' + $(this).attr('id') + ']').is(":checked") == true) {
					$('input:checkbox[id=' + $(this).attr('id') + ']').nextAll('.fa-check').css("color", "yellow");

				} else if ($('input:checkbox[id=' + $(this).attr('id') + ']').is(":checked") == false) {
					$('input:checkbox[id=' + $(this).attr('id') + ']').nextAll('.fa-check').css("color", "gray");
				}
			});
		});

		$(function () {
			$(".openDeleteModal").click(function () {
				var chkValues = [];
				$.each($("input[name='delOff_no']:checked"), function () {
					chkValues.push($(this).val());
				});

				$('.modal-footer #delBtn').css("display", "inline");
				$('.modal-footer #delCancel').text("취소하기");

				if (chkValues.length > 0) {
					$(".modal-body").html(chkValues.join(", ") + "번 매물을 삭제하시겠습니까?");
				} else {
					$(".modal-body").html("삭제할 매물을 선택해주세요.");
					$('.modal-footer #delBtn').css("display", "none");
					$('.modal-footer #delCancel').text("확인");
				}
			});
		});

		$(function () {
			// 필터 값들 설정
			var off_type = '전체';
			var off_unit = '전체';
			var min_price = 0
			var max_price = '';
			var off_maxNum = '';
			var offopt_name = 'null';
			var keyword = '';
			var sidx = 'off_no';
			var sord = 'desc';

			if ('<%=request.getParameter("off_type")%>' == 'null') {
			} else {
				off_type = '<%=request.getParameter("off_type")%>';
			}
			if ('<%=request.getParameter("off_unit")%>' == 'null') {
			} else {
				off_unit = '<%=request.getParameter("off_unit")%>';
			}
			if ('<%=request.getParameter("min_price")%>' == 'null') {
			} else {
				min_price = '<%=request.getParameter("min_price")%>';
			}
			if ('<%=request.getParameter("max_price")%>' == 'null') {
			} else {
				max_price = '<%=request.getParameter("max_price")%>';
			}
			if ('<%=request.getParameter("off_maxNum")%>' == 'null') {
			} else {
				off_maxNum = '<%=request.getParameter("off_maxNum")%>';
			}
			if ('<%=request.getParameter("offopt_name")%>' == 'null') {
			} else {
				offopt_name = '<%=request.getParameter("offopt_name")%>';
				offopt_name = offopt_name.replace(/ /g, "");
			}
			if ('<%=request.getParameter("keyword")%>' == 'null') {
			} else {
				keyword = '<%=request.getParameter("keyword")%>';
			}
			if ('<%=request.getParameter("SIDX")%>' == 'null' && '<%=request.getParameter("SORD")%>' == 'null') {
			} else {
				sidx = '<%=request.getParameter("SIDX")%>';
				sord = '<%=request.getParameter("SORD")%>';
			}

			$('#typeVal').val(off_type);
			$('#unitVal').val(off_unit);
			$('input[name=min_price]').val(min_price);
			$('input[name=max_price]').val(max_price);
			$('input[name=off_maxNum]').val(off_maxNum);

			var optArr = offopt_name.split(',');
			$.each(optArr, function (index, item) {
				$('input:checkbox[name=offopt_name][value="' + item + '"]').prop("checked", true);
			});

			$('input[name=keyword]').val(keyword);

			$('#sortSel').val(sidx);
			$('#sortSel2').val(sord);

			// 체크박스 전체 선택,해제
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
			var keyword = $('input[name=keyword]').val();
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
			if (keyword == '') {
				keyword = $('#keyword').text();
			}

			var sidx = $('#sortSel').val();
			var sord = $('#sortSel2').val();

			location.href = './getOfficeList.reo?pageNo=' + pageNo + '&off_type=' + off_type + '&off_unit=' + off_unit + '&min_price=' + min_price +
				'&max_price=' + max_price + '&off_maxNum=' + off_maxNum + '&offopt_name=' + off_options_str +
				'&SIDX=' + sidx + '&SORD=' + sord + '&keyword=' + keyword;
		}
	</script>
</head>

<body>
	<jsp:include page="/resources/include/admin/nav.jsp">
		<jsp:param name="office" value=" " />
	</jsp:include>
	<section>
		<div id="main" class="col-12 col-md-12 col-lg-10 offset-lg-2">
			<div class="sort_bar row">
				<div class="col-12 col-sm-8 row_mg_b mg_pd_z row_height">
					<div class="col-9 col-sm-10 form-group mg_pd_z float_left">
						<input name="keyword" class="form-control col-12 lg_em no_bd " type="text"
							placeholder="검색어를 검색해주세요" />
						<button id="keyword-reset" type="button" onclick="location.href='./getOfficeList.reo'"><i
								class="far fa-times-circle"></i></button>
					</div>
					<div class="col-3 col-sm-2 form-group mg_pd_z float_left row_height">
						<button type="button" onclick="setList()"
							class="form-control btn default type_color col-12 md_em row_height"><i
								class="fas fa-search lg_em" style="font-size:1em;"></i>검색</button>
					</div>
				</div>
				<div class="col-12 col-sm-4 mg_pd_z">
					<button type="button"
						class="btn default type_color col-12 col-sm-5 offset-md-1 float_left row_height md_em"
						onclick="displayFilter()"><i class="fas fa-filter" style="font-size:1em;"></i>필터</button>
				</div>
			</div>
			<form name="filterForm">
				<div id="filterArea" class="display">
					<div class="box_search row">
						<div id="typeArea" class="flex_box col-12 col-sm-3">
							<span class="category_tit"><strong>공간 유형</strong>을 선택해주세요.</span>
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
							<span class="category_tit"><strong>예약 단위</strong>를 선택해주세요.</span>
							<select id="unitVal" class="form-control" name="off_unit">
								<option value="전체" selected="selected">전체
								<option value="시간">시간단위
								<option value="월">월단위
							</select>
						</div>
						<div class="col-12 col-sm-3">
							<span class="category_tit"><strong>가격 범위</strong>를 선택해주세요.</span>
							<div class="input-group">
								<input type="number" name="min_price" min="0" value="0" class="form-control">
								<span id="priceRange">~</span>
								<input type="number" name="max_price" min="0" class="form-control">
							</div>
						</div>
						<div id="maxnumArea" class="col-12 col-sm-3">
							<span class="category_tit"><strong>인원</strong>을 선택해주세요.</span> <input type="number"
								name="off_maxNum" min="1" class="form-control"><br>
						</div>
						<div id="optionArea" class="col-12">
							<span class="category_tit"><strong>편의시설</strong>을 선택해주세요.</span>
							<ul class="check_list space">
								<li>
									<input type="checkbox" id="opt1" name="offopt_name" value="냉난방" />
									<label for="opt1">냉난방</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt2" name="offopt_name" value="인터넷/WIFI" />
									<label for="opt2">인터넷/WIFI</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt3" name="offopt_name" value="의자/테이블" />
									<label for="opt3">의자/테이블</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt4" name="offopt_name" value="TV/프로젝터" />
									<label for="opt4">TV/프로젝터</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt5" name="offopt_name" value="음향/마이크" />
									<label for="opt5">음향/마이크</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt6" name="offopt_name" value="복사/인쇄기" />
									<label for="opt6">복사/인쇄기</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt7" name="offopt_name" value="화이트보드" />
									<label for="opt7">화이트보드</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt8" name="offopt_name" value="PC/노트북" />
									<label for="opt8">PC/노트북</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt9" name="offopt_name" value="개별콘센트" />
									<label for="opt9">개별콘센트</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt10" name="offopt_name" value="개인사물함" />
									<label for="opt10">개인사물함</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt11" name="offopt_name" value="공기청정기" />
									<label for="opt11">공기청정기</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt12" name="offopt_name" value="보안시스템" />
									<label for="opt12">보안시스템</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt13" name="offopt_name" value="커피/다과" />
									<label for="opt13">커피/다과</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt14" name="offopt_name" value="취사시설" />
									<label for="opt14">취사시설</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt15" name="offopt_name" value="자판기" />
									<label for="opt15">자판기</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt16" name="offopt_name" value="우편물/택배물 관리" />
									<label for="opt16">우편물/택배물 관리</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt20" name="offopt_name" value="내부화장실" />
									<label for="opt20">내부화장실</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt18" name="offopt_name" value="전담컨시어지 서비스" />
									<label for="opt18">전담컨시어지 서비스</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt19" name="offopt_name" value="클리닝 서비스" />
									<label for="opt19">클리닝 서비스</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt17" name="offopt_name" value="법무사/세무사 무료컨설팅" />
									<label for="opt17">법무사/세무사 무료컨설팅</label>
									<i class="fas fa-check"></i>
								</li>
								<li>
									<input type="checkbox" id="opt21" name="offopt_name" value="금연" />
									<label for="opt21">금연</label>
									<i class="fas fa-check"></i>
								</li>
							</ul>
						</div>
					</div>
					<div id="btnArea" class="col-12">
						<div class="row">
							<div class="succBtn col-6">
								<button type="button" class="btn success" onclick="setList()">적용</button>
							</div>
							<div class="resetBtn col-6">
								<button type="button" class="btn default" onclick="filterReset()">초기화</button>
							</div>
						</div>
					</div>
				</div>
				<div class="sort_bar row" style="border:none;margin-top:0;">
					<div class="col-12 col-sm-8 row_height" id="keyword-result">
						<c:if test="${not empty keyword}">
							<span class="col-12 row_height lg_em" id="keyword">${keyword}</span><span
								class="col-6 lg_em"> 으(로) 검색 결과입니다.</span>
						</c:if>
					</div>
					<div class="col-12 col-sm-4 mg_pd_z">
						<select id="sortSel" class="type_color col-6 col-sm-5 offset-sm-1 float_left md_em" name="SIDX"
							onchange="setList()">
							<option selected="selected" value="off_no">등록 순</option>
							<option value="off_rent">가격 순</option>
							<option value="off_likeCount">좋아요 순</option>
							<option value="off_name">이름 순</option>
						</select>
						<select id="sortSel2" class="type_color col-6 col-sm-5 offset-sm-1 float_left md_em" name="SORD"
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
						<th class="col-xl-3 col-3">상품명</th>
						<th class="col-xl-1 col-2">유형</th>
						<th class="d-none d-xl-table-cell col-xl-2">가격</th>
						<th class="col-xl-2 col-3">상호명</th>
						<th class="col-xl-1 col-2">수용인원</th>
						<th class="d-none d-xl-table-cell col-xl-1">좋아요수</th>
						<th class="d-none d-xl-table-cell col-xl-1">수정</th>
						<th class="col-xl-1 col-2">삭제&nbsp;<input type="checkbox" id="chk_all" /></th>
					</tr>
					</thead>
					<tbody id="tbody">
					<c:choose>
						<c:when test="${not empty officeList}">
							<c:forEach items="${officeList}" var="office">
								<tr class="row deltr">
									<td class="col-xl-3 col-3"><a href="./detailOffice.reo?off_no=${office.off_no}&pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%><%} else {%>1<%}%>">${office.off_name}</a></td>
									<td class="col-xl-1 col-2">${office.off_type}</td>
									<td class="d-none d-xl-table-cell col-xl-2">${office.off_rent} (${office.off_unit})</td>
									<td class="col-xl-2 col-3">${office.mem_agentName}</td>
									<td class="col-xl-1 col-2">${office.off_maxNum}</td>
									<td class="d-none d-xl-table-cell col-xl-1">${office.off_likeCount}</td>
									<%-- 필터 적용후 페이지에서 수정버튼 눌러 이동후 다시 목록 돌아오면 필터 적용X 쿼리스트링으로 보류 
									&off_type=<%=request.getParameter("off_type")%>&off_unit=<%=request.getParameter("off_unit")%> --%>
									<td class=" d-none d-xl-table-cell col-xl-1"><button type="button" onclick="location.href='./getOffice.reo?off_no=${office.off_no}&pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%>'<%} else {%>1'<%}%>" class="btn btn-success">수정</button></td>
									<td class="col-xl-1 col-2"><input type="checkbox" name="delOff_no" class="delChkbox" value="${office.off_no}" /></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="row"><td class="col-12" colspan="8">등록된 매물이 없습니다.</td></tr>
						</c:otherwise>
					</c:choose>
					</tbody>
					<tfoot>
						<tr class="row">
							<td class="col-6" colspan="4"><input type="button" onclick="location.href='./insertOfficeView.reo?pageNo=<%if(request.getParameter("pageNo") != null){%><%=request.getParameter("pageNo")%>'<%} else {%>1'<%}%>" class="btn btn-success float-left" value="매물등록"/></td>
							<td class="col-6" colspan="4"><a href="" class="openDeleteModal btn btn-danger float-right" data-toggle="modal" data-id="${office.off_no}" data-target="#deleteModal">매물삭제</a></td>
						</tr>
						<tr class="row"><td class="col-12" colspan="8">${paging}</td></tr>
					</tfoot>
				</table>
			</div>
		</form>
	</div>
</section>
<!-- Modal -->
		<div class="modal fade" id="deleteModal"  role="dialog"  >
			<div class="modal-dialog" >
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">매물 삭제</h5>
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