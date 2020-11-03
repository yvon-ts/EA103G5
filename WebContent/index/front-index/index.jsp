<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*"%>
<%@ page import="com.speaker.model.*"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>
<%@ page import="com.course_assess.model.*"%>
<%@ page import="com.course.model.*"%>



<!DOCTYPE html>
<jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />

<%	LecService lecSvc = new LecService();
	List<LecVO> list = lecSvc.getList();
	pageContext.setAttribute("list", list);
	
	String startdate = "";
	String startmonth = "";
	String starttime = "";
	String lecinfo = "";
	String spkrname = "";
	
	
	
	
%>

<jsp:useBean id="CourseSvc" scope="page" class="com.course.model.CourseService" />

<html lang="en">
<head>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"> -->
<!-- </script> -->
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Xducation - 陪你成長的學習好夥伴</title>
	<!-- Sweet Alert -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"></script>
	<!-- toastr -->
	 <link rel="stylesheet" href="<%=request.getContextPath()%>/library/toastr-master/build/toastr.min.css">
	
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/bootstrap.min.css">
    <!-- Icon -->
   	<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/back-end/login/logincss/images/icons/logo.svg"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/fonts/line-icons.css">
    <!-- Owl carousel -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/owl.theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/nivo-lightbox.css">
    <!-- Animate -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/animate.css">
    <!-- Main Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/main.css">
    <!-- Responsive Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/responsive.css">
	<!-- Lecture css -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/lecAll.css">
    <!-- Font Awesome
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">-->
     <!-- rateit css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
	
	<style>
	.scrollable-dropdown{
	    height: auto;
	    max-height:320px;  /* Increase / Decrease value as per your need */
	    overflow-x: hidden;
	}
	
	img.img-fluid{
		transform-origin: 70% 88%;
	    animation: hand 2s infinite;
	    animation-delay: 1s;
		border-radius:10px;
	}

	@keyframes hand {
		0% { transform: rotate(0deg); }
		50% { transform: rotate(5deg) }
		100% { transform: rotate(0deg); }
	}
	img#nav_icon{
	width:36px;
	height:36px;
	}
	img.icon{
	width:30px;
	height:30px;
	}
	
	.star{
	width:20px;
	height:20px;
	}
	.owl-carousel .owl-item img {
	    display: block;
	    width:auto;
	}
	
/* 	星星用css */
	.rateit .rateit-preset {
	color: #FFCC36;
	background:
		url(https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/star.gif)
		left -32px !important;
	}
	
	</style>
</head>

