<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>상품 목록</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33522b328a3e6d673f8ef7bc8971cbb4&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
	<link type="text/css" rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/office/office.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/mypage.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>
<body class="pc">
<header><jsp:include page="/resources/include/client/header.jsp" /></header>
<section class="container sec">
	<div class="sort_bar row" style="margin-bottom: 0px;">
		<div class="col-12 col-md-8 mg_pd_z row_height" style="margin: 10px 0;">
			<c:if test="${not empty keyword}">
				<span class="col-12 row_height lg_em mg_pd_z keyword_bold" id="keyword">${keyword}</span><span class="col-6 lg_em mg_pd_z"> 으(로) 검색 결과입니다.</span>
			</c:if>
			<c:if test="${not empty param.off_type}">
				<span class="col-12 row_height lg_em mg_pd_z keyword_bold">${param.off_type}</span><span class="col-6 lg_em mg_pd_z"> 으(로) 검색 결과입니다.</span>
			</c:if>
		</div>
		<div class="col-12 col-md-4 mg_pd_z" style="margin: 10px 0;">
			<span><button id="mapcontrol" type="button" class="btn default type_color col-6 col-md-5 offset-md-1 float_left row_height md_em"><i class="fas fa-map-marker-alt dt_em" style="font-size:1em;"></i> 지도</button></span>
			<span><button type="button" class="btn default type_color col-6 col-md-5 offset-md-1 float_left row_height md_em" onclick="displayFilter()"><i class="fas fa-filter" style="font-size:1em;"></i> 필터</button></span>
		</div>
	</div>
	<div class="sort_bar row" style="border:none;margin-top:0;">
		<div class="col-12 col-sm-5 offset-sm-7 mg_pd_z">
			<select id="sortSel" class="type_color col-6 col-sm-5 offset-sm-1 float_left md_em" name="SIDX" onchange="setList()" >
				<option selected="selected" value="off_no">등록 순</option>
				<option value="off_rent">가격 순</option>
				<option value="off_likeCount">좋아요 순</option>
				<option value="off_name">이름 순</option>
			 </select>
			 <select id="sortSel2" class="type_color col-6 col-sm-5 offset-sm-1 float_left md_em" name="SORD" onchange="setList()">
				<option selected="selected" value="desc">내림차순</option>
				<option value="asc">오름차순</option>
			 </select>
		</div>
	</div>
	<form name="filterForm">
		<div id="filterArea" class="display">
			<div class="box_search row">
			 <div id="typeArea" class="flex_box col-12 col-md-3">
				<span class="category_tit"><strong>공간 유형</strong>을 선택해주세요.</span>
				<select id="typeVal" class="form-control" name="off_type" onchange="setList()">
					<option value="전체" selected="selected">전체
					<option value="공유오피스">공유오피스
					<option value="회의실">회의실
					<option value="세미나실">세미나실
					<option value="다목적홀">다목적홀
					<option value="스터디룸">스터디룸
				</select>
			 </div>
			 <div id="unitArea" class="col-12 col-md-3">
				<span class="category_tit"><strong>예약 단위</strong>를 선택해주세요.</span> 
				<select id="unitVal" class="form-control" name="off_unit" onchange="setList()">
					<option value="전체" selected="selected">전체
					<option value="시간">시간단위
					<option value="월">월단위
				</select>
			 </div>
			 <div class="col-12 col-md-3">
				<span class="category_tit"><strong>가격 범위</strong>를 선택해주세요.</span>
				<div class="input-group">
					<input type="number" name="min_price" min="0" value="0" class="form-control">
					<span id="priceRange">~</span>
					<input type="number" name="max_price" min="0" class="form-control">
				</div>
			 </div>
			 <div id="maxnumArea" class="col-12 col-md-3">
				<span class="category_tit"><strong>인원</strong>을 선택해주세요.</span> <input type="number" name="off_maxNum"
					min="1" class="form-control"><br>
			 </div>
			 <div id="optionArea" class="col-12">
				<span class="category_tit"><strong>편의시설</strong>을 선택해주세요.</span>
				<ul class="check_list space">
					<li>
						<input type="checkbox" id="opt1" name="offopt_name" value="냉난방" />
						<label for="opt1">냉난방</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt2" name="offopt_name" value="인터넷/WIFI" />
						<label for="opt2">인터넷/WIFI</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt3" name="offopt_name" value="의자/테이블" />
						<label for="opt3">의자/테이블</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt4" name="offopt_name" value="TV/프로젝터" />
						<label for="opt4">TV/프로젝터</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt5" name="offopt_name" value="음향/마이크" />
						<label for="opt5">음향/마이크</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt6" name="offopt_name" value="복사/인쇄기" />
						<label for="opt6">복사/인쇄기</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt7" name="offopt_name" value="화이트보드" />
						<label for="opt7">화이트보드</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt8" name="offopt_name" value="PC/노트북" />
						<label for="opt8">PC/노트북</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt9" name="offopt_name" value="개별콘센트" />
						<label for="opt9">개별콘센트</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt10" name="offopt_name" value="개인사물함" />
						<label for="opt10">개인사물함</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt11" name="offopt_name" value="공기청정기" />
						<label for="opt11">공기청정기</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt12" name="offopt_name" value="보안시스템" />
						<label for="opt12">보안시스템</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt13" name="offopt_name" value="커피/다과" />
						<label for="opt13">커피/다과</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt14" name="offopt_name" value="취사시설" />
						<label for="opt14">취사시설</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt15" name="offopt_name" value="자판기" />
						<label for="opt15">자판기</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt16" name="offopt_name" value="우편물/택배물 관리" />
						<label for="opt16">우편물/택배물 관리</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt20" name="offopt_name" value="내부화장실" />
						<label for="opt20">내부화장실</label>
						<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt18" name="offopt_name" value="전담컨시어지 서비스" />
						<label for="opt18">전담컨시어지 서비스</label>
					<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt19" name="offopt_name" value="클리닝 서비스" />
						<label for="opt19">클리닝 서비스</label>
					<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt17" name="offopt_name" value="법무사/세무사 무료컨설팅" />
						<label for="opt17">법무사/세무사 무료컨설팅</label>
					<i class="fas fa-check"></i>
					</li>
					<li>
						<input type="checkbox" id="opt21" name="offopt_name" value="금연" />
						<label for="opt21">금연</label>
					<i class="fas fa-check"></i>
					</li>
				</ul>
			 </div>
			</div>
			<div id="btnArea" class="col-12">
			 <div class="row">
				<div class="col-6">
					<button type="button" class="btn success" onclick="setList();areahide()">적용</button>
				</div>
				<div class="col-6">
					<button type="button" class="btn default" onclick="filterReset()">초기화</button>
				</div>
			 </div>
			</div>
		</div>
	</form>
	<div class="recomd_list">
		<div class="title_area">
			<h2 class="title_h2">추천 공간</h2>
		</div>
		<div class="swiper-container" id="office-container">
			<div class="swiper-wrapper">
				<c:choose>
					<c:when test="${not empty recomdList}">
					<c:forEach items="${recomdList}" var="office">
					<div class="swiper-slide box box_space">
						<div class="inner" style="width:100%;">
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
										<i class="fas fa-map-marker-alt"></i>
										${stdAddr[fn:length(stdAddr)-2]}
									</span>
									<p class="tag_type_name">#${fn:replace(office.off_type, ',', ' #')}</p>
								</div>
								<div class="info_price_hour">
									<div class="infos"><span class="txt_unit"><strong class="price"><fmt:formatNumber type="currency" value="${office.off_rent}"/></strong>원/${office.off_unit}</span></div>
									<div class="infos infos_info">
										<span class="txt_number_maxUser">
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
					</div>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<p>추천 매물이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- Add Pagination -->
			<div class="swiper-pagination"></div>
			<!-- Add Arrows -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
	</div> 
	
	<div class="space_list swiper_list row">
		<div class="flex_wrap column3 fluid col-12">
		 <c:choose>
			<c:when test="${not empty officeList}">
			<c:forEach items="${officeList}" var="office">
				<article class="box box_space delarticle col-12 col-sm-6 col-md-4">
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
								 <i class="fas fa-map-marker-alt"></i>
								 ${stdAddr[fn:length(stdAddr)-2]}
								</span>
								<p class="tag_type_name">#${fn:replace(office.off_type, ',', ' #')}</p>
							</div>
							
							<div class="info_price_hour">
								<div class="infos"><span class="txt_unit"><strong class="price"><fmt:formatNumber type="currency" value="${office.off_rent}"/></strong>원/${office.off_unit}</span></div>
								<div class="infos infos_info">
									<span class="txt_number_maxUser">
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
				<span id="noResultSpan">검색결과가 없습니다.</span>
			</c:otherwise>
		 </c:choose>
		</div>
	</div>
	<c:choose>
		<c:when test="${not empty officeList}">
			<div id="pagingDiv" class="text-center">
				<a onclick="setPaging()" class="btn_more">더보기 <i class="fas fa-chevron-down"></i></a>
			</div>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
