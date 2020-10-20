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
	String startmonth = "";
	String starttime = "";
%>

<html>
<head>
<%@ include file="/index/front-index/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/lecAll.css">
<title>listAlllec.jsp</title>
<style>
	h1{
		margin-top: 150px;
		margin-left: 400px;
	}
	#include{
		margin-left: 400px;
		padding: 30px;
		background-color: #F3F3F3;
		border-radius: 1%;
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
                                    <a href="#" class="btn btn-common">探索課程</a>
                                    <a href="#" class="btn btn-border video-popup">我要註冊</a>
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

    <!-- Features Section Start -->
    <%@ include file="/back-end/pool/page1.file" %>
    <section id="features" class="section-padding">
        <div class="container">
            <div class="section-header text-center">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="lni-rocket"></i> 名人講座</h2>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="content-left">
                        <div class="wow fadeInLeft" data-wow-delay="0.3s">
                        <% int listindex = 0; %>
	<c:forEach var="lecVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	<%
			//時間設定
			LecVO lecVO = list.get(listindex + pageIndex);
			Timestamp lecstart = lecVO.getLecstart();
			SimpleDateFormat fmtdate = new SimpleDateFormat("dd");
			SimpleDateFormat fmtmonth = new SimpleDateFormat("MMM");
			SimpleDateFormat fmttime = new SimpleDateFormat("HH:mm");
			startdate = fmtdate.format(lecstart);
			startmonth = fmtmonth.format(lecstart);
			starttime = fmttime.format(lecstart);
		%>
   <div class="div col-lg-9 col-md-12 col-sm-12 col-xs-12 box-item wow fadeInLeft" data-wow-delay="0.3s">
        <div class="daydiv">
            <span class="date"><%=startdate%></span><br>
            <span class="month"><%=startmonth%></span><br>
            <span class="time"><%=starttime%></span><br>
        </div>
        <div class="pic">
            <img src="<%=request.getContextPath()%>/index/front-index/assets/img/course/img1.jpg">
        </div>
        <div class="lec-txt">
        	<p class="title">${lecVO.lecname}</p><br>
        	<p class="ctnt">ANTICO FORNO主廚吳治君<br>現場示範3道義式經典料理 X 義大利飲食文化</p>
        </div>
        <div class="more">
        	<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
        		<input type="submit" value="我有興趣">
        		<input type="hidden" name="lecno" value="${lecVO.lecno}">
        		<input type="hidden" name="action" value="frontOne">
        	</form>
        </div>
    </div>
    <% listindex++;%>
    </c:forEach>
                    </div>
                </div>
                <!-- 講座區圖片 
                <div class="col-lg-5 col-md-12 col-sm-12 col-xs-12">
                    <div class="show-box wow fadeInUp" data-wow-delay="0.3s">
                        <img src="<%=request.getContextPath() %>/index/front-index/assets/img/head/calendar.gif" alt="">
                    </div>
                </div>-->
            </div>
        </div>
        </div>
    </section>
    <!-- Features Section End -->

    <!-- Footer Section Start -->
    
    <!-- Footer Section End -->
	
	<%@ include file="/back-end/pool/page2.file" %>
	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/select_page.jsp">
	<input type="submit" value="回首頁"></form>
	<%@ include file="/index/front-index/footer.jsp" %>
</body>
</html>