<body onload="connect();" onunload="disconnect();">
    <!-- Header Area wrapper Starts -->
    <header id="header-wrap">
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar">
            <div class="container">
                <a href="<%=request.getContextPath()%>/index/front-index/index.jsp" class="navbar-brand"><img src="<%=request.getContextPath()%>/index/front-index/assets/img/logo.svg" alt="">
                    <div id="logo">Xducation</div>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
                    aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="lni-menu"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav mr-auto w-100 justify-content-end clearfix">
                        <li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/tracking_list/listTrackingListForUser.jsp">
							購物車&nbsp;<img class="icon"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/shopping-cart.svg'>
							
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp">
							搜尋課程&nbsp;<img class="icon"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/search.svg'>
							
					</a></li>
					<c:if test="${not empty sessionScope.loginMembersVO}">
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/course/listMyCourse.jsp">
							我的課程&nbsp;<img class="icon"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/mycourse.svg'>
							
					</a></li>
					</c:if>
					
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/lecture/listAllLec.jsp">
							名人講座&nbsp;<img class="icon"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/influencer.svg'>
							
					</a></li>
					<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/front-end/course/addCourse.jsp">
								我要開課&nbsp;<img class="icon"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/opencourse.svg'>
							
						</a></li>
					</c:if>

					<c:if test="${not empty sessionScope.loginMembersVO}">
						<li class="nav-item">
							<div class="dropdown" id="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button"
									id="dropdownMenuButton" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false">
									${sessionScope.loginMembersVO.memname}</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									<a class="dropdown-item"
										href="<%=request.getContextPath()%>/front-end/members/updateMembersV2.jsp">個人檔案</a>

									<a class="dropdown-item"
										href='<%=request.getContextPath()%>/front-end/Order_Master/listAllByMemno.jsp'>課程訂單紀錄</a>
										
									<a class="dropdown-item"
										href='<%=request.getContextPath()%>/front-end/lecorder/listByMemno.jsp'>講座訂單紀錄</a>

									<a class="dropdown-item"
										href='<%=request.getContextPath()%>/front-end/coup_code/listAllByMemno.jsp'>持有折扣券</a>


									<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '待審核'}">
										<a class="dropdown-item" onclick="status()">老師檔案</a>

									</c:if>
									<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherDisplay.jsp">老師檔案</a>

									</c:if>
									<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '未通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherUpdate.jsp">老師檔案</a>

									</c:if>
									<c:if test="${not empty sessionScope.loginMembersVO}">
										<a class="dropdown-item"
											href='<%=request.getContextPath()%>/members/members.do?action=signout'>會員登出</a>
									</c:if>

								</div>
							</div>
						</li>

					</c:if>
					<c:if test="${not empty sessionScope.loginMembersVO.memno}">
						<c:if test="${empty teacherSvc.getStatus(sessionScope.loginMembersVO.memno)}">
							<img id="nav_icon"
								src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
						</c:if>
						<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '待審核'}">
							<img id="nav_icon"
								src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
						</c:if>
						<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
							<img id="nav_icon"
								src='<%=request.getContextPath()%>/front-end/members/assets/img/teacher.svg'>
						</c:if>
						<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '未通過'}">
							<img id="nav_icon"
								src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
						</c:if>
					</c:if>

					<c:if test="${empty sessionScope.loginMembersVO}">
						<li class="nav-item"><a class='nav-link'
							href='<%=request.getContextPath()%>/front-end/members/signIn.jsp'>我要登入&nbsp;<img class="icon" src='<%=request.getContextPath()%>/index/front-index/assets/img/login.svg'>
							</a>
						</li>
					</c:if>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <!-- Hero Area Start -->
        <div id="hero-area" class="hero-area-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 col-md-12 col-sm-12 col-xs-12">
                        <div class="contents">
                            <div class="about-wrapper wow fadeInLeft" data-wow-delay="0.3s">
                                <h2 class="head-title">陪你成長的學習好夥伴</h2>
                                <img class="icon" src="<%=request.getContextPath()%>/front-end/members/assets/img/rocket.png" alt="">&nbsp;
                                Xducation - 最有趣的線上學習平台
                            </div>
                            <br>
                            <div class="about-wrapper wow fadeInLeft" data-wow-delay="0.4s">
                            <form action ="<%=request.getContextPath()%>/course/coursesearch.do" method="post" id="searchForm">
                                <div id="search">
                                    <table id="searchbox">
                                        <tr>
                                        	
                                            <td><i class="lni-search"></i></td>
                                            <td>
                                                <input type="text" size="30" placeholder="&nbsp;&nbsp;今天想學什麼呢？"  name="searchText">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="header-button">
                                    <button class="btn btn-common">探索課程</button>
                                    <input type="hidden" name="action" value="search"/>
                                    <a href="<%=request.getContextPath()%>/front-end/members/addMembersV2.jsp" class="btn btn-border video-popup">我要註冊</a>
                                </div>
                             </form>   
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 col-md-12 col-sm-12 col-xs-12">
                        <div class="about-wrapper wow fadeInRight" data-wow-delay="0.3s">
                            <div id="introimg">
                
                                <img class="img-fluid" src="<%=request.getContextPath()%>/index/front-index/assets/img/head/intro1.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Hero Area End -->
    </header>
    <!-- Header Area wrapper End -->
    <!-- Services Section Start -->
    <section id="services" class="section-padding">
        <div class="container">
            <div class="section-header text-center">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="lni-rocket"></i> 精選課程</h2>
                <div class="shape wow fadeInDown" data-wow-delay="0.3s"></div>
            </div>
            <div class="row">
            	
              <c:forEach var="courseVO" items="${CourseSvc.max}">
							<div class="col-md-6 col-lg-3 col-xs-12">
								<div class="services-item wow fadeInRight" data-wow-delay="0.3s">
									<a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=${courseVO.courseno}">
									<div class="icon">
										<!-- 顯鈞：替換成新版本讀圖測試2020/10/22 -->
										<%-- <img src="<%=request.getContextPath()%>/course/coursephoto.do?action=searchPhoto&courseno=${courseVO.courseno}" style="width:200px;height:150px" class="pic"> --%>
										<%-- <img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" style="width: 200px; height: 150px;" class="pic"> --%>
										<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" style="max-width: 100%; height: 150px;" class="pic">
                        			</div>
                        			<div class="services-content">
