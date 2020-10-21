<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>

<%
MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
%>

<jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />



<!DOCTYPE html>
<html lang="en">

<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Xducation - 陪你成長的學習好夥伴</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/bootstrap.min.css">
    <!-- Icon -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/fonts/line-icons.css">
    <!-- Animate -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/animate.css">
    <!-- Main Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/main.css">
    <!-- Responsive Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/responsive.css">
    <style>
img#nav_icon{
width:36px;
height:36px;
}

    </style>
</head>

<body>
    <header id="header-wrap">
        <!-- Navbar Start -->
       <nav
			class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<a
					href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp"
					class="navbar-brand"><img src="<%=request.getContextPath()%>/front-end/members/assets/img/logo.svg" alt="">
					<div id="logo">Xducation</div> </a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarCollapse" aria-controls="navbarCollapse"
					aria-expanded="false" aria-label="Toggle navigation">
					<i class="lni-menu"></i>
				</button>
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<ul class="navbar-nav mr-auto w-100 justify-content-end clearfix">
						<li class="nav-item"><a class="nav-link" href="#">
								進入搜尋&nbsp;<i class="lni-search"></i>
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#">
								精選課程&nbsp;<i class="lni-leaf"></i>
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#">
								名人講座&nbsp;<i class="lni-bulb"></i>
						</a></li>
						<c:if test="${teacherSvc.getStatus(sessionScope.membersVO.memno).tchrstatus eq '已通過'}">
						<li class="nav-item"><a class="nav-link" href="#">
								我要開課&nbsp;<i class="lni-bulb"></i>
						</a></li>
						</c:if>
						
						<c:if test="${not empty sessionScope.membersVO}">
							
							
							<li class="nav-item">
								<div class="dropdown" id="dropdown">
									<button class="btn btn-secondary dropdown-toggle" type="button"
										id="dropdownMenuButton" data-toggle="dropdown"
										aria-haspopup="true" aria-expanded="false">
										${sessionScope.membersVO.memname}</button>
									<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/members/updateMembersV2.jsp">個人檔案</a>
											
										
										<c:if test="${teacherSvc.getStatus(sessionScope.membersVO.memno).tchrstatus eq '待審核'}">
										<a class="dropdown-item" onclick="status()" >老師檔案</a> 
											
										</c:if>
										<c:if test="${teacherSvc.getStatus(sessionScope.membersVO.memno).tchrstatus eq '已通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherDisplay.jsp">老師檔案</a> 
											
										</c:if>
											<c:if test="${teacherSvc.getStatus(sessionScope.membersVO.memno).tchrstatus eq '未通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherUpdate.jsp">老師檔案</a>
											
										</c:if>
										<c:if test="${not empty sessionScope.membersVO}">
										<a class="dropdown-item"
											href='<%=request.getContextPath()%>/members/members.do?action=signout'>會員登出</a> 
											
										</c:if>
											
											
										
											
											
											
									</div>
								</div>
								
							</li>
							
							</c:if>
							
							<c:if test="${not empty sessionScope.membersVO.memno}">
							<c:if test="${empty teacherSvc.getStatus(sessionScope.membersVO.memno)}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							</c:if>
							<c:if test="${teacherSvc.getStatus(sessionScope.membersVO.memno).tchrstatus eq '待審核'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							</c:if>
							
							<c:if test="${teacherSvc.getStatus(sessionScope.membersVO.memno).tchrstatus eq '已通過'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/teacher.svg'>
							</c:if>
							<c:if test="${teacherSvc.getStatus(sessionScope.membersVO.memno).tchrstatus eq '未通過'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							
							</c:if>
							</c:if>
							

						<c:if test="${empty sessionScope.membersVO}">
							<li class="nav-item"><a class='nav-link'
								href='<%=request.getContextPath()%>/front-end/members/signIn.jsp'>我要登入&nbsp;<i
									class='lni-bulb'></i></a></li>
						</c:if>



					</ul>
				</div>
			</div>
		</nav>
        <!-- Navbar End -->
    </header>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
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
</body>

</html>