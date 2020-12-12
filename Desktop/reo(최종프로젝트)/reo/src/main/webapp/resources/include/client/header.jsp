<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="URL" value="${requestScope['javax.servlet.forward.request_uri']}" />
<nav class="navbar navbar-default navbar-toggleable-md navbar-expand-md">
	<div class="mr-auto">
		<a class="navbar-brand d-flex" href="${pageContext.request.contextPath}/index.reo"><img id="nav_img" src="${pageContext.request.contextPath}/resources/img/REO.png" title="REO 로고"></a>
	</div>
	<c:choose>
		<c:when test="${fn:startsWith(URL,'/reo/my')}">
			<div class="mx-auto">
				<ul class="navbar-nav">
					<li class="nav-item btn d-none d-md-block d-lg-block d-xl-block nav_bold"><a class="nav-link" href="${pageContext.request.contextPath}/mybooking.reo">이용현황</a></li>
					<li class="nav-item btn d-none d-md-block d-lg-block d-xl-block nav_bold"><a class="nav-link" href="${pageContext.request.contextPath}/myfavorite.reo">위시리스트</a></li>
					<li class="nav-item btn d-none d-md-block d-lg-block d-xl-block nav_bold"><a class="nav-link" href="${pageContext.request.contextPath}/myQnaList.reo">문의 내역</a></li>
					<li class="nav-item btn d-none d-md-block d-lg-block d-xl-block nav_bold"><a class="nav-link" href="${pageContext.request.contextPath}/myPayList.reo">결제 내역</a></li>
					<c:choose>
						<c:when test="${mem_sector eq '기업'}">
							<li class="nav-item btn d-none d-md-block d-lg-block d-xl-block nav_bold"><a class="nav-link" href="${pageContext.request.contextPath}/myOfficeList.reo">내 오피스</a></li>
						</c:when>
						<c:when test="${mem_email eq 'admin'}">
							<li class="nav-item btn d-none d-md-block d-lg-block d-xl-block nav_bold"><a class="nav-link" href="${pageContext.request.contextPath}/admin/getOfficeList.reo">내 매물</a></li>
						</c:when>
					</c:choose>
				</ul>
			</div>
		</c:when>
		<c:when test="${!fn:startsWith(URL,'/reo/my')}">
			<div id="index_search" class="mr-auto col-6">
				<form class="form-inline" action="getOfficeList.reo" method="post">
					<input name="keyword" class="form-control col-12" type="text" placeholder="검색어를 입력하세요." aria-label="Search">
					<button><i class="fas fa-search" title="검색"></i></button>
				</form>
			</div>
		</c:when>
	</c:choose>
	<div class="ml-auto">
		<button class="navbar-toggler navbar-toggler-right" type="button" id="sidebarCollapse">
			<span class="fas fa-bars" title="메뉴 열기"></span>
		</button>
	</div>
	<div class="ml-auto">
		<ul class="navbar-nav">
			<c:if test="${mem_email eq null}">
				<li class="d-none d-md-block d-lg-block d-xl-block"><a href="${pageContext.request.contextPath}/getOfficeList.reo" class="btn nav-link fas fa-list"> 상품</a></li>
				<li class="d-none d-md-block d-lg-block d-xl-block"><a href="${pageContext.request.contextPath}/clientQnaList.reo" class="btn nav-link fas fa-clipboard-list"> Q&A</a></li>
				<c:if test="${fn:startsWith(URL,'/reo/index')}">
					<li class="d-none d-md-block d-lg-block d-xl-block"><a id="open_map" type="button" onclick="open_map()" class="btn nav-link fas fa-map"> 지도</a></li>
				</c:if>
				<li class="d-none d-md-block d-lg-block d-xl-block"><a href="${pageContext.request.contextPath}/login.reo" class="btn nav-link fas fa-user"> 로그인/회원가입</a></li>
			</c:if>
			<c:if test="${mem_email ne null}">
				<li class="d-none d-md-block d-lg-block d-xl-block"><a href="${pageContext.request.contextPath}/getOfficeList.reo" class="btn nav-link fas fa-list"> 상품</a></li>
				<li class="d-none d-md-block d-lg-block d-xl-block"><a href="${pageContext.request.contextPath}/clientQnaList.reo" class="btn nav-link fas fa-clipboard-list"> Q&A</a></li>
				<c:if test="${fn:startsWith(URL,'/reo/index')}">
					<li class="d-none d-md-block d-lg-block d-xl-block"><a id="open_map" type="button" onclick="open_map()" class="btn nav-link fas fa-map"> 지도</a></li>
				</c:if>
				<li class="d-none d-md-block d-lg-block d-xl-block"><a href="${pageContext.request.contextPath}/logout.reo" class="btn nav-link nav_bold">로그아웃</a></li>
				<li class="d-none d-md-block d-lg-block d-xl-block"><a href="${pageContext.request.contextPath}/mypage.reo" class="btn nav-link nav_bold">내정보</a></li>
			</c:if>
		</ul>
	</div>
