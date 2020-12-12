<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>관리자-계약서</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="image/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/REO.png">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.2/FileSaver.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/pay/contractIframe.js"></script>
		<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/pay/contractInfo.css">
		<script type="text/javascript" src="https://kit.fontawesome.com/2b208faafb.js"></script>
	</head>
	<body>
		<div id="contract">
			<table class="table">
				<tr class="row titlebar tableBorderTop">
					<td class="col-sm-12 col-12 textCenter">부동산(${office['off_type']}) 월세 계약서</td>
				</tr>
				<tr class="row tableBorderTop">
					<td class="col-sm-12 col-12 tableTitle">
						임대임과 임차인 쌍방은 아래 표시 부동산에 관하여 다음 계약 내용과 같이 임대차계약을 체결한다.<br />
						1. 부동산의 표시
					</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">소 재 지</td>
					<td class="col-sm-10 col-10">${contractDTO.location}</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">건&emsp;&emsp;물</td>
					<td class="col-sm-2 col-2 textCenter tableTitle">용&emsp;&emsp;도</td>
					<td class="col-sm-3 col-3">${office['off_type']}</td>
					<td class="col-sm-2 col-2 textCenter tableTitle">최대인원</td>
					<td class="col-sm-3 col-3">${office['off_maxNum']} 명</td>
				</tr>
				<tr class="row tableBorderTop">
					<td class="col-sm-12 col-12 tableTitle">
						2. 계약내용<br />제 1조 [목적]위 부동산의 임대차에 한하여 임대인과 임차인은 합의에 의하여 임차보증금 및 차임을 아래와 같이 지불하기로 한다.
					</td>
				</tr>
				<tr class="row">
					<jsp:useBean id="payday" class="java.util.Date"/>
					<jsp:setProperty property="time" name="payday" value="${contractDTO.payday}"/>
					<td class="col-sm-2 col-2 textCenter tableTitle">금&emsp;&emsp;액</td>
					<td class="col-sm-10 col-10"><span class="title">금</span> <fmt:formatNumber type="number" maxFractionDigits="3" currencySymbol="원" value="${contractDTO.price}" />&emsp;&emsp;&emsp;은
					<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${payday}"/>에 지불하였다.</td>
				</tr>
				<tr class="row">
					<jsp:useBean id="startdate" class="java.util.Date"/>
					<jsp:setProperty property="time" name="startdate" value="${contractDTO.startdate}"/>
					<jsp:useBean id="enddate" class="java.util.Date"/>
					<jsp:setProperty property="time" name="enddate" value="${contractDTO.enddate}"/>
					<td class="col-sm-2 col-2 textCenter tableTitle">기&emsp;&emsp;간</td>
					<td class="col-sm-10 col-10"><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${startdate}"/> ~ <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${enddate}"/> (${diffMonth}개월)</td>
				</tr>
				<tr class="row tableBorderTop">
					<td class="col-sm-12 col-12 outdent">
					<span class="outdent">&nbsp;제 2조 [존속기간] 임대인은 위 부동산을 임대차 목적대로 사용할 수 있는
					상태로&emsp;<strong><fmt:formatDate pattern="yyyy년MM월dd일" value="${startdate}"/></strong>&emsp;까지 임차인에게 인도하며,
					임대차 기간은 인도일로부터&emsp;<strong><fmt:formatDate pattern="yyyy년MM월dd일" value="${enddate}"/> (${diffDay}일)</strong>&emsp;까지로 한다.</span><br/>
					<span class="outdent">&nbsp;제 3조 [용도변경 및 전대 등] 임차인은 임대인의 동의없이 위 부동산의 용도나 구조를 변경하거나
					전대 임차권 양도 또는 담보제공을 하지 못하며 임대차 목적 이외의 용도로 사용할 수 없다.</span><br/>
					<span class="outdent">제 4조 [계약의 해지] 임차인의 차임 연체액이 2기의 차임액에 달하거나,
					제3조를 위반 하였을 때 임대인은 즉시 본 계약을 해지 할 수 있다.</span><br/>
					<span class="outdent">&nbsp;제 5조 [계약의 종료] 임대차 계약이 종료된 경우 임차인은
					위 부동산을 원상으로 회복하여 임대인에게 반환한다. 이러한 경우 임대인은 보증금을 임차인에게 반환하고,
					연체 임대료 또는 손해배상금이 있을 때는 이들을 제하고 그 잔액을 반환한다.</span><br/>
					<span class="outdent">&nbsp;제 6조 [계약의 해제] 임차인이 임대인에게 중도금(중도금이 없을때는 잔금)을
					지불하기 전까지 임대인은 계약금의 배액을 상환 하고, 임차인은 계약금을 포기하고 이 계약을 해제할 수 있다.</span><br/>
					<span class="outdent">&nbsp;제 7조 [채무불이행과 손해배상의 예정] 임대인 또는 임차인은 본계약상의 내용에
					대하여 불이행이 있을 경우 그 상대방은 불이행 한자에 대하여 서면으로 최고하고 계약을 해제 할 수 있다.
					이 경우 계약 당사자는 계약해제에 따른 손해배상을 각각 상대방에게 청구할 수 있으며,
					손해 배상에 대하여 별도의 약정이 없는 한 계약금을 손해배상의 기준으로 본다.</span><br/>
					<span class="outdent">&nbsp;제 8조 [중개보수] 개업공인중개사는 임대인 또는 임차인의 본 계약 불이행에 대하여 책임을 지지 않는다.
					또한 중개보수는 본 계약 체결에 따라 계약 당사자 쌍방이 각각 지불하며, 개업공인중개사의 고의나 과실 없이 본 계약이
					무효, 취소 또는 해제 되어도 중개보수는 지급한다. 공동중개인 경우에 임대인과 임차인은 자신이
					중개 의뢰한 개업공인중개사에게 각각 중개보수를 지급한다.</span><br/>
					<span class="outdent">&nbsp;제 9조 [중개대상물확인설명서교부 등] 개업공인중개사는 중개대상물확인설명서를 작성하고
					업무보증관계증서 (공제증서 등) 사본을 첨부하여 거래당사자 쌍방에게 교부한다. (교부일자 : <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${payday}"/>)</span>
					</td>
				</tr>
				<tr class="row tableBorderTop">
					<td class="col-sm-12 col-12 contract">
					&nbsp;[ 특약사항 ]<br/>
					&nbsp;1. 현 시설 상태에서의 매매 계약이며, 등기사항 증명서를 확인하고, 계약을 체결함.<br/>
					&nbsp;2. 잔금 시까지의 각종 공과금은 매도자 부담으로 한다.<br/>
					&nbsp;3. 본 특약 사항에 기재되지 않은 사항은 민법상 계약에 관한 규정과 부동산매매 일반 관례에 따른다.<br/>
					&nbsp;4. 현시설물 상태의 계약이나 계약시에 매도인이 고지하지 않은 부분에 하자가 있을 경우,
					하자담보책임과는 별개로 매도인은 이를 수리해주기로 한다.<br/>
					&nbsp;5. ○○은행 채권최고액 금○○원 상태의 계약으로 잔금일에 매도인이 상환하고 말소하기로 하며,
					매도인은 잔금일까지 채무를 부담하는 등의 새로운 권리변동을 일으키지 않도록 한다.<br/>
					&nbsp;6. 첨부서류 : 실제 첨부하여 교부한 서류만 기재.&emsp;예시) 중개대상물 확인 · 설명서
					</td>
				</tr>
				<tr class="row tableBorderTop">
					<td class="col-sm-12 col-12 indent">본 계약을 증명하기 위하여 계약 당사자가 이의 없음을 확인하고 각각 서명 · 날인 한다.&emsp;&emsp;&emsp;&emsp;<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${payday}"/></td>
				</tr>
				<tr class="row titlebar tableBorderTop">
					<td class="col-sm-12 col-12 textCenter">임대인 / 임차인</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">주&emsp;&emsp;소</td>
					<td class="col-sm-10 col-10">${member['mem_roadaddress']} ${member['mem_detailaddress']}</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">성&emsp;&emsp;명</td>
					<td class="col-sm-4 col-4">${contractDTO.name} (${contractDTO.id})</td>
					<td class="col-sm-1 col-1 textCenter tableTitle">생년월일</td>
					<td class="col-sm-2 col-2">${member['mem_birth']}</td>
					<td class="col-sm-1 col-1 textCenter tableTitle">전&emsp;&emsp;화</td>
					<td class="col-sm-2 col-2">${member['mem_tel']}</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">주&emsp;&emsp;소</td>
					<td class="col-sm-10 col-10">${office['mem_roadaddress']} ${office['mem_detailaddress']}</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">기업이름</td>
					<td class="col-sm-4 col-4">${office['mem_agentName']}</td>
					<td class="col-sm-1 col-1 textCenter tableTitle">전&emsp;&emsp;화</td>
					<td class="col-sm-2 col-2">${office['mem_tel']}</td>
					<td class="col-sm-1 col-1 textCenter tableTitle">등록번호</td>
					<td class="col-sm-2 col-2">${office['mem_buisnessNo']}</td>
				</tr>
				<tr class="row titlebar tableBorderTop">
					<td class="col-sm-12 col-12 textCenter">R E O</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">사무실 소재지</td>
					<td class="col-sm-10 col-10">서울 금천구 가산디지털2로 123 월드메르디앙벤처센터II KOSMO</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">사무소 명칭</td>
					<td class="col-sm-4 col-4">R E O</td>
					<td class="col-sm-2 col-2 textCenter tableTitle">대표자명</td>
					<td class="col-sm-4 col-4">King Coder's</td>
				</tr>
				<tr class="row">
					<td class="col-sm-2 col-2 textCenter tableTitle">전화번호</td>
					<td class="col-sm-4 col-4">010-1234-5678</td>
					<td class="col-sm-2 col-2 textCenter tableTitle">등록번호</td>
					<td class="col-sm-4 col-4">012-34-56789</td>
				</tr>
			</table>
		</div>
	</body>
</html>
