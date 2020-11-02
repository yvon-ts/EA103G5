<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*"%>
<%@ page import="com.speaker.model.*"%>
<%@ page import="com.lecseat.model.*"%>
<!DOCTYPE html>

<%
	// 取得講座資訊
	LecVO lecVO = (LecVO) request.getAttribute("lecVO");
	String lecno = lecVO.getLecno();
	String roomno = lecVO.getRoomno();
	String spkrno = lecVO.getSpkrno();
	
	// 登入檢查
	String memno = "";
	MembersVO memVO = (MembersVO)session.getAttribute("loginMembersVO");
	if (memVO != null){
		memno = memVO.getMemno();
		System.out.println("frontOneLec的memno="+ memno);
	} else {
		memno = "";
		System.out.println("frontOneLec memno= == null");
	}
	
	// 已購數量檢查
	boolean canBuy = false;
	int availableSeats = 0;
	
	LecseatService seatSvc = new LecseatService();
	int seatCount = seatSvc.hasBooked(memno, lecno);
	System.out.println("seatCount=" + seatCount);
	
	if (seatCount == 0){
		canBuy = true;
		availableSeats = 4;
	}
	else if (seatCount > 0 && seatCount < 4){
		canBuy = true;
		availableSeats = 4 - seatCount;
	}
	else{
		canBuy = false;
		availableSeats = 0;
	}
	System.out.println(memno + "尚可購買數量=" + availableSeats);
	
	ClassroomService roomSvc = new ClassroomService();
	ClassroomVO roomVO = roomSvc.getOneClassroom(roomno);
	
	SpkrService spkrSvc = new SpkrService();
	SpkrVO spkrVO = spkrSvc.getOne(lecVO.getSpkrno());
	String spkrname = spkrVO.getSpkrname();
	
	String roomname = roomVO.getRoomname();
	session.setAttribute("bookingLec", lecVO);
	session.setAttribute("roomname", roomname);
	session.setAttribute("spkrname", spkrname);
	
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
	
	//CKeditor - Bytes to String
	String spkrinfo = "講師資訊更新中";
	try{
		byte[] b = spkrVO.getSpkrinfo();
		spkrinfo = new String(b);
	} catch (Exception e){
		spkrinfo = "講師資訊更新中";
	}
	
	String lecinfo = "講座資訊更新中";
	try{
		byte[] b = lecVO.getLecinfo();
		lecinfo = new String(b);
	} catch (Exception e){
		lecinfo = "講座資訊更新中";
	}
%>

<html lang="en">

<head>

<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/main.css"> --%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css"> --%>
<%@ include file="/index/front-index/header.jsp" %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Blog Post - Start Bootstrap Template</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/blog-post.css" rel="stylesheet">
<style>
	.img-border{
		border: 2px solid #999;
		width: 100px;
		height: 100px;
	}
	.common{
		background-color: #0099cc;
		color: #fff;
		border-radius: 30px;
		padding: 5px 30px
	}
	.border{
		background-color: #0099cc;
		color: #0099cc;
		border-radius: 30px;
		padding: 5px 30px
	}
</style>
</head>

