$(document).ready(function() {
	$(document).bind("contextmenu", function() {
		alert("오른쪽 마우스 버튼 사용 불가");
		return false;
	});
	$(document).bind("selectstart", function() {
		alert("선택 불가");
		return false;
	});
	$(document).bind("click", function() {
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
	$(document).bind("focus", function() {
		alert("포커스 불가");
		return false;
	});

	// 프린트
	$(top.document).find(".fas.fa-print").on("click", function() {
		window.print();
	});

	// PDF 저장
	$(top.document).find(".fas.fa-file-image").on("click", function() {
		 html2canvas($("body")[0]).then(function(canvas) {
			// 캔버스를 이미지로 변환
			var imgData = canvas.toDataURL("계약서/png"); //캔버스를 이미지로 변환
			var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
			var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
			var imgHeight = canvas.height * imgWidth / canvas.width;
			var heightLeft = imgHeight;
			var margin = 12; // 출력 페이지 여백설정
			var doc = new jsPDF("p", "mm"); // jsPDF객체 생성
			var position = 12;

			// 첫 페이지 출력
			doc.addImage(imgData, "PNG", margin, position, imgWidth, imgHeight); //이미지를 기반으로 PDF 생성
			heightLeft -= pageHeight;

			// 한 페이지 이상일 경우 루프 돌면서 출력
			while (heightLeft >= 20) {
				position = heightLeft - imgHeight;
				doc.addPage();
				doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
				heightLeft -= pageHeight;
			}

			doc.save("계약서.pdf"); // 파일 저장
		});
	});

	// 이미지 저장
//	$(top.document).find(".fas.fa-file-image").on("click", function() {
//		html2canvas($("body"), {
//			onrendered: function(canvas) {
// 				canvas.toBlob(function(blob) {
//					saveAs(blob, "계약서.png");
//				});
//			}
//		});
//	});
});