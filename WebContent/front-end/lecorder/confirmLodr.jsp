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
	// booking info
	String memno = request.getParameter("memno");
	String count = request.getParameter("count");
	String lecamt = request.getParameter("lecamt");
	String currseat = request.getParameter("currseat");
	String seatno = request.getParameter("seatno");
	
	// lecture info
	LecVO lecVO = (LecVO) session.getAttribute("bookingLec");
	String lecno = lecVO.getLecno();
	String roomno = lecVO.getRoomno();
	String lecname = lecVO.getLecname();
	Integer lecprice = lecVO.getLecprice();
	
	ClassroomService roomSvc = new ClassroomService();
	ClassroomVO roomVO = roomSvc.getOneClassroom(roomno);
	String roomname = roomVO.getRoomname();
	
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
<head>
<meta charset="UTF-8">
<title>Xducation - 陪你成長的學習好夥伴</title>
<style>
body{
	margin: 0;
}
	#credit-card{
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
	#padd{
	padding: 40px 0;
	background-color: #fff;
	color: #fff;
	margin-bottom: 50px;
 	} 
</style>
</head>
<body>
<div id="padd"></div>
<div class="container">
 <div class="row">
   <div id="credit-card" class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
   <%@ include file="/front-end/lecorder/creditCard.jsp"%>
   <button id="btn">+</button>
   <div style="text-align: center">
   	請再次檢查您的訂購資訊<br>
   	並於上方填寫您的信用卡資料
   	<img src="<%=request.getContextPath()%>/index/front-index/assets/img/head/cus-service.png" style="max-height: 500px; width: auto">
   </div>
   </div>
<div id="form"><form class="login-form" method="post" action="<%=request.getContextPath()%>/lecorder/lecorder.do">
講座名稱
<input style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" type="text" value="<%=lecname%>"readonly>
講座日期
<input style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" type="text" value="<%=startdate%>"readonly>
講座時間
<input style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" type="text" value="<%=starttime%> - <%=endtime%>"readonly>
講座地點
<input style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" type="text" value="<%=roomname%>教室"readonly>
訂購數量
<input style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" type="text" name="count" value="<%=count%>" readonly>
單一票價
<input style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" id="lecprice" type="text" value="<%=lecprice%>" readonly>
訂購金額
<input style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" type="text" name="lecamt" value="<%=lecamt%>" readonly>
  講座編號
  <input type="text" name="lecno" style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" value="<%=lecno%>">
  座位號碼
  <input type="text" name="seatno" style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" value="<%=seatno%>">
  <input type="hidden" name="currseat" style="background-color: #fff; border-bottom: 1px #333 solid; border-radius: 0" value="<%=currseat%>">
  <input type="hidden" name="action" value="insert">
  <input type="hidden" name="memno" value="<%=memno%>">
  <input type="submit" value="確認付款">
</form>
</div>
</div>
</div>
<!-- Bootstrap core JavaScript -->
	<%@ include file="/index/front-index/footer.jsp" %>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script>
		$("#btn").click(function(){
			$(".num").val("1111");
			$("#card-name").val("COACH ANSI");
			$("#exp").val("11/20");
			$("#cvc").val("666");
		});
	</script>
	<script src="vendor/jquery/jquery.min.js"></script>
</body>
</html>