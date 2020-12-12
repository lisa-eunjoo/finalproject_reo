<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<title>R E O</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33522b328a3e6d673f8ef7bc8971cbb4&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
	<link type="text/css" rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<div id="block_map" class="col-12"></div>
	<section>
		<div id="indexmap" class="col-12 col-md-8 offset-md-2">
			<button id="map_reset" type="button" onclick='close_map()'>
				<i class="far fa-times-circle" title="닫기"></i>
			</button>
		</div>
		<div id="index_img_area"
			class="carousel slide swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal"
			data-ride="carousel" data-interval="false">
			<ul id="demo_ul" class="carousel-indicators">
				<li data-target="#index_img_area" class="active" data-slide-to='0'></li>
				<li data-target="#index_img_area" class="active" data-slide-to='1'></li>
				<li data-target="#index_img_area" class="active" data-slide-to='2'></li>
				<li data-target="#index_img_area" class="active" data-slide-to='3'></li>
				<li data-target="#index_img_area" class="active" data-slide-to='4'></li>
			</ul>
			<div id="demo_inner" class="carousel-inner">
				<div class="carousel-item active">
					<a onclick="location.href='./getOfficeList.reo?off_type=공유오피스'">
						<img id="index_list_img" src="${pageContext.request.contextPath}/resources/img/index/index_office.jpg" title="오피스" alt="오피스 이미지" />
						<div class="carousel-caption index_caption">
							<h4>새로운 시작 바쁜 사무실 </h4>
							<p>&quot;모두가 능력을 발휘할 <br>수 있는 최적의 업무공간&quot;</p>
						</div>
					</a>
				</div>
				<div class="carousel-item">
					<a onclick="location.href='./getOfficeList.reo?off_type=회의실'">
						<img id="index_list_img" src="${pageContext.request.contextPath}/resources/img/index/index_confer.jpg" title="회의실" alt="회의실 이미지" />
						<div class="carousel-caption index_caption">
							<h4>다양한 의견이 만들어지는 공간</h4>
							<p>&quot;서로 다른 의견을 뭉쳐서 <br>새로운 의견이 나오는 곳&quot;</p>
						</div>
					</a>
				</div>
				<div class="carousel-item">
					<a onclick="location.href='./getOfficeList.reo?off_type=세미나실'">
						<img id="index_list_img" src="${pageContext.request.contextPath}/resources/img/index/index_semina.jpg" title="세미나" alt="세미나 이미지" />
						<div class="carousel-caption index_caption">
							<h4>청중들을 아우르는 이야기 터</h4>
							<p>&quot;당신의 이야기를 다른 <br>이에게도 이야기해보세요&quot;</p>
						</div>
					</a>
				</div>
				<div class="carousel-item">
					<a onclick="location.href='./getOfficeList.reo?off_type=다목적홀'">
						<img id="index_list_img" src="${pageContext.request.contextPath}/resources/img/index/index_hall.jpg" title="다목적" alt="다목적 이미지" />
						<div class="carousel-caption index_caption">
							<h4>관객과 함께하는 공연들</h4>
							<p>&quot;같이 이용할 수 있는 편리한 공간&quot;</p>
						</div>
					</a>
				</div>
				<div class="carousel-item">
					<a onclick="location.href='./getOfficeList.reo?off_type=스터디룸'">
						<img id="index_list_img" src="${pageContext.request.contextPath}/resources/img/index/index_study.jpg" title="스터디 이미지" alt="스터디 이미지" />
						<div class="carousel-caption index_caption">
							<h4>종이와 필기구만 준비</h4>
							<p>&quot;하루 종일 공부할 공간이 필요하다면&quot;</p>
						</div>
					</a>
				</div>
			</div>
			<a class="carousel-control-prev" href="#index_img_area" data-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</a>
			<a class="carousel-control-next" href="#index_img_area" data-slide="next">
				<span class="carousel-control-next-icon"></span>
			</a>
		</div>
		<div class="recomd_list col-12 col-sm-8 offset-sm-2">
			<div class="title_area">
				<h2 id="index_title">추천 공간</h2>
			</div>
			<div class="swiper-container" id="index_swiper">
				<div class="swiper-wrapper" id="recomdList">

				</div>
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
				<!-- Add Arrows -->
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="/resources/include/client/footer.jsp" />
	</footer>
	<script src="<c:url value=" ./resources/js/client/indexLocation.js" />" type="text/javascript"></script>
	<script>
		$(function () {
			$.get({
				url: "./indexList.reo",
				type: "GET",
				dataType: "json",
				success: function (data) {
					$.each(data, function (index, item) {
						var addrArr = item.off_stdAddr.split(' ');

						$('#recomdList').append('<div class="swiper-slide box box_space"><div class="inner" style="width:100%;"><a href="./getOffice.reo?off_no=' + item.off_no +
							'"><div class="img_box"><img class="img" src="${pageContext.request.contextPath}/resources/upload/' + item.off_image +
							'" alt="사무실 이미지"/></div><div class="info_area"><h3 class="tit_space">' + item.off_name +
							'</h3><div class="tags"><span class="tag_area_name"><i class="fas fa-map-marker-alt"></i>' + addrArr[addrArr.length - 2] +
							'</span><p class="tag_type_name">#' + item.off_type + '</p></div><div class="info_price_hour"><div class="indexs"><span class="txt_unit mg_right"><strong class="price">￦' + item.off_rent.toLocaleString() +
							'</strong>원/' + item.off_unit + '</span></div><div class="indexs index_info"><span class="txt_number_maxUser"><i class="fas fa-user-alt usericon"></i><em>최대 ' +
							item.off_maxNum + '인</em></span></div><div class="indexs index_info"><span class="txt_number_love"><i id="heart" class="fas fa-heart"></i><em>' + item.off_likeCount +
							'</em></span></div></div></div></a></div></div>');
					});
					swiper_fn();
				},
			});
		});
		var swiper;
		function swiper_fn() {
			swiper = new Swiper('#index_swiper', {
				slidesPerView: 3,
				spaceBetween: 30,
				slidesPerGroup: 3,
				loop: true,
				pagination: {
					el: '.swiper-pagination',
					clickable: true,
				},
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev',
				},
				breakpoints: {
					500: {
						loop: true,
						spaceBetween: 30,
						slidesPerGroup: 1,
						slidesPerView: 1,
					},
				},
			});
		};
	</script>
</body>
</html>