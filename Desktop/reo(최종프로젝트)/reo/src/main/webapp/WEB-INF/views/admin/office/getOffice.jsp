<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>상품 수정</title>
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
		<form id="updateOffForm" class="form-horizontal">
			<div class="heading">
				<h3>공간 정보를 입력해주세요.</h3>
				<span class="option">
					<span class="txt_required">
						<span class="ico_required">* </span>
						필수입력
					</span>
				</span>
			</div>
			<input name="off_no" type="hidden" value="${office.off_no}" />
			<div class="box_form">
				<div class="tit">
					<label for="off_name">
						공간명
						<span class="ico_required"> *</span>
					</label>
				</div>
				<div class="input">
					<input name="off_name" type="text" value="${office.off_name}" id="off_name" class="form-control"
						maxlength="30" autofocus="autofocus" required />
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
							<input name="off_type" type="radio" value="공유오피스" id="off_rent" />
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
							</label>
						</div>
						<div class="input">
							<input name="mem_email" type="email" value="${office.mem_email}" id="mem_email"
								class="form-control" readonly />
						</div>
					</div>
					<div class="box_form">
						<div class="tit">
							<label for="mem_agentName">
								상호명
							</label>
						</div>
						<div class="input">
							<c:set var="mem_agentName" value="${office.mem_agentName}" />
							<c:if test="${!empty mem_agentName}">
								<input name="mem_agentName" type="text" value="${office.mem_agentName}"
									id="mem_agentName" class="form-control" readonly />
							</c:if>
						</div>
					</div>
					<div class="box_form">
						<div class="tit">
							<label for="mem_agentTel">
								전화번호
							</label>
						</div>
						<div class="input">
							<c:set var="mem_agentTel" value="${office.mem_agentTel}" />
							<c:if test="${!empty mem_agentTel}">
								<input name="mem_agentTel" type="text" value="${office.mem_agentTel}" id="mem_agentTel"
									class="form-control" readonly />
							</c:if>
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
					<input name="off_rent" type="number" value="${office.off_rent}" min="0" id="off_price"
						class="form-control" placeholder="가격을 입력하세요." required />
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
					<input type="text" id="sample3_postcode" placeholder="우편번호" readonly />
					<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기" />
					<div id="wrap"
						style="display: none; border: 1px solid; width: 100%; height: 100%; margin: 5px 0; position: relative">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap"
							style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
							onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
					<input type="text" name="off_stdAddr" value="${office.off_stdAddr}" id="sample3_address"
						class="form-control" placeholder="주소" required readonly /><br>
					<input type="text" name="off_detailAddr" value="${office.off_detailAddr}" id="sample3_detailAddress"
						class="form-control" placeholder="상세주소" />
					<input type="text" name="off_extraAddr" value="${office.off_extraAddr}" id="sample3_extraAddress"
						class="form-control" placeholder="참고항목" />
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
					<input name="off_maxNum" type="number" value="${office.off_maxNum}" min="1" id="off_maxNum"
						class="form-control" required>
				</div>
			</div>
			<div class="box_form">
				<div class="tit">
					<label>
						편의 시설
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
					<label for="off_feature">특징</label>
				</div>
				<div class="input">
					<textarea name="off_feature" id="off_feature" class="form-control" rows="5" cols="100"
						maxlength="500"
						placeholder="500자 이내로 입력해주세요."><c:set var="feature" value="${office.off_feature}" /><c:set var="strRN" value="\r\n" /><c:if test="${not empty feature}"><c:set var="rpcFeature" value="${fn:replace(feature, '<br>', strRN)}" />${feature}</c:if></textarea>
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
		</form>
		<div class="text-center fixed_bar fixed">
			<span class="btn_wrap col-3"><button id="offsubmit" class="btn btn-success insertbtn">수정</button></span>
			<span class="btn_wrap col-3"><input type="button" class="btn btn-danger insertbtn" value="삭제"
					data-toggle="modal" data-target="#exampleModal" /></span>
			<c:choose>
				<c:when test="${mem_sector eq '관리자'}">
					<span class="btn_wrap col-3"><input type="button" class="btn btn-secondary insertbtn" value="목록"
							onclick="location.href='./getOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" /></span>
				</c:when>
				<c:otherwise>
					<span class="btn_wrap col-3"><input type="button" class="btn btn-secondary insertbtn" value="목록"
							onclick="location.href='./myOfficeList.reo?pageNo=<%=request.getParameter("pageNo")%>'" /></span>
				</c:otherwise>
			</c:choose>
		</div>
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
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">상품 삭제</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">${office.off_no}번 상품을 삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						onclick="location.href='./deleteOffice.reo?delOff_no=${office.off_no}&pageNo=<%=request.getParameter("pageNo")%>'">삭제하기</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	var files = {};
	var delFiles = [];
	var previewIndex = 0;
	var isGetImg = false;

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
				+ "</span>" + "</div>");
			files[imgNum] = file;
			isGetImg = true;
			//console.log('files 길이: ' + Object.keys(files).length);
		};

		reader.readAsDataURL(file);
	}

	//preview 영역에서 삭제 버튼 클릭시 해당 미리보기이미지 영역 삭제
	function deletePreview(obj) {
		var imgNum = obj.attributes['value'].value;
		delete files[imgNum];
		delFiles.push($(obj).parent().text());
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
		// 현재 사무실의 등록되어 있는 사진 파일 출력
		$.ajax({
			type: 'GET',
			url: './getOffImage.reo?off_no=${office.off_no}',
			dataType: "json",
			success: function (data) {
				if (data.length > 0) {
					$.each(data, function (index, item) {
						imgNum = previewIndex++;

						var str = '<div class="preview-box" value="' + imgNum + '">';
						str += '<img src="${pageContext.request.contextPath}/resources/upload/' + item.offimg_name + '" alt="사무실 이미지" title=' + item.offimg_name + ' class="col-sm-12 thumbnail"/>';
						str += '<p>' + item.offimg_name + '</p>';
						str += '<span value="' + imgNum + '" onclick="deletePreview(this)" title="삭제"><img class="cancel" src="${pageContext.request.contextPath}/resources/img/cancel_icon.png" /></span>';
						str += '</div>';

						$('#preview').append(str);
					});

					isGetImg = true;
				} else {
					isGetImg = false;
				}
			},
			error: function () {
				alert('상품 이미지 파일출력 ajax 실패');
			}
		});
		//
		$('#offsubmit').on('click', function () {
			var form = $('#updateOffForm')[0];
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
				$('input').val('').focus();
			} else {
				if (isGetImg == false) {
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
						formData.append('delFiles', delFiles);

						$.ajax({
							type: 'POST',
							enctype: 'multipart/form-data',
							processData: false,
							contentType: false,
							cache: false,
							async: false,
							timeout: 600000,
							url: './updateOffice.reo',
							data: formData,
							success: function (data) {
								//-1 = 잘못된 확장자 업로드, -2 = 용량초과, 그외 = 성공(1)
								if (data == -1) {
									alert('jpg, jpeg, gif, png, bmp 확장자만 업로드 가능합니다.');
								} else if (data == -2) {
									alert('파일이 10MB를 초과하였습니다.');
								} else {
									alert('상품 수정 성공');
									location.href = "./detailOffice.reo?off_no=" + ${ office.off_no } +'&pageNo=<%=request.getParameter("pageNo")%>';
								}
							},
							error: function () {
								alert('등록에 필요한 필수 입력란들을 작성해주세요.');
							}
						});
					}
				}
			}
		});

		// <input type=file> 태그 기능 구현
		$('#attach input[type=file]').change(function () {
			addPreview($(this)); //preview form 추가하기
		});
	});

	$(function () {
		if ('${mem_sector}' != '관리자') {
			$('section').addClass("container");
		}

		$('input:radio[name=off_type][value="${office.off_type}"]').prop("checked", true);
		$('input:radio[name=off_type][value="${office.off_type}"]').nextAll('.fa-check').css("color", "yellow");

		$('input[name=off_unit]:input[value="${office.off_unit}"]').prop("checked", true);

		if ($('input[name=off_unit]:checked').val() == '시간') {
			$("#rent_label").text('가격 (시간단위)');
		} else {
			$("#rent_label").text('가격 (월단위)');
		}

		<c:forEach items="${off_options}" var="option">

			if($('input:checkbox[name=offopt_name][value="${option.offopt_name}"]').length) {
				$('input:checkbox[name=offopt_name][value="${option.offopt_name}"]').prop("checked", true);
			} else {
				var str = '<div class="newopt">';
				str += '<input type="text" name="offopt_name" value=\"'+"${option.offopt_name}"+'\" ';
				str += 'class="form-control newInput" placeholder="새로 입력하고 싶은 옵션을 적어주세요." required />';
				str += '</div>';

				$('#newInputArea').append(str);
			}
		</c:forEach >
	});

	$('input:radio[name=off_unit]').click(function () {
		if ($('input[name=off_unit]:checked').val() == '시간') {
			$("#rent_label").text('가격 (시간단위)');
		} else {
			$("#rent_label").text('가격 (월단위)');
		}
	});

	$('input:radio[name=off_type]').click(function () {
		$('input:radio[name=off_type]').nextAll('.fa-check').css("color", "gray");
		$('input:radio[name=off_type]:checked').nextAll('.fa-check').css("color", "yellow");

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

	// 위시리스트
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
					alert("위시 삭제 완료");
				}
				// 찜 추가
				if (data == 'add0') {
					alert("위시 추가 에러");
				} else if (data == 'add1') {
					alert("위시 추가 완료");
				}
			},
			error: function () {
				console.log('위시 ajax 실패');
			}
		});
	}
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 찾기 찾기 화면을 넣을 element
	var element_wrap = document.getElementById('wrap');

	function foldDaumPostcode() {
		// iframe을 넣은 element를 안보이게 한다.
		element_wrap.style.display = 'none';
	}

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