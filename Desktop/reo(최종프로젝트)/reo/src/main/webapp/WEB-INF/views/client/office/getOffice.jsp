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
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
<style>
/*radio 버튼 색상변경 */
  input[type='radio'] {
    -webkit-appearance:none;
    width:16px;
    height:16px;
    border:1px solid darkgray;
     border-radius:50%;
    outline:none;
    background:#e6e6e6;
  }
  input[type='radio']:before {
    content:'';
    display:block;
    width:60%;
    height:60%;
    margin: 20% auto;  
    border-radius:50%;
  }
  input[type='radio']:checked:before {
  	background:#6432FF;
  }

</style>
</head>
<body class="pc">
<jsp:include page="/resources/include/client/header.jsp" />
<section class="container sec">
	<div class="wrap main">
		<div class="wrap main detail meetspace">
			<div id="content_wraper">
				<div class="section_cont row">
					<div class="inner_width col-12 col-lg-8">
						<input type="hidden" id="off_no" value="${office.off_no}">
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
									<div id="demo" class="carousel slide swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal" data-ride="carousel">
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
													<img src="${pageContext.request.contextPath}/resources/upload/${image.offimg_name}" alt="사무실 이미지" />
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
										<c:set var="feature" value="${office.off_feature}" /><% pageContext.setAttribute("newLineChar", "\r\n"); %><c:if test="${not empty feature}"><c:set var="rpcFeature" value="${fn:replace(feature, newLineChar, '<br>')}" />${rpcFeature}</c:if>
										</p>
										<ul class="info_list officehours">
											<li>
												<span class="tit">공간유형</span>
												<span class="data">${office.off_type}</span>
											</li>
											<li>
												<span class="tit">가격</span>
												<span class="data">${office.off_rent}원 / ${office.off_unit}</span>
											</li>
											<li>
												<span class="tit">수용인원</span>
												<span class="data">최대 ${office.off_maxNum}인</span>
												<input type="hidden" id="off_maxNum" name="off_maxNum" value ="${office.off_maxNum }"/>
											</li>
											<li>
												<span class="tit">상호명</span>
												<span class="data">${office.mem_agentName}</span>
											</li>
											<li>
												<span class="tit">전화번호</span>
												<span class="data">${office.mem_agentTel}</span>
											</li>
										</ul>
										<c:if test="${!empty off_options}">
										<ul class="facility_list">
											<c:forEach items="${off_options}" var="option" varStatus="status">
											<li>
												<c:choose>
													<c:when test="${option.offopt_name eq '냉난방'}"><i class="fas fa-wind"></i></c:when>
													<c:when test="${option.offopt_name eq '인터넷/WIFI'}"><i class="fas fa-wifi"></i></c:when>
													<c:when test="${option.offopt_name eq '의자/테이블'}"><i class="fas fa-chair"></i></c:when>
													<c:when test="${option.offopt_name eq 'TV/프로젝터'}"><i class="fas fa-tv"></i></c:when>
													<c:when test="${option.offopt_name eq '음향/마이크'}"><i class="fas fa-microphone"></i></c:when>
													<c:when test="${option.offopt_name eq '복사/인쇄기'}"><i class="fas fa-print"></i></c:when>
													<c:when test="${option.offopt_name eq '화이트보드'}"><i class="fas fa-chalkboard"></i></c:when>
													<c:when test="${option.offopt_name eq 'PC/노트북'}"><i class="fas fa-laptop"></i></c:when>
													<c:when test="${option.offopt_name eq '개별콘센트'}"><i class="fas fa-plug"></i></c:when>
													<c:when test="${option.offopt_name eq '개인사물함'}"><i class="fas fa-suitcase"></i></c:when>
													<c:when test="${option.offopt_name eq '공기청정기'}"><i class="fas fa-fan"></i></c:when>
													<c:when test="${option.offopt_name eq '보안시스템'}"><i class="fas fa-shield-alt"></i></c:when>
													<c:when test="${option.offopt_name eq '커피/다과'}"><i class="fas fa-coffee"></i></c:when>
													<c:when test="${option.offopt_name eq '취사시설'}"><i class="fas fa-sink"></i></c:when>
													<c:when test="${option.offopt_name eq '자판기'}"><i class="fas fa-tint"></i></c:when>
													<c:when test="${option.offopt_name eq '우편물/택배물 관리'}"><i class="fas fa-mail-bulk"></i></c:when>
													<c:when test="${option.offopt_name eq '내부화장실'}"><i class="fas fa-toilet"></i></c:when>
													<c:when test="${option.offopt_name eq '전담컨시어지 서비스'}"><i class="far fa-handshake"></i></c:when>
													<c:when test="${option.offopt_name eq '클리닝 서비스'}"><i class="fas fa-broom"></i></c:when>
													<c:when test="${option.offopt_name eq '법무사/세무사 무료컨설팅'}"><i class="fas fa-user-tie"></i></c:when>
													<c:when test="${option.offopt_name eq '금연'}"><i class="fas fa-smoking-ban"></i></c:when>
													<c:otherwise><i class="fas fa-grip-horizontal"></i></c:otherwise>
												</c:choose>
												<span class="txt_name">
													${option.offopt_name}
												</span>
											</li>
											</c:forEach>
										</ul>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-4 reservArea" style="padding:0px;">
						<!-- 예약 시간/월 자리 예약 선택 라디오 버튼 -->
						<div class="nowbooking_area">
						<div id="now" >
							<div id="nowbooking">지금 바로 예약하세요! <br>
							<c:set var="offtype" value="${office.off_rent }"/>
							<div class="checks">
							<input type="radio" id="off_rent" class="type" name="roomtype" value="${office.off_rent}" checked="checked"/>${office.off_type}
							<span class="data"> : <fmt:formatNumber value="${office.off_rent}" pattern="#,###"/>원/${office.off_unit}</span>
							</div>
							</div>
						<div class="col-12" id="booking_area">
							<form name="reservform" id="makeReserv" action="mybooking.reo" method="POST">
								<input type="hidden" id="off_name" name="off_name" value="${office.off_name }">
								<input type="hidden" id="off_no" name="off_no" value="${office.off_no }">
								<input type="hidden" id="off_unit" name="off_unit" value="${office.off_unit }" />
								<input id="off_stdAddr" type="hidden" name="off_stdAddr" value="${office.off_stdAddr }"/>
								<input type="hidden" id="mem_name" name="mem_name" value="${mem_name}">
								<input type="hidden" id="mem_agentName" name="mem_agentName" value="${office.mem_agentName }">
								<input type="hidden" id="mem_tel" name="mem_tel" value="${office.mem_agentTel }">
								<input id="res_datetime" type="hidden" name="res_datetime" value="">
								<input id="res_startdatetime" type="hidden" name="res_startdatetime" value="">
								<input id="res_enddatetime" type="hidden" name="res_enddatetime" value="">
									<div class="bookingdate">
										<h5>예약 날짜 선택</h5><span class="font-small">일요일은 휴무입니다.</span><br>
										<c:choose>
											<c:when test="${office.off_unit eq '월' }">
											1년 이내의 날짜만 선택 가능합니다.
											</c:when>
											<c:when test="${office.off_unit eq '시간' }">
											두 달 이내의 날짜만 선택 가능합니다. 
											</c:when>
										</c:choose>
									<div class="color_desc">예약불가 <span class="color_disable"></span> 오늘 <span class="color_today"></span> 선택 <span class="color_select"></span></div>
										<div class="input-group date">
											<input id="selectdate" type="text" class="form-control-xs" >
											<span class="input-group-addon">&nbsp;<i class="fa fa-calendar-check-o fa-3x" aria-hidden="true"></i></span>
										</div>
									</div>
									<c:choose>
											<c:when test="${office.off_unit eq '월' }">
											<div id="monthchoice" style="text-align:left;">
											<h5>예약 단위 선택</h5>
												선택: <select id="offunitmonth" onchange="monthSelect()">
														<option value="" selected disabled>개월 선택</option>
														<c:forEach begin="1" end="12" step="1" var="i">
														<option value="${i}">${i}개월권</option>
														</c:forEach>
													</select>
											</div>
											</c:when>
											<c:when test = "${office.off_unit eq '시간' }">
												<div class="col-12" id="bookingtime">
													<h5>예약 시간 선택</h5><span class="font-small">최소 1시간 부터 예약 가능합니다.</span>
													<div class="color_desc">예약불가 <span class="color_disable"></span> 가능 <i class="far fa-square fa-sm"></i> 선택 <span class="color_timesel"></span>&nbsp;&nbsp;<span id="UserTime"></span></div>
												</div>
											<div class="col-12 timefont">
												<c:forEach begin="9" end="21" step="1" var="time">
												<div class="res_check_box">
													<span><fmt:formatNumber value="${time}" type="number" minIntegerDigits="2"/></span>
													<c:if test="${time == 21}">
													<span><fmt:formatNumber value="${time + 1}" type="number" minIntegerDigits="2"/></span>
													</c:if>
													<br/><input type="checkbox" id="chk${time}" class="chktime" value="<fmt:formatNumber value="${time}" type="number" minIntegerDigits="2"/>:00" disabled="disabled"/>
												</div>
												</c:forEach>
											</div>
											</c:when>
										</c:choose>
									<div class="bookingpeople" >
										<h5 style="margin-top: 15px;">예약 인원</h5>
										<span class="font-small">최소인원:1명&nbsp;&nbsp;&nbsp;최대인원:${office.off_maxNum}명</span>
										<p class="peolechoice" style="text-align:center;">
											<button type="button" class="minus"><i class="fa fa-minus fa-sm" aria-hidden="true"></i></button>
											<input type="number" id="reservpeople" name="res_people" class="numBox" min="1" max="11" value="1" readonly="readonly"/>
											<button type="button" class="plus"><i class="fa fa-plus fa-sm" aria-hidden="true"></i></button>
										</p>
									</div>
									<div class="roomprice">
										<h5>공간사용료</h5>
										<input type="text" id="res_totalprice" name="room_price" class="form-control text-center" readonly/><br>
									</div>
									<div class="resmemo">
										<h5>요청사항</h5>
										<textarea name="res_memo" rows="5" placeholder="50자 이내" style="width: 100%"></textarea>
									</div>
									<div class="usernotice">
										<p class="usernotice"><em class="usernotice"><i class="fa fa-exclamation-circle" aria-hidden="true"></i><span>알립니다</span></em>
										<p class="noti">이용예정일 12시간 전까지 취소시 90% 환불 가능하고 6시간 전까진 70% 환불, 3시간 전까진 50%, 1시간 전까진 10%만 환불 가능합니다.</p>
									</div>
									<div class="reschoice">
										<h5>선택내역</h5>
										일정: <span id="UserDate"/></span> <span id="selUserTime"></span><br>
										인원: <span id="UserPeople"></span><br>
										공간사용료: <span id="UserCost"></span>
									</div>
								</form>
							</div>
						</div>
						<div class="bookbttn btn-group form-group col-12">
							<input type="button" class="col-4 form-control" id="rescall" value="&#xf3cd 전화문의">
							<input type="button" class="col-4 form-control" onclick="check()" value="&#xf274; 예약신청">
							<input type="button" onclick="location.href='getOfficeList.reo'" class="col-4" value="&#xf039 목록">
						</div>
						</div>
					</div>
					<div class="detail_box map_box col-12">
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
					<div class="others_wrap col-12">
							<div class="text_box">
								<h4 class="h_intro">호스트의 다른 공간</h4>
							</div>
							<div class="space_list swiper_list">
								<div class="flex_wrap column3 fluid">
									<c:choose>
									<c:when test="${not empty relativeOffice}">
									<c:forEach items="${relativeOffice}" var="office">
										<article class="box box_space col-12 col-md-6">
											<div class="inner">
												<a href="./getOffice.reo?off_no=${office.off_no}">
													<div class="img_box">
														<c:choose>
															<c:when test="${not empty office.off_image}">
																<img class="img" src="${pageContext.request.contextPath}/resources/upload/${office.off_image}" alt="사무실 이미지"/>
															</c:when>
															<c:otherwise>
																<img class="img" src="${pageContext.request.contextPath}/resources/img/noimage.gif" alt="이미지 없음" />
															</c:otherwise>
														</c:choose>
													</div>
													<div class="info_area">
														<h3 class="tit_space">${office.off_name}</h3>
														<div class="tags">
															<c:set var="stdAddr" value="${fn:split(office.off_stdAddr, ' ')}"/>
															<span class="tag_area_name">
																${stdAddr[fn:length(stdAddr)-2]}
															</span>
															<p class="tag_type_name">#${office.off_type}</p>
														</div>
														<div class="info_price_hour">
															<div class="infos"><span class="txt_unit"><strong class="price">${office.off_rent}</strong>원/${office.off_unit}</span></div>
															<div class="infos infos_info"><span class="txt_number_maxUser">
																<i class="fas fa-user-alt usericon"></i>
																<em>최대 ${office.off_maxNum}인</em>
																</span>
															</div>
															<div class="infos infos_info">
																<span class="txt_number_love">
																	<i id="heart" class="fas fa-heart"></i>
																	<em>${office.off_likeCount}</em>
																</span>
															</div>
														</div>
													</div>
												</a>
											</div>
										</article>
									</c:forEach>
									</c:when>
									<c:otherwise>
										<article class="box box_space "><div class="inner">관련 상품이 없습니다.</div></article>
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
<div class="modal fade" id="restimecheck">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">확인</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				현재 예약되어 있는 시간입니다. 다른 시간을 선택해주세요.
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="resdatecheck">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">확인</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				현재 예약되어 있는 날짜입니다. 다른 날짜를 선택해주세요.
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="rescallmodal">
   <div class="modal-dialog modal-md">
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title"><i class="fas fa-mobile-alt"></i>&nbsp;문의하기</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
         <div class="modal-body">
            <h4 style="text-align:center;">${office.off_name }</h4>
            <h4 class="phone" style="text-align:center;">번호: ${office.mem_agentTel }</h4>
            <h5 style="text-align:center;">이 쪽으로 문의해주세요!</h5>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
         </div>
      </div>
   </div>
