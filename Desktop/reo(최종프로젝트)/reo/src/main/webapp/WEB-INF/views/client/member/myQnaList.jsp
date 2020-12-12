<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>REO</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/mypage.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>

<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<section>
		<div class="container myfavorite contents-wrap">
			<div class="row my_reo col-12">
				<div class="use_status col-12">
					<div class="col-12 default_tabs t3">
						<ul class="col-12">
							<li class="col-12"><a href="myQnaList.reo">문의 내역</a></li>
						</ul>
					</div>
					<c:choose>
						<c:when test="${not empty mylist}">
							<c:forEach items="${mylist}" var="qna">
								<h4 class="panel-title">
									<a id="qna_data${qna.qna_no}" data-toggle="collapse" data-parent="#accordion"
										href=".${qna.qna_no}" aria-expanded="false" aria-contorls="collapseOne">
								</h4>
								<div class="media border p-3">
									<div class="media-body col-12">
										<input type="hidden" class="qna_no" name="qna_no" value="${qna.qna_no}" />
										<h6>${qna.qna_name} <small>${qna.qna_date} <span class="report">신고
													${qna.qna_report}</span></small></h6>
										<c:choose>
											<c:when test="${(qna.qna_report ge 10) && (qna.qna_email ne mem_email)}">
												<div>
													<font color="red">신고를 받아 조회 금지된 게시물입니다. <i class="fa fa-ban"></i>
													</font>
												</div>
											</c:when>
											<c:when test="${not empty qna.qna_password && qna.qna_email eq mem_email}">
												<div id="title${qna.qna_no}">${qna.qna_title} <i
														class="fas fa-lock"></i></div>
												<div class="${qna.qna_no} panel-collapse collapse in" role="tabpanel"
													aria-labelledby="headingOne">
													<div class="panel-body">
														<pre><span id="content${qna.qna_no}" class="qnacontent">${qna.qna_content}</span></pre>
													</div>
												</div>
											</c:when>
											<c:when test="${empty qna.qna_password}">
												<div id="title${qna.qna_no}" style="display: inline;">${qna.qna_title}
												</div>
												<div class="myqnalistbtn btn-group btn-group-sm">
													<c:if test="${qna.qna_email eq mem_email}">
														<button id="modify${qna.qna_no}" class="btn btn-info"
															onclick="modify('${qna.qna_no}')"><i
																class="fas fa-edit"></i></button>
														<button id="delete${qna.qna_no}" class="btn btn-danger"
															onclick="model('${qna.qna_no}')"><i
																class="fas fa-trash-alt"></i></button>
														<button id="mod${qna.qna_no}" class="btn btn-info mod"
															style="display: none;" onclick="mod('${qna.qna_no}')"><i
																class="fas fa-check"></i></button>
														<button id="can${qna.qna_no}" class="btn btn-danger"
															style="display: none;" onclick="can('${qna.qna_no}')"><i
																class="fas fa-times"></i></button>
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
						</c:when>
						<c:otherwise>
							<div class="ls_result on">
								<p class="ls_result_no">문의하신 내역이 없습니다.</p>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div id="openModal"></div>
	</section>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
	<script type="text/javascript">
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
		};
		function model(qna_no) {
			modalCall("./qnaDelete.reo?qna_no=" + qna_no, "삭제", "정말 삭제 하시겠습니까?");
		};
		function modalCall(location, title, body) {
			callModal(location, title, body);
		}
		$("#openModal").on("hidden.bs.modal", function () {
			location.href = "myQnaList.reo";
		});
	</script>
	<script type="text/javascript" src="resources/js/openModal.js"></script>
</body>

</html>