<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	<script type="text/javascript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://www.google.com/recaptcha/api.js" async defer></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="resources/css/client/member/join.css">
	<link type="text/css" rel="stylesheet" href="resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>

	<style type="text/css">
		.error {
			color: red;
		}
	</style>
</head>

<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<section>
					<div class="joinform">
						<h1 class="entry-title" style="text-align: center;">
							<span>회원가입</span>
						</h1>
						<hr>
						<form:form class="form-horizontal" method="post" id="joinForm" action="insertMember.reo"
							commandName="memberDTO">
							<!-- 본인확인 이메일 -->
							<div class="form-group col-12">
								<label for="mem_email">이메일</label>
								<c:set var="email" value="${memberDTO.mem_email}" />
								<c:choose>
									<c:when test="${email eq null}">
										<div>
											<form:input path="mem_email" type="email" class="email form-control col-8"
												name="mem_email" id="mem_email" placeholder="E-mail" />
											<button type="button" class="btn btn-info col-3" id="sendemail"
												onclick="sendEmail()">메일 인증</button>
											<div id="email_check">
												<form:errors path="mem_email" class="check_font" cssClass="error">
												</form:errors>
											</div>
											<input type="text" class="cel form-control col-8" id="cerNum" name="cerNum"
												onkeyup="this.value=this.value.replace(/[^0-9a-zA-Z]/g,'');" maxlength="10" />
											<button type="button" class="btn btn-info col-3 cel" name="cer" id="cer"
												onclick="checkNum()">인증확인</button>
											<div class="check_font" id="cer_check"></div>
										</div>
									</c:when>
									<c:when test="${email ne null}">
										<div>
											<form:input path="mem_email" type="email" class="email form-control col-12"
												name="mem_email" id="mem_email" readonly="true" />
										</div>
									</c:when>
								</c:choose>
							</div>
							<!-- 비밀번호 -->
							<div class="form-group col-12">
								<label for="mem_pw">비밀번호</label>
								<form:input path="mem_pw" type="password" class="form-control" id="mem_pw" name="mem_pw"
									placeholder="비밀번호(8~20자,숫자,영문,특수문자)" />
								<form:errors path="mem_pw" class="check_font" id="pw_check" cssClass="error">
								</form:errors>
							</div>
							<!-- 비밀번호 재확인 -->
							<div class="form-group col-12">
								<label for="pwChk">비밀번호 확인</label>
								<input type="password" class="form-control" id="pwChk" name="pwChk"
									placeholder="비밀번호 확인">
								<p class="check_font" id="pwcheck"></p>
							</div>
							<c:if test="${buisness eq 'buisness'}">
								<!-- 사업자 번호 -->
								<div class="form-group col-12">
									<label for="mem_buisnessNo">사업자 번호</label>
									<div>
										<form:input path="mem_buisnessNo" type="number" class="email form-control col-8"
											id="mem_buisnessNo" name="mem_buisnessNo" placeholder="ex)1234567890" />
										<button type="button" class="btn btn-info col-3" id="biusnessbtn"
											onclick="buisnessno()">조회</button>
										<div id="buisnessChk">
											<form:errors path="mem_buisnessNo" class="check_font" cssClass="error">
											</form:errors>
										</div>
									</div>
								</div>
								<!-- 기업 이름 -->
								<div class="form-group col-12">
									<label for="mem_agentName">기업 이름</label>
									<form:input path="mem_agentName" type="text" class="form-control" id="mem_agentName"
										name="mem_agentName" placeholder="이름" />
									<form:errors path="mem_agentName" class="check_font" id="mem_check"
										cssClass="error"></form:errors>
								</div>
							</c:if>
							<c:set var="name" value="${memberDTO.mem_name}" />
							<c:choose>
								<c:when test="${name eq null}">
									<!-- 이름 -->
									<div class="form-group col-12">
										<label for="mem_name">이름</label>
										<form:input path="mem_name" type="text" class="form-control" id="mem_name"
											name="mem_name" placeholder="이름" />
										<form:errors path="mem_name" class="check_font" id="mem_check" cssClass="error">
										</form:errors>
									</div>
								</c:when>
								<c:when test="${name ne null}">
									<div class="form-group col-12">
										<label for="mem_name">이름</label>
										<form:input path="mem_name" type="text" class="form-control" id="mem_name"
											name="mem_name" readonly="true" />
									</div>
								</c:when>
							</c:choose>
							<!-- 휴대전화 -->
							<div class="form-group col-12">
								<label for="mem_tel">휴대전화 ('-' 없이 번호만 입력해주세요)</label>
								<form:input path="mem_tel" type="tel" class="form-control" id="mem_tel" name="mem_tel"
									placeholder="Phone Number" />
								<div id="phone_check">
									<form:errors path="mem_tel" class="check_font" cssClass="error"></form:errors>
								</div>
							</div>
							<!-- 주소 -->
							<div class="form-group col-12">
								<form:input path="mem_zipcode" class="form-control" style="width: 40%; display: inline;"
									placeholder="우편번호" name="mem_zipcode" id="mem_zipcode" type="text"
									readonly="true" />
								<button type="button" class="btn btn-default" onclick="execDaumPostcode();"><i
										class="fa fa-search"></i> 우편번호 찾기</button>
								<form:errors path="mem_zipcode" cssClass="error"></form:errors>
							</div>
							<div class="form-group col-12">
								<form:input path="mem_roadaddress" class="form-control" style="top: 5px;"
									placeholder="도로명 주소" name="mem_roadaddress" id="mem_roadaddress" type="text"
									readonly="readonly" />
								<form:errors path="mem_roadaddress" cssClass="error"></form:errors>
							</div>
							<div class="form-group col-12">
								<form:input path="mem_detailaddress" class="form-control" placeholder="상세주소"
									name="mem_detailaddress" id="mem_detailaddress" type="text" />
								<form:errors path="mem_detailaddress" cssClass="error"></form:errors>
							</div>
							<!-- 생년월일 -->
							<div class="form-group required col-12">
								<jsp:useBean id="todate" class="java.util.Date"/>
								<label for="mem_birth">생년월일</label>
								<form:input path="mem_birth" type="date" class="form-control" id="mem_birth"
									name="mem_birth" max="9999-12-31" />
								<div id="birth_check">
									<form:errors class="check_font" cssClass="error"></form:errors>
								</div>
							</div>
							<div class="form-group col-12">
								<div class="g-recaptcha" data-sitekey="6Lepb7UZAAAAANfx_SDFvA2w3fWxXHH203I8bChY"></div>
								<span class="captcha_chk"></span>
							</div>
							<input type="hidden" class="mem_role" name="mem_role" value="${memberDTO.mem_role}" />
							<div class="reg_button col-12">
								<a class="btn btn-danger" href="${pageContext.request.contextPath}/index.reo">
									<i class="fa fa-rotate-right"></i>취소하기
								</a>&emsp;&emsp;
								<button class="btn btn-primary" id="reg_submit" type="button" onclick="captcha()">
									<i class="fa fa-heart"></i>가입하기
								</button>
							</div>
						</form:form>
					</div>
				</section>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
