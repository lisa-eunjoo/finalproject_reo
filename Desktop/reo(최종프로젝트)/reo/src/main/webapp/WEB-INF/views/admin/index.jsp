<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-회원 목록</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
		<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/index.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<jsp:include page="/resources/include/admin/nav.jsp" />
		<section>
			<div class="visitorCount">현재 방문자 수 : ${userCount} 명</div>
			<div id="main" class="col-12 col-md-12 col-lg-10 offset-lg-2">
				<div class="row">
					<div class="col-sm-12 col-md-12"><canvas id="dateCountChart" title="일별 방문자수"></canvas></div>
				</div><br/>
				<div class="row">
					<div class="col-sm-12 col-md-6"><canvas id="ageChart" title="회원 연령대"></canvas></div>
					<div class="col-sm-12 col-md-6"><div id="topPayChart" title="결제 TOP5"></div></div>
				</div><br/>
				<div class="row">
					<div class="col-sm-12 col-md-6 textCenter">
						<h2 id="wordcloudTitle">검색어 순위</h2>
						<img id="wordcloud" src="${wordcloudURL}" title="검색어 순위" alt="검색어 순위" />
					</div>
					<div class="padding0 col-sm-12 col-md-6">
						<table class="table table-bordered">
							<caption>로그인 로그</caption>
							<thead>
								<tr class="row m-0">
									<th class="col-sm-4 col-6">아이디</th>
									<th class="col-sm-4 col-6">시간</th>
									<th class="col-sm-4 d-none d-sm-table-cell">IP</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${loginLog}" var="loginLogDTO">
								<tr class="row m-0">
									<td class="col-sm-4 col-6">${loginLogDTO.mem_email}</td>
									<td class="col-sm-4 col-6"><fmt:formatDate pattern="MM-dd HH:mm" value="${loginLogDTO.log_date}"/></td>
									<td class="col-sm-4 d-none d-sm-table-cell">${loginLogDTO.log_ip}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</section>
	</body>
	<script src="${pageContext.request.contextPath}/resources/js/admin/index.js"></script>
	<script type="text/javascript">
	<c:forEach items="${ageData}" var="ageData">
	ageChartLabels.push('${ageData.age}');
	ageChartDatas.push('${ageData.counts}');
	</c:forEach>
	<c:forEach items="${topPayData}" var="topPayData">
	topPayChartDatas.push({ label: '${topPayData.gu}', y: ${topPayData.counts} });
	</c:forEach>
	<c:forEach items="${dateCount}" var="dateCount">
	dateCountChartLabels.push('${dateCount.dates}');
	dateCountChartDatas.push(${dateCount.counts});
	</c:forEach>
	createAgeChart();
	createDateCountChart();
	topPayChart.render();
	$("script:last").remove();
	</script>
</html>