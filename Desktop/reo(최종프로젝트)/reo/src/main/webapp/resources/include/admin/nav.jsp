<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/resources/js/admin/nav.js"></script>
<aside>
	<div id="menuBar" class="col-9 col-sm-6 col-md-6 col-lg-2 menuBar menuHidden">
		<div id="closeMenuBar"><i class="fas fa-arrow-left" title="메뉴바 닫기"></i></div>
		<div class="logoBar">
			<a href="index.reo"><img src="${pageContext.request.contextPath}/resources/img/REO.png" alt="REO 로고" alt="REO 로고" title="REO 로고"/><span> R E O</span></a>
		</div>
		<nav class="navBar">
			<ul>
				<li ${param.member != null ? 'class=active' : ''}><a href="memberList.reo"><i class="fas fa-user-edit"></i><span> 회원 관리</span></a></li>
				<li ${param.reservation != null ? 'class=active' : ''}><a href="resList.reo"><i class="fas fa-calendar-check"></i><span> 예약 관리</span></a></li>
				<li ${param.pay != null ? 'class=active' : ''}><a href="payList.reo"><i class="fas fa-won-sign"></i><span> 결제 관리</span></a></li>
				<%-- <li ${param.contract != null ? 'class=active' : ''}><a href="contractList.reo"><i class="fas fa-file-contract"></i><span> 계약서 관리</span></a></li> --%>
				<li ${param.office != null ? 'class=active' : ''}><a href="getOfficeList.reo"><i class="fas fa-building"></i><span> 매물 관리</span></a></li>
				<li ${param.qna != null ? 'class=active' : ''}><a href="adminQnaList.reo"><i class="fas fa-comments"></i><span> Q&amp;A 관리</span></a></li>
				<li ${param.log != null ? 'class=active' : ''}><a href="loginLogList.reo"><i class="fas fa-database"></i><span> 로그인 로그</span></a></li>
				<li><a href="${pageContext.request.contextPath}/index.reo"><i class="fas fa-home"></i><span> 홈페이지</span></a></li>
				<li class="navLogout"><a href="${pageContext.request.contextPath}/logout.reo"><i class="fas fa-sign-out-alt"></i><span> 로그아웃</span></a></li>
			</ul>
		</nav>
	</div>
</aside>
<div id="openMenuBar"><i class="fas fa-bars" title="메뉴바 열기"></i></div>