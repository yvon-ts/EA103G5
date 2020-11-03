<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	LecVO lecVO = (LecVO) request.getAttribute("lecVO");
	//CKeditor - Bytes to String
	String info = "資訊更新中";
	try{
		byte[] b = lecVO.getLecinfo();
		info = new String(b);
	} catch (Exception e){
		info = "資訊更新中";
	}

	//日期設定
	Timestamp lecstart = lecVO.getLecstart();
	Timestamp lecend = lecVO.getLecend();
	Timestamp signstart= lecVO.getSignstart();
	Timestamp signend= lecVO.getSignend();
	String startdate = "";
	String starttime = "";
	String endtime = "";
	String opendate = "";
	String closedate = "";
	DateFormat fmtdate = new SimpleDateFormat("yyyy/MM/dd");
	DateFormat fmttime = new SimpleDateFormat("HH:mm");
	startdate = fmtdate.format(lecstart);
	starttime = fmttime.format(lecstart);
	endtime = fmttime.format(lecend);
	opendate = fmtdate.format(signstart);
	closedate = fmtdate.format(signend);
	
	String status = "";
	String statusCss = "";
	
	if (lecVO.getLecstatus() == 1){
		status = "正常";
		statusCss = "defaultLec";
	} else if (lecVO.getLecstatus() == 0) {
		status = "取消";
		statusCss = "cancelLec";
	} else if (lecVO.getLecstatus() == 2){
		status = "額滿";
		statusCss = "soldOutLec";
	} else if (lecVO.getLecstatus() == 3){
		status = "結束";
		statusCss = "endLec";
	} 
	
	pageContext.setAttribute("lecVO", lecVO);
	
%>
<!DOCTYPE html>
<jsp:useBean id="spkrSvc" scope="page" class="com.speaker.model.SpkrService" />
<jsp:useBean id="roomSvc" scope="page" class="com.classroom.model.ClassroomService" />
<html>
<head>
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
	#displayInfo{
		width: 100%;
		padding: 30px;
		background-color: #F3F3F3;
		border-radius: 5px;
	}
	#btn1{
		margin-left: 400px;
		margin-top: 150px;
		display: inline-block;
	}
	#btn2{
		margin-top: 150px;
		display: inline-block;
	}
		.defaultLec{
		color: #fff;
		font-weight: 600;
		background-color: #0099cc;
		border-radius: 20px;
		padding: 8px 20px;
	}
	.cancelLec{
		color: #fff;
		font-weight: 600;
		background-color: orange;
		border-radius: 20px;
		padding: 8px 20px;
	}
	.soldOutLec{
		color: #fff;
		font-weight: 600;
		background-color: #ff6680;
		border-radius: 20px;
		padding: 8px 20px;
	}
	.endLec{
		color: #333;
		font-weight: 600;
		background-color: #e5e5e5;
		border-radius: 20px;
		padding: 8px 20px;
	}
</style>
</head>
<body>
<main class="app-content" style="background-color: #f3f3f3">
<div id="table-area" class="container-fluid">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-2">
						<form method="post"	action="<%=request.getContextPath()%>/back-end/lecture/listAllLec.jsp">
						<button class="bttn" type="submit">回列表</button>
						</form>
					</div>
                    <div class="col-sm-7">
                        <h2 class="text-center" style="font-weight: 700">單一講座查詢</h2>
                    </div>
                </div>
            </div>
 <table class="table table-bordered">
 <thead>
	<tr>
		<th>講座編號</th>
		<th>講座名稱</th>
		<th>講座票價</th>
		<th>講師姓名</th>
		<th>講座地點</th>
		<th>講座票價</th>
		<th>講座日期</th>
		<th>開始時間</th>
		<th>結束時間</th>
<!-- 		<th>開始報名</th> -->
<!-- 		<th>結束報名</th> -->
<!-- 		<th>起始座位狀態</th> -->
<!-- 		<th>目前座位狀態</th> -->
		<th>講座狀態</th>
		<th>更新時間</th>
		<th>修改</th>
	</tr>
	<tr>
			<td>${lecVO.lecno}</td>
			<td>${lecVO.lecname}</td>
			<td>${lecVO.lecprice}</td>
			<c:forEach var="spkrVO" items="${spkrSvc.list}">
                    <c:if test="${lecVO.spkrno==spkrVO.spkrno}">
	                    <td data-title="講師姓名">${spkrVO.spkrname}</td>
                    </c:if>
                </c:forEach>
			<c:forEach var="roomVO" items="${roomSvc.all}">
                    <c:if test="${lecVO.roomno==roomVO.roomno}">
	                    <td data-title="講座地點">${roomVO.roomname}</td>
                    </c:if>
                </c:forEach>
			<td>$${lecVO.lecprice}</td>
			<td><%=startdate%></td>
			<td><%=starttime%></td>
			<td><%=endtime%></td>
<%-- 			<td><%=opendate%></td> --%>
<%-- 			<td><%=closedate%></td> --%>
<%-- 			<td>${lecVO.initseat}</td> --%>
<%-- 			<td>${lecVO.currseat}</td> --%>
			<td><span class="<%=statusCss%>"><%=status%></span></td>
			<td>${lecVO.leclmod}</td>
			<td>
				<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do">
				<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
				<input type="hidden" name="lecno" value="${lecVO.lecno}">
				<input type="hidden" name="action" value="update_fromList"></form>
			</td>
	</tr>
</table>
<div id="displayInfo">
 <img src="<%=request.getContextPath()%>/lecture/picreader?lecno=${lecVO.lecno}">

        <hr>

        <!-- Post Content -->
		<%=info%>

</div>
<%-- <%@ include file="/back-end/lecture/roomsetting/singleLayout.jsp"%><br> --%>
<jsp:include page="/roomsetting/singleLayout.jsp"></jsp:include>
</div>
</div>
</div>
</main>
</body>
</html>