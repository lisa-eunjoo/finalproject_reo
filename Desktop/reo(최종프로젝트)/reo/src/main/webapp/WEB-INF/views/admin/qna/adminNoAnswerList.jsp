<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>관리자-QNA 목록</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/qna/adminNoAnswerList.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>

<body>
	<jsp:include page="/resources/include/admin/nav.jsp">
		<jsp:param name="qna" value=" " />
	</jsp:include>
	<section>
		<div id="main" class="col-12 col-md-12 col-lg-10 offset-lg-2">
			<h2>Q&A 게시판</h2>
			<div class="qnaMenu">
				<a href="./adminQnaList.reo">전체 글보기</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="./adminReportedList.reo">신고된 글만 보기</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="./adminNoAnswerList.reo">답변 안달린 글만 </a>
			</div>
			<div class="table-responsive">
				<div class="allCheck">
					<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label>
				</div>
				<div class="delBtn">
					<button type="button" class="selectDelete_btn">선택 삭제</button>
				</div>
				<br><br><br>
				<c:forEach items="${qnaList }" var="qna">
					<input type="checkbox" name="chBox" class="chBox" data-cartNum="${qna.qna_no}" />
					<h4 class="panel-title">
						<a id="qna_data${qna.qna_no}" data-toggle="collapse" data-parent="#accordion"
							href=".${qna.qna_no}" aria-expanded="false" aria-contorls="collapseOne">
					</h4>
					<div class="media border p-3">
						<div class="media-body">
							<input type="hidden" class="qna_no" name="qna_no" value="${qna.qna_no}" />
							<h6>${qna.qna_name} <small>${qna.qna_date} <span class="report">신고
										${qna.qna_report}</span></small>
							</h6>
							<c:choose>
								<c:when test="${qna.qna_report ge 10}">
									<div id="title${qna.qna_no}">
										<font color="red">${qna.qna_title} <i class="fa fa-ban"></i></font>
									</div>
									<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
										aria-labelledby="headingOne">
										<div class="panel-body">
											<span id="content${qna.qna_no}" class="qnacontent">
												<pre>${qna.qna_content}</pre></span>
										</div>
									</div>
								</c:when>
								<c:when test="${not empty qna.qna_password}">
									<div id="title${qna.qna_no}">${qna.qna_title} <i class="fas fa-lock" title="비밀글"></i></div>
									<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
										aria-labelledby="headingOne">
										<div class="panel-body">
											<span id="content${qna.qna_no}" class="qnacontent">
												<pre>${qna.qna_content}</pre></span>
										</div>
									</div>
								</c:when>
								<c:when test="${empty qna.qna_password}">
									<div id="title${qna.qna_no}">${qna.qna_title}</div>
									<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
										aria-labelledby="headingOne">
										<div class="panel-body">
											<span id="content${qna.qna_no}" class="qnacontent">
												<pre>${qna.qna_content}</pre></span>
										</div>
									</div>
								</c:when>
							</c:choose>
						</div>
						<div class="btn-group btn-group">
							<button id="modify${qna.qna_no}" class="btn btn-info" onclick="modify('${qna.qna_no}')"><i
									class="far fa-edit" title="수정"></i></button>
							<button id="delete${qna.qna_no}" class="btn btn-danger" onclick="model('${qna.qna_no}')"><i
									class="fas fa-trash" title="삭제"></i></button>
							<button id="mod${qna.qna_no}" class="btn btn-info mod" style="display: none;"
								onclick="mod('${qna.qna_no}')"><i class="fas fa-check" title="완료"></i></button>
							<button id="can${qna.qna_no}" class="btn btn-info" style="display: none;"
								onclick="can('${qna.qna_no}')"><i class="fas fa-times" title="취소"></i></button>
						</div>
					</div>
					</a>
					<c:choose>
						<c:when test="${qna.answer_exist == 1}">
							<input type="hidden" class="qna_no" name="qna_no" value="${qna.qna_no}" />
							<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
								aria-labelledby="headingOne">
								<div style="background-color: #ededed">
									<div class="media border p-3">
										<div class="media-body">
											<h6>${qna.answer_name} <small>${qna.answer_date}</small></h6>
											<div id="answer_title${qna.qna_no}">${qna.answer_title}</div>
											<div id="answer_content${qna.qna_no}">
												<pre>${qna.answer_content}</pre>
											</div>
											<div class="btn-group2 btn-group-sm">
												<button id="modifyAnswer${qna.qna_no}" class="btn btn-info"
													onclick="modifyAnswer('${qna.qna_no}')"><i
														class="far fa-edit" title="수정"></i></button>
												<button id="deleteAnswer${qna.qna_no}" class="btn btn-danger"
													onclick="deleteAnswer('${qna.qna_no}')"><i
														class="fas fa-trash" title="삭제"></i></button>
												<button id="modA${qna.qna_no}" class="btn btn-info mod"
													style="display: none;" onclick="modA('${qna.qna_no}')"><i
														class="fas fa-check" title="완료"></i></button>
												<button id="canA${qna.qna_no}" class="btn btn-info"
													style="display: none;" onclick="canA('${qna.qna_no}')"><i
														class="fas fa-times" title="취소"></i></button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:when>
						<c:when test="${qna.answer_exist == 0}">
							<input type="hidden" class="qna_no" name="qna_no" value="${qna.qna_no}" />
							<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
								aria-labelledby="headingOne">
								<div style="background-color: #ededed">
									<div class="media border p-3">
										<div class="media-body">
											<div id="answer_title${qna.qna_no}"></div>
											<div id="answer_content${qna.qna_no}"></div>
											<div class="btn-group2 btn-group-sm">
												<button id="setAnswer${qna.qna_no}" class="btn btn-info"
													onclick="setAnswer('${qna.qna_no}')">답변하기</button>
												<button id="setA${qna.qna_no}" class="btn btn-info mod"
													style="display: none;" onclick="setA('${qna.qna_no}')"><i
														class="fas fa-check" title="완료"></i></button>
												<button id="stopA${qna.qna_no}" class="btn btn-info"
													style="display: none;" onclick="stopA('${qna.qna_no}')"><i
														class="fas fa-times" title="취소"></i></button>
												<button id="modifyAnswer${qna.qna_no}" class="btn btn-info"
													style="display: none;" onclick="modifyAnswer('${qna.qna_no}')"><i
														class="far fa-edit" title="수정"></i></button>
												<button id="deleteAnswer${qna.qna_no}" class="btn btn-danger"
													style="display: none;" onclick="deleteAnswer('${qna.qna_no}')"><i
														class="fas fa-trash" title="삭제"></i></button>
												<button id="modA${qna.qna_no}" class="btn btn-info mod"
													style="display: none;" onclick="modA('${qna.qna_no}')"><i
														class="fas fa-check" title="완료"></i></button>
												<button id="canA${qna.qna_no}" class="btn btn-info"
													style="display: none;" onclick="canA('${qna.qna_no}')"><i
														class="fas fa-times" title="취소"></i></button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:when>
					</c:choose>
				</c:forEach>
			</div>
			<div class="qnabtn">
				<a class="btn btn-primary" href="adminQnaWrite.reo">글쓰기</a>
			</div>
			<br>
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
								self.location = "./adminNoAnswerList.reo" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
							});
						});
					</script>
				</div>
			</form>
			<div class="text-center">
				<div>
					<ul class="pagination justify-content-center">
						<c:if test="${pageMaker.prev}">
							<li class="page-item"><a class="page-link"
									href="./adminNoAnswerList.reo${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a>
							</li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li class="page-item <c:out value=" ${scri.page==idx ? 'active' : '' }" /> ">
							<a class="page-link" href="./adminNoAnswerList.reo${pageMaker.makeSearch(idx)}">${idx}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li class="page-item"><a class="page-link"
									href="./adminNoAnswerList.reo${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div id="openModal"></div>
	</section>
	<script type="text/javascript">

		function modalCall(location, title, body) {
			callModal(location, title, body);
		}
		$("#openModal").on("hidden.bs.modal", function () {
			location.href = "./adminNoAnswerList.reo";
		});

		function can(qna_no) {
			var title = $('#modifyInput' + qna_no).val();
			var content = $('#modifyArea' + qna_no).val();

			$("#modifyInput").remove();
			$("#modifyArea").remove();
			$("#title" + qna_no).text("");
			$("#title" + qna_no).text(title);
			$("#content" + qna_no).text("");
			$("#content" + qna_no).append('<pre>' + content + '</pre>');
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
				url: './adminQnaUpdate.reo',
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
					$("#modifyInput").remove();
					$("#modifyArea").remove();
					$("#title" + qna_no).text("");
					$("#title" + qna_no).text(title);
					$("#content" + qna_no).text("");
					$("#content" + qna_no).append('<pre>' + content + '</pre>');
					$("#modify" + qna_no).css("display", "block");
					$("#mod" + qna_no).css("display", "none");
				}
			});
		}
		function model(qna_no) {
			modalCall("./adminQnaDelete.reo?qna_no=" + qna_no, "삭제", "정말 삭제 하시겠습니까?");
		}

		$(".selectDelete_btn").click(function () {
			var confirm_val = confirm("정말 삭제하시겠습니까?");

			if (confirm_val) {
				var checkArr = new Array();

				$("input[class='chBox']:checked").each(function () {
					checkArr.push($(this).attr("data-cartNum"));
				});

				$.ajax({
					url: "./adminMultiDelete.reo",
					type: "post",
					data: { chbox: checkArr },
					success: function () {
						location.href = "./adminNoAnswerList.reo";
					},
					error: function (error) {
						alert("글 삭제에 실패했습니다.");
					}
				});
			}
		});

		$(".chBox").click(function () {
			$("#allCheck").prop("checked", false);
		});

		$("#allCheck").click(function () {
			var chk = $("#allCheck").prop("checked");
			if (chk) {
				$(".chBox").prop("checked", true);
			} else {
				$(".chBox").prop("checked", false);
			}
		});

		////////답변작성 관련//////////

		function stopA(qna_no) {
			var answer_title = $('#modifyInput1' + qna_no).val();
			var answer_content = $('#modifyArea1' + qna_no).val();

			$("#modifyInput1").remove();
			$("#modifyArea1").remove();
			$("#answer_title" + qna_no).text("");
			$("#answer_title" + qna_no).text(answer_title);
			$("#answer_content" + qna_no).text("");
			$("#answer_content" + qna_no).append('<pre>' + answer_content + '</pre>');
			$("#setAnswer" + qna_no).css("display", "inline-block");
			$("#setA" + qna_no).css("display", "none");
			$("#stopA" + qna_no).css("display", "none");
			$("#modifyAnswer" + qna_no).css("display", "none");
			$("#deleteAnswer" + qna_no).css("display", "none");
		}

		function setAnswer(qna_no) {
			var answer_title = $("#answer_title" + qna_no).text();
			var answer_content = $("#answer_content" + qna_no).text();

			$("#setAnswer" + qna_no).css("display", "none");
			$("#setA" + qna_no).css("display", "inline-block");
			$("#stopA" + qna_no).css("display", "inline-block");
			$("a[href='." + qna_no + "']").attr("href", "");
			$("." + qna_no).addClass("show");
			$("#answer_title" + qna_no).text("");
			$("#answer_title" + qna_no).append('<input type="text" id="modifyInput1' + qna_no + '" value="' + answer_title + '" />');
			$("#answer_content" + qna_no).text("");
			$("#answer_content" + qna_no).append('<textarea style="width:100%;" id="modifyArea1' + qna_no + '">' + answer_content + '</textarea>');
		}

		function setA(qna_no) {
			var answer_title = $('#modifyInput1' + qna_no).val();
			var answer_content = $('#modifyArea1' + qna_no).val();
			$.ajax({
				url: './adminSetAnswer.reo',
				type: 'POST',
				dataType: "JSON",
				data: JSON.stringify({
					"qna_no": qna_no,
					"answer_title": $('#modifyInput1' + qna_no).val(),
					"answer_content": $('#modifyArea1' + qna_no).val()
				}),
				contentType: 'application/json; charset=UTF-8',
				success: function (data) {
					console.log(data)
					$("#modifyInput1").remove();
					$("#modifyArea1").remove();
					$("#answer_title" + qna_no).text("");
					$("#answer_title" + qna_no).text(answer_title);
					$("#answer_content" + qna_no).text("");
					$("#answer_content" + qna_no).append('<pre>' + answer_content + '</pre>');
					$("#modifyAnswer" + qna_no).css("display", "inline-block");
					$("#deleteAnswer" + qna_no).css("display", "inline-block");
					$("#setAnswer" + qna_no).css("display", "none");
					$("#setA" + qna_no).css("display", "none");
					$("#stopA" + qna_no).css("display", "none");
				}
			});
		}

		///////답변 수정 및 삭제 관련/////////////

		function canA(qna_no) {
			var answer_title = $('#modifyInput1' + qna_no).val();
			var answer_content = $('#modifyArea1' + qna_no).val();

			$("#modifyInput1").remove();
			$("#modifyArea1").remove();
			$("#answer_title" + qna_no).text("");
			$("#answer_title" + qna_no).text(answer_title);
			$("#answer_content" + qna_no).text("");
			$("#answer_content" + qna_no).append('<pre>' + answer_content + '</pre>');
			$("#modifyAnswer" + qna_no).css("display", "inline-block");
			$("#deleteAnswer" + qna_no).css("display", "inline-block");
			$("#modA" + qna_no).css("display", "none");
			$("#canA" + qna_no).css("display", "none");
		}

		function modifyAnswer(qna_no) {
			var answer_title = $("#answer_title" + qna_no).text();
			var answer_content = $("#answer_content" + qna_no).text();

			$("#modifyAnswer" + qna_no).css("display", "none");
			$("#deleteAnswer" + qna_no).css("display", "none");
			$("#modA" + qna_no).css("display", "inline-block");
			$("#canA" + qna_no).css("display", "inline-block");
			$("a[href='." + qna_no + "']").attr("href", "");
			$("." + qna_no).addClass("show");
			$("#answer_title" + qna_no).text("");
			$("#answer_title" + qna_no).append('<input type="text" id="modifyInput1' + qna_no + '" value="' + answer_title + '" />');
			$("#answer_content" + qna_no).text("");
			$("#answer_content" + qna_no).append('<textarea style="width:100%;" id="modifyArea1' + qna_no + '">' + answer_content + '</textarea>');
		}

		function modA(qna_no) {
			var answer_title = $('#modifyInput1' + qna_no).val();
			var answer_content = $('#modifyArea1' + qna_no).val();
			$.ajax({
				url: './adminUpdateAnswer.reo',
				type: 'POST',
				dataType: "JSON",
				data: JSON.stringify({
					"qna_no": qna_no,
					"answer_title": $('#modifyInput1' + qna_no).val(),
					"answer_content": $('#modifyArea1' + qna_no).val()
				}),
				contentType: 'application/json; charset=UTF-8',
				success: function (data) {
					console.log(data)
					$("#modifyInput1").remove();
					$("#modifyArea1").remove();
					$("#answer_title" + qna_no).text("");
					$("#answer_title" + qna_no).text(answer_title);
					$("#answer_content" + qna_no).text("");
					$("#answer_content" + qna_no).append('<pre>' + answer_content + '</pre>');
					$("#modifyAnswer" + qna_no).css("display", "inline-block");
					$("#deleteAnswer" + qna_no).css("display", "inline-block");
					$("#modA" + qna_no).css("display", "none");
					$("#canA" + qna_no).css("display", "none");
				}
			});
		}
		function deleteAnswer(qna_no) {
			modalCall("./adminDeleteAnswer.reo?qna_no=" + qna_no, "삭제", "이 답변을 삭제 하시겠습니까?");
		}
	</script>
	<script type="text/javascript" src="../resources/js/openModal.js"></script>
</body>

</html>