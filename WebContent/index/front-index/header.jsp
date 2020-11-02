<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>

<% //宇臣需要
MembersVO membersVO = (MembersVO) session.getAttribute("loginMembersVO");
TeacherVO teacherVO = (TeacherVO) session.getAttribute("loginTeacherVO");

%>

<jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />

<!DOCTYPE html>
<html lang="en">

<head>
<!-- Sweetalert2 -->
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
    <link rel="icon" type="image/png" href="<%=request.getContextPath()%>/back-end/login/logincss/images/icons/logo.svg"/>    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/fonts/line-icons.css">
    <!-- Animate -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/animate.css">
    <!-- Main Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/main.css">
    <!-- Responsive Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/responsive.css">
    
    <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
    <style>
img#nav_icon{
width:36px;
height:36px;
}
img.iconForNav{
width:30px;
height:30px;
}
a.nav-link{
margin-right:5px;
}
div#navBar{
 width: -webkit-fill-available;

}

    </style>
</head>

<body onload="connect();" onunload="disconnect();">
   <header id="header-wrap">
        <!-- Navbar Start -->
       <nav
			class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar">
			<div class="container" id="navBar">
				<!-- Brand and toggle get grouped for better mobile display -->
				<a
					href="<%=request.getContextPath()%>/index/front-index/index.jsp"
					class="navbar-brand"><img src="<%=request.getContextPath()%>/front-end/members/assets/img/logo.svg" alt="">
					<div id="logo">Xducation</div> </a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarCollapse" aria-controls="navbarCollapse"
					aria-expanded="false" aria-label="Toggle navigation">
					<i class="lni-menu"></i>
				</button>
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<ul class="navbar-nav mr-auto w-100 justify-content-end clearfix">
						<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/tracking_list/listTrackingListForUser.jsp">
							購物車&nbsp;<img class="iconForNav"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/shopping-cart.svg'>
							
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp">
							搜尋課程&nbsp;<img class="iconForNav"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/search.svg'>
							
					</a></li>
					<c:if test="${not empty sessionScope.loginMembersVO}">
					 <li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/course/listMyCourse.jsp">
							我的課程&nbsp;<img class="iconForNav"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/mycourse.svg'>
							
					</a></li>
					</c:if>
				
					
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/lecture/listAllLec.jsp">
							名人講座&nbsp;<img class="iconForNav"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/influencer.svg'>
							
					</a></li>
					<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/front-end/course/addCourse.jsp">
								我要開課&nbsp;<img class="iconForNav"
								src='<%=request.getContextPath()%>/index/front-index/assets/img/opencourse.svg'>
							
						</a></li>
					</c:if>





					<c:if test="${not empty sessionScope.loginMembersVO}">
						<li class="nav-item">
							<div class="dropdown" id="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button"
									id="dropdownMenuButton" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false" style="background-color: #6c757d">
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
							href='<%=request.getContextPath()%>/front-end/members/signIn.jsp'>我要登入&nbsp;<img class="iconForNav" src='<%=request.getContextPath()%>/index/front-index/assets/img/login.svg'>
							</a>
							</li>
					</c:if>



					</ul>
				</div>
			</div>
		</nav>
        <!-- Navbar End -->
    </header>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
	
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery-min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/popper.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/wow.js"></script>
<!--     	沒有拿掉，首頁連結會失效 -->
<%--     <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.nav.js"></script> --%>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/scrolling-nav.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.easing.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.counterup.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/waypoints.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/main.js"></script>
</body>
<!-- toastr -->
	<script src="<%=request.getContextPath()%>/library/toastr-master/build/toastr.min.js"></script>
   <link rel="stylesheet" href="<%=request.getContextPath()%>/library/toastr-master/build/toastr.min.css">
   
<script>

function status(){
	
	 swal('老師資格審核中', '請耐心等候1~3個工作天，一但審核完畢，即會立刻通知', 'info');
}
//==================webSocket=======================
	
		var MyPoint = "/NotifyWS/${sessionScope.loginTeacherVO.tchrno}";
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










</script>



</html>