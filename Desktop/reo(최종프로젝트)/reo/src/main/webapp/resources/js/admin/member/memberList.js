$(document).ready(function() {
	//체크박스 전체 선택 & 해제
	$('#allCheck').click(function() {
		if ($("#allCheck").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});

	$('#delete').click(function() {
		if (confirm("삭제하시겠습니까?")) {
			var chk_obj = document.getElementsByName("rowCheck");
			var checked = 0;
			for (i = 0; i < chk_obj.length; i++) {
				if (chk_obj[i].checked == true) {
					checked += 1;
				}
			}
			if (checked == 0) {
				alert("선택한 정보가 없습니다.");
				return false;
			} else {
				var link = location.href.split("?")[1];
				if (link != undefined) {
					$("[name=deleteForm]").attr("action", "memberMultiDelete.reo?" + link);
				}
				deleteForm.submit();
			}
		} else {
			return false;
		}
	});

	$('[data-toggle="tooltip"]').tooltip();
});