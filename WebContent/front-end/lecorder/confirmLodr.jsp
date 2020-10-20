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
	//訂購資訊
	String memno = request.getParameter("memno");
	String count = request.getParameter("count");
	String lecamt = request.getParameter("lecamt");
	String currseat = request.getParameter("currseat");
	String seatno = request.getParameter("seatno");
	
	//講座資訊
	LecVO lecVO = (LecVO) session.getAttribute("bookingLec");
	String lecno = lecVO.getLecno();
	String roomno = lecVO.getRoomno();
	ClassroomService roomSvc = new ClassroomService();
	ClassroomVO roomVO = roomSvc.getOneClassroom(roomno);
	String roomname = roomVO.getRoomname();
	
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
   信用卡模板
   </div>
<div id="form"><form class="login-form" method="post" action="<%=request.getContextPath()%>/lecorder/lecorder.do">
<h1>${lecVO.lecname}</h1>
<ul>
	<li>講座日期：<%=startdate%></li>
	<li>講座時間：<%=starttime%> - <%=endtime%></li>
	<li>講座地點：<%=roomname%>教室</li>
	<li>講座票價：<span id="lecprice">${lecVO.lecprice}</span>元/人</li>
	<li>訂購數量：<input type="text" name="count" value="<%=count%>" readonly></li>
	<li>訂購金額：<input type="text" name="lecamt" value="<%=lecamt%>" readonly></li>
	
</ul>
  <label>會員編號</label>
  <input type="text" name="memno" value="<%=memno%>">

  <input type="submit" value="確認付款">
  講座編號<input type="text" name="lecno" value="<%=lecno%>">
  座位<input type="text" name="currseat" value="<%=currseat%>">
  座位號碼<input type="text" name="seatno" value="<%=seatno%>">
  <input type="hidden" name="action" value="insert">
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
	</script>
</body>
</html>