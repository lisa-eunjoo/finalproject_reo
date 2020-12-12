$(function() {
	$("tbody > tr").click(function() {
		location.href = "payInfo.reo?payNo=" + $(this).data("payno") + "&pageNo=" + $("#pageNo").val() + "&fromDate="
		+ $("#fromDate").val() + "&toDate=" + $("#toDate").val() + "&searchType="
		+ $("#searchType").val() + "&search=" + $("#search").val();
	});

	$("#fromDate").change(function() {
		$("#toDate").attr("min", $("#fromDate").val());
		$("#toDate").val("");
	});
});