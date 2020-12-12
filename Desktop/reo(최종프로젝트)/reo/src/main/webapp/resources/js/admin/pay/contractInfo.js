$(document).ready(function() {
	$("#contractForm").submit();
	$("#contractForm").remove();

	$(document).bind("contextmenu", function() {
		alert("오른쪽 마우스 버튼 사용 불가");
		return false;
	});
	$("div:not(.windowMenu)").bind("selectstart", function() {
		alert("선택 불가");
		return false;
	});
	$("div:not(.windowMenu)").bind("click", function() {
		alert("클릭 불가");
		return false;
	});
	$(document).bind("dblclick", function() {
		alert("더블클릭 불가");
		return false;
	});
	$(document).bind("dragstart", function() {
		alert("드래그 불가");
		return false;
	});
	$(document).bind("keydown", function() {
		if (event.keyCode != 116) { // F5
			alert("사용 불가");
			return false;
		}
	});
	$("iframe").bind("focus", function() {
		alert("포커스 불가");
		return false;
	});

	$(".fas.fa-times").on("click", function() {
		window.close();
	});
});