</nav>
<div id="wraps">
	<div id="sidebar">
		<article class="profile">
			<div class="back">
				<div class="menuclose">
					<span><i class="fas fa-arrow-circle-right" title="메뉴 닫기"></i></span>
				</div>
				<dl>
					<c:choose>
						<c:when test="${mem_email eq null}">
							<dt class="require_login"><a href="${pageContext.request.contextPath}/login.reo"><strong>로그인 후 이용해주세요.</strong></a></dt>
						</c:when>
					</c:choose>
					<c:if test="${mem_email ne null}">
						<dt class="require_login"><a href="${pageContext.request.contextPath}/mypage.reo"><strong>${mem_email}</strong></a></dt>
					</c:if>
					<dd class="profile_img"><a href="${pageContext.request.contextPath}/login.reo" style="background-image: url('resources/img/REO.png')" title="REO 로고"></a></dd>
				</dl>
			</div>
		</article>
		<div class="menu_top">
			<ul>
				<li><a href="${pageContext.request.contextPath}/mybooking.reo"><i class="fas fa-tasks"></i><div>예약 리스트</div></a></li>
			</ul>
			<ul>
				<li><a href="${pageContext.request.contextPath}/clientQnaList.reo"><i class="fas fa-clipboard-list"></i><div>Q&A</div></a></li>
			</ul>
			<ul>
				<li><a href="${pageContext.request.contextPath}/myfavorite.reo"><i class="fas fa-heart"></i><div>찜 리스트</div></a>
				</li>
			</ul>
		</div>
		<nav id="gnb">
			<ul class="sidebar-nav">
				<c:choose>
					<c:when test="${fn:startsWith(URL,'/reo/index')}">
						<li class="nav-item btn d-md-none"><a class="nav-link" href="${pageContext.request.contextPath}/getOfficeList.reo">상품<i class="fas fa-angle-right"></i></a></li>
						<li class="nav-item btn d-md-none"><a class="nav-link" href="${pageContext.request.contextPath}/clientQnaList.reo">Q&A<i class="fas fa-angle-right"></i></a></li>
						<li class="nav-item btn d-md-none"><a class="nav-link" onclick="open_map()" style="color: #000000;">지도<i class="fas fa-angle-right"></i></a></li>
					</c:when>
					<c:when test="${!fn:startsWith(URL,'/reo/my')}">
						<li class="nav-item btn d-md-none"><a class="nav-link" href="${pageContext.request.contextPath}/getOfficeList.reo">상품<i class="fas fa-angle-right"></i></a></li>
						<li class="nav-item btn d-md-none"><a class="nav-link" href="${pageContext.request.contextPath}/clientQnaList.reo">Q&A<i class="fas fa-angle-right"></i></a></li>
					</c:when>
					<c:when test="${fn:startsWith(URL,'/reo/my')}">
						<li class="nav-item btn"><a class="nav-link" href="${pageContext.request.contextPath}/mybooking.reo">이용현황<i class="fas fa-angle-right"></i></a></li>
						<li class="nav-item btn"><a class="nav-link" href="${pageContext.request.contextPath}/myfavorite.reo">위시리스트<i class="fas fa-angle-right"></i></a></li>
						<li class="nav-item btn"><a class="nav-link" href="${pageContext.request.contextPath}/myQnaList.reo">문의 내역<i class="fas fa-angle-right"></i></a></li>
						<li class="nav-item btn"><a class="nav-link" href="${pageContext.request.contextPath}/myPayList.reo">결제 내역<i class="fas fa-angle-right"></i></a></li>
					</c:when>
				</c:choose>
			</ul>
			<div class="menu_btn col-12 btn-group text-center">
				<c:choose>
					<c:when test="${mem_email ne null}">
						<button type="button" class="btn btn-primary col-6" onclick="location.href='${pageContext.request.contextPath}/logout.reo'">로그아웃</button>
						<button type="button" class="btn btn-primary col-6" onclick="location.href='${pageContext.request.contextPath}/mypage.reo'">내 정보</button>
					</c:when>
					<c:when test="${mem_email eq null}">
						<button type="button" class="btn btn-primary col-6" onclick="location.href='${pageContext.request.contextPath}/login.reo'">로그인</button>
						<button type="button" class="btn btn-primary col-6" onclick="location.href='${pageContext.request.contextPath}/agreement.reo'">회원가입</button>
					</c:when>
				</c:choose>
			</div>
		</nav>
	</div>
	<div class="overlaymenu"></div>
</div>
<c:if test="${mem_email eq 'admin'}">
	<div class="cogmo"><a href="${pageContext.request.contextPath}/admin/index.reo"><i class="fas fa-cogs" title="관리"></i></a></div>
</c:if>
<script type="text/javascript">
	$('#sidebarCollapse').on('click', function () {
		$('#sidebar').addClass('active');
		$('.overlaymenu').fadeIn();
	});
	$('.overlaymenu').on('click', function () {
		$('#sidebar').removeClass('active');
		$('.overlaymenu').fadeOut();
	});
	$('.menuclose').on('click', function () {
		$('#sidebar').removeClass('active');
		$('.overlaymenu').fadeOut();
	});
</script>