</div>
<a class="MOVE_TOP_BTN" href="#">TOP</a>
<footer>
	<jsp:include page="/resources/include/client/footer.jsp" />
</footer>
</body>
<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33522b328a3e6d673f8ef7bc8971cbb4&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">

	var maplist = ${maplist};
	var mapContainer = document.getElementById('map'); // 지도를 표시할 div
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	mapOption = {
		center : new kakao.maps.LatLng(maplist.map_la, maplist.map_ln), // 지도의 중심좌표
		level : 3,
		minLevel : 2,
		maxLevel : 10
	};
	//지도에 마커와 인포윈도우를 표시하는 함수입니다
	var map = new kakao.maps.Map(mapContainer, mapOption);

	var imageSize = new kakao.maps.Size(30, 40);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	var marker = new kakao.maps.Marker({
		map : map, // 마커를 표시할 지도
		position : new kakao.maps.LatLng(maplist.map_la, maplist.map_ln), // 마커를 표시할 위치
		clickable : true, // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
		image : markerImage
	});
</script>
<script type="text/javascript">
	var off_no = $('#off_no').val();
	var params = 'off_no=' + off_no;
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var mapContainer = document.getElementById('map'); // 지도를 표시할 div
	var imageSize = new kakao.maps.Size(30, 40);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	
	function ShowMap(maplist) {
		mapOption = {
			center : new kakao.maps.LatLng(maplist.map_la, maplist.map_ln), // 지도의 중심좌표
			level : 3,
			minLevel : 2,
			maxLevel : 7
		};
		var map = new kakao.maps.Map(mapContainer, mapOption);
		var marker = new kakao.maps.Marker({
			map : map, // 마커를 표시할 지도
			position : new kakao.maps.LatLng(maplist.map_la, maplist.map_ln), // 마커를 표시할 위치
			clickable : true, // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
			image : markerImage
		});
	};
	$(document).ready(function() {
		$.get({
			url : "./aloneMap.reo",
			type : "GET",
			async : false,
			data : params,
			success : function(data) {
				ShowMap(data);
			},
		});
		$(".carousel-indicators").children().first().addClass('active');
		$(".carousel-inner").children().first().addClass('active');
	});
	function wishFunc() {
		$.ajax({
			type : 'GET',
			url : './searchWish.reo?off_no=' + off_no,
			dataType : "text",
			success : function(data) {
				// 찜 삭제
				if(data == 'del0') {
					alert("위시 삭제 에러");
				} else if(data == 'del1') {
					$('.fa-bookmark').remove();
					$('.inner_width .btn_share_detail').append('<i class="far fa-bookmark"></i>');
				}
				// 찜 추가
				if(data == 'add0') {
					alert("위시 추가 에러");
				} else if(data == 'add1') {
					$('.fa-bookmark').remove();
					$('.inner_width .btn_share_detail').append('<i class="fas fa-bookmark"></i>');
				}
			},
			error : function() {
				alert('위시 ajax 실패');
			}
		});
	}
	
	function likeFunc() {
		$.ajax({
			type : 'GET',
			url : './searchLike.reo?off_no=' + off_no,
			dataType : "json",
			success : function(data) {
				// 좋아요 삭제
				if(data['queryRst'] == 'del0') {
					alert("좋아요 삭제 에러");
				} else if(data['queryRst'] == 'del1') {
					$('.fa-heart').remove();
					$('.inner_width .btn_love_detail').append('<i class="far fa-heart"></i>');
					$('#likecount').text(data['countLike']);
				}
				// 좋아요 추가
				if(data['queryRst'] == 'add0') {
					alert("좋아요 추가 에러");
				} else if(data['queryRst'] == 'add1') {
					$('.fa-heart').remove();
					$('.inner_width .btn_love_detail').append('<i class="fas fa-heart"></i>');
					$('#likecount').text(data['countLike']);
				}
			},
			error : function() {
				alert('좋아요 ajax 실패');
			}
		});
	};
	$('.MOVE_TOP_BTN').css("display", "none");
	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 500) {
				$('.MOVE_TOP_BTN').fadeIn();
			} else {
				$('.MOVE_TOP_BTN').fadeOut();
			}
	});
	
	$(".MOVE_TOP_BTN").click(function() {
		$('html, body').animate({scrollTop : 0}, 400);
			return false;
		});
	});