<!--                         	 -->
                        	&nbsp;&nbsp;&nbsp;<div class="rateit" data-rateit-value="${courseVO.csscore / courseVO.csscoretimes }" data-rateit-ispreset="true" data-rateit-readonly="true"></div> 
                        	<br>&nbsp;&nbsp;&nbsp;${courseVO.csscoretimes}則評價
                        	<h3 style="line-height:40px;">${courseVO.coursename}</h3></a>
<%--                             <h3><a href="<%=request.getContextPath()%>/course/course.do?action=getOne_For_Display&courseno=${courseVO.courseno}">${courseVO.coursename}</a></h3> --%>
                            
							<!-- 將課程總時數換算為分鐘 -->
							<% Integer ttltimeInMin = ((CourseVO)pageContext.getAttribute("courseVO")).getTtltime()/60; %>                            
                            <p>課程總長 <%= ttltimeInMin %> 分鐘</p>
							

								
                           <h5>NT$${courseVO.courseprice}</h5>
                        	
                        </div>
                    </div>
                </div>
                
                </c:forEach>
              
            </div>
        </div>
    </section>
    <!-- Services Section End -->
    <!-- About Section start -->
    <div class="about-area section-padding bg-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-12 col-xs-12 wow fadeInLeft" data-wow-delay="0.3s">
                    <img class="img-fluid" src="<%=request.getContextPath()%>/index/front-index/assets/img/head/tchr.png" alt="">
                </div>
                <div class="col-lg-1 col-md-12 col-xs-12"></div>
                <div class="col-lg-5 col-md-12 col-xs-12 info">
                    <div class="about-wrapper wow fadeInRight" data-wow-delay="0.3s">
                        <div>
                            <div class="site-heading">
                                <h2 class="section-title">成為我們的老師</h2>
                            </div>
                            <div class="content">
                                <p>
                                    V&emsp;分享您的才華<br>
                                    V&emsp;創造被動收入<br>
                                    V&emsp;自我激勵成長
                                </p>
                                <a href="<%=request.getContextPath()%>/front-end/teacher/teacherIndex.jsp" class="btn btn-common mt-3">我想瞭解</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- About Section End -->
    <!-- Features Section Start -->
    <%@ include file="/index/front-index/assets/lecpage1.file" %>
    <section id="features" class="section-padding">
        <div class="container">
            <div class="section-header text-center">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="lni-rocket"></i> 名人講座</h2>
                <div class="shape wow fadeInDown" data-wow-delay="0.3s"></div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div>
                        
                       
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
			//講者姓名
			SpkrService spkrSvc = new SpkrService();
			SpkrVO spkrVO = spkrSvc.getOne(lecVO.getSpkrno());
			spkrname = spkrVO.getSpkrname();
			//講座資訊
			lecinfo = "講座資訊更新中";
				try{
					//CKeditor - Bytes to String
					byte[] b = lecVO.getLecinfo();
					if (b != null) {
						String bString = new String(b);
						lecinfo = bString.substring(0, 23);
					} else {
						System.out.println("b is null");
					}
				} catch (Exception e){
					lecinfo = "講座資訊更新中";
					e.printStackTrace();
				}
			
		%>
		<div class="div col-lg-1 col-md-12 col-sm-12 col-xs-12"></div>
