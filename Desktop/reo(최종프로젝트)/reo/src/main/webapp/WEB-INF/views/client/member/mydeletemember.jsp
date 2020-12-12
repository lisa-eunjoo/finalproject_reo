<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/myinfo.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<jsp:include page="/resources/include/client/header.jsp" />

<body>
	<c:set var="password" value="${member.mem_pw}" />
	<c:choose>
		<c:when test="${password ne null}">
			<div class="container contents-wrap">
				<div id="content" class="content">
					<div class="my_reo col-12">
						<div class="info_modify">
							<div class="steps s01"><i class="fas fa-lock"></i></div>
							<div class="step1">
								<p class="t1">개인정보보호를 위한 확인절차단계입니다.</p>
								<p class="t2"><strong>회원 탈퇴를 </strong>하시려면 <strong>비밀번호를 입력</strong>해주세요.</p>

								<label for="pwInfo">
									<span class="inputs">
										<input type="password" id="pwInfo" class="mem_pw" name="mem_pw"
											placeholder="비밀번호 입력">
									</span>
								</label>
								<span class="pwinfo"></span>
								<div class="bts">
									<button type="button" onclick="pwche();" class="btn btn-primary">확인</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:when>
		<c:when test="${password eq null}">
			<div class="container">
				<div id="content" class="content">
					<div class="my_reo col-12">
						<div class="info_modify">
							<div class="steps s01"><i class="fas fa-lock"></i></div>
							<div class="step1">
								<p class="t1">개인정보보호를 위한 확인절차단계입니다.</p>
								<p class="t2">회원정보를 수정하시려면 <strong>초기 비밀번호를 설정</strong>해주세요.</p>

								<label for="pwInfo">
									<span class="inputs">
										<input type="password" id="mem_pw" class="mem_pw" name="mem_pw"
											placeholder="비밀번호">
									</span>
								</label>
								<span class="pwinfo"></span>
								<label for="pwInfo">
									<span class="inputs">
										<input type="password" id="pwChk" class="pwChk" name="pwChk"
											placeholder="비밀번호 확인">
									</span>
								</label>
								<span id="pwcheck"></span>
								<div class="bts">
									<button type="button" onclick="pwupdate();" class="btn btn-primary">확인</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>
	<div id="openModal"></div>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
</body>
<script type="text/javascript">
	function pwupdate() {
		if ($('.mem_pw').val() != $('.pwChk').val()) {
			$('.pwinfo').text("비밀번호를 확인해 주세요.");
			$('.pwinfo').css("color", "red");
			return false;
		}
		var params = "mem_pw=" + $('.mem_pw').val();
		$.ajax({
			type: "POST",
			url: "./pwinsert.reo",
			data: params,
			success: function (data) {
				console.log(data)
				location.href = "./mypage.reo"
			}
		});
	}
	function pwche() {
		var params = "mem_pw=" + $('.mem_pw').val();
		console.log(params);
		if ($('#pwInfo').val() == "") {
			$('.pwinfo').text("비밀번호를 입력해 주시길 바랍니다.");
			$('.pwinfo').addClass("text-danger");
			$('.mem_pw').focus();
		} else {
			$.ajax({
				type: "POST",
				url: "./mydeleteMember.reo",
				data: params,
				success: function (data) {
					console.log(data)
					if (data == 'false') {
						$('.pwinfo').text("비밀번호를 확인해 주세요.");
						$('.pwinfo').css("color", "red");
					} else {
						$('.pwinfo').css("display", "none");
						modalCall("logout.reo", "회원탈퇴 완료", "회원탈퇴가 완료되었습니다.<br>그동안 이용해 주셔서 감사합니다.<br>메인으로 이동합니다.");
					}
				}
			});
		}
	};
	$(function () {
		$('#pwChk').keyup(function () {
			if ($('#mem_pw').val() != $('#pwChk').val()) {
				$("#pwcheck").text("비밀번호가 일치하지 않습니다.");
				$("#pwcheck").css("color", "red");
			} else {
				$("#pwcheck").text("비밀번호가 일치 합니다.");
				$("#pwcheck").css("color", "blue");
			}
		});
	});
	function modalCall(location, title, body) {
		callModal(location, title, body);
		$("#noBtn").remove();
	}
	$("#openModal").on("hidden.bs.modal", function () {
		location.href = "logout.reo";
	});
</script>
<script type="text/javascript" src="resources/js/openModal.js"></script>

</html>