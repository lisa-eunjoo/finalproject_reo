<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>비밀번호 변경</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/join.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		$("#mem_email").blur(function () {
			var email = $('#mem_email').val();
			$.ajax({
				url: './emailChk.reo?mem_email=' + email,
				type: 'GET',
				dataType: 'text',
				success: function (data) {
					console.log("1 = 중복o / 0 = 중복x : " + data);
					if ($("#mem_email").val() == '') {
						$("#email_check").text("이메일을 입력 하세요.");
						$("#email_check").css("color", "red");
						$('#mem_email').focus();
					}
					if (data == 0) {
						$("#email_check").text("이메일을 확인하세요.");
						$("#email_check").css("color", "red");
					} else {
						$("#email_check").text("");
					}
				}, error: function () {
					$('#mem_email').focus();
					console.log("실패");
				}
			});
		});
	});
</script>
<script type="text/javascript">
	function sendEmail() {
		var email = $('#mem_email').val();
		console.log(email)
		if (email == '') {
			$("#email_check").text("이메일을 입력 하세요.");
			$("#email_check").css("color", "red");
			$('#cer').css("display", "none")
			$('#mem_email').focus();
		} else {
			$.ajax({
				url: './sendMail.reo?mem_email=' + email,
				type: 'GET',
				contentType: 'text/plain; charset=utf-8',
				dataType: 'text',
				success: function (data) {
					if ($("#mem_email").val() != '') {
						$('#cer').css("display", "inline");
						$('#cerNum').css("display", "inline");
						$('#mem_email').attr("readonly", true);
					}
				}
			});
		};
	};
</script>
<script type="text/javascript">
	function checkNum() {
		var num = $('#cerNum').val();
		var email = $("#mem_email").val();
		var tranferData = { "mem_email": email, "cerNum": num };
		if (num == '') {
			$("#cer_check").text("인증번호를 입력 하세요.");
			$("#cer_check").css("color", "red");
			$('#cerNum').focus();
		} else {
			$.ajax({
				url: './join_injeung.reo',
				type: 'POST',
				data: JSON.stringify(tranferData),
				success: function (data) {
					console.log(data);
					if (data != null && data != '') {
						if (data == '0') {
							$("#cer_check").text("인증되었습니다.");
							$("#cer_check").css("color", "blue");
							$(".pwChange").css("display", "inline");
							$("#cer").css("display", "none");
							$("#sendemail").css("display", "none");
							$('#cerNum').attr("readonly", true);
						} else {
							$("#cer_check").text("인증번호를 확인 하세요.");
							$("#cer_check").css("color", "red");
						}
					}
				}
			});
		};
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
		})
	});
</script>

<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-12">
				<form:form action="passchange.reo" method="post" commandName="memberDTO">
					<div class="form-group col-12">
						<label for="mem_email">이메일</label>
						<div>
							<form:input path="mem_email" type="email" class="email form-control col-8" name="mem_email"
								id="mem_email" placeholder="E-mail" />
							<button type="button" class="btn btn-info col-3" id="sendemail" onclick="sendEmail()">메일
								인증</button>
							<form:errors path="mem_email" class="check_font" cssClass="error"></form:errors>
							<div id="email_check"></div>
							<input type="number" class="cel form-control col-8" id="cerNum" name="cerNum">
							<button type="button" class="cel btn btn-info col-3" name="cer" id="cer"
								onclick="checkNum()">인증확인</button>
							<div class="check_font" id="cer_check"></div>
						</div>
					</div>
					<div class="pwChange">
						<div class="form-group col-8">
							<label for="mem_pw">변경할 비밀번호</label>
							<input type="password" class="form-control" id="mem_pw" name="mem_pw"
								placeholder="변경할 비밀번호" />
							<p class="check_font" id="pw_check"></p>
						</div>
						<!-- 비밀번호 재확인 -->
						<div class="form-group col-8">
							<label for="pwChk">비밀번호 확인</label>
							<input type="password" class="form-control" id="pwChk" name="pwChk" placeholder="비밀번호 확인">
							<p class="check_font" id="pwcheck"></p>
						</div>
						<div class="form-group col-12 changebtn">
							<button type="submit" class="btn btn-primary btn-lg">변경</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>

</html>