<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.classroom.model.*"%>
<%@ page import="com.lecture.model.*"%>

<%
	LecVO lecVO = (LecVO) request.getAttribute("lecVO");
	String lecno = lecVO.getLecno();
	String roomno = lecVO.getRoomno();
	
	ClassroomService roomSvc = new ClassroomService();
	ClassroomVO roomVO = roomSvc.getOneClassroom(roomno);
	
	String roomname = roomVO.getRoomname();
	session.setAttribute("bookingLec", lecVO);
	
	// date time formatter
	Timestamp lecstart = lecVO.getLecstart();
	Timestamp lecend = lecVO.getLecend();
	String startdate = "";
	String starttime = "";
	String endtime = "";
	DateFormat fmtdate = new SimpleDateFormat("yyyy/MM/dd");
	DateFormat fmttime = new SimpleDateFormat("HH:mm");
	startdate = fmtdate.format(lecstart);
	starttime = fmttime.format(lecstart);
	endtime = fmttime.format(lecend);
%>

<!DOCTYPE html>
<html>
<%@ include file="/index/front-index/header.jsp" %>
<link href="<%=request.getContextPath()%>/front-end/lecture/listOneLec/vendor/bootstrap/css/bootstrap-grid.min.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/front-end/lecorder/css/addLodr.css" rel="stylesheet" />
<head>
<meta charset="UTF-8">
<title>Xducation - 陪你成長的學習好夥伴</title>
<style>
body{
	margin: 0;
}
</style>
</head>
<body>
<div id="padd"></div>
<form class="login-form" method="post" action="<%=request.getContextPath()%>/front-end/lecorder/confirmLodr.jsp">
<div class="container">
	<div class="row">
   		<div id="info-part" class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
    		<img src="<%=request.getContextPath()%>/lecture/picreader?lecno=${lecVO.lecno}">
    		<br>
    		<br>
    		請依下方黃色區塊選擇您的座位<br>
    		（每位會員僅限購四個座位）
    		<%@ include file="/front-end/lecorder/bookingSeats.jsp"%>
  		</div> 
<%--    <%@ include file="/calendar/calendar.jsp" %> --%>
		<div id="form" class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
		<h1 style="color: #333">${lecVO.lecname}</h1>
    		
				講座日期<br>
				&nbsp;<input class="txt" type="text" value="<%=startdate%>"readonly><br>
				講座時間：<br>&nbsp;<input class="txt" type="text" value="<%=starttime%> - <%=endtime%>"readonly><br>
				講座地點：<br>&nbsp;<input class="txt" type="text" value="<%=roomname%>教室"readonly><br>
				訂購數量：<br>&nbsp;<input class="txt" id="count" type="text" name="count" readonly><br>
				單一票價：<br>$<input class="txt" id="lecprice" type="text" name="lecprice" value="${lecVO.lecprice}" readonly><br>
				金額小計：<br>$<input class="txt" id="lecamt" type="text" name="lecamt" readonly><br>
				付款方式：&nbsp;<input type="radio" style="width: 20px"checked>&nbsp;信用卡
			
				會員編號：<input type="text" name="memno">
				<input id="submit" type="submit" value="確認付款">
  				<input type="hidden" name="lecno" value="<%=lecno%>">
			</div>
 	</div>
</div>
</form>
<!-- Bootstrap core JavaScript -->
<%@ include file="/index/front-index/footer.jsp" %>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script>
	$("#submit").mousedown(function() {
	    var arr = document.getElementsByClassName("chosen");
	    let txt = "";
	    if (arr.length > 0) {
	        for (let i = 0; i < arr.length; i++) {
	            txt += arr[i].textContent + " ";
	        }
	    }
	    var input = document.createElement("input");
	    input.value = txt;
	    input.setAttribute("name", "seatno");
	    input.setAttribute("type", "hidden");
	    $("#lecamt").append(input);
	});
	
	</script>
</body>
</html>