<body>
 <!-- Header Area wrapper Starts -->
    <header id="header-wrap">
       
        <!-- Hero Area Start -->
        <div id="hero-area" class="hero-area-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                        <div class="contents">
                            <div class="about-wrapper wow fadeInLeft" data-wow-delay="0.3s">
                                <h2 class="head-title">Xducation 名人講座</h2>
                                <i class="lni-rocket"></i>&emsp;達人不藏私 x 面對面交流<br>
                                <i class="lni-rocket"></i>&emsp;來聽各行各業你最想知道的事<br>
                            </div>
                            <br>
                            <div class="about-wrapper wow fadeInLeft" data-wow-delay="0.4s">
                                <div id="search">
                                    <table id="searchbox">
                                        <tr>
                                            <td><i class="lni-search"></i></td>
                                            <td>
                                                <input type="text" size="30" placeholder="&nbsp;&nbsp;今天想學什麼呢？">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                 <div class="header-button">
                                    <a id="common" href="<%=request.getContextPath()%>/front-end/lecture/listAllLec.jsp" class="btn btn-common" style="background-color: #0099cc;color: #fff;border-radius: 30px;padding: 5px 30px">搜尋講座</a>
                                    <a id="border" href="<%=request.getContextPath()%>/front-end/lecture/listAllLec.jsp" class="btn btn-border" style="background-color: #fff;border: 1px solid #0099cc;color: #0099cc;border-radius: 30px;padding: 5px 30px">查看全部</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                        <div class="about-wrapper wow fadeInRight" data-wow-delay="0.3s">
                            <div id="introimg">
                                <img class="img-fluid" src="<%=request.getContextPath() %>/index/front-index/assets/img/head/lecture.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <!-- Hero Area End -->
    </header>
    <!-- Header Area wrapper End -->
  <!-- Page Content -->
  <div class="container">

    <div class="row">

      <!-- Post Content Column -->
      <div class="col-lg-8">

        <!-- Title -->
        <h1 class="mt-4" style="font-weight: 700">${lecVO.lecname}</h1>

        <!-- Author -->
       <div class="media mt-4">
              <img class="d-flex mr-3 rounded-circle img-border" src="<%=request.getContextPath()%>/speaker/iconreader?spkrno=<%=spkrno%>" alt="">
              <div class="media-body">
                <h5 class="mt-0" style="font-weight: 600"><%=spkrname%></h5>
                <%=spkrinfo %>
              </div>
            </div>
        <hr>

        <!-- Date/Time -->
        <p>Xducation 帶給您最優質的講座內容</p>

        <hr>

        <!-- Preview Image -->
         <img src="<%=request.getContextPath()%>/lecture/picreader?lecno=${lecVO.lecno}">

        <hr>

        <!-- Post Content -->
        <p class="lead">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus, vero, obcaecati, aut, error quam sapiente nemo saepe quibusdam sit excepturi nam quia corporis eligendi eos magni recusandae laborum minus inventore?</p>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut, tenetur natus doloremque laborum quos iste ipsum rerum obcaecati impedit odit illo dolorum ab tempora nihil dicta earum fugiat. Temporibus, voluptatibus.</p>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eos, doloribus, dolorem iusto blanditiis unde eius illum consequuntur neque dicta incidunt ullam ea hic porro optio ratione repellat perspiciatis. Enim, iure!</p>

        <blockquote class="blockquote">
          <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
          <footer class="blockquote-footer">Someone famous in
            <cite title="Source Title">Source Title</cite>
          </footer>
        </blockquote>
		<%=lecinfo%>
        <hr>

        <!-- Comment with nested comments -->
        <div class="media mb-4">
          <div class="media-body">
            <%@ include file="/calendar/calendar.jsp" %>
          </div>
        </div>

      </div>

      <!-- Sidebar Widgets Column -->
      <div class="col-md-4">

        <!-- Search Widget -->
        <div class="card my-4">
          <h5 class="card-header">Search</h5>
          <div class="card-body">
            <div class="input-group">
              <form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do">
              <span class="input-group-append">
              <input type="hidden" name="action" value="bookOne">
              <input type="hidden" name="lecno" value="${lecVO.lecno}">
              <input type="hidden" name="availableSeats" value="<%=availableSeats%>">
                <button id="bookASeat" class="btn btn-secondary" type="submit">我要訂票</button>
                </span>
                </form>
            </div>
          </div>
        </div>

        <!-- Categories Widget -->
        <div class="card my-4">
          <h5 class="card-header">Search</h5>
          <div class="card-body">
            <div class="input-group">
              <form method="post"	action="<%=request.getContextPath()%>/front-end/lecorder/listByMemno.jsp">
              <span class="input-group-append">
              <input type="hidden" name="memno" value="<%=memno%>"><br>
                <button id="viewOrders" class="btn btn-secondary" type="submit">查看我的講座清單</button>
                </span>
                </form>
            </div>
          </div>
        </div>

        <!-- Side Widget -->
        <div class="card my-4">
          <h5 class="card-header">Side Widget</h5>
          <div class="card-body">
            <%@ include file="/roomsetting/singleLayout.jsp"%>
          </div>
        </div>

      </div>

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<%@ include file="/index/front-index/footer.jsp" %>

<script>
var memno = "<%=memno%>";
$("#bookASeat").mousedown(function(e){
	if (memno.length == 0){
		e.preventDefault();
		alert("請先登入");
	} else if (<%=canBuy%> === false){
		e.preventDefault();
		alert("您已達到購買數量上限");
	}
});
$("#viewOrders").mousedown(function(e){
	if (memno.length == 0){
		e.preventDefault();
		alert("請先登入");
	}
});


</script>

</body>

</html>
