<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>REO</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/client/member/mypage.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
</head>

<body>
	<jsp:include page="/resources/include/client/header.jsp" />
	<div class="container myfavorite contents-wrap">
		<div class="row my_reo col-12">
			<div class="use_status col-12">
				<div class="col-12 default_tabs t3">
					<ul class="col-12">
						<li class="col-12"><a href="myfavorite.reo">관심 목록</a></li>
					</ul>
				</div>
				<div class="space_list swiper_list row">
					<div class="flex_wrap column3 fluid col-12">
						<c:choose>
							<c:when test="${not empty mywishlist}">
								<c:forEach items="${mywishlist}" var="wish">
									<article class="box box_space delarticle col-6 col-md-4">
										<div class="inner">
											<a href="./getOffice.reo?off_no=${wish.off_no}">
												<div class="img_box">
													<c:choose>
														<c:when test="${not empty wish.off_image}">
															<img class="img"
																src="${pageContext.request.contextPath}/resources/upload/${wish.off_image}"
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
													<h3 class="tit_space">${wish.off_name}</h3>
													<div class="tags">
														<c:set var="stdAddr"
															value="${fn:split(wish.off_stdAddr, ' ')}" />
														<span class="tag_area_name">
															<i class="fas fa-map-marker-alt"></i>
															${stdAddr[fn:length(stdAddr)-2]}
														</span>
														<p class="tag_type_name">#${fn:replace(wish.off_type, ',', '
															#')}</p>
													</div>
													<div class="info_price_hour">
														<div class="infos"><span class="txt_unit"><strong
																	class="price">${wish.off_rent}</strong>원${wish.off_unit}</span>
														</div>
														<div class="infos infos_info">
															<span class="txt_number_maxUser">
																<i class="fas fa-user-alt usericon"></i>
																<em>최대 ${wish.off_maxNum}인</em>
															</span>
														</div>
														<div class="infos infos_info">
															<span class="txt_number_love">
																<i id="heart" class="fas fa-heart"></i>
																<em>${wish.off_likeCount}</em>
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
								<div class="ls_result on">
									<p class="ls_result_no">저장하신 관심상품이 없습니다.<br> 마음에 드는 상품이 있으시다면 찜을 눌러 담아두세요.</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<footer>
	<jsp:include page="/resources/include/client/footer.jsp" />
</footer>

</html>