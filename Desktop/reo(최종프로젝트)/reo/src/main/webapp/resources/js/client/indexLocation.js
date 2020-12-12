function open_map() {
	$('#indexmap').css('visibility', 'visible');
	$('#block_map').css('visibility', 'visible');
	$('#map_reset').css('visibility', 'visible');
	$('#sidebar').removeClass('active');
	$('.overlaymenu').fadeOut();
};
function close_map() {
	$('#indexmap').css('visibility', 'hidden');
	$('#block_map').css('visibility', 'hidden');
	$('#map_reset').css('visibility', 'hidden');
};
var bounds = new Array();
var mapContainer = document.getElementById('indexmap'); // 지도를 표시할 div
var jsonLocation = './resources/area.json';
var areas = new Array();
var areapath = new Array();
var offtype = 1;
// 가로값
var windowWidth = $(window).width();
// 폴리곤 초기화 배열
var polygons = [];
// 오버레이 초기화 배열
var customOverlays = [];
// 마커 초기화 배열
var markers = [];
if (windowWidth > 500) {
	mapOption = {
		center : new kakao.maps.LatLng(37.5642135, 126.9716985), // 지도의 중심좌표
		level : 8.5,
		minLevel : 8.5,
		maxLevel : 10
	};
} else {
	mapOption = {
		center : new kakao.maps.LatLng(37.5642135, 127.0016985), // 지도의 중심좌표
		level : 9.7,
		minLevel : 9,
		maxLevel : 10
	};
}
	if (navigator.geolocation) {
		// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		navigator.geolocation.getCurrentPosition(function(position) {
	
			var lat = position.coords.latitude, // 위도
			lon = position.coords.longitude, // 경도
			locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를
															// geolocation으로 얻어온 좌표로
															// 생성합니다
	
			displayMarker(locPosition)
		});
	}
var imageSrc = './resources/img/index/highlight_marker.png';
// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition) {
	var imageSize = new kakao.maps.Size(24, 35);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		image : markerImage,
		map : map,
		position : locPosition,
		zIndex : 1,
		title : "내위치"
	});
}
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// JSON 객체 가져오기
$.getJSON(jsonLocation, function(data) {
	$.each(data, function(index, item) {
		areapath = new Array();
		$.each(item.path, function(index, item) {
			areapath.push(new kakao.maps.LatLng(item[0], item[1]))
		});
		areas.push({
			"name" : item.name,
			"center" : new kakao.maps.LatLng(item.center[0], item.center[1]),
			"poly_color" : item.poly_color,
			"path" : $.each(areapath, function(index, item) {
			})
		});
	});
	// 폴리곤 생성
	for (var i = 0, len = areas.length; i < len; i++) {
		displayArea(areas[i]);
	}
	;
});
// 다각형을 생상하고 이벤트를 등록하는 함수입니다
function displayArea(area) {
	// 다각형을 생성합니다
	var polygon = new kakao.maps.Polygon({
		map : map, // 다각형을 표시할 지도 객체
		path : area.path,
		strokeWeight : 2,
		strokeColor : '#000',
		strokeOpacity : 0,
		fillColor : area.poly_color,
		fillOpacity : 0.7
	});
	if (windowWidth > 500) {
		var content = '<a href=./getOfficeList.reo?keyword='
				+ area.name
				+ '><div><span class="left"></span><span class="center" style="font-size:1em">'
				+ area.name + '</span><span class="right"></span></div></a>';
	} else {
		var content = '<a href=./getOfficeList.reo?keyword='
				+ area.name
				+ '><div><span class="left"></span><span class="center" style="font-size:0.7em">'
				+ area.name + '</span><span class="right"></span></div></a>';
	}
	// 커스텀 오버레이가 표시될 위치입니다
	var position = area.center;
	// 커스텀 오버레이를 생성합니다
	customOverlay = new kakao.maps.CustomOverlay({
		position : position,
		content : content
	});
	customOverlay.setMap(map);

	customOverlays.push(customOverlay);

	polygons.push(polygon);
	// 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다
	// 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
	kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
		polygon.setOptions({
			fillColor : area.poly_color,
			fillOpacity : 1,
		});
	});

	// 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
	// 커스텀 오버레이를 지도에서 제거합니다
	kakao.maps.event.addListener(polygon, 'mouseout', function() {
		polygon.setOptions({
			fillColor : area.poly_color,
			fillOpacity : 0.7,
		});
		customOverlay.setMap(null);
	});

	kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
		polygu = area.name
		var moveLatLon = area.center
		polygon.setOptions({
			fillColor : '#fff'
		});
		location.href = "./getOfficeList.reo?keyword=" + polygu;
	});
}
// 기본지도 하얀색배경
var sw = new kakao.maps.LatLng(30, 120), // 사각형 영역의 남서쪽 좌표
ne = new kakao.maps.LatLng(36, 140);
var rectangleBounds = map.getBounds(sw, ne);
// 지도에 사각형을 표시한다 */
var rectangle = new kakao.maps.Rectangle({
	map : map, // 사각형을 표시할 지도 객체
	bounds : rectangleBounds, // 사각형의 영역
	fillColor : '#fff', // 채움 색
	fillOpacity : 1, // 채움 불투명도
	strokeWeight : 3, // 선의 두께
	strokeColor : '#ffffff', // 선 색
	strokeOpacity : 1, // 선 투명도
	strokeStyle : 'solid' // 선 스타일
});
// 드레그 막기
// 줌막기
map.setDraggable(false);
map.setZoomable(false);