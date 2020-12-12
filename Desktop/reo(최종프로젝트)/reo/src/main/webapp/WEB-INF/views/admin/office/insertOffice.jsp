<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>상품 등록</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/office/office.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>

<body>
	<c:choose>
		<c:when test="${mem_sector eq '관리자'}">
			<header>
				<jsp:include page="/resources/include/admin/nav.jsp"><jsp:param name="office" value=" " /></jsp:include>
			</header>
		</c:when>
		<c:otherwise>
			<header>
				<jsp:include page="/resources/include/client/header.jsp" />
			</header>
		</c:otherwise>
	</c:choose>
	<section>
		<c:if test="${mem_sector eq '관리자'}">
			<div id="main" class="col-12 col-md-12 col-lg-10 offset-lg-2">
		</c:if>
		<form id="insertOffForm" class="form-horizontal">
			<div class="heading">
				<h3>공간 정보를 입력해주세요.</h3>
				<span class="option">
					<span class="txt_required">
						<span class="ico_required">* </span>
						필수입력
					</span>
				</span>
			</div>

			<div class="box_form">
				<div class="tit">
					<label for="off_name">
						공간명
						<span class="ico_required"> *</span>
					</label>
				</div>
				<div class="input">
					<input name="off_name" type="text" id="off_name" class="form-control" maxlength="30"
						autofocus="autofocus" required />
				</div>
			</div>
			<div class="box_form">
				<div class="tit">
					<label for="space_intro">
						공간 유형
						<span class="ico_required">*</span>
					</label>
				</div>
				<p class="option">
					<span class="txt_required">필수선택</span>
				</p>
				<div class="row">
					<ul class="check_list space">
						<li>
							<input name="off_type" type="radio" value="공유오피스" id="off_rent" checked />
							<label for="off_rent" class="ellip">공유오피스</label>
							<i class="fas fa-check"></i>
						</li>
						<li>
							<input name="off_type" type="radio" value="회의실" id="off_rentConfer" />
							<label for="off_rentConfer" class="ellip">회의실</label>
							<i class="fas fa-check"></i>
						</li>
						<li>
							<input name="off_type" type="radio" value="세미나실" id="off_rentSemi" />
							<label for="off_rentSemi" class="ellip">세미나실</label>
							<i class="fas fa-check"></i>
						</li>
						<li>
							<input name="off_type" type="radio" value="다목적홀" id="off_rentHall" />
							<label for="off_rentHall" class="ellip">다목적홀</label>
							<i class="fas fa-check"></i>
						</li>
						<li>
							<input name="off_type" type="radio" value="스터디룸" id="off_rentStudy" />
							<label for="off_rentStudy" class="ellip">스터디룸</label>
							<i class="fas fa-check"></i>
						</li>
					</ul>
				</div>
			</div>
			<div class="box_form">
				<div class="tit">
					<label>
						예약 단위
						<span class="ico_required"> *</span>
					</label>
				</div>
				<div class="input unitRadio">
					<input name="off_unit" type="radio" value="시간" id="off_type_1" checked /><label
						for="off_type_1">시간단위</label>
					<input name="off_unit" type="radio" value="월" id="off_type_2" /><label for="off_type_2">월단위</label>
				</div>
			</div>
			<c:choose>
				<c:when test="${mem_sector eq '관리자'}">
					<div class="box_form">
						<div class="tit">
							<label for="mem_email">
								이메일
								<span class="ico_required"> *</span>
							</label>
						</div>
						<div class="input">
							<input name="mem_email" type="email" id="mem_email" class="form-control" maxlength="50"
								placeholder="ex) reo@gmail.com" required />
						</div>
					</div>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>

			<div class="box_form">
				<div class="tit">
					<label for="off_price" id="rent_label">
						가격 (시간단위)
						<span class="ico_required"> *</span>
					</label>
				</div>
				<div class="input">
					<input name="off_rent" type="number" min="0" step="100" class="form-control"
						placeholder="가격을 입력하세요." required />
				</div>
			</div>

			<div class="box_form">
				<div class="tit">
					<label for="sample3_address">
						주소
						<span class="ico_required"> *</span>
					</label>
				</div>
				<div class="input">
					<input type="text" id="sample3_postcode" placeholder="우편번호" readonly="readonly" />
					<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기" />
					<div id="wrap"
						style="display: none; border: 1px solid; width: 100%; height: 100%; margin: 5px 0; position: relative">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap"
							style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
							onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
					<input type="text" name="off_stdAddr" id="sample3_address" class="form-control" placeholder="주소"
						required readonly="readonly" /><br>
					<input type="text" name="off_detailAddr" id="sample3_detailAddress" class="form-control"
						placeholder="상세주소" />
					<input type="text" name="off_extraAddr" id="sample3_extraAddress" class="form-control"
						placeholder="참고항목" />
					<div id="map" style="display: none;width:300px;height:300px;margin-top:10px;"></div>
					<div>
						<input id="map_si" name="map_si" type="hidden" />
						<input id="map_gu" name="map_gu" type="hidden" />
						<input id="map_dong" name="map_dong" type="hidden" />
						<input id="map_la" name="map_la" type="number" style="display: none;" />
						<input id="map_ln" name="map_ln" type="number" style="display: none;" />
					</div>
				</div>
			</div>

			<div class="box_form">
				<div class="tit">
					<label for="off_maxNum">
						최대 수용 인원수
						<span class="ico_required"> *</span>
					</label>
				</div>
				<div class="input">
					<input name="off_maxNum" type="number" min="1" id="off_maxNum" class="form-control" required>
				</div>
			</div>
			<div class="box_form">
				<div class="tit">
					<label>
						편의 시설
					</label>
					<input id="chk_all" type="checkbox"><label for="chk_all">
						전체 선택
					</label>
				</div>
				<div class="input">
					<input type="hidden" name="offopt_name" />
					<table class="font">
						<tr>
							<td><input type="checkbox" id="opt1" name="offopt_name" value="냉난방" /><label
									for="opt1">냉난방</label></td>
							<td><input type="checkbox" id="opt2" name="offopt_name" value="인터넷/WIFI" /><label
									for="opt2">인터넷/WIFI</label></td>
							<td><input type="checkbox" id="opt3" name="offopt_name" value="의자/테이블" /><label
									for="opt3">의자/테이블</label></td>
						</tr>
						<tr>
							<td><input type="checkbox" id="opt4" name="offopt_name" value="TV/프로젝터" /><label
									for="opt4">TV/프로젝터</label></td>
							<td><input type="checkbox" id="opt5" name="offopt_name" value="음향/마이크" /><label
									for="opt5">음향/마이크</label></td>
							<td><input type="checkbox" id="opt6" name="offopt_name" value="복사/인쇄기" /><label
									for="opt6">복사/인쇄기</label></td>
						</tr>
						<tr>
							<td><input type="checkbox" id="opt7" name="offopt_name" value="화이트보드" /><label
									for="opt7">화이트보드</label></td>
							<td><input type="checkbox" id="opt8" name="offopt_name" value="PC/노트북" /><label
									for="opt8">PC/노트북</label></td>
							<td><input type="checkbox" id="opt9" name="offopt_name" value="개별콘센트" /><label
									for="opt9">개별콘센트</label></td>
						</tr>
						<tr>
							<td><input type="checkbox" id="opt10" name="offopt_name" value="개인사물함" /><label
									for="opt10">개인사물함</label></td>
							<td><input type="checkbox" id="opt11" name="offopt_name" value="공기청정기" /><label
									for="opt11">공기청정기</label></td>
							<td><input type="checkbox" id="opt12" name="offopt_name" value="보안시스템" /><label
									for="opt12">보안시스템</label></td>
						</tr>
						<tr>
							<td><input type="checkbox" id="opt13" name="offopt_name" value="커피/다과" /><label
									for="opt13">커피/다과</label></td>
							<td><input type="checkbox" id="opt14" name="offopt_name" value="취사시설" /><label
									for="opt14">취사시설</label></td>
							<td><input type="checkbox" id="opt15" name="offopt_name" value="자판기" /><label
									for="opt15">자판기</label></td>
						</tr>
						<tr>
							<td colspan="2"><input type="checkbox" id="opt16" name="offopt_name"
									value="우편물/택배물 관리" /><label for="opt16">우편물/택배물 관리</label></td>
							<td><input type="checkbox" id="opt20" name="offopt_name" value="내부화장실" /><label
									for="opt20">내부화장실</label></td>
						</tr>
						<tr>
							<td colspan="2"><input type="checkbox" id="opt18" name="offopt_name"
									value="전담컨시어지 서비스" /><label for="opt18">전담컨시어지 서비스</label></td>
							<td><input type="checkbox" id="opt19" name="offopt_name" value="클리닝 서비스" /><label
									for="opt19">클리닝 서비스</label></td>
						</tr>
						<tr>
							<td colspan="2"><input type="checkbox" id="opt17" name="offopt_name"
									value="법무사/세무사 무료컨설팅" /><label for="opt17">법무사/세무사 무료컨설팅</label></td>
							<td><input type="checkbox" id="opt21" name="offopt_name" value="금연" /><label
									for="opt21">금연</label></td>
						</tr>
					</table>
					<div class="tit">
						<label class="newOptArea">새 편의시설 추가</label><br>
						<div class="newInputBtn col-6" onclick="plusOpt()"><i class="fas fa-plus"></i></div><div class="newInputBtn col-6" onclick="minusOpt()"><i class="fas fa-minus"></i></div>
						<div id="newInputArea"></div>
					</div>
				</div>
			</div>
			<div class="box_form">
				<div class="tit">
					<label for="off_indate">특징</label>
				</div>
				<div class="input">
					<textarea name="off_feature" class="form-control" rows="5" cols="100" maxlength="500"
						placeholder="500자 이내로 입력해주세요."></textarea>
				</div>
			</div>
			<div class="box_form">
				<span class="tit"><label>이미지</label></span>
				<p class="option">최대 10MB 업로드</p>
				<div class="file">
					<div class="inner">이미지 파일을 추가해 주세요. (JPG, PNG, GIF)</div>
					<div id="attach">
						<label class="btn" for="off_imgs">
							<div class="btntext">파일 첨부</div>
							<input type="file" name="filedata" id="off_imgs" class="display" multiple />
						</label>
					</div>
					<!-- 미리보기 영역 -->
					<br>
					<div id="preview" class="content"></div>
				</div>
			</div>
			<div class="row">
				<div class="box_form col-6">
					<div class="tit">
						<label>
							매물 다중 추가 여부
							<span class="ico_required"> *</span>
						</label>
					</div>
					<div class="input unitRadio">
						<input name="isMultiAdd" type="radio" value="yes" id="add_yes" /><label for="add_yes">예</label>
						<input name="isMultiAdd" type="radio" value="no" id="add_no" checked /><label
							for="add_no">아니오</label>
					</div>
				</div>
				<div id="addCountDiv" class="box_form col-6 display">
					<div class="tit">
						<label for="addCount">
							총 등록할 매물 개수
							<span class="ico_required"> *</span>
						</label>
					</div>
					<div class="input">
						<input name="addCount" type="number" value="1" min="1" id="addCount" class="form-control">
					</div>
				</div>
			</div>
			<div class="text-center fixed_bar fixed">
				<span class="btn_wrap col-4"><button id="offsubmit" class="btn btn-success insertbtn">등록</button></span>
				<span class="btn_wrap col-4"><input type="reset" class="btn btn-secondary insertbtn"
						value="다시작성" /></span>
				<c:choose>
					<c:when test="${mem_sector eq '관리자'}">
						<span class="btn_wrap col-4"><input type="button" class="btn btn-secondary insertbtn" value="목록"
								onclick="location.href='./getOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" /></span>
					</c:when>
					<c:otherwise>
						<span class="btn_wrap col-4"><input type="button" class="btn btn-secondary insertbtn" value="목록"
								onclick="location.href='./myOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" /></span>
					</c:otherwise>
				</c:choose>
			</div>
		</form>
		<c:if test="${mem_sector eq '관리자'}">
			</div>
		</c:if>
	</section>
	<c:choose>
		<c:when test="${mem_sector ne '관리자'}">
			<footer>
				<jsp:include page="/resources/include/client/footer.jsp" />
			</footer>
		</c:when>
	</c:choose>
