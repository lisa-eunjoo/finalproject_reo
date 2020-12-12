<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="errorBox">
	<span class="glyphicon glyphicon-alert"></span>
	<h3>요청하신 페이지를 찾을 수 없습니다.</h3>
	<p>입력한 주소가 잘못되었거나, 사용이 일시 중단되어 요청하신 페이지를 찾을 수 없습니다.</p>
	<p>서비스에 이용에 불편을 드려 죄송합니다.</p>
	<br>
	<button type="button" class="btn btn-default" onclick="history.back()">이전 페이지로</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-default" onclick="location.href='${param.homelocation}'">${param.home} 바로가기</button>
</div>