<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>


<jsp:useBean id="teacherSvc" scope="page"
	class="com.teacher.model.TeacherService" />




<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Xducation-老師首頁</title>
<!-- Favicon-->
<!-- Font Awesome icons (free version)-->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/index/front-index/assets/fonts/line-icons.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic"
	rel="stylesheet" type="text/css" />
<!-- Third party plugin CSS-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.min.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="<%=request.getContextPath()%>/front-end/teacher/teacher_css/styles.css"
	rel="stylesheet" />

<!-- Main Style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/teacher/nav_css/css/main.css">
<!-- Responsive Style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/teacher/nav_css/css/responsive.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/assets/fonts/line-icons.css">
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>

</head>

<style>
video {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
	z-index: -1;
}

div#logo {
	padding-top: 10px;
}

img#nav_icon {
	width: 36px;
	height: 36px;
}
img.icon{
width:30px;
height:30px;
}

body {
	font-family: 'Gochi Hand';
}

header.masthead {
	height: 92vh;
	min-height: 0px;
	background: rgba(57, 63, 84, 0.6);
}

.lni-bulb:before {
	content: "\e92f";
}
</style>
<body id="page-top">
	<!-- Navigation-->
	<!--  <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="#page-top">Start Bootstrap</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about">About</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#services">Services</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#portfolio">Portfolio</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#contact">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav> -->
	<!--         <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar"  style="background-color: #fff"> -->
	<!--             <div class="container"> -->

	<%--                 <a href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp" class="navbar-brand"><img src="<%=request.getContextPath()%>/front-end/teacher/nav_css/img/logo.svg" alt=""> --%>
	<!--                     <div id="logo">Xducation</div> -->
	<!--                 </a> -->

	<!--                 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"> -->
	<!--                     <i class="lni-menu"></i> -->
	<!--                 </button> -->
	<!--                 <div class="collapse navbar-collapse" id="navbarCollapse"> -->
	<!--                     <ul class="navbar-nav mr-auto w-100 justify-content-end clearfix"> -->
	<!--                         <li class="nav-item"> -->
	<!--                             <a class="nav-link" href="#" style="color: #0099CC"> -->
	<!--                                 進入搜尋&nbsp;<i class="lni-search"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->
	<!--                         <li class="nav-item"> -->
	<!--                             <a class="nav-link" href="#" style="color: #0099CC"> -->
	<!--                                 精選課程&nbsp;<i class="lni-leaf"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->
	<!--                         <li class="nav-item"> -->
	<!--                             <a class="nav-link" href="#" style="color: #0099CC"> -->
	<!--                                 名人講座&nbsp;<i class="lni-bulb"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->

	<!--                         <li class="nav-item"> -->
	<%--                             <a class="nav-link" href="<%=request.getContextPath()%>/front-end/members/signIn.jsp" style="color: #0099CC"> --%>
	<!--                                 我要登入&nbsp;<i class="lni-home"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->




	<!--                      </ul> -->
	<!--                 </div> -->
	<!--             </div> -->
	<!--         </nav> -->
	<!-- Masthead-->
	<nav
		class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<a href="<%=request.getContextPath()%>/index/front-index/index.jsp"
				class="navbar-brand"><img
				src="<%=request.getContextPath()%>/index/front-index/assets/img/logo.svg"
				alt="">
				<div id="logo">Xducation</div> </a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarCollapse" aria-controls="navbarCollapse"
				aria-expanded="false" aria-label="Toggle navigation">
				<i class="lni-menu"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<ul class="navbar-nav mr-auto w-100 justify-content-end clearfix">
					<li class="nav-item">
						<%--                             <a class="nav-link" href="<%=request.getContextPath()%>/front-end/course/listAllCourse.jsp"> --%>
						<!--                                進入搜尋&nbsp;<i class="lni-search"></i>  -->
						<!--                             </a> -->
					</li>
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
	<header class="masthead">

		<div class="container h-100">
			<video id=""
				src="<%=request.getContextPath()%>/front-end/teacher/teacher_css/img/portfolio/video.mp4"
				autoplay controls muted loop></video>

			<div
				class="row h-100 align-items-center justify-content-center text-center">
				<div class="col-lg-10 align-self-end">
					<h1 class="text-uppercase text-white font-weight-bold">上架你的才華</h1>
					<hr class="divider my-4" />
				</div>
				<div class="col-lg-8 align-self-baseline">
					<p class="text-white-75 font-weight-light mb-5">一起將你的熱情與技能分享給全世界！</p>

					<c:if test="${not empty sessionScope.loginMembersVO}">

						<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '待審核'}">
							<a class="btn btn-primary btn-xl js-scroll-trigger" onclick="status()" style="color: white;">審核中</a>

						</c:if>

						<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '未通過'}">
							<a class="btn btn-primary btn-xl js-scroll-trigger"
								href="<%=request.getContextPath()%>/front-end/teacher/teacherUpdate.jsp" style="color: white;">再次遞交申請</a>

						</c:if>

						<c:if test="${empty teacherSvc.getOneTeacherByMemno(loginMembersVO.memno)}">
							<a class="btn btn-primary btn-xl js-scroll-trigger"
								href="<%=request.getContextPath()%>/front-end/teacher/teacherRegister.jsp" style="color: white;">申請成為老師</a>
						</c:if>
						
						<c:if test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
							<a class="btn btn-primary btn-xl js-scroll-trigger"
								href="<%=request.getContextPath()%>/front-end/course/addCourse.jsp" style="color: white;">申請開課</a>
						</c:if>



					</c:if>







					<c:if test="${empty sessionScope.loginMembersVO}">
						<a class="btn btn-primary btn-xl js-scroll-trigger"
							style="color: white;" onclick="rej()">申請成為老師</a>
					</c:if>

				</div>
			</div>
		</div>
	</header>
	<!-- About-->
	<section class="page-section bg-primary" id="about">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8 text-center">
					<h2 class="text-white mt-0">成為一位好老師</h2>
					<hr class="divider light my-4" />
					<ul>
						<li>
							<p class="text-white-50 mb-4">完成老師開課申請，簡單幾步驟創造你的課程提案，Xducation
								將會審核課程，讓你朝下一個目標邁進。</p>
						</li>
						<li>
							<p class="text-white-50 mb-4">準備優質課程內容，
								當你的知識技能點亮每個人的生活，讓學生再次體驗純粹的熱情，將會有越來越多人加入你的課程。</p>
						</li>
						<li>
							<p class="text-white-50 mb-4">持續創造教學生態圈，每個階段隨時掌控與學生的交流，回答問題或提供鼓勵，一起滿足學習渴望，得到分享的充實。</p>
						</li>


					</ul>

					<!-- <a class="btn btn-light btn-xl js-scroll-trigger" href="#services">Get Started!</a> -->
				</div>
			</div>
		</div>
	</section>
	<!-- Services-->
	<section class="page-section" id="services">
		<div class="container">
			<h2 class="text-center mt-0 " style="font-family: 'Gochi Hand';">關於Xducation平台</h2>
			<hr class="divider my-4" />
			<div class="row">
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<i class="fas fa-4x fa-globe text-primary mb-4"></i>
						<h2 class="h4 mb-2">395,000+ 位</h2>
						<h6>來自各地的學生</h6>
						<p class="text-muted mb-0">395,000+
							名註冊會員遍及全台，更有遠從馬來西亞、香港、新加坡…等各地學生加入
							Xducation。沒有時間地域限制，線上學習的需求遠超乎你的想像。</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<i class="fas fa-4x fa-laptop-code text-primary mb-4"></i>
						<h2 class="h4 mb-2">7,000 堂</h2>
						<h6>每月售出課堂數</h6>
						<p class="text-muted mb-0">透過分享和群眾支持的力量，老師只需專心創造好內容，與學生零時差互動，就能發揮影響力，擁有強大支持社群。</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<i class="fas fa-4x fa-gem text-primary mb-4"></i>
						<h2 class="h4 mb-2">90%</h2>
						<h6>最高售課分潤</h6>
						<p class="text-muted mb-0">每一筆由老師銷售出的課程，老師會獲得高達 90% 的分成，由
							Xducation 售出則獲得 50% 的分成。交易資訊公開透明，後台系統可以隨時查看明細。</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<i class="fas fa-4x fa-heart text-primary mb-4"></i>
						<h2 class="h4 mb-2">93%</h2>
						<h6>募資成功率</h6>
						<p class="text-muted mb-0">跨出勇敢的第一步，高達 93% 的募資成功率，在 Xducation
							開課賺取你的夢想基金！2015 年 2 月上線至今，有 3 位賺取超過百萬、1 位破千萬的老師，被動收入持續累積中。</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Portfolio-->
	<div id="portfolio">
		<div class="container-fluid p-0">
			<div class="row no-gutters">
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="assets/img/portfolio/fullsize/1.jpg">
						<img class="img-fluid"
						src="teacher_css/img/portfolio/thumbnails/1.jpg" alt="" />
						<div class="portfolio-box-caption">
							<div class="project-category text-white-50">1.尋找主題</div>
							<div class="project-name">你想教的，是否也是線上學習者想付費學習的？點擊教學，帶你一步步分析客群，驗證需求，朔造與其他資源的差異與優勢</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="assets/img/portfolio/fullsize/2.jpg">
						<img class="img-fluid"
						src="teacher_css/img/portfolio/thumbnails/2.jpg" alt="" />
						<div class="portfolio-box-caption">
							<div class="project-category text-white-50">2.編輯提案</div>
							<div class="project-name">安排時間擬定課程架構，拍攝1~3分鐘的募資影片，Step by
								Step完成提案！更多開課小撇步請參考Xducation開課教學系列文章</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="assets/img/portfolio/fullsize/3.jpg">
						<img class="img-fluid"
						src="teacher_css/img/portfolio/thumbnails/3.jpg" alt="" />
						<div class="portfolio-box-caption">
							<div class="project-category text-white-50">3.提案審核</div>
							<div class="project-name">致力於推出優質課程，收到你的提案後，Xducation會依據審核標準給你建議，通過審核才會予以上架募資。快來查看最新的審核標準吧</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="assets/img/portfolio/fullsize/4.jpg">
						<img class="img-fluid"
						src="teacher_css/img/portfolio/thumbnails/4.jpg" alt="" />
						<div class="portfolio-box-caption">
							<div class="project-category text-white-50">4.募資階段</div>
							<div class="project-name">募資階段正式好玩的開始！行銷宣傳你的提案，與大家一起集氣;聆聽學生的建議與需求，彈性調整課綱內容</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="assets/img/portfolio/fullsize/5.jpg">
						<img class="img-fluid"
						src="teacher_css/img/portfolio/thumbnails/5.jpg" alt="" />
						<div class="portfolio-box-caption">
							<div class="project-category text-white-50">5.製作課程</div>
							<div class="project-name">恭喜你！募資成功後就可以開始製作課程囉，上傳課程影片，提供參考講義，準備字幕，別讓期待的學生等太久</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="assets/img/portfolio/fullsize/6.jpg">
						<img class="img-fluid"
						src="teacher_css/img/portfolio/thumbnails/6.jpg" alt="" />
						<div class="portfolio-box-caption p-3">
							<div class="project-category text-white-50">6.審核開課</div>
							<div class="project-name">在預定開課日前將課程提交給Xducation，審核通過後即可正式開課！別忘了善用討論區與作業區，持續交流互動，創造更多收入</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Call to action-->
	<section class="page-section bg-dark text-white">
		<div class="container text-center">
			<h2 class="mb-4">課程製作服務!</h2>
			<p>
				想和我們一起更完整地打造獨一無二的課程嗎？<br>歡迎申請 Xducation
				專業的「課程製作服務」，通過審核後，我們將提供編輯提案與課程攝影服務，讓 Xducation 助你一臂之力。
			</p>
			<a class="btn btn-primary btn-xl js-scroll-trigger" href="#about">點此申請</a>
		</div>
	</section>
	<!-- Contact-->
	<section class="page-section" id="contact">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8 text-center">
					<h2 class="mt-0">Let's Get In Touch with Xducation!</h2>
					<hr class="divider my-4" />
					<p class="text-muted mb-5">Ready to start your next project
						with us? Give us a call or send us an email and we will get back
						to you as soon as possible!</p>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 ml-auto text-center mb-5 mb-lg-0">
					<i class="fas fa-phone fa-3x mb-3 text-muted"></i>
					<div>HongKong 3345678</div>
				</div>
				<div class="col-lg-4 mr-auto text-center">
					<i class="fas fa-envelope fa-3x mb-3 text-muted"></i>
					<!-- Make sure to change the email address in BOTH the anchor text and the link target below!-->
					<a class="d-block" href="mailto:contact@yourwebsite.com">contact@Xducation.com</a>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer id="footer" class="footer-area">
		<section id="copyright" class="">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copyright-content">
							Xducation
							<p>
								<a href="#">關於我們</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">其他服務</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
									href="#">網站地圖</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</section>
	</footer>
	<input type="hidden" id="inform6" value="${requestScope.inform6}">










	<script type="text/javascript">
		var inform6 = document.getElementById('inform6').value;
		if (inform6 === '200') {
			swal('申請成功', '我們會盡快審核並告知您審核結果,請耐心等候通知', 'success');
		}

		function status() {

			swal('老師資格審核中', '請耐心等候1~3個工作天，一但審核完畢，即會立刻通知', 'info');
		}
		function rej() {

			swal('NO NO', '請先登入會員唷', 'warning');
		}
	</script>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
	<!-- Third party plugin JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
	<!-- Core theme JS-->
</body>
</html>
