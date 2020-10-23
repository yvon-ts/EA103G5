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
	
	//日期設定
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
<link href="<%=request.getContextPath()%>/front-end/lecture/listOneLec/vendor/bootstrap/css/bootstrap-grid.min.css" rel="stylesheet" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#calendar{
		background-color: #fff;
		padding: 30px;
		border-radius: 2%;
	}
html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
input{
  display:block;
  width:100%;
  padding:.2em;
  margin: .2em 0 .6em;
  font-size:1.2em;
}
input[type=submit]{
  background: #6699cc;
  border:none;
  margin:1em 0;
  color:white;
  padding:1em;
}
.message{
  background: #333;
  padding: 1em .5em;
  margin: 1em 0;
}
/* Presentational for this pen */
html{
  background: #F3F3F3;
}
#form{
  padding:5%;
  background: white;
  max-width:30em;
  margin: 6% auto;
  box-shadow:1em 1em 0 0 rgba(0,0,0,.2);
  font-family:Raleway, sans-serif;
}
</style>
</head>
<body>
<div class="container">
 <div class="row">
   <div id="calendar" class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
    <img src="<%=request.getContextPath()%>/lecture/picreader?lecno=${lecVO.lecno}">
    <h1>${lecVO.lecname}</h1>
    <ul>
	<li>講座日期：<%=startdate%></li>
	<li>講座時間：<%=starttime%> - <%=endtime%></li>
	<li>講座地點：<%=roomname%>教室</li>
	<li>講座票價：<span id="lecprice">${lecVO.lecprice}</span>元/人</li>
</ul>
  付款方式：<input type="radio" checked>信用卡<br>
  訂購數量：<input id="count" type="text" name="count" readonly>
  
  <input id="lecamt" type="text" name="lecamt" readonly>
    
<%--    <%@ include file="/calendar/calendar.jsp" %> --%>
   </div>
<div id="form"><form class="login-form" method="post" action="<%=request.getContextPath()%>/front-end/lecorder/confirmLodr.jsp">

<%@ include file="/front-end/lecorder/bookingSeats.jsp"%>

  <label>會員編號</label>
  <input type="text" name="memno">

  <input id="submit" type="submit" value="確認付款">
  <input type="hidden" name="lecno" value="<%=lecno%>">
   <div>
   
   </div>
</form>
</div>
</div>
</div>
<!-- Bootstrap core JavaScript -->
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