</section>
<article>
	<div id="map_header">
		<c:if test="${not empty keyword}">
			<span style="display:none;">${keyword}</span>
		</c:if>
		<a id="header_exit" href="#" style="display:none;"><img src="./resources/img/close.png"></a>
	</div>
	<div id="map"></div>
	<div id="map_slider">
		<div id="map_container" class="swiper-container swiper-container-initialized swiper-container-horizontal">
			<div id="map_insertSlider" class="swiper-wrapper"></div>
			<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
		</div>
	</div>
</article>
<a class="MOVE_TOP_BTN" href="#">TOP</a>
<footer>
	<jsp:include page="/resources/include/client/footer.jsp" />
</footer>
</body>
	<script>
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
		var limit = 12;
		var offset = 0;
		var isDisplay = false;
		var iDocHeight = (window.innerHeight || self.innerHeight || document.documentElement.clientHeight || document.body.clientHeight);
		var markers =[];
		var clustercount=1;
		var clusMarker;
		var mapList=[];
		
		function isEmptyObject(value) {
			if( value == "" || value == null || value == undefined || (value != null && typeof value == "object" && !Object.keys(value).length) ) { 
				return true;
			} else { 
				return false;
			}
		}
		function filterReset() {
			filterForm.reset();
			$('input:checkbox[name=offopt_name]').nextAll('.fa-check').css("color", "gray");
		}
		var swiper = new Swiper('#office-container', {
			slidesPerView:3,
			spaceBetween:10,
			slidesPerGroup:3,
			loop:true,
			loopFillGroupWithBlank:true,
			pagination:{
				el:'.swiper-pagination',
				clickable:true,
			},
			navigation:{
				nextEl:'.swiper-button-next',
				prevEl:'.swiper-button-prev',
			},
			breakpoints: {
				500: {
					loop:false,
					spaceBetween: 30,
					slidesPerGroup: 1,
					slidesPerView: 1,
				},
			},
		});
		function swiper_map_fn(){
			var swiper = new Swiper('#map_container', {
				slidesPerView: 4,
				spaceBetween: 30,
				threshold: 30,
				breakpoints: {
					1250: {
						slidesPerView: 3,
					}, 800: {
						slidesPerView: 2,
					}, 500: {
						slidesPerView: 1,
					},
				},
			});
		};
		
		$(function() {
			var params='keyword='+$('#keyword').text();
			$.get({
				url: "./firstEnter.reo",
				type: "GET",
				data:params,
				success: function(data){
					mapList=data;
				},
			});
			$('#header_exit').click(function(){
				$('#map').css("height","0%");
				$('#map_header').css("height","0%");
				$('#map_header a').css('display','none');
				$('#map_header span').css('display','none');
				$('#map_slider').css('visibility','hidden');
			});
			$('#mapcontrol').click(function(){
				$('#map_header a').css('display','block');
				$('#map_header span').css({'display':'block','color':'white','line-height':'80px','padding-left':'25px','font-size':'2em'});
				$('#map_header a img').css({'right':'20px','position':'fixed','top':'20px','width':'40px'});
				var mapContainer = document.getElementById('map'); // 지도를 표시할 div
				$('#map').css("height",iDocHeight);
				$('#map_header').css({'height':'80px','position':'fixed','z-index':'2','top':'0px','width':'100%'});
				$('#map').css({'position':'fixed','z-index':'1','top':'0px','width':'100%'});
			mapOption = {
				center : new kakao.maps.LatLng(37.5642135, 127.0016985), // 지도의 중심좌표
				level : 3,
				minLevel: 2,
				maxLevel: 8
			};
			// 지도에 마커와 인포윈도우를 표시하는 함수입니다
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			var imageSrctwo = './resources/img/33.png';
			var clusterer = new kakao.maps.MarkerClusterer({
				map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
				averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
				minLevel: 2, // 클러스터 할 최소 지도 레벨
				gridSize: 30,
				minClusterSize: 1,
				disableClickZoom: true, // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
				styles: [{
					width : '50px', height : '50px',
					textAlign: 'center',
					lineHeight: '48px',
					borderRadius: '25px',
					image:imageSrctwo,
					background: 'rgba(128, 229, 255,0.8)'
					
				},{
					width : '50px', height : '50px',
					textAlign: 'center',
					lineHeight: '48px',
					borderRadius: '25px',
					image:imageSrctwo,
					background: 'rgba(128, 229, 255,0.8)'
					
				},{
					width : '50px', height : '50px',
					textAlign: 'center',
					lineHeight: '48px',
					borderRadius: '25px',
					image:imageSrctwo,
					background: 'rgba(128, 229, 255,0.8)'
					
				},{
					width : '50px', height : '50px',
					textAlign: 'center',
					lineHeight: '48px',
					borderRadius: '25px',
					image:imageSrctwo,
					background: 'rgba(128, 229, 255,0.8)'
					
				}]
			});
				kakao.maps.event.addListener(map, 'zoom_changed', function() {
					$('#map_slider').css('visibility','hidden');
				});
				kakao.maps.event.addListener(map, 'dragend', function() {
					for (var i = 0; i < clusterer._clusters.length; i++) {
					 clusterer._clusters[i]._content.style.background='rgba(128, 229, 255,0.8)';
					}
					$('#map_slider').css('visibility','hidden');
				});
				kakao.maps.event.addListener( clusterer, 'clusterclick', function( cluster ) {
					for (var i = 0; i < clusterer._clusters.length; i++) {
					 clusterer._clusters[i]._content.style.background='rgba(128, 229, 255,0.8)';
					}
					cluster.getClusterMarker().Yb.style.background='rgba(0,0,255,0.8)';
					clusTitle=[];
					clusMarker=cluster.getMarkers();
					for (var i = 0; i < clusMarker.length; i++) {
					 clusTitle.push(clusMarker[i].getTitle())
					};
					var params=	'clusTitle='+ clusTitle ;
					$.ajax({
					 url: "./clustererMap.reo",
					 type: "POST",
					 async: false,
					 data : params,
					 success: function(data){
						$("#map_insertSlider").empty();
						$(".swiper-notification").remove();
						$.each(data,function(index,item){
							$('#map_insertSlider').append('<div id=swiper'+index+' class="swiper-slide slidex" style=background:none;></div>');
							$('#swiper'+index).append('<div id=slider'+index+' class="carousel slide map_carousel" data-ride="carousel">'
							+'<div id=inner'+index+' class="carousel-inner map_carousel_inner"></div></div>');
							$.each(item.off_imgs,function(innerIndex,items){
								if(innerIndex==0){
								 $('#inner'+index).append('<div class="carousel-item active map_imgs"><a href=getOffice.reo?off_no='+item.off_no+'><img src="/reo/resources/upload/'+items+'" style="height:170px;width:300px"></a></div>');
								}else{
								 $('#inner'+index).append('<div class="carousel-item map_imgs"><a href=getOffice.reo?off_no='+item.off_no+'><img src="/reo/resources/upload/'+items+'" style="height:170px;width:300px;"></a></div>');	
								}
							});
							$('#inner'+index).append('<a class="carousel-control-prev" href="#slider'+index+'" data-slide="prev"><span class="carousel-control-prev-icon"></span></a>'
							+'<a class="carousel-control-next" href="#slider'+index+'" data-slide="next"><span class="carousel-control-next-icon"></span></a>');
							$('#slider'+index).append('<div id=map_info_area'+index+' class="info_areas"></div>');
							$('#map_info_area'+index).append('<h4 class="map_info_tit">'+item.off_name+'</h4>');
							$('#map_info_area'+index).append('<div id=map_info_area_tag'+index+' class="map_tags"></div>');
							$('#map_info_area_tag'+index).append('<span class=map_area_name><i class="fas fa-map-marker-alt" aria-hidden=true />'+item.off_stdAddr.split(" ")[2]+'</span>');
							$('#map_info_area'+index).append('<div class=map_info_price ><strong class=price>'+item.off_rent+'</strong><span>원/'+item.off_unit+'</span>'+
							'<span><i class="fas fa-user-alt" aria-hidden="true" style="font-size:15px;"/>최대'+item.off_maxNum+'인</span></div>');
						});
						
						$('#map_slider').css('visibility','visible');
						swiper_map_fn()
					 },
					 error: function(){
						alert("실패");
					 }
					});
					map.panTo(cluster.getCenter());
				});
			if(mapList.length>0){
				markers =[];
				var positions =[];
				for (var i = 0; i < mapList.length; i ++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var marker = new kakao.maps.Marker({
					 map: map, // 마커를 표시할 지도
					 position: new kakao.maps.LatLng(mapList[i].map_la,mapList[i].map_ln), // 마커를 표시할 위치
					 clickable: true, // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
					 title:mapList[i].off_no
					 });
					markers.push(marker);
				};
				clusterer.addMarkers(markers);
				var center =markers[0].getPosition();
				map.setCenter(center);
				map.setLevel(6);
			};
		 });
		});
		
		$(function() {
			if('<%=request.getParameter("off_type")%>' != 'null') {
				$('#typeVal').val('<%=request.getParameter("off_type")%>');
			}
		});
		
		function setList() {
			$('#noResultSpan').remove();
			$('#pagingDiv').css("display", "block");
			$('.recomd_list').remove();
		
			var off_type = $('#typeVal').val();
			var off_unit = $('#unitVal').val();
			var min_price = $('input[name=min_price]').val();
			var max_price = $('input[name=max_price]').val();
			var off_maxNum = $('input[name=off_maxNum]').val();
			var off_options = [];
			var keyword = $('#keyword').text();
		
			$("input[name=offopt_name]:checked").each(function(i){
				off_options.push($(this).val());
			});
		
			var sidx = $('#sortSel').val();
			var sord = $('#sortSel2').val();
			limit = 12;
			offset = 0;
			
			 $.ajax({
				 type:'GET',
				url: "./mapListFilter.reo?off_type="+off_type+"&off_unit="+off_unit+"&min_price="+min_price+
				"&max_price="+max_price+"&off_maxNum="+off_maxNum+"&offopt_name="+off_options+
				"&SIDX="+sidx+"&SORD="+sord+"&offset="+offset+"&keyword="+keyword,
				type: "GET",
				dataType : "json",
				async:false,
				success: function(data){
					mapList=[];
					mapList=data;
				},
			 });
			$.ajax({
				type : 'GET',
				url : "./getOfficeListByUnit.reo?off_type="+off_type+"&off_unit="+off_unit+"&min_price="+min_price+
						"&max_price="+max_price+"&off_maxNum="+off_maxNum+"&offopt_name="+off_options+
						"&SIDX="+sidx+"&SORD="+sord+"&limit="+limit+"&offset="+offset+"&keyword="+keyword,
				dataType : "json",
				success : function(data) {
					if(data.length != 0) {
						$.each(data, function(index, item) {
						 var addrArr = item.off_stdAddr.split(' ');
						 
						 var str = '<article class="box box_space delarticle col-6 col-sm-4"><div class="inner">';
						 str += '<a href="./getOffice.reo?off_no=' + item.off_no + '">';
						 str += '<div class="img_box">';
						 if(!isEmptyObject(item.off_image)) { // item.off_image != null || item.off_image != '' 자바스크립트 null 비교 불가, 함수호출로 직접 비교
							str += '<img class="img" src="${pageContext.request.contextPath}/resources/upload/' + item.off_image + '" alt="사무실 이미지" /></div>';
						 } else {
							str += '<img class="img" src="${pageContext.request.contextPath}/resources/img/noimage.gif" alt="이미지 없음" /></div>';
						 }
						 
 						 str += '<div class="info_area"><h3 class="tit_space">' + item.off_name + '</h3>';
 						 str += '<div class="tags"><span class="tag_area_name"><i class="fas fa-map-marker-alt"></i>' + addrArr[addrArr.length-2] + '</span>';
 						 str += '<p class="tag_type_name">'+item.off_type+'</p></div><div class="info_price_hour"><div class="infos"><span class="txt_unit">';
 						 str += '<strong class="price">￦' + item.off_rent.toLocaleString() + '</strong>원/' + item.off_unit + '</span></div>';
 						 str += '<div class="infos infos_info"><span class="txt_number_maxUser"><i class="fas fa-user-alt usericon"></i><em>최대 '+item.off_maxNum+'인</em></span></div>';
 						 str += '<div class="infos infos_info"><span class="txt_number_love"><i id="heart" class="fas fa-heart"></i><em>'+item.off_likeCount+'</em></span></div>';
 						 str += '</div></div></a></div></article>';
			
						 $('.flex_wrap').append(str);
						});
					} else {
						
						var str = '<span id="noResultSpan">검색결과가 없습니다.</span>'
						$('.flex_wrap').append(str);
						$('#pagingDiv').css("display", "none");
					}
				},
				error : function() {
					alert('사무실 unit 필터 리스트 ajax 실패');
				}
			});
			$('.delarticle').remove();
		}
		
		function setPaging() {
			$('#noResultSpan').remove();
			var off_type = $('#typeVal').val();
			var off_unit = $('#unitVal').val();
			var min_price = $('input[name=min_price]').val();
			var max_price = $('input[name=max_price]').val();
			var off_maxNum = $('input[name=off_maxNum]').val();
			var off_options = [];
			var keyword = $('#keyword').text();
			
			$("input[name=offopt_name]:checked").each(function(i){
				off_options.push($(this).val());
			});
		
			var sidx = $('#sortSel').val();
			var sord = $('#sortSel2').val();
		
			limit = 12;
			offset = offset + 12;
		
			var lastArticle = $('.flex_wrap').children(":last");
			$('html, body').animate({scrollTop: lastArticle.offset().top }, 1000);
		
			$.ajax({
				type : 'GET',
				url : "./getOfficeListByUnit.reo?off_type="+off_type+"&off_unit="+off_unit+"&min_price="+min_price+
						"&max_price="+max_price+"&off_maxNum="+off_maxNum+"&offopt_name="+off_options+
						"&SIDX="+sidx+"&SORD="+sord+"&limit="+limit+"&offset="+offset+"&keyword="+keyword,
				dataType : "json",
				success : function(data) {
					if(data.length != 0) {
						$.each(data, function(index, item) {
						 var typeArr = item.off_type.split(',');
						 var addrArr = item.off_stdAddr.split(' ');
						 
						 var str = '<article class="box box_space delarticle col-12 col-sm-6 col-md-4"><div class="inner">';
						 str += '<a href="./getOffice.reo?off_no=' + item.off_no + '">';
						 str += '<div class="img_box">';
						 if(!isEmptyObject(item.off_image)) { // item.off_image != null || item.off_image != '' 자바스크립트 null 비교 불가, 함수호출로 직접 비교
							str += '<img class="img" src="${pageContext.request.contextPath}/resources/upload/' + item.off_image + '" alt="사무실 이미지" /></div>';
						 } else {
							str += '<img class="img" src="${pageContext.request.contextPath}/resources/img/noimage.gif" alt="이미지 없음" /></div>';
						 }
						 str += '<div class="info_area"><h3 class="tit_space">' + item.off_name + '</h3>';
						 str += '<div class="tags"><span class="tag_area_name"><i class="fas fa-map-marker-alt"></i>' + addrArr[addrArr.length-2] + '</span>';
						 str += '<p class="tag_type_name">'+item.off_type+'</p></div><div class="info_price_hour"><div class="infos"><span class="txt_unit">';
						 str += '<strong class="price">￦' + item.off_rent.toLocaleString() + '</strong>원/' + item.off_unit + '</span></div>';
						 str += '<div class="infos infos_info"><span class="txt_number_maxUser"><i class="fas fa-user-alt usericon"></i><em>최대 '+item.off_maxNum+'인</em></span></div>';
						 str += '<div class="infos infos_info"><span class="txt_number_love"><i id="heart" class="fas fa-heart"></i><em>'+item.off_likeCount+'</em></span></div>';
						 str += '</div></div></a></div></article>';
			
						 $('.flex_wrap').append(str);
						});
					} else {
						$('#pagingDiv').css("display", "none");
					}
				},
				error : function() {
					alert('사무실 unit 필터 리스트 ajax 실패');
				}
			});
		}
		
		function displayFilter() {
			if(!isDisplay) {
				$('#filterArea').css("display", "block");
				isDisplay = true;
			} else {
				$('#filterArea').css("display", "none");
				isDisplay = false;
			}
		}
		
		$('input:checkbox[name=offopt_name]').click(function() {
			if($('input:checkbox[id='+$(this).attr('id')+']').is(":checked") == true) {
				$('input:checkbox[id='+$(this).attr('id')+']').nextAll('.fa-check').css("color", "yellow");
			
			} else if($('input:checkbox[id='+$(this).attr('id')+']').is(":checked") == false) {
				$('input:checkbox[id='+$(this).attr('id')+']').nextAll('.fa-check').css("color", "gray");
			}
		});
		function areahide(){
			isDisplay = false;
			$('#filterArea').css("display", "none");	
		}
</script>
</html>