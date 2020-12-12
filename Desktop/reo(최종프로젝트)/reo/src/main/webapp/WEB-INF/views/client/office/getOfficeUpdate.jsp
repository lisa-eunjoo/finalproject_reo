<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>상품 상세</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/office/office.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/reservation/reservation.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>

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
		var dateclick;
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
		//금액 표시 함수
		function addComma(num) {
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			return num.toString().replace(regexp, ',');
		}

		$(document).ready(function () {
			$('input[type="radio"]').click(function () { //다른 공간 선택시 초기화 - 다선택할 수 있게 하기 
				$('input:checkbox[class="chktime"]').each(function () { //cehckbox 초기화
					$(this).prop("checked", false);
					$(this).prop("disabled", false);
				});
				$('#UserTime').html(" "); //시간 계산시 달력을 클릭할 때마다 초기화
				$('#selUserTime').html(" "); //새로운 날짜를 클릭할 때마다 전에 시간을 선택한 것 초기화	
				$('#UserCost').html(" ");
				$('#UserDate').html(" ");
				$("#selectdate").val(" "); //달력 날짜 초기화
				$('#res_totalprice').val(" ");

				if ($(this).attr('id') == 'off_rent') {
					$('#booking_area').show();
				}
			});

			$('.chktime').click(function () {
				$("#UserTime").html("");
				$("#UserCost").html(" "); //금액 초기화
				$('#res_totalprice').val(" ");
				$('#UserPeople').html(1); // 선택 내역에서 인원의 초기값을 1로 주기 위해서 
				if ($("#res_datetime").val().length < 11) {
					$("#res_datetime").val($("#res_datetime").val() + " 00:00:00");
				};
				if (chkcount % 2 == 0) {
					firstindex = $('input:checkbox[class="chktime"]:checked:first').index();
					lastindex = $('input:checkbox[class="chktime"]:checked:last').index();
					lastnum = parseInt($('input:checkbox[class="chktime"]:checked:last').val());
					var timeplus = lastnum + 1; //시간 선택 시 시간 범위로 나와야 되기 때문에
					var timeplusstr = String(timeplus) + ":00";
					$("#res_startdatetime").attr("value", $("#res_datetime").attr("value").substr(0, 11) + $('input:checkbox[class="chktime"]:checked:first').val() + ":00");
					$("#res_enddatetime").attr("value", $("#res_datetime").attr("value").substr(0, 11) + timeplusstr + ":00");
					if (lastindex > firstindex) {
						$("#res_enddatetime").attr("value", $("#res_datetime").attr("value").substr(0, 11) + timeplusstr + ":00");
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
							alert('예약된 시간을 포함할수 없습니다.');
							$('input:checkbox[class="chktime"]').each(function () {
								this.checked = false; //checked 처리
							});
							checkbool = true;
							firstindex = lastindex;
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
				//시간 클릭 시 선택 내역에 시간 계산해서 나오게끔 하기 
				dateclick = $('input:checkbox[class="chktime"]:checked').length; //체크된 갯수 
				firstnum = parseInt($('input:checkbox[class="chktime"]:checked:first').val());
				lastnum = parseInt($('input:checkbox[class="chktime"]:checked:last').val());

				var timeplus = lastnum + 1 //시간 선택 시 시간 범위로 나와야 되기 때문에
				var timeminus = lastnum - firstnum + 1

				if (dateclick > 1) {
					$("#UserDate").html($("#selectdate").val() + " " + $('input:checkbox[class="chktime"]:checked:first').val() + "~" + timeplus + ":00");
					$("#UserTime").html(timeminus + "시간");
					$("#selUserTime").html("(" + timeminus + "시간" + ")");

				} else if (dateclick != 0) { //한번 클릭할 때
					$("#UserDate").html($("#selectdate").val() + " " + $('input:checkbox[class="chktime"]:checked:first').val() + "~" + timeplus + ":00");
					$('#UserTime').html(1 + "시간");
					$('#selUserTime').html("(1시간)");

				} else if (dateclick == 0) {
					$("#UserDate").html($("#selectdate").val()); //시간을 클릭하지 않을 땐 날짜만 나오게 
					$('#selUserTime').html(" ");
				};

				// 가격 표시 - 선택값에 따른 자동 가격 계산 
				var rentconfer = $('input:radio[id=off_rent]').val();
				var rentconferfee = parseInt($('input:radio[id=off_rent]').val());
				var timeconfer = timeminus * rentconferfee;
				if (isNaN(timeconfer)) {
					timeconfer = " ";
				}

				if ($('input:radio[id=off_rent]').is(':checked')) {
					$('#UserCost').html(addComma(timeconfer));
					$('#res_totalprice').val(addComma(timeconfer));
					$('#res_price').val(addComma(timeconfer));
				}
			});

			//달력 클릭시 변환 함수
			$('.input-group.date').on('changeDate', function () {
				var tempDate = $("#selectdate").val() + " " + "00:00:00"; //selectdate: db timestamp이라 비교하려고
				$('#UserDate').html($("#selectdate").val()); //선택 내역에 선택한 일정 표시 
				//초기화 다선택 할수있게 초기화
				$('input:checkbox[class="chktime"]').each(function () {
					$(this).prop("disabled", false);
				})
				$('#UserTime').html(" "); //시간 계산시 달력을 클릭할 때마다 초기화
				$('#selUserTime').html(" "); //새로운 날짜를 클릭할 때마다 전에 시간을 선택한 것 초기화	
				$('#res_totalprice').val(" ");
				$("#UserCost").html(" "); //금액 초기화
				//찍어낼시간 (비교용) 배열 초기화
				arrtime = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00'];
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
					data: $('#makeReserv').serialize(), //serialize로 form 데이터값 전송해서 디비에 시간 데이터값들 비교
					success: function (data) {
						if (0 < data.length) {
							//예약이 많을경우 0번 인덱스가 아닌 다른 인덱스도 비교해야 되기 때문이다.
							for (var i = 0; i < data.length; i++) {
								starthour = new Date(data[i].res_startdatetime).getHours();
								endhour = new Date(data[i].res_enddatetime).getHours();
								$('input:checkbox[class="chktime"]').each(function () {
									// value가 이안에 있는 값이냐를 물어보고 있으면 disabled 하는 조건문
									if (starthour <= parseInt($(this).val()) && parseInt($(this).val()) < endhour) { //endhour -> checkbox에서 막기 위해서 
										$(this).prop("disabled", true);
									};
								});
							}
						}
						console.log(data);
					},
					error: function () {
						alert("예약 ajax 실패");
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
				$('#UserPeople').html($(".numBox").val()); //인원 선택시 선택 내역의 값 변경
			});
		});

		//form 전송 전 유효성 검사
		function check() {
			if ($('input:checkbox[class="chktime"]').is(":checked") == false) {
				$('#formcheck').modal();
				return false;
			} else {
				return true;
			}
		}

	</script>
</head>
<div class="modal" id="formcheck">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">확인</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				예약 일정을 선택해주세요.
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<body class="pc">
	<section class="container sec">
		<div class="wrap main">
			<div class="wrap main detail meetspace">
				<div id="content_wraper">
					<div class="section_cont row">
						<div class="inner_width col-12 col-md-8">
							<div class="h_area" style="overflow:hidden">
								<div class="h_space">
									<h2 class="space_name">${office.off_name}</h2>
								</div>
								<div class="tags">
									<span class="tag">#${office.off_type}</span>
								</div>
							</div>
							<div class="detail_forms">
								<div class="box_form right_fixed detail_space">
									<div class="ly_right_wrap meet">
										<div class="ly_right_fixed">
											<div class="heading">
												<a class="btn_share_detail meet" onclick="wishFunc()">
													<c:set var="isWish" value="${isWish}" />
													<c:choose>
														<c:when test="${isWish gt 0}">
															<i class="fas fa-bookmark"></i>
														</c:when>
														<c:otherwise>
															<i class="far fa-bookmark"></i>
														</c:otherwise>
													</c:choose>
												</a>
												<a class="btn_love_detail meet" onclick="likeFunc()">
													<c:set var="isLike" value="${isLike}" />
													<c:choose>
														<c:when test="${isLike gt 0}">
															<i class="fas fa-heart"></i>
														</c:when>
														<c:otherwise>
															<i class="far fa-heart"></i>
														</c:otherwise>
													</c:choose> <span id="likecount">${countLike}</span>
												</a>
											</div>
										</div>
									</div>
								</div>
								<div class="photo_box_wrap type9">
									<div class="detail_box v slide_wrap">
										<!-- 이미지 -->
										<div id="demo"
											class="carousel slide swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal"
											data-ride="carousel">
											<!-- Indicators -->
											<ul class="carousel-indicators">
												<c:forEach items="${off_images}" var="image" varStatus="status">
													<li data-target="#demo" data-slide-to="${status.index}"></li>
												</c:forEach>
											</ul>
											<!-- The slideshow -->
											<div class="carousel-inner">
												<c:forEach items="${off_images}" var="image">
													<div class="carousel-item">
														<img src="${pageContext.request.contextPath}/resources/upload/${image.offimg_name}"
															alt="사무실 이미지" />
													</div>
												</c:forEach>
											</div>
											<!-- Left and right controls -->
											<c:if test="${fn:length(off_images) > 1}">
												<a class="carousel-control-prev" href="#demo" data-slide="prev">
													<span class="carousel-control-prev-icon"></span>
												</a>
												<a class="carousel-control-next" href="#demo" data-slide="next">
													<span class="carousel-control-next-icon"></span>
												</a>
											</c:if>
										</div>
									</div>
									<div class="meetspace">
										<div id="s_intro" class="text_box">
											<h4 class="h_intro">공간 소개</h4>
											<p class="p_intro">
												<c:set var="feature" value="${office.off_feature}" />
												<% pageContext.setAttribute("newLineChar", "\r\n"); %><c:if
													test="${not empty feature}">
													<c:set var="rpcFeature"
														value="${fn:replace(feature, newLineChar, '<br>')}" />
													${rpcFeature}</c:if>
											</p>
											<ul class="info_list officehours">
												<li>
													<span class="tit">가격</span>
													<span class="data">${office.off_rent}원 / ${office.off_unit}</span>
												</li>
												<li>
													<span class="tit">번호</span>
													<span class="data">${office.mem_agentTel}</span>
												</li>
												<li>
													<span class="tit">수용인원</span>
													<span class="data">최대 ${office.off_maxNum}인</span>
												</li>
												<li>
													<span class="tit">공간유형</span>
													<span class="data">${office.off_type}</span>
												</li>
											</ul>
											<ul class="facility_list">
												<%-- <c:set var="optionMap" value="<%=new java.util.HashMap<String, Object>()%>"
												/>
												<c:set var="optionArr"
													value="${fn:split('냉난방,인터넷/WIFI,의자/테이블,TV/프로젝터,음향/마이크,복사/인쇄기,화이트보드,PC/노트북,개별콘센트,개인사물함,공기청정기,보안시스템,커피/다과,취사시설,자판기,우편물/택배물 관리,내부화장실,전담컨시어지 서비스,클리닝 서비스,법무사/세무사 무료컨설팅,금연', ',')}">
												</c:set>
												<c:set var="iconArr"
													value="${fn:split('fas fa-wind,fas fa-wifi,fas fa-chair,fas fa-tv,fas fa-microphone,fas fa-print,fas fa-chalkboard,fas fa-laptop,fas fa-plug,fas fa-suitcase,fas fa-fan,fas fa-shield-alt,fas fa-coffee,fas fa-sink,fas fa-tint,fas fa-mail-bulk,fas fa-toilet,far fa-handshake,fas fa-broom,fas fa-user-tie,fas fa-smoking-ban', ',')}">
												</c:set>
												<c:forEach items="${optionArr}" var="option" varStatus="status">
													<c:set target="${optionMap}" property="${option}"
														value="${iconArr[status.index]}" />
												</c:forEach> --%>

												<c:forEach items="${off_options}" var="option" varStatus="status">
													<li>
														<%-- <c:choose>
														<c:when test="${option.offopt_name eq optionMap.option.offopt_name}">
															<i class="${optionMap[option.offopt_name]}"></i>
														</c:when>
														<c:otherwise>
															<i class="fas fa-grip-horizontal"></i>
														</c:otherwise>
													</c:choose> --%>
														<c:choose>
															<c:when test="${option.offopt_name eq '냉난방'}"><i
																	class="fas fa-wind"></i></c:when>
															<c:when test="${option.offopt_name eq '인터넷/WIFI'}"><i
																	class="fas fa-wifi"></i></c:when>
															<c:when test="${option.offopt_name eq '의자/테이블'}"><i
																	class="fas fa-chair"></i></c:when>
															<c:when test="${option.offopt_name eq 'TV/프로젝터'}"><i
																	class="fas fa-tv"></i></c:when>
															<c:when test="${option.offopt_name eq '음향/마이크'}"><i
																	class="fas fa-microphone"></i></c:when>
															<c:when test="${option.offopt_name eq '복사/인쇄기'}"><i
																	class="fas fa-print"></i></c:when>
															<c:when test="${option.offopt_name eq '화이트보드'}"><i
																	class="fas fa-chalkboard"></i></c:when>
															<c:when test="${option.offopt_name eq 'PC/노트북'}"><i
																	class="fas fa-laptop"></i></c:when>
															<c:when test="${option.offopt_name eq '개별콘센트'}"><i
																	class="fas fa-plug"></i></c:when>
															<c:when test="${option.offopt_name eq '개인사물함'}"><i
																	class="fas fa-suitcase"></i></c:when>
															<c:when test="${option.offopt_name eq '공기청정기'}"><i
																	class="fas fa-fan"></i></c:when>
															<c:when test="${option.offopt_name eq '보안시스템'}"><i
																	class="fas fa-shield-alt"></i></c:when>
															<c:when test="${option.offopt_name eq '커피/다과'}"><i
																	class="fas fa-coffee"></i></c:when>
															<c:when test="${option.offopt_name eq '취사시설'}"><i
																	class="fas fa-sink"></i></c:when>
															<c:when test="${option.offopt_name eq '자판기'}"><i
																	class="fas fa-tint"></i></c:when>
															<c:when test="${option.offopt_name eq '우편물/택배물 관리'}"><i
																	class="fas fa-mail-bulk"></i></c:when>
															<c:when test="${option.offopt_name eq '내부화장실'}"><i
																	class="fas fa-toilet"></i></c:when>
															<c:when test="${option.offopt_name eq '전담컨시어지 서비스'}"><i
																	class="far fa-handshake"></i></c:when>
															<c:when test="${option.offopt_name eq '클리닝 서비스'}"><i
																	class="fas fa-broom"></i></c:when>
															<c:when test="${option.offopt_name eq '법무사/세무사 무료컨설팅'}"><i
																	class="fas fa-user-tie"></i></c:when>
															<c:when test="${option.offopt_name eq '금연'}"><i
																	class="fas fa-smoking-ban"></i></c:when>
															<c:otherwise><i class="fas fa-grip-horizontal"></i>
															</c:otherwise>
														</c:choose>
														<span class="txt_name">
															<%-- <c:set var="offopt_name" value="${fn:replace(option.offopt_name, ' ', '<br>')}" /> --%>
															${option.offopt_name}
														</span>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
									<div class="detail_box map_box">
										<div class="host_profile">
											<div class="inner">
												<div class="sp_location">
													<p class="sp_name">${office.off_name}</p>
													<p class="sp_address">${office.off_stdAddr}</p>
												</div>
											</div>
										</div>
										<div id="map" style="height: 500px;">
										</div>
									</div>
								</div>

							</div>
						</div>
						<div class="col-12 col-md-4 reservArea">
							<!-- 예약 시간/월 자리 예약 선택 라디오 버튼 -->
							<div id="now">
								현재 예약 변경 중입니다!<br>
								<c:set var="offtype" value="${office.off_rent }" />
								<input type="radio" id="off_rent" class="type" name="roomtype"
									value="${office.off_rent}" />${office.off_type}
								<span class="data"> :
									<fmt:formatNumber value="${office.off_rent}" pattern="#,###" />
									원/${office.off_unit}</span>
							</div>
							<div class="col-12" id="booking_area">
								<form name="reservform" id="makeReserv" action="reservModify.reo" method="POST"
									onsubmit="return check()">
									<input type="hidden" id="off_name" name="off_name" value="${office.off_name }">
									<input type="hidden" id="off_no" name="off_no" value="${office.off_no }">
									<input type="hidden" name="pageNo" value="${param.pageNo }">
									<input id="res_datetime" type="hidden" name="res_datetime" value="">
									<input id="res_startdatetime" type="hidden" name="res_startdatetime" value="">
									<input id="res_enddatetime" type="hidden" name="res_enddatetime" value="">
									<h5>예약 날짜 선택</h5><span class="font-small">일요일은 휴무입니다.</span><br>두 달 이내의 날짜만 선택
									가능합니다.
									<div class="color_desc">예약불가 <span class="color_disable"></span> 오늘 <span
											class="color_today"></span> 선택 <span class="color_select"></span></div>
									<div class="input-group date">
										<input id="selectdate" type="text" class="form-control-xs">
										<span class="input-group-addon"><i class="fa fa-calendar-check-o fa-3x"
												aria-hidden="true"></i></span>
									</div><br>
									<div class="col-12" id="bookingtime">
										<h5>예약 시간 선택</h5><span class="font-small">최소 1시간 부터 예약 가능합니다.</span>
										<div class="color_desc">예약불가 <span class="color_disable"></span> 가능 <i
												class="far fa-square fa-sm"></i> 선택 <span class="color_timesel"></span>
										</div>
									</div>
									<div class="col-12 timefont">
										<div>
											<span style="width:30px;height:15px; display:inline-block;">09</span>
											<span style="width:40px;height:10px; display:inline-block;">10</span>
											<span style="width:40px;height:15px; display:inline-block;">11</span>
											<span style="width:35px;height:15px; display:inline-block;">12</span>
											<span style="width:35px;height:15px; display:inline-block;">13</span>
											<span style="width:40px;height:15px; display:inline-block;">14</span>
											<span style="width:40px;height:15px; display:inline-block;">15</span>
											<span style="width:40px;height:15px; display:inline-block;">16</span>
											<span style="width:35px;height:15px; display:inline-block;">17</span>
											<span style="width:40px;height:15px; display:inline-block;">18</span>
											<span style="width:45px;height:15px; display:inline-block;">19</span>
											<span style="width:45px;height:15px; display:inline-block;">20</span>
											<span style="width:45px;height:15px; display:inline-block;">21</span>
											<span style="width:45px;height:15px; display:inline-block;">22</span>
										</div>
										<div class="check_list">
											<input type="checkbox" id="chk09" value="09:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk10" value="10:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk11" value="11:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk12" value="12:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk13" value="13:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk14" value="14:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk15" value="15:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk16" value="16:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk17" value="17:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk18" value="18:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk17" value="19:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk18" value="20:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
											<input type="checkbox" id="chk17" value="21:00" class="chktime"
												disabled="disabled"
												style="width: 50px; min-width: 50px; height:40px; margin:-5px">
										</div>
									</div><br>
									<div class="col-12 bookingpeople">
										<h5 style="margin-top: 15px;">예약 인원</h5>
										<span class="font-small">최소인원:1명&nbsp;&nbsp;&nbsp;최대인원:10명</span>
										<p class="peolechoice" style="text-align:center;">
											<button type="button" class="minus"><i class="fa fa-minus fa-sm"
													aria-hidden="true"></i></button>
											<input type="number" id="reservpeople" name="res_people" class="numBox"
												min="1" max="11" value="1" readonly="readonly" />
											<button type="button" class="plus"><i class="fa fa-plus fa-sm"
													aria-hidden="true"></i></button>
										</p>
									</div>
									<div class="col-12 roomprice">
										<h5>공간사용료</h5>
										<input type="text" id="res_totalprice" class="form-control text-center" value=""
											readonly />
										<input type="hidden" id="res_price" name="room_price" value="" />
									</div><br>
									<div class="col-12 resmemo">
										<h5>요청사항</h5>
										<textarea name="res_memo" cols="42" rows="5" placeholder="100자 이내"></textarea>
									</div>
									<div class="usernotice">
										<p class="usernotice"><em class="usernotice"><i class="fa fa-exclamation-circle"
													aria-hidden="true"></i><span>알립니다</span></em>
											<br><span>예약 변경은 이용일 하루 전까지만 가능합니다.</span>
									</div>
									<div class="reschoice">
										<h5>선택내역</h5>
										일정: <span id="UserDate" /></span> <span id="selUserTime"></span><br>
										인원: <span id="UserPeople"></span><br>
										공간사용료: <span id="UserCost"></span>
									</div><br>
									<div class="right bttn" style="text-align:center;">
										<input type="button" id="call" class="btn btn-outline-primary" value="전화문의">
										<input type="submit" class="btn btn-outline-primary" value="예약변경">
										<input type="button" value="취소" onclick="history.go(-1);"
											class="btn btn-outline-primary">
									</div>
									<input name="res_no" type="hidden" value="${param.res_no}">
									<input name="off_no" type="hidden" value="${param.off_no}">
								</form>
								<div class="call_info" style="display:none;">
									문의하기 <br>
									<h5 class="space_name">${office.off_name}</h5>
									<span class="tit">번호</span> <span class="data">${office.mem_agentTel}</span>
									<a class="btn btn_full btn_default">확인</a>
								</div>
							</div>
						</div>
					</div>
					<div class="others_wrap col-12">
						<div class="text_box">
							<h4 class="h_intro">호스트의 다른 공간</h4>
						</div>
						<div class="space_list swiper_list">
							<div class="flex_wrap column3 fluid">
								<c:choose>
									<c:when test="${not empty relativeOffice}">
										<c:forEach items="${relativeOffice}" var="office">
											<article class="box box_space ">
												<div class="inner">
													<a href="./getOffice.reo?off_no=${office.off_no}">
														<div class="img_box">
															<c:choose>
																<c:when test="${not empty office.off_image}">
																	<img class="img"
																		src="${pageContext.request.contextPath}/resources/upload/${office.off_image}"
																		alt="사무실 이미지" />
																</c:when>
																<c:otherwise>
																	<img class="img"
																		src="${pageContext.request.contextPath}/resources/img/noimage.gif"
																		alt="이미지 없음" />
																</c:otherwise>
															</c:choose>
														</div>
														<div class="info_area">
															<h3 class="tit_space">${office.off_name}</h3>
															<div class="tags">
																<c:set var="stdAddr"
																	value="${fn:split(office.off_stdAddr, ' ')}" />
																<span class="tag_area_name">
																	${stdAddr[fn:length(stdAddr)-2]}
																</span>
																<p class="tag_type_name">#${office.off_type}</p>
															</div>
															<div class="info_price_hour">
																<strong class="price">${office.off_rent}</strong>
																<span class="txt_unit">원/${office.off_unit}</span>
															</div>
															<div class="info_number_love">
																<span class="txt_number_maxUser">
																	<i class="fas fa-user-alt"></i>
																	<em>최대 ${office.off_maxNum}인</em>
																</span>
																<span class="txt_number_love">
																	<i id="heart" class="fas fa-heart"></i>
																	<em>${office.off_likeCount}</em>
																</span>
															</div>
														</div>
													</a>
												</div>
											</article>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<article class="box box_space ">
											<div class="inner">관련 상품이 없습니다.</div>
										</article>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</section>

</body>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33522b328a3e6d673f8ef7bc8971cbb4&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">

	var maplist = ${ maplist };
	var mapContainer = document.getElementById('map'); // 지도를 표시할 div
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	mapOption = {
		center: new kakao.maps.LatLng(maplist.map_la, maplist.map_ln), // 지도의 중심좌표
		level: 3,
		minLevel: 2,
		maxLevel: 10
	};
	//지도에 마커와 인포윈도우를 표시하는 함수입니다
	var map = new kakao.maps.Map(mapContainer, mapOption);

	var imageSize = new kakao.maps.Size(30, 40);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	var marker = new kakao.maps.Marker({
		map: map, // 마커를 표시할 지도
		position: new kakao.maps.LatLng(maplist.map_la, maplist.map_ln), // 마커를 표시할 위치
		clickable: true, // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
		image: markerImage
	});
</script>
<script type="text/javascript">
	$(document).ready(function () {
		$(".carousel-indicators").children().first().addClass('active');
		$(".carousel-inner").children().first().addClass('active');
	});

	function wishFunc() {
		$.ajax({
			type: 'GET',
			url: './searchWish.reo?off_no=${office.off_no}',
			dataType: "text",
			success: function (data) {
				// 찜 삭제
				if (data == 'del0') {
					alert("위시 삭제 에러");
				} else if (data == 'del1') {
					$('.fa-bookmark').remove();
					$('.inner_width .btn_share_detail').append('<i class="far fa-bookmark"></i>');
					//alert("위시 삭제 완료");
				}
				// 찜 추가
				if (data == 'add0') {
					alert("위시 추가 에러");
				} else if (data == 'add1') {
					$('.fa-bookmark').remove();
					$('.inner_width .btn_share_detail').append('<i class="fas fa-bookmark"></i>');
					//alert("위시 추가 완료");
				}
			},
			error: function () {
				alert('위시 ajax 실패');
			}
		});
	}
	function likeFunc() {
		$.ajax({
			type: 'GET',
			url: './searchLike.reo?off_no=${office.off_no}',
			dataType: "json",
			success: function (data) {
				// 좋아요 삭제
				if (data['queryRst'] == 'del0') {
					alert("좋아요 삭제 에러");
				} else if (data['queryRst'] == 'del1') {
					$('.fa-heart').remove();
					$('.inner_width .btn_love_detail').append('<i class="far fa-heart"></i>');
					$('#likecount').text(data['countLike']);
					//alert("좋아요 삭제 완료");
				}
				// 좋아요 추가
				if (data['queryRst'] == 'add0') {
					alert("좋아요 추가 에러");
				} else if (data['queryRst'] == 'add1') {
					$('.fa-heart').remove();
					$('.inner_width .btn_love_detail').append('<i class="fas fa-heart"></i>');
					$('#likecount').text(data['countLike']);
					//alert("좋아요 추가 완료");
				}
			},
			error: function () {
				alert('좋아요 ajax 실패');
			}
		});
	}
</script>

</html>