<div class="div col-lg-10 col-md-12 col-sm-12 col-xs-12 box-item wow fadeInLeft" data-wow-delay="0.3s">
        <div class="daydiv">
            <span class="date"><%=startdate%></span><br>
            <span class="month"><%=startmonth%></span><br>
            <span class="time"><%=starttime%></span><br>
        </div>
        <div class="pic">
            <img src="<%=request.getContextPath()%>/lecture/picreader?lecno=${lecVO.lecno}">
        </div>
        <div class="lec-txt">
        	<p class="title">${lecVO.lecname}</p><br>
        	<p class="spkr">【<%=spkrname%>】</p>
        	<p class="info"><%=lecinfo%></p>
        	<p><span class="price">NT$${lecVO.lecprice}</span></p>
        </div>
        <div class="more">
        	<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
        		<input type="submit" class="btn btn-common" value="我有興趣">
        		<input type="hidden" name="lecno" value="${lecVO.lecno}">
        		<input type="hidden" name="action" value="frontOne">
        	</form>
        </div>
    </div>
    <% listindex++;%>
    </c:forEach>
                <!-- 講座區圖片 -->
                <div class="row">
                <div class="col-lg-3 col-md-12 col-sm-12 col-xs-12">
                </div>
                <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                    <div class="show-box wow fadeInUp" data-wow-delay="0.3s">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/index/front-index/assets/img/head/lecture.png" alt="">
                    </div>
                </div>
                </div>
            </div>
        </div>
        </div>
        </div>
    </section>
    <!-- Features Section End -->
    <!-- Testimonial Section Start -->
    <%
    Course_assessService course_assessSvc = new Course_assessService();
    List<Course_assessVO> course_assesslist = course_assessSvc.getAll("COUR0001");
    pageContext.setAttribute("course_assesslist", course_assesslist);
    pageContext.setAttribute("course_assessSvc",course_assessSvc);
    %>
    <jsp:useBean id="membersSvc" scope="page" class="com.members.model.MembersService" />
    
    <section id="testimonial" class="testimonial section-padding">
        <div class="container">
            <div class="section-header text-center">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s" style="color: #fff"><i
                        class="lni-rocket"></i>&nbsp;好評大聲說</h2>
                <div class="shape wow fadeInDown" data-wow-delay="0.3s"></div>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div id="testimonials" class="owl-carousel wow fadeInUp" data-wow-delay="1.2s">
                        
                        
                        
                       <c:forEach var="course_assessVO" items="${course_assesslist}" varStatus="s">
                        
                        <div class="item">
                            <div class="testimonial-item" style="height:350px;">
                                <div class="img-thumb">
                                <img style="border-radius:50%;width:100px;height:100px;" src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${course_assessVO.memno}" alt="sing up image">
                                </div>
                                <div class="info">
                                
                                
                                    <h2><a href="#">${membersSvc.getOneMembers(course_assessVO.memno).memname}</a></h2>
                                    <h3><a href="#">${membersSvc.getOneMembers(course_assessVO.memno).nkname}</a></h3>
                                </div>
                                <div class="content">
                                    <p class="description">${course_assessVO.comments}</p>
                                    <div>
                                    <table>
                                    <tr>
                                    <c:forEach var="num" begin="1" end="${course_assessVO.coursescore}" step="1">
                                    <td><img class="star" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/star.svg"></td>
                                     </c:forEach> 
                                    
                                    
                                    </tr>
                                    
                                    </table>
                                         
                                         
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                        
                        
                        
                          </c:forEach>
                        
                        <%-- <div class="item">
                            <div class="testimonial-item">
                                <div class="img-thumb">
                                    <img src="<%=request.getContextPath()%>/index/front-index/assets/img/testimonial/img3.jpg" alt="">
                                </div>
                                <div class="info">
                                    <h2><a href="#">Dommini Albert</a></h2>
                                    <h3><a href="#">Nesnal Design co.</a></h3>
                                </div>
                                <div class="content">
                                    <p class="description">Praesent cursus nulla non arcu tempor, ut egestas elit
                                        tempus. In ac ex fermentum, gravida felis nec, tincidunt ligula.</p>
                                    <div class="star-icon mt-3">
                                        <span><i class="lni-star-filled"></i></span>
                                        <span><i class="lni-star-filled"></i></span>
                                        <span><i class="lni-star-filled"></i></span>
                                        <span><i class="lni-star-filled"></i></span>
                                        <span><i class="lni-star-half"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>  --%>
                        
                        
                        <%-- <div class="item">
                            <div class="testimonial-item">
                                <div class="img-thumb">
                                    <img src="<%=request.getContextPath()%>/index/front-index/assets/img/testimonial/img4.jpg" alt="">
                                </div>
                                <div class="info">
                                    <h2><a href="#">Fernanda Anaya</a></h2>
                                    <h3><a href="#">Developer</a></h3>
                                </div>
                                <div class="content">
                                    <p class="description">Praesent cursus nulla non arcu tempor, ut egestas elit
                                        tempus. In ac ex fermentum, gravida felis nec, tincidunt ligula.</p>
                                    <div class="star-icon mt-3">
                                        <span><i class="lni-star-filled"></i></span>
                                        <span><i class="lni-star-filled"></i></span>
                                        <span><i class="lni-star-half"></i></span>
                                        <span><i class="lni-star-half"></i></span>
                                        <span><i class="lni-star-half"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div> --%>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Testimonial Section End -->
    <!-- Footer Section Start -->
    <footer id="footer" class="footer-area section-padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 col-mb-1">
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 col-mb-12">
                    <div class="widget" style="text-align: center">
                        <img id="backIndex" src="<%=request.getContextPath()%>/index/front-index/assets/img/logo.svg" style="width: 100px; height: auto" alt="">
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                    <h3 class="footer-titel">關於我們</h3>
                    常見問題<br>
                    隱私政策<br>
                    功能更新
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                    <h3 class="footer-titel">其他服務</h3>
                    企業方案<br>
                    異業合作<br>
                    廣告洽談
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                    <h3 class="footer-titel">網站地圖</h3>
                    精選課程<br>
                    名人講座<br>
                    老師功能
                </div>
            </div>
        </div>
        <div class="col-md-12" style="padding-bottom: 100px">
        </div>
	
    </footer>
    <!-- Footer Section End -->
    <!-- Go to Top Link -->
    <a href="#" class="back-to-top">
        <i class="lni-comments"></i>
    </a>
    <!-- Preloader -->
    <div id="preloader">
        <div class="loader" id="loader-1"></div>
    </div>
    <!-- End Preloader -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
     <!-- toastr -->
	<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
    <script src="<%=request.getContextPath()%>/library/toastr-master/build/toastr.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery-min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/popper.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/wow.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.nav.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/scrolling-nav.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.easing.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.counterup.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/waypoints.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/main.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
    
    <script>
    
    
    /*-------Kyle-------*/
    var inform2 = '${inform2}';
	if(inform2 ==='200'){
		swal('註冊失敗', '可以再考慮一下嗎?', 'error');
	}else if(inform2 ==='100'){
		swal('登入成功', '準備好要來一場線上學習之旅了嗎?', 'success');
	}else if(inform2 ==='300'){
		swal('登出成功', '我們會一直在這裡等您回來<br>一起學習!', 'success');
	}
	function status(){
		 swal('老師資格審核中', '請耐心等候1~3個工作天，一但審核完畢，即會立刻通知', 'info');
	}
	var MyPoint = "/NotifyWS/${sessionScope.loginMembersVO.memno}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	var webSocket;

	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);	

		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			
		};
		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			if("chat" === jsonObj.type){
				var message = jsonObj.message;
				toastr.info(message);
			}
		}
		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	function disconnect() {
		webSocket.close();
		
	}
	
	
	/*-------Link to Back Index-------*/
	
	
	$("#backIndex").click(function(){
		window.location.href = "<%=request.getContextPath()%>/back-end/index/homepage.jsp";
	});
	
	
	
	
	/*-------星星-------*/
	$("div.rateit, span.rateit").rateit()
	
	
	
	
	
	
	
	
	
	
	
	
    </script>
    
</body>
	
</html>