<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>관리자-예약변경</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.min.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>

	<style>
		p.peolechoice input {
			font-size: 18px;
			width: 50px;
			padding: 5px;
			margin: 0;
			border: 1px solid #eee;
			text-align: center;
		}

		p.peolechoice button {
			font-size: 20px;
			border: none;
			background: none;
		}
	</style>

	<script type='text/javascript'>
		var text;
		var arrtime = new Array();
		var compare = new Array();
		var firstindex;
		var lastindex;
		var chkcount = 0;
		var checkbool = true;
		var starthour;
		var endhour;
		var test;

		//현재시간
		var sysdate = new Date();
		sysdate = date_to_str(sysdate);
		//현재시간 형변환 함수
		function date_to_str(format) {
			var year = format.getFullYear();
			var month = format.getMonth() + 1;
			if (month < 10) month = '0' + month;
			var date = format.getDate();
			if (date < 10) date = '0' + date;
			var hour = format.getHours();
			if (hour < 10) hour = '0' + hour;
			var min = format.getMinutes();
			if (min < 10) min = '0' + min;
			var sec = format.getSeconds();
			return year + "-" + month + "-" + date + " " + hour + ":" + min + ":" + sec;
		};

		$(document).ready(function () {
			$('.chktime').click(function () {
				if ($("#res_datetime").val().length < 11) {
					$("#res_datetime").val($("#res_datetime").val() + " 00:00:00");
				};
				if (chkcount % 2 == 0) {
					firstindex = $('input:checkbox[class="chktime"]:checked:first').index();
					lastindex = $('input:checkbox[class="chktime"]:checked:last').index();
					$("#res_startdatetime").attr("value", $("#res_datetime").attr("value").substr(0, 11) + $('input:checkbox[class="chktime"]:checked:first').val() + ":00");
					$("#res_enddatetime").attr("value", $("#res_datetime").attr("value").substr(0, 11) + $('input:checkbox[class="chktime"]:checked:last').val() + ":00");
					if (lastindex > firstindex) {
						$("#res_enddatetime").attr("value", $("#res_datetime").attr("value").substr(0, 11) + $('input:checkbox[class="chktime"]:checked:last').val() + ":00");
						for (var i = firstindex + 1; i < lastindex; i++) {
							if ($('input:checkbox[class="chktime"]:eq(' + i + ')').attr("disabled") == "disabled")
								checkbool = false;
						};
						if (checkbool) {
							$('input:checkbox[class="chktime"]').each(function () {
								if (firstindex <= $('.chktime').index(this) && $('.chktime').index(this) <= lastindex) { //값 비교
									this.checked = true; //checked 처리
								}
							});
							chkcount += 1;//범위로 선택됐을때 안되어있을 때 
						} else {
							alert('예약된 시간을 포함할 수 없습니다.');
							$('input:checkbox[class="chktime"]').each(function () {
								this.checked = false; //checked 처리
							});
							checkbool = true;
						};
					};
				} else {
					$('input:checkbox[class="chktime"]').each(function () {
						if (firstindex <= $('.chktime').index(this) && $('.chktime').index(this) <= lastindex) { //값 비교
							this.checked = false; //checked 처리
						}
					});
					chkcount += 1;
				}
			});
			//달력 클릭시 변환 함수
			$('.input-group.date').on('changeDate', function () {
				var tempDate = $("#selectdate").val() + " " + "00:00:00"; //selectdate: db timestamp이라 비교하려고
				//초기화 다선택 할수있게 초기화
				$('input:checkbox[class="chktime"]').each(function () {
					$(this).prop("disabled", false);
				})
				//찍어낼시간 비교용 배열 초기화
				arrtime = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00'];
				//히든 오류 변경 :00:00:00
				$("#res_datetime").val(tempDate); //datetime 값 전송할때 사용
				$("#res_startdatetime").val(tempDate);
				$("#res_enddatetime").val(tempDate);
				//checked 초기화
				$('input:checkbox[class="chktime"]').each(function () {
					$(this).prop("checked", false);
					$(this).prop("disabled", false);
				});
				//hour 초기화
				endhour = 0;
				starthour = 25;
				$.ajax({
					url: "reservAddList.reo",
					type: "POST",
					async: false,
					data: $('#makeReserv').serialize(), //serialize로 form 데이터값 전송
					success: function (data) {
						if (0 < data.length) {
							//예약이 많을경우 0번 인덱스가 아닌 다른 인덱스도 비교해야 되기 때문이다.
							for (var i = 0; i < data.length; i++) {
								starthour = new Date(data[i].res_startdatetime).getHours();
								endhour = new Date(data[i].res_enddatetime).getHours();
								$('input:checkbox[class="chktime"]').each(function () {
									// value가 이안에 있는 값이냐를 물어보고 있으면 disabled 하는 조건문
									if (starthour <= parseInt($(this).val()) && parseInt($(this).val()) <= endhour) {
										$(this).prop("disabled", true);
									};
								});
							}
						}
					},
					error: function () {
						alert("실패");
					}
				});
				//지금 시간 이전 막기 그리고 1시간 뒤부터 예약 가능 시간 짤림
				if (String($("#selectdate").val()).substr(8) == sysdate.slice(8, 10)) {
					var nowTime = parseInt(sysdate.slice(-8, -6)) + 1;
					var time;
					for (var i = arrtime.length; i > -1; i--) {
						time = parseInt(arrtime[i]);
						if (time < nowTime) {
							arrtime.splice(i, 1);
							$('input:checkbox[class="chktime"]:eq(' + i + ')').prop("disabled", true);
						};
					};
				};
			});
			//여기까지 
			$('#UserPeople').html(1); // 선택 내역에서 인원의 초기값을 1로 주기 위해서 
			//인원 선택시 선택 내역의 값 변경
			$("#reservpeople").on("click", function () {
			});
		}); //document 

		//달력생성
		$(function () {
			$('.input-group.date').datepicker({
				calendarWeeks: false,
				todayHighlight: true,
				autoclose: true,
				format: "yyyy-mm-dd",
				language: "kr",
				startDate: 'd',
				endDate: '+65d',
				daysOfWeekDisabled: [0, 7],
			});
		});
		//달력 한글 패치
		(function ($) {
			$.fn.datepicker.dates['kr'] = {
				days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
				daysShort: ["일", "월", "화", "수", "목", "금", "토"],
				daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
				months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			};
		}(jQuery));

		//인원 수량 증가 감소 버튼 
		$(document).ready(function () {
			$(".plus").click(function () {
				var num = $(".numBox").val();
				var plusNum = Number(num) + 1;

				if (plusNum >= 11) {
					$(".numBox").val(num);
				} else {
					$(".numBox").val(plusNum);
				}
				$('#UserPeople').html($(".numBox").val());
			});

			$(".minus").click(function () {
				var num = $(".numBox").val();
				var minusNum = Number(num) - 1;

				if (minusNum <= 0) {
					$(".numBox").val(num);
				} else {
					$(".numBox").val(minusNum);
				}
				$('#UserPeople').html($(".numBox").val());
			});
		});

	</script>