</script>
<script type='text/javascript'>
	var text;
	var arrtime=new Array();
	var compare=new Array();
	var firstindex;
	var lastindex;
	var chkcount=0;
	var checkbool=true;
	var starthour;
	var endhour;
	var dateclick;
	var resdateArray;
	var enddate=new Date();
	var startdate=new Date();
	var insertdate = new Date();
	var today = new Date();
	//넣어야되는 배열
	var insertArray=[];
	//현재시간
	var sysdate = new Date();
	sysdate = date_to_str(sysdate);
	
	//현재시간 형변환 함수
	function date_to_str(format){
	var year = format.getFullYear();
	var month = format.getMonth() + 1;
	if(month<10) month = '0' + month;
	var date = format.getDate();
	if(date<10) date = '0' + date;
	var hour = format.getHours();
	if(hour<10) hour = '0' + hour;
	var min = format.getMinutes();
	if(min<10) min = '0' + min;
	var sec = format.getSeconds();
	return year + "-" + month + "-" + date + " " + hour + ":" + min + ":" + sec;
	};
	function date_to_array(format){
		var year = format.getFullYear();
		var month = format.getMonth() + 1;
		if(month<10) {month = '0' + month};
		var date = format.getDate();
		if(date<10) {date = '0' + date};
		return year + "-" + month + "-" + date;
	};
	//금액 표시 함수
	function addComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
	}

