function cancelModal() {
	callModal("", "결제취소", "해당 결제를 취소하시겠습니까?");
	$("#yesBtn").attr("onclick", "payCancel()");
}

function payCancel() {
	$.ajax({
		type : "POST",
		url : "kPayCancel.reo",
		data : JSON.stringify({
			"payNo" : $("#payNo").text()
		}),
		contentType : 'application/json; charset=UTF-8',
		processData : false,
		cache : false,
		async : false,
		timeout : 5000,
		success : function(data) {
			if (data == "Success") {
				$("#cancelBtn").remove();
				$("#payState").text("결제취소");
			} else {
				location.href = "500error.reo";
			}
		},
		error : function() {
			alert("요청에 실패하였습니다. 다시 시도 해주세요.");
		}
	});
}

function contractOpen() {
	var sw = window.outerWidth;
	var sh = window.innerHeight;
//	var w = 773; // 팝업창 가로길이
//	var h = 870; // 세로길이
	var w = 1185; // 팝업창 가로길이
	var h = 925; // 세로길이
	var xpos = 0;
	var ypos = 0;
	if (sw > 1000) {
		xpos = (sw - w) / 2; // 화면에 띄울 위치
		ypos = (sh - h) / 2; // 중앙에 띄웁니다.
	}
	var option = "width = " + w + ", height = " + h + ", top = " + ypos + ", left = " + xpos;
	option += ", menubar = no, status = no, titlebar = no, scrollbars = no, "
	option += "toolbar = no, location = no, resizable = no, fullscreen = no";
	window.open("", "contractInfo", option);
	$("section").append('<form id="contractForm" action="contractInfo.reo" method="POST" target="contractInfo">');
	$("#contractForm").append('<input type="hidden" name="pay_no" value="' + $("#payNo").text() + '"/>');
	$("#contractForm").submit();
	$("#contractForm").remove();
}