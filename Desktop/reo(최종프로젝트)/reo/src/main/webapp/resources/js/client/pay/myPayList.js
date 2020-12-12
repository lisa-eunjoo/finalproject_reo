$(function() {
	$("tbody > tr").click(function() {
		location.href = "myPayInfo.reo?payNo=" + $(this).data("payno") + "&pageNo=" + $("#pageNo").val() +
			"&fromDate=" + $("#fromDate").val() + "&toDate=" + $("#toDate").val() + "&search=" + $("#search").val();
	});

	$("#fromDate").change(function() {
		$("#toDate").attr("min", $("#fromDate").val());
		$("#toDate").val("");
	});
});