</head>

<body>
	<section class="wrapper">
		<div id="booking_area">
			<form name="reservform" id="makeReserv" action="resChange.reo" method="POST">
				<h2>관리자 예약 변경</h2>
				<p>예약 내역을 변경합니다.</p>
				<input type="hidden" name="mem_email" value="${rescheck.getMem_email()}" />
				<div class="col-md-6">
					<label for="booking_date">예약 날짜 선택<span class="font-small"><br>두 달 이내의 날짜만 선택이 가능합니다.</span></label>
					<div class="input-group date">
						<input id="res_datetime" type="hidden" name="res_datetime" value="">
						<input id="res_startdatetime" type="hidden" name="res_startdatetime" value="">
						<input id="res_enddatetime" type="hidden" name="res_enddatetime" value="">
						<input id="selectdate" type="text" class="form-control"><span class="input-group-addon"><i
								class="fa fa-calendar-check-o fa-3x"></i></span>
					</div>
				</div>
				<div class="col-md-6">
					<h3>예약 시간 선택</h3>
				</div>
				<div class="col-md-6">
					<input type="checkbox" value="09:00" class="chktime" disabled="disabled" />09:00
					<input type="checkbox" value="10:00" class="chktime" disabled="disabled" />10:00
					<input type="checkbox" value="11:00" class="chktime" disabled="disabled" />11:00
					<input type="checkbox" value="12:00" class="chktime" disabled="disabled" />12:00
					<input type="checkbox" value="13:00" class="chktime" disabled="disabled" />13:00
					<input type="checkbox" value="14:00" class="chktime" disabled="disabled" />14:00
					<input type="checkbox" value="15:00" class="chktime" disabled="disabled" />15:00
					<input type="checkbox" value="16:00" class="chktime" disabled="disabled" />16:00
					<input type="checkbox" value="17:00" class="chktime" disabled="disabled" />17:00
					<input type="checkbox" value="18:00" class="chktime" disabled="disabled" />18:00
					<input type="checkbox" value="19:00" class="chktime" disabled="disabled" />19:00
				</div>
				<div class="col-md-12">
					<h3>예약 인원</h3>
					<span class="font-small">최소인원:1명&nbsp;&nbsp;&nbsp;최대인원:10명</span>
					<p class="peolechoice">
						<button type="button" class="minus"><i class="fa fa-minus fa-sm"
								aria-hidden="true"></i></button>
						<input type="number" id="reservpeople" name="res_people" class="numBox" min="1" max="11"
							value="1" readonly="readonly" />
						<button type="button" class="plus"><i class="fa fa-plus fa-sm" aria-hidden="true"></i></button>
					</p>
				</div>
				<div>
					<h3>요청사항</h3>
					<textarea name="res_memo" cols="110" rows="15" placeholder="100자 이내">
							</textarea>
				</div>
				<div class="form-group text-center">
					<p></p>
					<button type="submit" class="btn btn-primary btn-lg">변경 하기</button>
					<button type="button" class="btn btn-primary btn-lg"
						onclick="location.href='./resList.reo'">취소하기</button>
				</div>
				<input name="res_no" type="hidden" value="${param.res_no}">
			</form>
		</div>
	</section>
</body>

</html>