$(document).ready(function(){
		var offmonth = $("#off_unit").val();
		if(offmonth=="월"){
			$.ajax({
				url: "resMonth.reo?off_no=${office.off_no}",
				type: "GET",
				async: false,
				dataType: "json",
				success : function(data) {
					resdateArray = data;
					if(resdateArray.length > 0){
						for (var i = 0; i < resdateArray.length; i++) {
							enddate=new Date(resdateArray[i].res_enddatetime);
							startdate=new Date(resdateArray[i].res_startdatetime);
							var temp1 =startdate.getTime();
							var temp2 =enddate.getTime();
							var limit =today.getTime();
							var date_limit=(temp1-limit)/(24*60*60*1000);
							var date_diff=(temp2-temp1)/(24*60*60*1000);
							for (var j = 0; j <date_diff+1; j++) {
								insertdate.setTime(temp1+(24*60*60*1000*j));
								insertArray.push(date_to_array(insertdate));
							}
						}
					}
				},
			});
		}
		$('.chktime').click(function(){
			$("#UserTime").html("");
			$("#UserCost").html(""); //금액 초기화
			$('#res_totalprice').val("");	
			$('#UserPeople').html(1); // 선택 내역에서 인원의 초기값을 1로 주기 위해서 
			if($("#res_datetime").val().length<11){
				$("#res_datetime").val($("#res_datetime").val()+" 00:00:00");
			};
			if ($("input.chktime:checked").length == 2) {
				var firstindex = Number($("input.chktime:checked:first").attr("id").substring(3));
				var lastindex = Number($("input.chktime:checked:last").attr("id").substring(3));
				lastnum=parseInt($('input:checkbox[class="chktime"]:checked:last').val());
				var timeplus = lastnum+1; //시간 선택 시 시간 범위로 나와야 되기 때문에
				var timeplusstr= String(timeplus)+":00";
				$("#res_startdatetime").attr("value",$("#res_datetime").attr("value").substr(0,11)+$('input:checkbox[class="chktime"]:checked:first').val()+":00");
				$("#res_enddatetime").attr("value",$("#res_datetime").attr("value").substr(0,11)+timeplusstr+":00");
				if (firstindex > lastindex) {
					$("#res_enddatetime").attr("value",$("#res_datetime").attr("value").substr(0,11)+timeplusstr+":00");
					for(var i = lastindex; i >= firstindex; i--) {
						if($("#chk" + i).attr("disabled")=="disabled") {
							$("#restimecheck").modal();
							$(".chktime").prop("checked", false);
							return false;
						}
						$("#chk" + i).prop("checked", true);
					}
				} else {
					$("#res_enddatetime").attr("value",$("#res_datetime").attr("value").substr(0,11)+timeplusstr+":00");
					for(var i = firstindex; i <= lastindex; i++) {
						if($("#chk" + i).attr("disabled")=="disabled") {
							$("#restimecheck").modal();
							$(".chktime").prop("checked", false);
							return false;
						}
						$("#chk" + i).prop("checked", true);
					}
				}
			} else if ($("input.chktime:checked").length > 2) {
				$("input.chktime").each(function() {
					$(this).prop("checked", false);
				});
			}
		//시간 클릭 시 선택 내역에 시간 계산해서 나오게끔 하기 
			dateclick=$('input:checkbox[class="chktime"]:checked').length; //체크된 갯수 
			firstnum=parseInt($('input:checkbox[class="chktime"]:checked:first').val());
			lastnum=parseInt($('input:checkbox[class="chktime"]:checked:last').val());

			var timeplus = lastnum+1 //시간 선택 시 시간 범위로 나와야 되기 때문에
			var timeminus = lastnum-firstnum+1

			if(dateclick>1){
				$("#UserDate").html($("#selectdate").val()+" "+$('input:checkbox[class="chktime"]:checked:first').val()+"~"+timeplus+":00");
				$("#UserTime").html(timeminus + "시간");
				$("#selUserTime").html("(" + timeminus + "시간" + ")");
				
			}else if(dateclick!=0){ //한번 클릭할 때
				$("#UserDate").html($("#selectdate").val()+" "+$('input:checkbox[class="chktime"]:checked:first').val() + "~" +timeplus+":00");
				$('#UserTime').html(1 + "시간");
				$('#selUserTime').html("(1시간)");	
				
			}else if(dateclick==0){
				$("#UserDate").html($("#selectdate").val()); //시간을 클릭하지 않을 땐 날짜만 나오게 
				$('#selUserTime').html(" ");	
			};
			// 가격 표시 - 선택값에 따른 자동 가격 계산 
			var rentconfer = $('input:radio[id=off_rent]').val();
			var rentconferfee = parseInt($('input:radio[id=off_rent]').val());
			var timeconfer = timeminus*rentconferfee;
			if(isNaN(timeconfer)) {
				timeconfer = " ";
			}
			if($('input:radio[id=off_rent]').is(':checked')){
				$('#UserCost').html(addComma(timeconfer));
				$('#res_totalprice').val(addComma(timeconfer));
			}
		});

		//달력에서 요일 클릭시 변환 함수
		$('.input-group.date').on('changeDate',function(){
			var tempDate=$("#selectdate").val()+" "+"00:00:00"; //selectdate: db timestamp이라 비교하려고
			$('#UserDate').html($("#selectdate").val()); //선택 내역에 선택한 일정 표시 
			//초기화 다선택 할수있게 초기화
			$('input:checkbox[class="chktime"]').each(function() {
				$(this).prop("disabled",false);
			});
			$("#offunitmonth option:eq(0)").prop("selected", true); //셀렉트 옵션 선택 개월 단위 초기화

			$('#UserTime').html(" "); //시간 계산시 달력을 클릭할 때마다 초기화
			$('#selUserTime').html(" "); //새로운 날짜를 클릭할 때마다 전에 시간을 선택한 것 초기화	
			$('#res_totalprice').val(" ");
			$("#UserCost").html(" "); //금액 초기화
			//찍어낼 시간 (비교용) 배열 초기화
			arrtime = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00'];
			//히든 오류 변경 :00:00:00
			$("#res_datetime").val(tempDate); //datetime 값 전송할때 사용
			$("#res_startdatetime").val(tempDate);
			$("#res_enddatetime").val(tempDate);
			
			//checked 초기화
			$('input:checkbox[class="chktime"]').each(function() {
					$(this).prop("checked",false);
					$(this).prop("disabled",false);
			});
			//hour 초기화
			endhour=0;
			starthour=25;
			//시간 단위 예약 시 시간을 checkbox에서 선택할 때 ajax로 예약되어 있는 시간(날짜) 조회
			$.ajax({
				url: "reservAddList.reo",
				type: "POST",
				async: false,
				data : $('#makeReserv').serialize(), //serialize로 form 데이터값 전송해서 데이터베이스에 시간 데이터값들 비교
				success: function(data){
					if(0<data.length){
						//예약이 많을경우 0번 인덱스가 아닌 다른 인덱스도 비교
						for (var i = 0; i < data.length; i++) {
							starthour=new Date(data[i].res_startdatetime).getHours();
							endhour=new Date(data[i].res_enddatetime).getHours();
							$('input:checkbox[class="chktime"]').each(function() {
								// checkbox의 value값이 예약되어 있는 시간에 포함되어 있으면 disabled 처리하는 조건문
								if(starthour<=parseInt($(this).val())&&parseInt($(this).val())<endhour){ 
									$(this).prop("disabled",true);
								};
							});
						}
					}
				},
				error: function(){
					alert("예약 ajax 실패");
				}
			});
			//현재 시간 이전은 선택하지 못하도록 하고, 현재 시간이 8시 30분이면 9시부터 시간 선택이 가능하도록
			if(String($("#selectdate").val()).substr(8)==sysdate.slice(8,10)){
				var nowTime=parseInt(sysdate.slice(-8,-6))+1; 
				var time;
				for (var i =arrtime.length; i >-1; i--) {
					time=parseInt(arrtime[i]);
					if(time<nowTime){
					 arrtime.splice(i,1);
					 $('input:checkbox[class="chktime"]:eq('+i+')').prop("disabled",true);
					};
				};
			};
		});
		
	//여기까지 	
	}); //document 
		//달력생성
		$(function(){
			var offmonth = $("#off_unit").val();
			
			if(offmonth=="월"){
				$('.input-group.date').datepicker({
					calendarWeeks: false,
					todayHighlight: true,
					autoclose: true,
					format: "yyyy-mm-dd",
					language: "kr",
					startDate:'+1d',
					endDate: '+365d',
					daysOfWeekDisabled: [0,7],
					datesDisabled : insertArray, //배열 넘겨야 함 
				});
			} else {
				$('.input-group.date').datepicker({
				calendarWeeks: false,
				todayHighlight: true,
				autoclose: true,
				format: "yyyy-mm-dd",
				language: "kr",
				startDate:'d',
				endDate: '+65d',
				daysOfWeebled: [0,7],
				});
			}
		});

		//달력 한글 패치
		(function($){
		 $.fn.datepicker.dates['kr'] = {
			days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
			daysShort: ["일", "월", "화", "수", "목", "금", "토"],
			daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
			months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
		 };
		}(jQuery));
		
		//인원 수량 증가 감소 버튼 
		$(document).ready(function(){
			$(".plus").click(function(){
				var num = $(".numBox").val();
				var plusNum = Number(num) + 1;
				var offmaxnum = $('#off_maxNum').val();
				var offmaxnumint = Number(offmaxnum);
				if(plusNum > offmaxnumint) {
					$(".numBox").val(num);
				} else {
					$(".numBox").val(plusNum);
				}
				$('#UserPeople').html($(".numBox").val());
			});
					
			$(".minus").click(function(){
				var num = $(".numBox").val();
				var minusNum = Number(num) - 1;
				if(minusNum <= 0) {
					$(".numBox").val(num);
				} else {
					$(".numBox").val(minusNum);
				}
				$('#UserPeople').html($(".numBox").val()); //인원 선택시 선택 내역의 값 변경
				$()
			});
		});

	//form 전송 전 유효성 검사
	function check(){
		if(($('input:checkbox[class="chktime"]').is(":checked") == false) && ($("#off_unit").val() == '시간')){ //시간 
			$('#formcheck').modal();
			return false;
		}else if(($('#offunitmonth option:selected').val()=="") && ($("#off_unit").val() == '월')){
			$('#formcheck').modal();
			return false;
		} else{
			$('#makeReserv').submit();
			return true;
		}
	};

	//전화문의
	$(function(){
		$('#rescall').click(function(){
		$('#rescallmodal').modal();
		});
	});

	//예약 월단위 선택내역
	function monthSelect(){
		var tempDate=$("#selectdate").val()+" "+"00:00:00"; //selectdate: db timestamp이라 비교하려고
		var month = $("#offunitmonth option:selected").val();
		var monthnum = parseInt($("#offunitmonth option:selected").val());
		var rentconfer = $('input:radio[id=off_rent]').val();
		var rentconferfee = parseInt($('input:radio[id=off_rent]').val());
		var monthconfer = monthnum*rentconferfee;
		var selectmon = $("#selectdate").val();
		var selmonreal = new Date(selectmon);
		selmonreal.setMonth(selmonreal.getMonth() + Number(month));

		var resdate = selmonreal.getFullYear() + "-" + (selmonreal.getMonth() + 1) + "-" + selmonreal.getDate();
		var month = (selmonreal.getMonth()+1).toString();
		
		if(month.length < 2){
			month = "0" + month;
		}
		var date = selmonreal.getDate().toString();
		if(date.length < 2){
			date = "0" + date; 
		}
		var resultDate = selmonreal.getFullYear()+ "-" + month +  "-" + date;
		$('#res_totalprice').val(addComma(monthconfer));
		$('#UserCost').html(addComma(monthconfer));
		$('#UserPeople').html(1); // 선택 내역에서 인원의 초기값을 1로 주기 위해서 
		$('#UserDate').html($("#selectdate").val() + " ~ " + resultDate);
		$("#res_enddatetime").val(resultDate + " 00:00:00");

		//월 예약 할 때 예약일정이 겹치면 예약 못하게 막기
		var selectdate = $("#selectdate").val();
		var splitselectdate = selectdate.split('-');
		var splitresultdate = resultDate.split('-');
		var myselectdate = new Date(splitselectdate);
		var myresultdate = new Date(splitresultdate);

		for (var i = 0; i < resdateArray.length; i++) {
			var startdate = resdateArray[i].res_startdatetime;
			if(myselectdate.getTime() < startdate && startdate < myresultdate.getTime()){
				$("#offunitmonth option:eq(0)").prop("selected", true); //셀렉트 옵션 선택 개월 단위 초기화
				$('#res_totalprice').val(" ");	//금액 초기화
				$('#UserDate').html(" ");
				$("#UserCost").html(" ");
				$("#UserPeople").html(" ");
				$("#resdatecheck").modal();
			}
		}
	}
</script>
</html>