</body>
<script type="text/javascript">
	$(function () {
		if ('${mem_sector}' != '관리자') {
			$('section').addClass("container");
		}

		$("#chk_all").click(function () {
			if ($("#chk_all").is(":checked")) {
				$("input:checkbox[name=offopt_name]").prop("checked", true);
			} else {
				$("input:checkbox[name=offopt_name]").prop("checked", false);
			}
		});
	});

	$('input:radio[name=isMultiAdd]').click(function () {
		if ($('input[name=isMultiAdd]:checked').val() == 'yes') {
			$("#addCountDiv").css('display', 'block');
		} else {
			$("#addCountDiv").css('display', 'none');
			$('#addCount').val(1);
		}
	});

	$('input:radio[name=off_type]').click(function () {
		$('input:radio[name=off_type]').nextAll('.fa-check').css("color", "gray");
		$('input:radio[name=off_type]:checked').nextAll('.fa-check').css("color", "yellow");
	});

	$('input:radio[name=off_unit]').click(function () {
		if ($('input[name=off_unit]:checked').val() == '시간') {
			$("#rent_label").text('가격 (시간단위)');
		} else {
			$("#rent_label").text('가격 (월단위)');
		}
	});

	// 새로 입력
	function plusOpt() {
		var str = '<div class="newopt">';
		str += '<input type="text" name="offopt_name" class="form-control newInput" placeholder="새로 입력하고 싶은 옵션을 적어주세요." required />';
		str += '</div>';

		$('#newInputArea').append(str);
	}
	function minusOpt() {
		$('#newInputArea .newopt:last-child').remove();
	}

	var files = {};
	var previewIndex = 0;

	function addPreview(input) {
		if (input[0].files) {
			for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
				var file = input[0].files[fileIndex];
				if (validation(file.name))
					continue;
				setPreviewForm(file);
			}
		} else {
			alert('invalid file input');
		}
	}

	function setPreviewForm(file, img) {
		var reader = new FileReader();

		reader.onload = function (img) {
			var imgNum = previewIndex++;
			$("#preview").append(
				"<div class=\"preview-box\" value=\"" + imgNum + "\">"
				+ "<img class=\"thumbnail\" src=\"" + img.target.result + "\"\/>"
				+ "<p>" + file.name + "</p>"
				+ "<span value=\"" + imgNum
				+ "\" onclick=\"deletePreview(this)\" title = '삭제'>"
				+ "<img class='cancel' src='${pageContext.request.contextPath}/resources/img/cancel_icon.png' />"
				+ "</span></div>");
			files[imgNum] = file;

			//console.log('files 길이: ' + Object.keys(files).length);
		};
		reader.readAsDataURL(file);
	}

	//preview 영역에서 삭제 버튼 클릭시 해당 미리보기이미지 영역 삭제
	function deletePreview(obj) {
		var imgNum = obj.attributes['value'].value;
		delete files[imgNum];
		$("#preview .preview-box[value=" + imgNum + "]").remove();
	}

	//client-side validation
	//always server-side validation required
	function validation(fileName) {
		fileName = fileName + "";
		var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
		var fileNameExtension = fileName.toLowerCase().substring(
			fileNameExtensionIndex, fileName.length);
		if (!((fileNameExtension === 'jpg') || (fileNameExtension === 'jpeg') || (fileNameExtension === 'gif')
			|| (fileNameExtension === 'png') || (fileNameExtension === 'bmp'))) {
			alert('jpg, jpeg, gif, png, bmp 확장자만 업로드 가능합니다.');
			return true;
		} else {
			return false;
		}
	}

	$(document).ready(function () {
		$('input[name=off_type]:checked').nextAll('.fa-check').css("color", "yellow");

		$('#offsubmit').on('click', function () {
			var form = $('#insertOffForm')[0];
			var formData = new FormData(form);
			var count = $("#preview > .preview-box:last").attr("value");
			var newInput = $('.newopt').find('.newInput');
			var isNewinputEmpty = false;

			for (var i = 0; i < newInput.length; i++) {
				if (newInput[i].value == '') {
					isNewinputEmpty = true;
				}
			}

			if ($('#off_name').val() == '' || $('#mem_email').val() == '' || $('off_price').val() == '' ||
				$('sample3_address').val() == '' || $('off_maxNum').val() == '' || $('addCount').val() == '') {
				alert('등록에 필요한 필수 입력란들을 작성해주세요.');
				$('input:required').focus();
			} else {
				if (Object.keys(files).length == 0) {
					alert("이미지 파일을 1장이상 첨부해주세요.");
				} else {
					if (isNewinputEmpty) {
						$('.newInput').focus();
					} else {
						for (var index = 0; index <= count; index++) {
							if (files[index] != null) {
								//formData 공간에 files라는 이름으로 파일을 추가한다.
								//동일명으로 계속 추가할 수 있다.
								formData.append('files', files[index]);
							}
						}

						$.ajax({
							type: 'POST',
							enctype: 'multipart/form-data',
							processData: false,
							contentType: false,
							cache: false,
							async: false,
							timeout: 600000,
							url: './insertOffice.reo',
							data: formData,
							success: function (data) {
								//-1 = 잘못된 확장자 업로드, -2 = 용량초과, 1 = 성공, 그외 = 중개인이메일 불일치
								if (data == -1) {
									alert('jpg, jpeg, gif, png, bmp 확장자만 업로드 가능합니다.');
								} else if (data == -2) {
									alert('파일이 10MB를 초과하였습니다.');
								} else if (data == 1) {
									alert('상품 등록 성공');
									$.ajax({
										dataType: 'HTML',
										data: data,
										success: function (data) {
											if ('${mem_sector}' == '관리자') {
												location.href = "./getOfficeList.reo";
											} else {
												location.href = "./myOfficeList.reo";
											}
										},
										error: function () {
											alert('관리자 리스트 페이지 이동 ajax 실패');
										}
									});
								} else {
									alert(data + '는 존재하지 않는 이메일입니다.');
								}
							},
							error: function () {
								alert('매물 등록 ajax 실패');
							}
						});
					}
				}
			}
		});

		$('#attach input[type=file]').change(function () {
			addPreview($(this));
		});
	});
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33522b328a3e6d673f8ef7bc8971cbb4&libraries=services"></script>
<script>
	// 우편번호 찾기 찾기 화면을 넣을 element
	var element_wrap = document.getElementById('wrap');
	function foldDaumPostcode() {
		// iframe을 넣은 element를 안보이게 한다.
		element_wrap.style.display = 'none';
		$('#map').hide();
	}

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		mapOption = {
			center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
			level: 5
			// 지도의 확대 레벨
		};

	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);
	//주소-좌표 변환 객체를 생성
	var geocoder = new daum.maps.services.Geocoder();
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
		position: new daum.maps.LatLng(37.537187, 127.005476),
		map: map
	});

	function sample3_execDaumPostcode() {
		// 현재 scroll 위치를 저장해놓는다.
		var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
		new daum.Postcode({
			oncomplete: function (data) {
				// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("sample3_extraAddress").value = extraAddr;

				} else {
					document.getElementById("sample3_extraAddress").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('sample3_postcode').value = data.zonecode;
				document.getElementById("sample3_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("sample3_detailAddress").focus();

				// iframe을 넣은 element를 안보이게 한다.
				// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
				element_wrap.style.display = 'none';

				// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
				document.body.scrollTop = currentScroll;
				geocoder.addressSearch(data.address, function (results, status) {
					// 정상적으로 검색이 완료됐으면
					if (status === daum.maps.services.Status.OK) {
						var result = results[0]; //첫번째 결과의 값을 활용
						$('#map_la').val(result.y);
						$('#map_ln').val(result.x);
						$('#map_si').val(data.sido);
						$('#map_gu').val(data.sigungu);
						$('#map_dong').val(data.bname);
						// 해당 주소에 대한 좌표를 받아서
						var coords = new daum.maps.LatLng(result.y, result.x);
						// 지도를 보여준다.
						mapContainer.style.display = "block";
						map.relayout();
						// 지도 중심을 변경한다.
						map.setCenter(coords);
						// 마커를 결과값으로 받은 위치로 옮긴다.
						marker.setPosition(coords)
					}
				});
			},
			// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
			onresize: function (size) {
				element_wrap.style.height = size.height + 'px';
			},
			width: '100%',
			height: '100%'
		}).embed(element_wrap);

		// iframe을 넣은 element를 보이게 한다.
		element_wrap.style.display = 'block';
	}
</script>

</html>