</body>
<script type="text/javascript">
	$(document).ready(function () {
		$("#mem_email").on("propertychange change keyup paste input", function () {
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
					if (data == 1) {
						$("#email_check").text("사용중인 이메일입니다");
						$("#email_check").css("color", "red");
						$('#mem_email').focus();
						$('#sendemail').attr("disabled", "disabled");
						return false;
					} else {
						$("#email_check").text("사용가능한 이메일입니다");
						$("#email_check").css("color", "blue");
						$('#sendemail').removeAttr("disabled");
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
		if (email == '') {
			$("#email_check").text("이메일을 입력 하세요.");
			$("#email_check").css("color", "red");
			$('#check').css("display", none);
			$('#cer').css("display", none);
			$('#mem_email').focus();
		} else {
			$.ajax({
				url: './sendMail.reo?mem_email=' + email,
				type: 'GET',
				contentType: 'text/plain; charset=utf-8',
				dataType: 'text',
				success: function (data) {
					console.log(data);
					if ($("#mem_email").val() != '') {
						$('#cer').css("display", "inline");
						$('#cerNum').css("display", "inline");
					}
				}
			});
		};
	};
</script>
<script type="text/javascript">
	function buisnessno() {
		var num = $('#mem_buisnessNo').val();
		if (num == '') {
			$('#buisnessChk').text("사업자 번호를 입력 하세요.");
			$('#buisnessChk').css("color", "red");
			$('#mem_buisnessNo').focus();
		} else {
			$.ajax({
				url: "./buisnessNo.reo?mem_buisnessNo=" + num,
				type: "GET",
				data: num,
				dataType: "text",
				cache: false,
				success: function (data) {
					if (data == 1) {
						$('#buisnessChk').text("등록되어 있지 않은 사업자등록번호 입니다.");
						$('#buisnessChk').css("color", "red");
						$('#mem_buisnessNo').focus();
					} else {
						$('#buisnessChk').text("등록되어 있는 사업자등록번호 입니다.");
						$('#buisnessChk').css("color", "blue");
						$('#mem_buisnessNo').attr("readonly", true);
						$("#biusnessbtn").css("display", "none");

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
							$("#cer").css("display", "none");
							$("#sendemail").css("display", "none");
							$('#cerNum').attr("readonly", true);
							$('#mem_email').attr("readonly", true);
							$('#mem_pw').focus();
						} else {
							$("#cer_check").text("인증번호를 확인 하세요.");
							$("#cer_check").css("color", "red");
						}
					}
				}
			});
		};
	};
</script>
<script type="text/javascript">
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

	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function (data) {
				var fullRoadAddr = data.roadAddress;
				var extraRoadAddr = "";
				// 법정동명이 있을 경우 추가 (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝남
				if (data.bname != "" && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가
				if (data.buildingName != "" && data.apartment == "Y") {
					extraRoadAddr += (extraRoadAddr !== "" ? ", " + data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열 생성
				if (extraRoadAddr != "") {
					extraRoadAddr = " (" + extraRoadAddr + ")";
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소 추가
				if (fullRoadAddr != "") {
					fullRoadAddr += extraRoadAddr;
				}
				// 우편번호, 주소 값 바인딩
				$("#mem_zipcode").val(data.zonecode);
				$("#mem_roadaddress").val(fullRoadAddr);
				$("#mem_detailaddress").focus();
			}
		}).open();
	};

	function captcha() {
		var captcha = 1;
		$.ajax({
			url: '/reo/VerifyRecaptcha.reo',
			type: 'post',
			data: { recaptcha: $(".g-recaptcha-response").val() },
			success: function (data) {
				switch (data) {
					case 0:
						$('.captcha_chk').css("display", "none");
						console.log("자동 가입 방지 봇 통과");
						captcha = 0;
						$('#joinForm').submit();
						break;
					case 1:
						$('.captcha_chk').text("보안문자를 확인해주세요.");
						$('.captcha_chk').css("color", "red");
						break;
					default:
						$('.captcha_chk').text("보안문자를 확인해주세요.");
						$('.captcha_chk').css("color", "red");
						return false;
						break;
				}
			}
		});
	}

	var today = getTimeStamp();
	var date = $('#mem_birth').val();
	function getTimeStamp() {
		var d = new Date();

		var s =
			leadingZeros(d.getFullYear(), 4) + '-' +
			leadingZeros(d.getMonth() + 1, 2) + '-' +
			leadingZeros(d.getDate(), 2);

		return s;
	}

	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++) {
				zero += '0';
			}
		}
		return zero + n;
	}

	$('#mem_birth').on("propertychange change intput", function () {
		if ($('#mem_birth').val() > today) {
			$('#birth_check').text("오늘 이후 날짜는 선택할 수 없습니다.");
			$('#birth_check').css("color", "red");
			$('#mem_birth').val(today);
		} else {
			$('#birth_check').text("");
		}
	})
</script>

</html>