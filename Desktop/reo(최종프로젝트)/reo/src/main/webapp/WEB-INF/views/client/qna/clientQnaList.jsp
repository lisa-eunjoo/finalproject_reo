<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>QNA 목록</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<section>
		<div class="container contents-wrap">
			<div class="sort_bar col-12">
				<div class="text-center">
					<h2>Q&A 게시판</h2>
				</div>
			</div>
			<div class="table-responsive">
				<c:forEach items="${qnaList }" var="qna">
					<h4 class="panel-title">
						<a id="qna_data${qna.qna_no}" data-toggle="collapse" data-parent="#accordion"
							href=".${qna.qna_no}" aria-expanded="false" aria-contorls="collapseOne">
					</h4>
					<div class="media border p-3">
						<div class="media-body">
							<input type="hidden" class="qna_no" name="qna_no" value="${qna.qna_no}" />
							<h6>${qna.qna_name} <small>${qna.qna_date} <span class="report">신고
										${qna.qna_report}</span></small></h6>
							<c:choose>
								<c:when test="${(qna.qna_report ge 10) && (qna.qna_email ne mem_email)}">
									<div>
										<font color="red">신고를 받아 조회 금지된 게시물입니다. <i class="fa fa-ban" title="금지글"></i></font>
									</div>
								</c:when>
								<c:when test="${not empty qna.qna_password && qna.qna_email eq mem_email}">
									<div id="title${qna.qna_no}" style="display: inline;">${qna.qna_title} <i
											class="fas fa-lock" title="비밀글"></i></div>
									<div class="myqnalistbtn btn-group btn-group-sm">
										<c:if test="${qna.qna_email eq mem_email}">
											<button id="modify${qna.qna_no}" class="btn btn-info"
												onclick="modify('${qna.qna_no}')"><i class="far fa-edit" title="수정"></i></button>
											<button id="delete${qna.qna_no}" class="btn btn-danger"
												onclick="model('${qna.qna_no}')"><i
													class="fas fa-trash-alt"></i></button>
											<button id="mod${qna.qna_no}" class="btn btn-info mod"
												style="display: none;" onclick="mod('${qna.qna_no}')"><i
													class="fas fa-check" title="완료"></i></button>
											<button id="can${qna.qna_no}" class="btn btn-danger" style="display: none;"
												onclick="can('${qna.qna_no}')"><i class="fas fa-times" title="취소"></i></button>
										</c:if>
										<c:if
											test="${(qna.qna_email ne mem_email) && (mem_email ne null) && (qna.qna_report lt 10) && (qna.qna_secret eq 0) }">
											<button class="btn btn-outline-danger" id="reportA" data-toggle="modal" data-target="#myModal"
												data-id='${qna.qna_no}'>신고 🚨</button>
										</c:if>
									</div>
									<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
										aria-labelledby="headingOne">
										<div class="panel-body">
											<pre><span id="content${qna.qna_no}" class="qnacontent">${qna.qna_content}</span></pre>
										</div>
									</div>
								</c:when>
								<c:when test="${not empty qna.qna_password && qna.qna_email ne mem_email}">
									<div>비밀글 입니다. <i class="fas fa-lock" title="비밀글"></i></div>
								</c:when>
								<c:when test="${empty qna.qna_password}">
									<div id="title${qna.qna_no}" style="display: inline;">${qna.qna_title}</div>
									<div class="myqnalistbtn btn-group btn-group-sm">
										<c:if test="${qna.qna_email eq mem_email}">
											<button id="modify${qna.qna_no}" class="btn btn-info"
												onclick="modify('${qna.qna_no}')"><i class="far fa-edit" title="수정"></i></button>
											<button id="delete${qna.qna_no}" class="btn btn-danger"
												onclick="model('${qna.qna_no}')"><i
													class="fas fa-trash-alt" title="삭제"></i></button>
											<button id="mod${qna.qna_no}" class="btn btn-info mod"
												style="display: none;" onclick="mod('${qna.qna_no}')"><i
													class="fas fa-check" title="완료"></i></button>
											<button id="can${qna.qna_no}" class="btn btn-danger" style="display: none;"
												onclick="can('${qna.qna_no}')"><i class="fas fa-times" title="취소"></i></button>
										</c:if>
										<c:if
											test="${(qna.qna_email ne mem_email) && (mem_email ne null) && (qna.qna_report lt 10) && (qna.qna_secret eq 0) }">
											<button class="btn btn-outline-danger" id="reportA" data-toggle="modal" data-target="#myModal"
												data-id='${qna.qna_no}'>신고 🚨</button>
										</c:if>
									</div>
									<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
										aria-labelledby="headingOne">
										<div class="panel-body">
											<pre><span id="content${qna.qna_no}" class="qnacontent">${qna.qna_content}</span></pre>
										</div>
									</div>
								</c:when>
							</c:choose>
						</div>
					</div>
					</a>
					<c:if test="${qna.answer_exist == 1}">
						<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
							aria-labelledby="headingOne">
							<c:if test="${qna.qna_email eq mem_email || qna.qna_secret eq 0}">
								<div style="background-color: #ededed">
									<div class="media border p-3">
										<div class="media-body">
											<h6>${qna.answer_name} <small>${qna.answer_date}</small></h6>
											${qna.answer_title}
											<div class="qnacontent">
												${qna.answer_content}
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="qnabtn">
				<a class="btn btn-primary" href="clientQnaWrite.reo">글쓰기</a>
			</div>
			<form role="form" method="get">
				<div class="search text-center">
					<select name="searchType">
						<option value="n" <c:out value="${scri.searchType == null ? 'selected' : ''}" />>-----</option>
						<option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' : ''}" />>제목</option>
						<option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' : ''}" />>내용</option>
						<option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' : ''}" />>작성자</option>
						<option value="tc" <c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}" />>제목+내용</option>
					</select>
					<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" />
					<button id="searchBtn" type="button" class="btn btn-primary">검색</button>
					<script>
						$(function () {
							$('#searchBtn').click(function () {
								self.location = "clientQnaList.reo" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
							});
						});   
					</script>
				</div>
			</form>
			<div class="text-center">
				<div id="pg">
					<ul class="pagination justify-content-center">
						<c:if test="${pageMaker.prev}">
							<li class="page-item"><a class="page-link"
									href="clientQnaList.reo${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
						</c:if>

						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li class="page-item"><a class="page-link"
									href="clientQnaList.reo${pageMaker.makeSearch(idx)}">${idx}</a></li>
						</c:forEach>

						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li class="page-item"><a class="page-link"
									href="clientQnaList.reo${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div id="openModal"></div>
		<!-- The Modal -->
		<div class="modal" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">신고</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						신고 하시겠습니까?
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" id="reportmodal" class="btn btn-primary"
							onclick="javascript:reportAnswerCheck()" data-dismiss="modal">신고</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>

				</div>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
	<script type="text/javascript">
		$(function () {
			$('#reportA').click(function () {
				var value = $(this).data('id');
				console.log(value);
				$("#reportmodal").attr("onclick", "reportAnswerCheck(" + value + ")");
			});
		});
		function reportAnswerCheck(qna_no) {
			var params = "qna_no=" + qna_no;
			console.log(params);
			$.ajax({
				type: 'POST',
				url: "./reportAnswer.reo",
				data: params,
				success: function (data) {
					if (data == "true") {
						$('span').remove('.report');
						modalCall("clientQnaList.reo", "신고가 완료 되었습니다.");
					} else {
						modalCall("clientQnaList.reo", "신고 할 수 없습니다.");
					}
				}
			});
		};
		function modalCall(location, title, body) {
			callModal(location, title, body);
		}
		$("#openModal").on("hidden.bs.modal", function () {
			location.href = "clientQnaList.reo";
		});

		function can(qna_no) {
			var title = $('#modifyInput' + qna_no).val();
			var content = $('#modifyArea' + qna_no).val();

			$("#title" + qna_no).text("");
			$("#title" + qna_no).text(title);
			$("#content" + qna_no).text("");
			$("#content" + qna_no).text(content);
			$("#modify" + qna_no).css("display", "block");
			$("#delete" + qna_no).css("display", "block");
			$("#mod" + qna_no).css("display", "none");
			$("#can" + qna_no).css("display", "none");
		}

		function modify(qna_no) {
			var title = $("#title" + qna_no).text();
			var content = $("#content" + qna_no).text();

			$("#modify" + qna_no).css("display", "none");
			$("#delete" + qna_no).css("display", "none");
			$("#mod" + qna_no).css("display", "block");
			$("#can" + qna_no).css("display", "block");
			$("a[href='." + qna_no + "']").attr("href", "");
			$("." + qna_no).addClass("show");
			$("#title" + qna_no).text("");
			$("#title" + qna_no).append('<input type="text" id="modifyInput' + qna_no + '" value="' + title + '" />');
			$("#content" + qna_no).text("");
			$("#content" + qna_no).append('<textarea style="width:100%;" id="modifyArea' + qna_no + '">' + content + '</textarea>');
		}

		function mod(qna_no) {
			var title = $('#modifyInput' + qna_no).val();
			var content = $('#modifyArea' + qna_no).val();
			$.ajax({
				url: './qnaUpdate.reo',
				type: 'POST',
				dataType: "JSON",
				data: JSON.stringify({
					"qna_no": qna_no,
					"qna_title": $('#modifyInput' + qna_no).val(),
					"qna_content": $('#modifyArea' + qna_no).val()
				}),
				contentType: 'application/json; charset=UTF-8',
				success: function (data) {
					console.log(data)
					$("#title" + qna_no).text(title);
					$("#content" + qna_no).text(content);
					$("#modify" + qna_no).css("display", "block");
					$("#delete" + qna_no).css("display", "block");
					$("#mod" + qna_no).css("display", "none");
					$("#can" + qna_no).css("display", "none");
					$("." + qna_no).addClass("collapsed");
				}
			});
		}
		function model(qna_no) {
			modalCall("./qnaDelete.reo?qna_no=" + qna_no, "삭제", "정말 삭제 하시겠습니까?");
		}
	</script>
	<script type="text/javascript" src="resources/js/openModal.js"></script>
</body>
</html>