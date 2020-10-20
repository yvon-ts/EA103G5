<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*"%>


<!DOCTYPE html>

<%
	LecService lecSvc = new LecService();
	List<LecVO> list = lecSvc.getList();
	pageContext.setAttribute("list", list);
	
	String startdate = "";
	String starttime = "";
	String endtime = "";
	String opendate = "";
	String closedate = "";
%>
<jsp:useBean id="spkrSvc" scope="page" class="com.speaker.model.SpkrService" />
<html>
<head>
<%@ include file="/index/front-index/header.jsp" %>
<title>listAllLec.jsp</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/table_withCal.css">
<style>
	#table-area{
		background-color: #f3f3f3;
		padding: 30px;
	}

</style>
<body>
<%if (list == null || list.size() == 0){%>
	<b style="color: #19B3D3">查無資料</b>		
<%}%>
<div style="margin-left: 50px; margin-top: 100px;">
<div class="content">
<h1>講座查詢</h1>
<div id="table-area"><table class="table">
	<tr>
		<th>講座編號</th>
		<th>講座名稱</th>
		<th>講師編號</th>
		<th>講座地點</th>
		<th>講座票價</th>
		<th>講座日期</th>
		<th>開始時間</th>
		<th>結束時間</th>
		<th>開始報名</th>
		<th>結束報名</th>
		<th>講座狀態</th>
		<!-- <th>初始座位</th> 
		<th>目前座位</th>
		<th>修改時間</th>-->
		<th></th>
		<th></th>
		
	</tr>
	<% int listindex = 0; %>
	<%@ include file="/back-end/pool/page1.file" %>
	<c:forEach var="lecVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	
		<%
			//時間設定
			LecVO lecVO = list.get(listindex + pageIndex);
			Timestamp lecstart = lecVO.getLecstart();
			Timestamp lecend = lecVO.getLecend();
			Timestamp signstart = lecVO.getSignstart();
			Timestamp signend = lecVO.getSignend();
			SimpleDateFormat fmtdate = new SimpleDateFormat("yyyy/MM/dd");
			SimpleDateFormat fmttime = new SimpleDateFormat("HH:mm");
			startdate = fmtdate.format(lecstart);
			starttime = fmttime.format(lecstart);
			endtime = fmttime.format(lecend);
			opendate = fmtdate.format(signstart);
			closedate = fmtdate.format(signend);
			//狀態設定
			String status = "";
			
			if (lecVO.getLecstatus() == 1){
				status = "正常";
			} else {
				status = "取消";
			}
		%>
		
		<tr>
			
			<td data-title="講座編號">${lecVO.lecno}</td>
			<td data-title="講座名稱">${lecVO.lecname}</td>
			<c:forEach var="spkrVO" items="${spkrSvc.list}">
                    <c:if test="${lecVO.spkrno==spkrVO.spkrno}">
	                    <td data-title="講者編號">${spkrVO.spkrname}</td>
                    </c:if>
                </c:forEach>
			
			<td data-title="教室編號">${lecVO.roomno}</td>
			<td data-title="講座票價">${lecVO.lecprice}</td>
			<td data-title="講座日期"><%=startdate%></td>
 			<td data-title="開始時間"><%=starttime%></td>
			<td data-title="結束時間"><%=endtime%></td>
			<td data-title="報名開始"><%=opendate%></td>
			<td data-title="報名結束"><%=closedate%></td>
			<td data-title="講座狀態"><%=status%></td>
			<%--<td data-title="初始座位">${lecVO.initseat}</td>
			<td data-title="目前座位">${lecVO.currentseat}</td>
			<td data-title="講座狀態">${lecVO.lecstatus}</td>
			<td data-title="修改時間">${lecVO.leclmod}</td> --%>
			<td>
			<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
			<input type="submit" value="資訊">
			<input type="hidden" name="lecno" value="${lecVO.lecno}">
			<input type="hidden" name="action" value="getOne"></form>
			</td>
			<td>
				<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do">
				<input type="submit" value="修改">
				<input type="hidden" name="lecno" value="${lecVO.lecno}">
				<input type="hidden" name="action" value="update_fromList"></form>
			</td>
		</tr>
		<% listindex++;%>
	</c:forEach>
	</table>
	</div>
	<div style="background-color: '#ffffff'">
	</div>
	</div>
	</div>
	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/select_page.jsp">
	<input type="submit" value="回首頁"></form>
	<%@ include file="/index/front-index/footer.jsp" %>
</body>

</html>
