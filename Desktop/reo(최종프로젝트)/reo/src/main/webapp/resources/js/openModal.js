$(document).ready(function() {
	$("#openModal").on("hidden.bs.modal", function() {
		openModalClose();
	});
});

function callModal(location, title, body) {
	if (typeof body == "undefined") {
		body = title;
		title = location;
		openModalOpen1(title, body);
	} else {
		openModalOpen2(location, title, body);
	}
}

function openModalOpen1(title, body) {
	$("#openModal:last").addClass("modal fade").attr("role", "dialog");
	$("#openModal:last").append('<div class="modal-dialog" id="openModal-dialog"></div>');
	$("#openModal-dialog:last").append('<div class="modal-content" id="openModal-content"></div>');
	$("#openModal-content:last").append('<div class="modal-header" id="openModal-header"></div>');
	$("#openModal-header:last").append('<h4 class="modal-title"><span class="fas fa-exclamation-circle"></span> ' + title + '</h4>').append('<button type="button" class="close" data-dismiss="modal">&times;</button>');
	$("#openModal-header:last").after('<div class="modal-body" id="openModal-body"></div>');
	$("#openModal-body:last").append('<p>' + body + '</p>').after('<div class="modal-footer" id="openModal-footer"></div>');
	$("#openModal-footer:last").append('&nbsp;<button type="button" id="noBtn" class="btn btn-primary" data-dismiss="modal">확인</button>');
	$("#openModal").after('<button type="button" id="openModalBtn" class="btn" data-toggle="modal" data-target="#openModal"></button>');
	$("#openModalBtn").css("display", "none");
	$("#openModalBtn").trigger("click");
}

function openModalOpen2(location, title, body) {
	location = "'" + location + "'";
	$("#openModal:last").addClass("modal fade").attr("role", "dialog");
	$("#openModal:last").append('<div class="modal-dialog" id="openModal-dialog"></div>');
	$("#openModal-dialog:last").append('<div class="modal-content" id="openModal-content"></div>');
	$("#openModal-content:last").append('<div class="modal-header" id="openModal-header"></div>');
	$("#openModal-header:last").append('<h4 class="modal-title"><span class="fas fa-exclamation-circle"></span> ' + title + '</h4>').append('<button type="button" class="close" data-dismiss="modal">&times;</button>');
	$("#openModal-header:last").after('<div class="modal-body" id="openModal-body"></div>');
	$("#openModal-body:last").append('<p>' + body + '</p>').after('<div class="modal-footer" id="openModal-footer"></div>');
	$("#openModal-footer:last").append('<button type="button" id="yesBtn" class="btn btn-success" data-dismiss="modal" onclick="location.href=' + location + '">확인</button>').append('&nbsp;<button type="button" id="noBtn" class="btn btn-danger" data-dismiss="modal">취소</button>');
	$("#openModal").after('<button type="button" id="openModalBtn" class="btn" data-toggle="modal" data-target="#openModal"></button>');
	$("#openModalBtn").css("display", "none");
	$("#openModalBtn").trigger("click");
}

function openModalClose() {
	$("#openModal-dialog:last").remove();
	$("#openModalBtn:last").remove();
	$("#openModal:last").removeClass().removeAttr("role").removeAttr("style").removeAttr("aria-hidden");
	$('script[src="resources/js/openModal.js"]').remove();
	$('script:last').remove();
}