$(function() {
	$("#closeMenuBar").click(function() {
		if (!$("#menuBar").hasClass("menuHidden")) {
			$("#menuBar").addClass("menuHidden");
		}
	});

	$("#openMenuBar").click(function() {
		$("#menuBar").removeClass("menuHidden");
	});

	$("section").click(function() {
		if (!$("#menuBar").hasClass("menuHidden")) {
			$("#menuBar").addClass("menuHidden");
		}
	})
});