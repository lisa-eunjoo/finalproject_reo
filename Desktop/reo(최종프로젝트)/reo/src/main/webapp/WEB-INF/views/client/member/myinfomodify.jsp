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
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/mypage.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/join.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<jsp:include page="/resources/include/client/header.jsp" />

<body>
	<div class="container contents-wrap">
		<div class="row">
			<div class="mymodify col-md-12">
				<section>
					<div class="joinform">
						<h1 class="entry-title" style="text-align: center;">
							<span>정보 수정</span>
						</h1>
						<hr>
						<form:form class="form-horizontal" method="post" id="joinForm" action="myupdateMember.reo"
							commandName="memberDTO">
							<!-- 본인확인 이메일 -->
							<div class="form-group col-12">
								<label for="mem_email">이메일</label>
								<div>
									<form:input path="mem_email" type="email" class="email form-control col-12"
										name="mem_email" id="mem_email" readonly="true" />
								</div>
							</div>
							<!-- 비밀번호 -->
							<div class="form-group col-12">
								<label for="mem_pw">비밀번호</label>
								<form:input path="mem_pw" type="password" class="form-control" id="mem_pw" name="mem_pw"
									placeholder="비밀번호" />
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
							<c:set var="buisnessNo" value="${memberDTO.mem_buisnessNo}" />
							<c:if test="${buisnessNo ne null}">
								<!-- 사업자 번호 -->
								<div class="form-group col-12">
									<label for="mem_buisnessNo">사업자 번호</label>
									<div>
										<form:input path="mem_buisnessNo" type="number"
											class="email form-control col-12" id="mem_buisnessNo" name="mem_buisnessNo"
											readonly="true" />
									</div>
								</div>
								<!-- 기업 이름 -->
								<div class="form-group col-12">
									<label for="mem_agentName">기업 이름</label>
									<form:input path="mem_agentName" type="text" class="form-control" id="mem_agentName"
										name="mem_agentName" placeholder="이름" readonly="true" />
									<form:errors path="mem_agentName" class="check_font" id="mem_check"
										cssClass="error"></form:errors>
								</div>
							</c:if>
							<!-- 이름 -->
							<div class="form-group col-12">
								<label for="mem_name">이름</label>
								<form:input path="mem_name" type="text" class="form-control" id="mem_name"
									name="mem_name" readonly="true" />
								<form:errors path="mem_name" class="check_font" id="mem_check" cssClass="error">
								</form:errors>
							</div>
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
									readonly="true" />
								<form:errors path="mem_roadaddress" cssClass="error"></form:errors>
							</div>
							<div class="form-group col-12">
								<form:input path="mem_detailaddress" class="form-control" placeholder="상세주소"
									name="mem_detailaddress" id="mem_detailaddress" type="text" />
								<form:errors path="mem_detailaddress" cssClass="error"></form:errors>
							</div>
							<!-- 생년월일 -->
							<c:set var="birth" value="${memberDTO.mem_birth}" />
							<c:choose>
								<c:when test="${birth ne null}">
									<div class="form-group required col-12">
										<label for="mem_birth">생년월일</label>
										<form:input path="mem_birth" type="date" class="form-control" id="mem_birth"
											name="mem_birth" readonly="true" />
										<div id="birth_check">
											<form:errors class="check_font" cssClass="error"></form:errors>
										</div>
									</div>
								</c:when>
								<c:when test="${birth eq null}">
									<div class="form-group required col-12">
										<label for="mem_birth">생년월일</label>
										<form:input path="mem_birth" type="date" class="form-control" id="mem_birth"
											name="mem_birth" />
										<div id="birth_check">
											<form:errors class="check_font" cssClass="error"></form:errors>
										</div>
									</div>
								</c:when>
							</c:choose>
							<div class="reg_button col-12">
								<a class="btn btn-danger" href="${pageContext.request.contextPath}/index.reo">
									<i class="fa fa-rotate-right"></i>취소하기
								</a>&emsp;&emsp;
								<button class="btn btn-primary" id="reg_submit" type="submit">
									<i class="fa fa-heart"></i>수정하기
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
</script>

</html>