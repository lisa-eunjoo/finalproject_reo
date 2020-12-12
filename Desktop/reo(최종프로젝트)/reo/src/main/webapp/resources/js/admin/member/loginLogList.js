$(function() {
	$("#searchForm").submit(function(e) {
		e.preventDefault();
		$("#pageNo").val("1");
		search();
	});

	$(document).on("click", "#logTable a", function(e) {
		e.preventDefault();
		$("#pageNo").val($(this).attr("href"));
		search();
	});

	function search() {
		$.ajax({
			type : "POST",
			url : "loginLogList.reo",
			data : $("#searchForm").serialize(),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			processData : false,
			cache : false,
			timeout : 5000,
			success : function(data) {
				$("#logTable tbody").remove();
				$("#logTable tfoot").remove();
				$("#logTable thead").after(data);
			}, error : function() {
				alert("요청에 실패하였습니다. 다시 시도 해주세요.");
			}
		});
	}
});