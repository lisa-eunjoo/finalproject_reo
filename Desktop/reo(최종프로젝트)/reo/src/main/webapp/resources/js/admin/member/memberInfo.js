//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function daumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
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

// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
var idJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
$("#mem_email").blur(function() {
	var mem_mail = $("#mem_email").val();
	$.ajax({
		url: "idCheck.reo?mem_email=" + mem_mail,
		type: "GET",
		success: function(data) {
			if (data == 1) {
				// 1 : 아이디가 중복되는 문구
				$("#emailCheck").text("사용중인 아이디입니다.");
				$("#emailCheck").removeAttr("style");
			} else {
				if (idJ.test(mem_mail)) {
					// 0 : 아이디 길이 / 문자열 검사
					$("#emailCheck").text("사용 가능한 ID입니다.");
					$("#emailCheck").css("color", "blue");
				} else if (mem_mail == "") {
					$("#emailCheck").text("아이디를 입력해주세요.");
					$("#emailCheck").removeAttr("style");
				} else {
					$("#emailCheck").text("email형식에 맞지않습니다.");
					$("#emailCheck").removeAttr("style");
				}
			}
		}, error: function() {
			alert("요청에 실패하였습니다. 다시 시도 해주세요.");
		}
	});
});

$("#mem_pwCheck").blur(function() {
	$("#passwordCheck").text("");
	if ($("#mem_pw").val() != $("#mem_pwCheck").val()) {
		$("#passwordCheck").text("비밀번호가 일치하지 않습니다.");
		$("#mem_pw").focus();
		$("#mem_pwCheck").val("");
	}
});

$(document).ready(function() {
	if ($("#ordinary").is(":checked") == true) {
		$("#biz").css("display", "none");
	} else if ($("#business").is(":checked") == true) {
		$("#biz").css("display", "block");
	}

	if ($("#mem_no").val() == 0) {
		$("#modifyBtn").text("회원 등록");
	} else if ($("#mem_no").val() > 0) {
		var link = location.href.split("?")[1];
		$("#memberForm input").attr("disabled", true);
		$("#memberForm").attr("action", "updateMember.reo?" + link);
	}

	$("#modifyBtn").click(function() {
		if ($("#mem_no").is(":disabled") == true) {
			$("#mem_no").attr("disabled", false);
			$("#mem_tel").attr("disabled", false);
			$("#mem_zipcode").attr("disabled", false);
			$("#daumPostcodeBtn").attr("disabled", false);
			$("#mem_roadaddress").attr("disabled", false);
			$("#mem_detailaddress").attr("disabled", false);
			$("#deleteBtn").text("비밀번호 초기화");
			$("#deleteBtn").attr("id", "initPwBtn");
			$("#modifyBtn").text("수정 완료");
		} else if ($("#mem_no").is(":disabled") == false) {
			var reportValidity = $("#memberForm")[0].reportValidity();
			if (reportValidity) {
				$("#memberForm").submit();
			}
		}
	});

	$("[name=mem_sector]").change(function() {
		if ($("#ordinary").is(":checked") == true) {
			$("#biz").css("display", "none");
		} else if ($("#business").is(":checked") == true) {
			$("#biz").css("display", "block");
		}
	});

	$(document).on("click", "#deleteBtn", function() {
		if (confirm("회원 정보를 삭제하시겠습니까?")) {
			location.href = "deleteMember.reo?memNo=" + $(this).data("memno");
		}
	});

	$(document).on("click", "#initPwBtn", function() {
		if (confirm("비밀번호를 초기화 하시겠습니까?")) {
			$.ajax({
				url: "initPassword.reo",
				type: "POST",
				data: JSON.stringify({
					"mem_no": $("#mem_no").val()
				}),
				contentType: "application/json; charset=UTF-8",
				processData: false,
				cache: false,
				async: false,
				timeout: 5000,
				success: function(data) {
					if (data == 1) {
						alert("비밀번호가 'reo123456!'로 초기화되었습니다.");
						location.reload();
					} else {
						location.href = "./500error.reo";
					}
				}, error: function() {
					alert("요청에 실패하였습니다. 다시 시도 해주세요.");
				}
			});
		}
	});
});